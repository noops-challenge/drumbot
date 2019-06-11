import SoundPlayer from './SoundPlayer';

const defaultPosition = {
  absolute: -1,
  measure: -1,
  step: -1,
  time: -1
};
const WebAudioCtor = window.AudioContext || window.webkitAudioContext;

function initializeFirstContext() {
  const desiredSampleRate = 44100;

  var context = createNewContext()

  // in iOS, need to set the sample rate after initializing a context
  // SEE: https://stackoverflow.com/questions/29901577/distorted-audio-in-ios-7-1-with-webaudio-api
  if (/(iPhone|iPad)/i.test(navigator.userAgent) && context.sampleRate !== desiredSampleRate) {
    const buffer = context.createBuffer(1, 1, desiredSampleRate)
    const dummy = context.createBufferSource()
    dummy.buffer = buffer
    dummy.connect(context.destination)
    dummy.start(0)
    dummy.disconnect()

    context.close() // dispose old context
    return createNewContext();
  }

  return context
}

function createNewContext() {
  return new WebAudioCtor();
}

const leaderTime = 0.25;

export const browserSupportsWebAudio = () => !!WebAudioCtor;

export default class AudioEngine {
  constructor({ onStep }) {
    this.onStep = onStep;
    this.position = defaultPosition;
    this.context = initializeFirstContext();
    this.soundPlayer = new SoundPlayer();
  }


  prepare = () => this.soundPlayer.prepare(this.context);

  setPattern(pattern) {
    this.pattern = pattern;
  }

  startClock = (beatsPerMinute) => {
    this.stepsPerSecond = beatsPerMinute / 60 * 4;
    this.context = createNewContext();

    this.playing = true;
    this.scheduleSounds(this.getPosition(0));
    this.context.resume();

    this.onTick();
  }

  stopClock = () => {
    this.playing = false;
    this.position = defaultPosition;

    this.context.suspend();
    this.context.close();
  }

  onTick = () => {
    const currentStepAbsolute = this.getStepAbsolute(this.context.currentTime);
    if (currentStepAbsolute !== this.position.absolute) {
      this.setCurrentStepAbsolute(currentStepAbsolute);
    }
    if (this.playing) {
      requestAnimationFrame(this.onTick);
    }
    else {
      this.position = defaultPosition;
      this.onStep({ position: this.position});
    }
  }

  getStepAbsolute(timing) {
    return Math.floor((timing - leaderTime) * this.stepsPerSecond);
  }

  setCurrentStepAbsolute(absoluteStepCount) {
    this.onStep({ position: this.getPosition(absoluteStepCount)});

    // schedule the sounds one beat ahead so the timing is exact
    this.scheduleSounds(this.getPosition(absoluteStepCount + 1));
  }

  getPosition(absoluteStepCount) {
    const { stepCount } = this.pattern;
    return {
      measure: Math.floor(absoluteStepCount / stepCount),
      step: absoluteStepCount % stepCount,
      timing: absoluteStepCount / this.stepsPerSecond + leaderTime,
      absolute: absoluteStepCount
    }
  }

  scheduleSounds = (position) =>  {
    if (!this.playing) return;
    this.pattern.tracks.forEach(track => {
      if (track.steps[position.step]) {
        this.soundPlayer.play({
          context: this.context,
          instrument: track.instrument,
          timing: position.timing
        });
      }
    });
  }
}

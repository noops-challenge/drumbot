import SamplePlayer from './SamplePlayer';

const samples = [
  'clap',
  'cowbell',
  'kick',
  'snare',
  'hihat',
  'ride',
  'rim'
 ];

export default class SoundPlayer {
  constructor() {
    this.instruments = {};
  }

  prepare = (context) => {
    // load all samples
    return Promise.all(samples.map(sample => this.loadSample(context, sample)))
  }

  loadSample = (context, instrument) => {
    const url = `./samples/${instrument}.wav`;
    return new Promise((resolve, reject) => {
      var request = new XMLHttpRequest();

      request.open('GET', url, true);

      request.responseType = 'arraybuffer';

      request.onload =  () => {
        var audioData = request.response;

        context.decodeAudioData(audioData, (buffer) => {
          this.instruments[instrument] = new SamplePlayer(buffer);
          resolve();
        }, reject);
      };

      request.send();
    });
  }

  play({
    context,
    instrument,
    timing
  }) {
    const player = this.instruments[instrument];
    const gainNode = context.createGain();
    gainNode.gain.setValueAtTime(0.1, timing);
    gainNode.connect(context.destination);

    if (player) player.play({context, timing, destination: gainNode});
  }
}

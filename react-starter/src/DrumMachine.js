import React from 'react';
import './DrumMachine.css';
import { fetch } from 'whatwg-fetch';
import AudioEngine, {browserSupportsWebAudio } from './AudioEngine';
const apiHost = process.env.REACT_APP_API_HOST || 'https://api.noopschallenge.com';

export default class DrumMachine extends React.Component {
  state = {
    poweredOn: false,
    loading: true,
    playing: false,
    startTime: 0,
    position: {},
    pattern: {
      tracks: []
    }
  };

  componentDidMount() {
    if (!browserSupportsWebAudio()) {
      return this.setState({
        loading: false,
        error: 'This browser does not support WebAudio. Try Edge, Firefox, Chrome or Safari.'
      });
    }
  }

  powerOn = () => {
    this.audioEngine = new AudioEngine({ onStep: this.onStep});
    this.audioEngine.prepare().then(() =>
      fetch(`${apiHost}/drumbot/patterns`).then(r => r.json()).then(
        patterns => {
          this.setState({ patterns, poweredOn: true }, () => {
            const randomIndex = Math.floor(Math.random() * patterns.length);
            this.selectPattern(randomIndex)
          });
        },
        err => {
          this.setState({ error: 'Oops. Something went wrong. Please check your connection and refresh your browser.', loading: false });
        }
    ), error => {
      this.setState({ error: true, loading: false });
    });
  }

  startClock = () => {
    this.audioEngine.startClock(this.state.pattern.beatsPerMinute);

    this.setState({ playing: true });
  }
  stopClock = () => {
    this.audioEngine.stopClock();

    this.setState({ playing: false});
  }

  onStep = ({
    position,
  }) => {
    this.setState({ position });
  }

  selectPattern(index) {
    if (index < 0) index = this.state.patterns.length - 1;
    if (index >= this.state.patterns.length) index = 0;
    const pattern = this.state.patterns[index]
    if (this.state.playing) {
      this.stopClock();
    }


    fetch(`${apiHost}/drumbot/patterns/${pattern.name}`).then(r => r.json()).then(
      pattern => {
        this.setState({ pattern, patternIndex: index, loading: false });
        this.audioEngine.setPattern(pattern);
      }
    );
  }

  nextPattern = () => {
    this.selectPattern(this.state.patternIndex + 1);
  }

  previousPattern = () => {
    this.selectPattern(this.state.patternIndex - 1);
  }

  render() {

    if (this.state.error) return (
      <div className='DrumMachine__Error'>
        {this.state.error}
      </div>
    );

    if (!this.state.poweredOn) {
      return (
        <div className='DrumMachine'>
          <div className='DrumMachine__GetStarted'>
            <p>Welcome to drumbot</p>
            <button className='DrumMachine__StartStopButton' onClick={this.powerOn}>Start!</button>
          </div>
        </div>
      );
    }

    const { pattern: { tracks, name }, position: { step } } = this.state;

    return (
      <div className='DrumMachine'>
        <div className='DrumMachine__TopPanel'>
          <div className="DrumMachine__Logo">
            <div className="DrumMachine__Title">
              PR-606
            </div>
            <div className="DrumMachine__SubTitle">
              FORKABLE DRUM COMPUTER
            </div>
          </div>
          {this.state.poweredOn && (
            <>
              <div className='DrumMachine__PatternSelector'>
                <div className='DrumMachine__PatternButton'>
                  <button onClick={this.previousPattern}>&lt;</button>
                </div>
                <div className='DrumMachine__SelectedPattern'>
                  {name}
                </div>
                <div className='DrumMachine__PatternButton'>
                  <button onClick={this.nextPattern}>&gt;</button>
                </div>
              </div>
              <div className='DrumMachine__Transport'>
                <button disabled={this.state.playing} className='DrumMachine__StartStopButton' onClick={this.startClock}>Start</button>
                <button disabled={!this.state.playing} className='DrumMachine__StartStopButton' onClick={this.stopClock}>Stop</button>
              </div>
            </>
          )}
        </div>

        <div className='DrumMachine__Tracks'>
          {tracks.map((track, trackIndex) => (
            <div className='DrumMachine__Track' key={trackIndex}>
              <div className='DrumMachine__TrackLabel'>{track.instrument}</div>
              <div className='DrumMachine__TrackSteps'>
                {track.steps.map((trackStep, i) => (
                  <div className={`DrumMachine__Step DrumMachine__Step--${step === i ? 'Active' : 'Inactive'} DrumMachine__Step--${trackStep ? 'On' : 'Off'}`} key={i}>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>

        <div className='DrumMachine__Footer'>
          <div>Join the fun at <a href='https://noopschallenge.com'>noopschallenge.com</a></div>
          <div><a href='https://github.com/noops-challenge/drumbot'>Fork me on GitHub</a></div>
        </div>
      </div>
    );
  }
}

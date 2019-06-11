// Play a sample loaded from a file
export default class SamplePlayer {
  constructor(buffer) {
    this.buffer = buffer;
  }

  play({ context, timing, destination }) {
    const source = context.createBufferSource();

    source.buffer = this.buffer;
    source.connect(destination);
    source.start(timing);
  }
}

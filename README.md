![](https://user-images.githubusercontent.com/212941/59231343-2a71cd80-8b95-11e9-8bc9-9dfb58467094.png)

## 👋 Drumbot wants you!

Drumbot loves drum machines so much that she made an API dedicated to them.
Nothing would make her happier than for you to bring this API to life.

Drumbot has included a drum machine written using React and the WebAudio API to help you get started.

You can start with this or create your own from scratch.

### API
Drumbot's API has the following methods:

`GET /drum-machine/patterns`

Returns the list of available patterns

`GET /drum-machine/patterns/{pattern-name}`

Returns a pattern.

See [the API documention](API.md) For all the details!

## React Starter Kit

Drumbot has provided a starter kit &ndash; a drum machine that runs inside a browser, built with React and the WebAudio API.

[See it in action here](https://noops-challenge.github.io/drumbot/index.html)

To get started with the react example, you'll need recent version of node.js. Fork this repository to your own github account so you can share your work.

```
cd react-starter
npm install
npm start
```

This example requires WebAudio support,

The WebAudio API is relatively new and support can be slightly different in each browser. This drum machine should work on Edge, Firefox, Chrome, and Safari.

Also note that on some mobile devices, WebAudio only plays through headphones &ndash; so if you don't hear anything, plug some in!

The [WebAudio page on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) is a good place to start learning about the WebAudio API.

## Ideas to try

Here are a few ideas for you to try:

#### Change the sounds

This drum machine loads its sounds from samples that are stored in the .wav format.

The sounds are found in the `public/samples` folder. Try replacing these with your own sounds.

If you're feeling adventurous, try synthesizing your own drum sounds using [oscillators](https://developer.mozilla.org/en-US/docs/Web/API/BaseAudioContext/createOscillator).

#### Change the speed!

This drum machine doesn't let you set the tempo. Try adding a tempo control!

#### Dynamics

This drum machine plays each sound at an equal volume. Try varying the volume of the sounds or adding a volume knob to each track.

Use the [AudioContext.createGain](https://developer.mozilla.org/en-US/docs/Web/API/BaseAudioContext/createGain) method to create a gain node to control the volume.

#### Stererereo

You can move sounds around from left to right. Try using [AudioContext.createStereoPanner()](https://developer.mozilla.org/en-US/docs/Web/API/BaseAudioContext/createStereoPanner) to create a [StereoPannerNode](https://developer.mozilla.org/en-US/docs/Web/API/StereoPannerNode).

You can even get crazy and move sounds around in 3D with a [PannerNode](https://developer.mozilla.org/en-US/docs/Web/API/PannerNode).

#### Make it Swing!

A revolutionary feature on the [Linn LM-1](https://en.wikipedia.org/wiki/Linn_LM-1), one of the earliest drum machines, was "Swing" - the ability to make the beat "swing" by slightly changing the timing of every other step. Most drum machines since then have included some sort of swing control.  Try adding one to this drum machine.

#### Spice up the design!

Drumbot is not a designer. Are you? Let's see what you got.

#### Create your own drum pattern API.

Can you reverse-engineer the drumbot API and create your own beats? Show us.

#### Add visualizations

Use [AudioContext.createAnalyser](https://developer.mozilla.org/en-US/docs/Web/API/BaseAudioContext/createAnalyser) to analyze the audio data. Create a sound meter or do something else awesome!

#### Change the pattern!

Enable changing the pattern by toggling each spet on or off.

## Nevermind the starter; I want to roll my own!

Great! Here are some ideas to get you started.

#### Use a different programming language

Most languages and platforms out there can play music, with a little help from a library or two. What's your favorite language?

#### Connect to other devices

 Connect to a real drum machine! Hook these patterns up to your favorite music program! Make your smart microwave heat up pizza to the beatza!

### Visualize the rhythm

Playing sounds is just one of them. Build something else cool with these repeating patterns. Light up your smart lightbulbs or anything else.

## Show drumbot what you made!

Push your work up to your own fork.



More about Drumbot here: https://noopschallenge.com/challenges/drumbot

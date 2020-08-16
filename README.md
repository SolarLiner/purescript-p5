# purescript-p5

Idiomatic PureScript wrapper over p5.js. [GitHub starter template](https://github.com/SolarLiner/purescript-p5-template)

This project attempts to provide easy-to-use bindings to the `p5.js` project, in a way that remains easy to learn but still is idiomatic.

Instead of wrapping every `p5` function 1:1, this library wires in existing libraries (e.g. `purescript-color` and `purescript-sized-vectors`) instead of wrapping p5 implementations.

## Running the examples

First, build the example with spago (`spago build`), and then bundle the `index.html` file using any compatible bundler (for example Parcel).

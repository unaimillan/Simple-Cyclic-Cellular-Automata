# Simple Cyclic Cellular Automata

All the code and this README.md was heavily inspired by examples in the repository of [accelerate-examples](https://github.com/AccelerateHS/accelerate-examples)

## Description

This is the [Cyclic Cellular Automata](https://en.wikipedia.org/wiki/Cyclic_cellular_automaton) implemented in Haskell as a pet project using the [accelerate-hs](https://github.com/AccelerateHS/accelerate) library

The original intention is to show the beauty of cyclic cellular automatons and their ability to generate 
some pretty looking pictures😉

## Installation

### External dependencies

Installation of `accelerate-examples` and its dependencies requires several
external packages. You may need to adjust the package names or versions slightly
for your system.

  * Ubuntu/Debian (apt-get):
    - llvm-9-dev
    - freeglut3-dev
    - libfftw3-dev

If you want to use the CUDA GPU enabled backend
[`accelerate-llvm-ptx`](https://github.com/AccelerateHS/accelerate-llvm), you will also need to install the CUDA toolkit for your system. You can find an
installer on NVIDIA's website here:

  * https://developer.nvidia.com/cuda-downloads

**NB: The project uses Cuda 10.2**

### Building: stack

For development, the recommend build method is via the
[`stack`](http://haskellstack.org) tool. This will simplify pulling in
dependencies not yet on Hackage. For example, to build using ghc-8.8:

```bash
stack build                         # or, 'stack install' to install the executable globally
```

Before building, you may want to edit the `stack.yaml` file to change the build
configuration. In particular, the `flags` section at the bottom can be used to
enable or disable individual example programs and accelerate backends, as well
as features such as monitoring and debug output.

**NB**: You may be interested in adding the following `flags` to turn off the Cuda support
so the project could _compile_ without installing Cuda

```yaml
flags:
  accelerate-fft:
    llvm-ptx: false
  cyclic-cellular-automata:
    llvm-ptx: false
```

Adding new backends
-------------------

Adding support for new Accelerate backends should require only a few minor
additions to the cabal file and the module '`Data.Array.Accelerate.Examples.Internal.Backend`'.

## Usage

To launch the project as is, you could use `stack run` or it's possible to pass additional flags to the executable with `--`, e.g.

`stack run -- --help`

Common way to start the executable with NVIDIA Backend is `stack run -- --llvm-ptx`

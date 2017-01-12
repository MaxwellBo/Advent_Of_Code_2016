## Requirements

- Julia
- Python 2
- Python 3
- Haskell
    + Cabal

## Setup

- `python3 -m venv .`
- `pip3 install networkx numpy more_itertools`
- `source bin/activate`

## Usage

### Haskell

#### Setup

- `cabal sandbox init`
- `cabal install containers split mtl parallel puremd5`

#### Execution

- `cabal repl`
- `> :l <DAY>`
- `> main`

### Python

#### Setup


#### Execution

- `python3 <DAY>`

### Scala

- `sbt`
- `> run <DAY>`

# Capers

Play checkers against the computer and study draughts games from books.

This contains the full source code to both the Python GUI and the C engines.

Please see original [README](README.txt) for other information.

## New version for Python 3 and PyGObject

The `pygobject` branch is a new version of the game, ported to Python 3 and PyGObject by [Claude AI](https://claude.ai).

```bash
git clone --single-branch --depth 1 --branch pygobject https://github.com/rchastain2/capers.git capers-py3
cd capers-py3
make
sudo make install
```

Or, without installation:

```bash
make
mkdir -p lib && cp -fv cliche/simplech.so lib
./capers
```

## Screenshot

![Screenshot](doc/screenshot3.png)

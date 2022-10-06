eval $(/opt/homebrew/bin/brew shellenv)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims"

eval "$(pyenv init --path)"

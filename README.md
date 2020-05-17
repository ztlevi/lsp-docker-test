# README

## Reproduce steps

1. Clone the project

```sh
mkdir -p ~/Developer
cd ~/Developer
git clone https://github.com/ztlevi/lsp-docker-test.git
```

2. Build docker image

```sh
cd ~/Developer/lsp-docker-test
docker build --tag my-lsp-docker-container:1.0 my-lsp-docker-container
```

3. Run emacs, note this will create `elpa--test-lsp-docker` folder under `~/.emacs.d`. You can remove it after testing

```sh
emacs -nw -Q -l ~/Developer/lsp-docker-test/minimal-test.el
```

4. `C-x C-f` open `~/Developer/lsp-docker-test/test.py`

5. Move cursor to `from typing import Deq[I]ue, List` `[I]` position. Run `M-x lsp-find-definitions`

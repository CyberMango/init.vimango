# init.vimango

My personal Neovim configurations.
This repository was created for personal usage.

Main guidelines:
  - Highly Documented and well organized.
  - Portable - everything is in a single directories tree!
  - Follows most of /r/vim's best practices guide.
  - Minimizing the number of plugins:
    - No unused plugins.
    - No duplicate plugins.
    - Prefer builtin features over plugins when results are similar.

Features:
  - Summaries of great vim-related articles in my_wiki.
  - Language specific supports: cpp, python.
  - Easy use of tabpages, buffers and windows. Each used the way it was meant to be.
  - Useful, efficient and consistent shortcuts for many actions.

Future TODOs:
  - replace Defx with a better file explorer (maybe coc-explorer or tree.nvim when either is ready).
    Defx problems:
      - tabedit from inside of defx opens the file in the defx buffer window.
      - cant recursivley open already openend dirs.
      - no easy way to open dir like in an explorer.
      - file open might move to different tab if file is opened there (due to drop's behavior).
      - In general, requires programming too much by myself due to missing features.


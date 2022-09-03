# init.vimango

My personal Neovim configurations.
This repository was created for personal usage.

Main guidelines:
  - Highly Documented and well organized.
    - Organize everything by what it relates to, like the main editor, a specific plugin, etc...
    - Document options/features to save the need for scanning :help files all the time.
  - Fairly portable - everything is in a single directories tree!
  - Minimizing the number of plugins:
    - No unused plugins.
    - No duplicate plugins.
    - Prefer builtin features over plugins when results are similar.
    - Configs for each plugin are stored together making it easily removeable/replaceable.
  - Prefer plugins that dont require external dependencies (such as python/nodeJS).
  - Scaleable: No features that only work for small code bases and break or become unuseable for bigger ones.
  - Usually prefer built-in shortcuts or highly standardized shortcuts (like the default lsp shortcuts)
    over shoftcuts specific to this configuration.
  - Let vim be vim - dont force behaviors of "regular" editors on vim,

Features:
  - Language specific configs: cpp, python, lua.
    - Easy to add more languages.
  - Easy use of tabpages, buffers and windows. Each used the way it was meant to be.
  - Useful, efficient and consistent shortcuts for many actions.
  - Enhancements to some built-in features.
  - A personal wiki with summaries of vim-related articles, unknown features and neat tricks.

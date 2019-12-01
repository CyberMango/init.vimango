"" The extra configurations list. TODO change this after you learn how to make
"" a compilation DB / a good normal extra configs file.
"let g:ycm_extra_conf_globlist = ['~/.local/share/nvim/site/pack/YouCompleteMe/.ycm_extra_conf.py', '~/[c, python]/.ycm_extra_conf.py']
"
"" Show diagnostics in the locations list.
"let g:ycm_always_populate_location_list = 1
"
"" Max completion suggestions
"let g:ycm_max_num_candidates = 30
"let g:ycm_max_num_identifier_candidates = 20
"
"" Automatically suggest semantic or identifier completions. This is default
"" but doesnt work for some reason.
"let g:ycm_auto_trigger = 1
"
"" Show completions when inside of comments.
"let g:ycm_complete_in_comments = 0
"
"" Get completions from the language's vim syntax (why isnt this default?!)
"let g:ycm_seed_identifiers_with_syntax = 1
"
"" Close preview window after completion is done
"let g:ycm_autoclose_preview_window_after_completion = 0
"let g:ycm_autoclose_preview_window_after_insertion = 0
"" Dont show previews
"set completeopt=longest
"
"" Anything triggers semantic completion. Regex includes whitespace so anything
"" triggers this.
""let g:ycm_semantic_triggers =  {
""\   'c': ['re!\w{2}']
""\}
"

asyncomplete-look.vim
=====================

Provide `/usr/bin/look` completions for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim).

This plugin is inspired by [neco-look](https://github.com/ujihisa/neco-look).

## Required

You should have `look` command.

## Install

It depends `async.vim`.

### vim-plug

```
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'gonzoooooo/asyncomplete-look.vim'
```

### dein.vim

```toml
[[plugins]]
repo = 'prabirshrestha/async.vim'

[[plugins]]
repo = 'prabirshrestha/asyncomplete.vim'

[[plugins]]
repo = 'gonzoooooo/asyncomplete-look.vim'
```

## Registration

```
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#look#get_source_options({
  \ 'name': 'look',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#look#completor'),
  \ 'config': {
  \   'complete_min_chars': 2,
  \   'allow_first_capital_letter': 0,
  \ },
  \ }))
```

### complete_min_chars

If `complete_min_chars` is set, do not show the completion popup until the specified number of characters is reached. (Optional)

If this is not set, `g:asyncomplete_min_chars` will be used.

### allow_first_capital_letter

If `allow_first_capital_letter` is `1`, the first letter will be completed in uppercase.

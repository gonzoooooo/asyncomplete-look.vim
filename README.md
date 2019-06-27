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
  \ }))
```

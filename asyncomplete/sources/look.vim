function! asyncomplete#sources#look#get_source_options(opts)
  return a:opts
endfunction

function! asyncomplete#sources#look#completor(opt, ctx)
  let l:col = a:ctx['col']
  let l:typed = a:ctx['typed']

  let l:keyword = matchstr(l:typed, '\v\S+$')
  let l:keyword_len = len(l:keyword)

  if l:keyword_len < 1
    return
  endif

  let l:start_col = l:col - l:keyword_len
  let l:info = { 'start_col': l:start_col, 'opt': a:opt, 'ctx': a:ctx, 'lines': [] }
  let l:cmd = ['look', l:keyword]

  call async#job#start(l:cmd, {
    \   'on_stdout': function('s:handler', [l:info]),
    \   'on_exit': function('s:handler', [l:info])
    \ })
endfunction

function! s:handler(info, id, data, event) abort
  if a:event == 'exit'
    call asyncomplete#log('asyncomplete-look.vim', 'exitcode', a:data)

    let l:ctx = a:info['ctx']
    let l:start_col = a:info['start_col']
    let l:matches = map(a:info['lines'], '{ "word" : v:val, "dup" : 1, "icase" : 1, "menu" : "look" }')

    call asyncomplete#complete(a:info['opt']['name'], l:ctx, l:start_col, l:matches)
  elseif a:event == 'stdout'
    let a:info['lines'] += a:data
  endif
endfunction


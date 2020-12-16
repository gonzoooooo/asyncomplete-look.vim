function! asyncomplete#sources#look#get_source_options(opts)
  return a:opts
endfunction

function! asyncomplete#sources#look#completor(opt, ctx)
  let l:col = a:ctx['col']
  let l:typed = a:ctx['typed']

  let l:keyword = matchstr(l:typed, '\v[a-z,A-Z]+$')
  let l:keyword_len = len(l:keyword)

  if l:keyword_len < 1
    return
  endif

  let l:start_col = l:col - l:keyword_len
  let l:info = { 'start_col': l:start_col, 'opt': a:opt, 'ctx': a:ctx, 'lines': [] }
  let l:cmd = ['look', l:keyword]

  let l:dict = get(g:, 'asyncomplete#sources#look#dict', v:none)
  if v:none != l:dict
    let l:cmd = l:cmd + [l:dict]
  endif

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

    let l:linelen = len(a:info['lines'])
    let l:matches = map(repeat([{}], l:linelen), {k,v -> copy({'dup' : 1, 'icase' : 1, 'menu' : 'look' })})

    for l:linenr in range(l:linelen)
      let l:linesplit = split(a:info['lines'][l:linenr])

      if len(l:linesplit) != 0
        let l:matches[l:linenr]['word'] = l:linesplit[0]
        if len(l:linesplit) > 1
          let l:matches[l:linenr]['info'] = join(l:linesplit[1:], ' ')
        endif
      endif
    endfor

    call asyncomplete#complete(a:info['opt']['name'], l:ctx, l:start_col, l:matches)
  elseif a:event == 'stdout'
    let a:info['lines'] += a:data
  endif
endfunction


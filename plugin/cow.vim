"==============================================================
"    file: cow.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfy
"   email: tenfy@tenfy.cn
" created: 2019-03-15 09:04:04
"==============================================================

if exists('g:cow_version')
  finish
endif
let g:cow_version=0.1.0
lockvar g:cow_version

function! s:close_win(direction)
  if a:direction !~# '^[hjkl]$'
    return
  endif

  let origin_winid = win_getid()
  exec printf("normal \<c-w>%d%s", v:count1, a:direction)
  let to_close_winid = win_getid()
  if origin_winid == to_close_winid
    return
  endif

  let to_close_name = bufname('%')
  if to_close_name == ''
    let to_close_name = '<Untitled>'
  endif
  if &modified && !&hidden
    echohl WarningMsg
    echom "cow: " . to_close_name . " the buffer is modified, please save it first."
    silent call win_gotoid(origin_winid)
    echohl None
    return
  endif

  silent close
  silent call win_gotoid(origin_winid)
endfunction

nnoremap <silent><Plug>(cow-close-h) :<c-u>call <sid>close_win('h')<cr>
nnoremap <silent><Plug>(cow-close-j) :<c-u>call <sid>close_win('j')<cr>
nnoremap <silent><Plug>(cow-close-k) :<c-u>call <sid>close_win('k')<cr>
nnoremap <silent><Plug>(cow-close-l) :<c-u>call <sid>close_win('l')<cr>


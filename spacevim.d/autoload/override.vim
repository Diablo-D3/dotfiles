function! override#before() abort
  let g:coc_disable_startup_warning = 1;
endfunction

function! override#after() abort
  set nowrap
  set norelativenumber
endfunction

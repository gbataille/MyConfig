if stridx(expand('%:p'), '/luxrender/') != -1
  let g:syntastic_cpp_include_dirs = [
    \   '/Users/gregou/Documents/Prog/lux/macos/include'
    \ , '/Users/gregou/Documents/Prog/lux/macos/include/LuxRays'
    \ , '/Users/gregou/Documents/Prog/lux/luxrender/core' ]
endif

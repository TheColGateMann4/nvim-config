function! TextObj_Function_Select() range
  return v:lua.require('depends.textobjs').functions()
endfunction

function! TextObj_Class_Select() range
  return v:lua.require('depends.textobjs').classes()
endfunction

call textobj#user#plugin('function', {'select-a-function': 'TextObj_Function_Select','select-i-function': 'TextObj_Function_Select'})

call textobj#user#plugin('class', {'select-a-function': 'TextObj_Class_Select','select-i-function': 'TextObj_Class_Select'})

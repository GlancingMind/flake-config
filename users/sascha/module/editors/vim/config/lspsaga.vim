lua << EOF
local saga = require 'lspsaga'

-- use default config for now.
-- saga.init_lsp_saga()

saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
  border_style = "round",
}
EOF

" popup window smart scroll settings
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" lsp finder
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

" show code actions
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

" show hover doc
nnoremap <silent> K <Cmd>Lspsaga hover_doc<CR>

" show signature help
nnoremap <silent> <leader>gs <Cmd>Lspsaga signature_help<CR>

" show rename window
nnoremap <silent> <leader>rs <Cmd>Lspsaga rename<CR>

" preview definition
nnoremap <silent> <leader>pd :Lspsaga preview_definition<CR>

" show diagnostics
nnoremap <silent> <leader>sd :Lspsaga show_line_diagnostics<CR>
" jump diagnostic
nnoremap <silent> <leader>nd :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> <leader>pd :Lspsaga diagnostic_jump_prev<CR>

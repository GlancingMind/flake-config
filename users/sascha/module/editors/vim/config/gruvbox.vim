" =====================
" gruvbox config

let g:gruvbox_contrast_dark = "soft"
let g:gruvbox_contrast_light = "soft"

" Set colorscheme once to apply above mentioned settings
" See https://github.com/morhetz/gruvbox/wiki/Troubleshooting for reference
if exists("g:colors_name") && g:colors_name ==# "gruvbox"
    "Reload gruvbox colorscheme
    colorscheme gruvbox
endif

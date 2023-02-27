command! Nvterm lua require'nvterm'.run('', '')
command! NvtermSplit lua require'nvterm'.run('v', '')
command! NvtermVSplit lua require'nvterm'.run('h', '')
command! Unittest lua require'nvterm'.run('h', 'python unittest')

local M = {}

M.get_term_txt = function(split)
    local split_txt = ''
    if(split == 'h') then
        split_txt = ':split | '
    elseif(split == 'v') then
        split_txt = ':vsplit | '
    end
    return split_txt .. 'terminal'
end

M.get_cmd_tbl = function()
    local cmd_tbl = {}
    cmd_tbl['python unittest'] = '"python3 -m unittest\\n")'
    return cmd_tbl
end

M.get_cmd_txt = function(cmd)
    local cmd_tbl = M.get_cmd_tbl()
    local cmd_txt = cmd_tbl[cmd]
    if(cmd_txt == nil) then
        return nil
    else
        return ':call jobsend(b:terminal_job_id, ' .. cmd_txt
    end
end

M.run = function(split, cmd)
    local term_txt = M.get_term_txt(split)
    vim.cmd(term_txt)
    local cmd_txt = M.get_cmd_txt(cmd)
    if(cmd_txt ~= nil) then
        vim.cmd(cmd_txt)
    end
end

return M

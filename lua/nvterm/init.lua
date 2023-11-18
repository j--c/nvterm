local M = {}
M.cmd_tbl = {}

M.add_cmd = function(key, cmd)
    M.cmd_tbl[key] = cmd
end

M.run = function(split, cmd)
    local term_txt = M.get_term_txt(split)
    if(term_txt ~= nil) then
        vim.cmd(term_txt)
    end

    local cmd_txt = M.get_cmd_txt(cmd)
    if(cmd_txt ~= nil) then
        vim.cmd(cmd_txt)
    end
end

M.get_term_txt = function(split)
    local split_txt = ''
    if(split == 'h') then
        split_txt = ':split | '
    elseif(split == 'v') then
        split_txt = ':vsplit | '
    end
    return split_txt .. 'terminal'
end

M.get_cmd_txt = function(cmd)
    local cmd_txt = M.cmd_tbl[cmd]
    if(cmd_txt == nil) then
        return nil
    else
        return ':call jobsend(b:terminal_job_id, ' .. cmd_txt .. '\\n\")' 
    end
end

return M

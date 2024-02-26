local get_term_txt = function(split)
    local split_txt = ''
    if(split == 'h') then
        split_txt = ':split | '
    elseif(split == 'v') then
        split_txt = ':vsplit | '
    end
    return split_txt .. 'terminal'
end

local get_cmd_txt = function(cmd, cmd_tbl, parms)
    local cmd_txt = ''
    if parms ~= nil then
        for _, v in ipairs(parms) do
            cmd_txt = cmd_tbl[cmd] .. ' ' .. v
        end
    else
        cmd_txt = cmd_tbl[cmd]
    end
    if(cmd_txt == nil) then
        return nil
    else
        return ':call jobsend(b:terminal_job_id, "' .. cmd_txt .. '\\n\")'
    end
end

local M = {
    ['cmds'] = {}
}

M.add_cmd = function(key, cmd)
    if(M.cmds[key] == nil) then
        M.cmds[key] = cmd
    end
end

M.setup = function(commands)
    for k, v in pairs(commands) do
        M.add_cmd(k, v)
    end
end

M.run = function(split, cmd, parms)
    local term_txt = get_term_txt(split)
    if(term_txt ~= nil) then
        vim.cmd(term_txt)
    end

    local cmd_txt = get_cmd_txt(cmd, M.cmds, parms)
    if(cmd_txt ~= nil) then
        vim.cmd(cmd_txt)
    end
end

return M

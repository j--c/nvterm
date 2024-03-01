local get_param_string_from_file = function(paramfile)
    local file_param_string = ''
    local f = io.open(paramfile, 'r')
    if f then
        file_param_string = f:read('all')
        f:close()
    end
    return string.gsub(file_param_string, '[\n\r]', '')
end


local get_param_string_from_cmd_tbl = function(cmd_tbl, cmd_idx)
    local cmd_param_string = ''
    for _, v in ipairs(cmd_tbl) do
        if v.index == cmd_idx then
            if v.paramfile ~= nil then
                cmd_param_string = get_param_string_from_file(v.paramfile)
            end
        end
    end
    return cmd_param_string
end


local get_term_string = function(split)
    local split_string = ''
    if(split == 'h') then
        split_string = ':split | '
    elseif(split == 'v') then
        split_string = ':vsplit | '
    end
    return split_string .. 'terminal'
end


local get_cmd_string = function(cmd_tbl, cmd_idx)
    local cmd_string = ''
    for _, v in ipairs(cmd_tbl) do
        if v.index == cmd_idx then
            cmd_string = v.command
        end
    end
    return cmd_string
end

local M = {
}


M.setup = function()
    local slash = package.config:sub(1, 1)
    local home_dir = vim.loop.os_homedir()
    local cmd_dir = home_dir .. slash.. '.nvterm'
    package.path = package.path .. ";" .. cmd_dir .. slash ..'?.lua'
    M.cmd_tbl = require('cmds')
end


M.run = function(split, cmd_idx)
    local cmd_w_param_string = ''
    local term_txt = get_term_string(split)
    local cmd_string = get_cmd_string(M.cmd_tbl, cmd_idx)
    local param_string = get_param_string_from_cmd_tbl(M.cmd_tbl, cmd_idx)
    if cmd_string ~= '' then
        cmd_w_param_string = cmd_string
        if param_string ~= '' then
            cmd_w_param_string = cmd_string .. ' ' .. param_string
        end
    end

    if(term_txt ~= '') then
        vim.cmd(term_txt)
    end
    if cmd_w_param_string ~= '' then
        --print(cmd_w_param_string)
        vim.cmd(':call jobsend(b:terminal_job_id, "' .. cmd_w_param_string .. '\\n\")')
    end
end


return M

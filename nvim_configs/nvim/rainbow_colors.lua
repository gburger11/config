local colors = {
    "#e06c75",  -- soft red
    "#61afef",  -- sky blue
    "#98c379",  -- green
    "#e5c07b",  -- yellow
    "#c678dd",  -- purple
    "#56b6c2",  -- cyan
    "#d19a66",  -- orange
    "#be5046",  -- dark red
    "#528bff",  -- bright blue
    "#7ec8a0",  -- mint
    "#e0af68",  -- amber
    "#bb9af7",  -- lavender
    "#73daca",  -- teal
    "#ff9e64",  -- peach
    "#9ece6a",  -- lime
    "#f7768e",  -- pink
    "#2ac3de",  -- aqua
    "#d4a574",  -- sand
    "#7aa2f7",  -- periwinkle
    "#ad8ee6",  -- mauve
    "#4ec9b0",  -- seafoam
    "#ce9178",  -- salmon
    "#dcdcaa",  -- tan
    "#b5cea8",  -- sage
    "#f48fb1",  -- rose
    "#80cbc4",  -- pale teal
    "#fff07b",  -- pale yellow
    "#a8cc8c",  -- muted green
    "#569cd6",  -- steel blue
}
local ns = vim.api.nvim_create_namespace("rainbow_vars")

local function hash_name(text)
    local h = 5381
    for i = 1, #text do
        h = bit.band(h * 33 + string.byte(text, i), 0xFFFFFF)
    end
    return h
end

local function rainbow_vars_v0(bufnr)
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    local parser = vim.treesitter.get_parser(bufnr)
    if not parser then return end
    local query = vim.treesitter.query.get(parser:lang(), "highlights")
    if not query then return end
    local tree = parser:parse()[1]
    local node_found = nil
    local found = false
    local blocked = true
    for id, node in query:iter_captures(tree:root(), bufnr) do
        local name = query.captures[id]
        if name:match("^variable") then
            found = true
            node_found = node

            local text = vim.treesitter.get_node_text(node_found, bufnr)
            local color = colors[(hash_name(text) % #colors) + 1]
            local row1, col1, row2, col2 = node_found:range()
            local hl_group = "RainbowVar_" .. text:gsub("[^%w]", "_")
            vim.api.nvim_set_hl(0, hl_group, { fg = color })
            vim.api.nvim_buf_set_extmark(bufnr, ns, row1, col1,
                { end_row = row2, end_col = col2, hl_group = hl_group, priority = 200 })
        end
    end
end

local function rainbow_vars(bufnr)
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    local parser = vim.treesitter.get_parser(bufnr)
    if not parser then return end
    local query = vim.treesitter.query.get(parser:lang(), "highlights")
    if not query then return end
    local tree = parser:parse()[1]

    -- First pass: collect all nodes captured as functions
    local function_nodes = {}
    for id, node in query:iter_captures(tree:root(), bufnr) do
        local name = query.captures[id]
        if name:match("^function") or name:match("^constant.macro") or name:match("operator") or name:match("^module") then
            local row1, col1, _, _ = node:range()
            function_nodes[row1 .. ":" .. col1] = true
        end
    end

    -- Second pass: color variables that are not in function_nodes
    for id, node in query:iter_captures(tree:root(), bufnr) do
        local name = query.captures[id]
        if name:match("^variable") then
            local row1, col1, row2, col2 = node:range()
            local key = row1 .. ":" .. col1
            if not function_nodes[key] then
                local text = vim.treesitter.get_node_text(node, bufnr)
                local color = colors[(hash_name(text) % #colors) + 1]
                -- local hl_group = "RainbowVar_" .. text:gsub("[^%w]", "_")
                local hl_group = "RainbowVar_" .. color:gsub("#", "")
                vim.api.nvim_set_hl(0, hl_group, { fg = color })
                vim.api.nvim_buf_set_extmark(bufnr, ns, row1, col1,
                    { end_row = row2, end_col = col2, hl_group = hl_group, priority = 200 })
            end
        end
    end
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "TextChanged"},  {
    callback = function(args) rainbow_vars(args.buf) end
})

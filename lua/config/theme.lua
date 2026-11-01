-- One theme for the terminal, tmux and Neovim, picked with <leader>tt or :Theme.
-- ~/.config/theme/theme owns the choice: it recolors the terminal and tmux and writes the theme in
-- use to a state file, which every running Neovim watches and follows. Every custom color lives here,
-- so it survives :colorscheme reloads.
local M = {}

local dir = vim.fn.expand("~/.config/theme")
local script = dir .. "/theme"
local state = vim.env.THEME_STATE or ((vim.env.XDG_STATE_HOME or vim.fn.expand("~/.local/state")) .. "/theme")

-- hand-picked for Tokyo Night; the other themes derive theirs from their palette
local custom = {
    ["tokyonight-night"] = {
        indent = { "#353E5B", "#384A5D", "#403A58", "#2C4755", "#3C4738", "#4D4339" },
        rainbow = { "#698cd6", "#68b3de", "#9a7ecc", "#25aac2", "#80a856", "#c49a5a" },
        scope = "#b0bcf2",
        header = "#709ad2",
        picker = "#9d7cd8",
        line_nr = "#737aa2",
    },
}

local function first_line(path)
    local file = io.open(path)
    if not file then
        return nil
    end
    local line = file:read("*l")
    file:close()
    return line
end

-- the key=value files the theme script sources
local function read_vars(path)
    local vars = {}
    for line in io.lines(path) do
        local key, value = line:match("^([%w_]+)=(.*)$")
        if key then
            vars[key] = value:match('^"(.-)"') or value:gsub("%s+#.*$", "")
        end
    end
    return vars
end

local function config()
    local ok, vars = pcall(read_vars, dir .. "/config")
    return ok and vars or { default = "tokyonight-night" }
end

local function load(name)
    local ok, theme = pcall(read_vars, ("%s/themes/%s.sh"):format(dir, name))
    if not ok then
        return nil
    end
    theme.name = name
    return theme
end

local function blend(fg, bg, alpha)
    local out = "#"
    for i = 2, 6, 2 do
        local f, b = tonumber(fg:sub(i, i + 1), 16), tonumber(bg:sub(i, i + 1), 16)
        out = out .. ("%02x"):format(math.floor(f * alpha + b * (1 - alpha) + 0.5))
    end
    return out
end

local function derive(theme)
    local rainbow = { theme.blue, theme.cyan, theme.purple, theme.teal, theme.green, theme.orange }
    local alpha = theme.appearance == "light" and 0.4 or 0.25
    return {
        rainbow = rainbow,
        indent = vim.tbl_map(function(color) return blend(color, theme.background, alpha) end, rainbow),
        scope = blend(theme.accent, theme.foreground, 0.5),
        header = theme.accent,
        picker = theme.purple,
        line_nr = theme.muted,
    }
end

local function highlight()
    local theme = M.current
    if not theme or vim.g.colors_name ~= theme.colorscheme then
        return -- a colorscheme loaded by hand keeps its own colors
    end
    local c = custom[theme.name] or derive(theme)
    local set = vim.api.nvim_set_hl

    set(0, "CursorLine", {}) -- only the line number is highlighted
    set(0, "CursorLineNr", { fg = c.line_nr, bold = true })
    set(0, "MatchParen", { link = "LspReferenceText" })
    for i = 1, 6 do
        set(0, "SnacksIndent" .. i, { fg = c.indent[i] })
        set(0, "RainbowDelimiter" .. i, { fg = c.rainbow[i] })
    end
    set(0, "SnacksIndentScope", { fg = c.scope })
    set(0, "SnacksDashboardHeader", { fg = c.header })
    for _, group in ipairs({ "SnacksPickerInputBorder", "SnacksPickerInputTitle", "SnacksPickerPrompt" }) do
        set(0, group, { fg = c.picker })
    end
end

-- a bar color of the theme in use (accent, surface, dark, muted), for lualine
function M.color(key)
    local fallback = { accent = "#7aa2f7", surface = "#3b4261", dark = "#15161e", muted = "#a9b1d6" }
    return M.current and M.current[key] or fallback[key]
end

-- follow the theme the script says is in use
function M.sync()
    local name = first_line(state .. "/current") or config().default
    if M.current and M.current.name == name then
        return
    end
    M.current = load(name)
    vim.cmd.colorscheme(M.current and M.current.colorscheme or "tokyonight-night")
end

function M.set(name)
    if vim.fn.executable(script) == 0 then
        return vim.notify("theme script not found: " .. script, vim.log.levels.ERROR)
    end
    vim.system({ script, "set", name }, { text = true }, function(result)
        if result.code ~= 0 then
            vim.schedule(function() vim.notify(vim.trim(result.stderr), vim.log.levels.ERROR) end)
        end
    end)
end

function M.names()
    local names = { "auto" }
    for _, path in ipairs(vim.fn.glob(dir .. "/themes/*.sh", false, true)) do
        table.insert(names, vim.fn.fnamemodify(path, ":t:r"))
    end
    return names
end

function M.pick()
    local cfg = config()
    local chosen = first_line(state .. "/chosen") or cfg.default
    local function label(name)
        if name == "auto" then
            local dark, light = load(cfg.auto_dark), load(cfg.auto_light)
            return ("Auto: %s in dark mode, %s in light"):format(dark and dark.label, light and light.label)
        end
        return load(name).label
    end

    vim.ui.select(M.names(), {
        prompt = "Theme",
        format_item = function(name) return (name == chosen and "● " or "  ") .. label(name) end,
    }, function(name)
        if name then
            M.set(name)
        end
    end)
end

function M.setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("Theme", { clear = true }),
        desc = "Apply the custom colors of the theme in use",
        callback = highlight,
    })
    vim.api.nvim_create_user_command("Theme", function(opts)
        if opts.args == "" then
            M.pick()
        else
            M.set(opts.args)
        end
    end, { nargs = "?", complete = M.names, desc = "Pick or set the theme" })

    M.sync()

    vim.fn.mkdir(state, "p")
    vim.uv.new_fs_event():start(
        state,
        {},
        vim.schedule_wrap(function(err)
            if not err then
                M.sync()
            end
        end)
    )
end

return M

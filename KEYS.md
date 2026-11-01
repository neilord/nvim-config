# Keys

Leader is `Space`. Press it and wait: which-key lists what can follow, groups marked with `+`.
`<leader>?` opens this page, `<leader>sk` searches every keymap, `q` closes this window.

## Leader groups

### `<leader>s` Search

| Keys | Action |
|---|---|
| `<leader>f` · `<leader>F` | Files · text (outside the group, used most) |
| `sr` · `sw` · `so` | Resume last search · word or selection · recent files |
| `sd` · `ss` · `sS` | Diagnostics · symbols in file · symbols in workspace |
| `sg` · `sq` · `sH` | Git changes · quickfix list · help pages |
| `sk` · `sh` · `sc` | Keymaps · highlight groups · config files |
| `sp` · `st` | Plugins (Lazy) · tools (Mason) |

In any picker: `<C-q>` sends the results to the quickfix list, `<Tab>` selects several.

### `<leader>l` Code / LSP

| Keys | Action |
|---|---|
| `lf` | **Format** the file, or the selection |
| `la` · `ln` | Code action · rename symbol |
| `ld` · `lq` | Diagnostics on this line · all diagnostics to quickfix |
| `lr` · `li` | Restart LSP · LSP info |

### `<leader>h` Git hunk

| Keys | Action |
|---|---|
| `hs` · `hr` | Stage / reset the hunk (or selected lines) |
| `hS` · `hR` | Stage / reset the whole buffer |
| `hp` · `hb` · `hd` | Preview hunk · blame line · diff the file |

### `<leader>x` Debug

| Keys | Action |
|---|---|
| `xc` · `xq` | Start or continue · stop |
| `xo` · `xi` · `xu` | Step over · into · out |
| `xC` · `xl` | Run to cursor · rerun the last session |
| `xp` · `xx` | Log point · clear all breakpoints |
| `xe` · `xw` · `xv` | Evaluate · add a watch · toggle the panel |

### `<leader>c` Claude

| Keys | Action |
|---|---|
| `cc` · `cf` | Toggle · focus the Claude terminal |
| `cb` · `cs` | Add this buffer · send the selection |
| `ca` · `cd` | Accept · reject Claude's proposed diff |

### `<leader>t` Toggle and `<leader>r` Replace

| Keys | Action |
|---|---|
| `tb` · `td` · `ti` | Line blame · diagnostics · inlay hints |
| `th` · `ts` · `tw` | Search highlight · spell check · line wrap |
| `tt` | **Theme** for the terminal, tmux, Neovim and CLI tools, or Auto to follow macOS |
| `rw` | Replace the word under the cursor (or the selection) in the file |

## Single leader keys

| Keys | Action |
|---|---|
| `<leader>f` · `<leader>F` · `<leader>,` | Find files · find text · buffers |
| `<leader>e` · `<leader>E` | File tree · reveal current file |
| `<leader>a` · `<C-e>` · `<leader>1`–`4` | Harpoon: add file · menu · jump to file 1–4 |
| `<leader>w` · `<leader>W` | Save · save without formatting |
| `<leader>q` · `<leader>Q` | Quit all · force quit |
| `<leader>g` · `<C-/>` | LazyGit · floating terminal |
| `<leader>u` | Undo history tree |
| `<leader>b` · `<leader>B` | Toggle breakpoint · conditional breakpoint |
| `<leader>y` `Y` · `<leader>d` `D` | Yank / cut to the system clipboard |
| `<leader>p` (visual) | Paste over the selection, keep what you yanked |

## Code (LSP)

| Keys | Action |
|---|---|
| `gd` · `grr` · `gri` · `grt` | Definition · references · implementations · type definition |
| `K` · `<C-k>` (insert) | Hover docs · signature help |
| `grn` · `gra` | Rename · code action (same as `<leader>ln`, `<leader>la`) |
| `gO` | Symbols in this file |
| `]d` `[d` · `]D` `[D` · `<C-w>d` | Next/previous diagnostic · last/first · show it in a float |
| `<leader>lf` · `gq{motion}` | Format file or selection · format a motion |
| `gcc` · `gc{motion}` | Toggle comment on a line · over a motion |
| `<CR>` · `<C-n>` `<C-p>` · `<C-e>` · `<C-Space>` | Completion: accept · next/previous · close · open |
| `<Tab>` / `<S-Tab>` | Jump to the next/previous snippet field |

## Git

| Keys | Action |
|---|---|
| `]c` · `[c` | Next / previous changed hunk |
| `ih` | Text object: the hunk under the cursor (`vih`, `dih`) |
| `:Git` · `:Git blame` · `:Gvdiffsplit` | Fugitive: status, blame, side-by-side diff |

## Debugging

| Keys | Action |
|---|---|
| `<F5>` | Start, or continue to the next breakpoint |
| `<F10>` · `<F11>` · `<F12>` | Step over · into · out |
| `<leader>b` · `<leader>B` | Breakpoint · conditional breakpoint |

In the debug panel, press the letters in its title bar to switch sections, `g?` for its keys.

## Windows and buffers

| Keys | Action |
|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move to the window left / below / above / right |
| `<C-w>v` · `<C-w>s` · `<C-w>q` · `<C-w>o` | Split vertically · horizontally · close · close all others |
| `<C-w>=` · `<C-w>_` · `<C-w>\|` | Equal sizes · maximize height · maximize width |
| `<C-^>` | Previous file |
| `<C-o>` · `<C-i>` | Back / forward through jumps |

## Vim essentials

The grammar is **operator + count + motion or text object**: `d3w` deletes three words, `ci"`
changes inside quotes, `yap` yanks a paragraph. `.` repeats the last change.

### Moving

| Keys | Action |
|---|---|
| `w` `b` `e` · `W` `B` `E` | Next word · back · end of word (capitals skip punctuation) |
| `0` · `^` · `$` | Line start · first non-blank · line end |
| `f{c}` `t{c}` · `F` `T` · `;` `,` | To / before next char · previous · repeat forward/back |
| `gg` · `G` · `{n}G` | First line · last line · line n |
| `{` · `}` · `%` | Previous / next blank line · matching bracket |
| `<C-d>` · `<C-u>` | Half page down / up, centered |
| `H` · `M` · `L` | Top / middle / bottom of the screen |
| `zz` · `zt` · `zb` | Scroll so the cursor line is centered / top / bottom |
| `*` · `#` · `n` `N` | Search word under cursor forward / back · next / previous match |
| `` `. `` · `gi` | Last change · back to insert where you left off |

### Operators

| Keys | Action |
|---|---|
| `d` · `c` · `y` | Delete · change (delete and insert) · yank |
| `dd` · `cc` · `yy` | Whole line |
| `D` · `C` · `Y` | To the end of the line |
| `>` `<` · `=` | Indent / dedent · re-indent |
| `gu` · `gU` · `~` | Lowercase · uppercase · toggle case |
| `p` · `P` | Paste after / before |
| `u` · `U` | Undo · redo |
| `J` · `+` `-` | Join lines · increment / decrement a number |
| `x` | Delete the char (does not overwrite the yank register) |

### Text objects

Use after an operator or in visual mode. `i` is inside, `a` includes the surrounding.

| Keys | Selects |
|---|---|
| `iw` `aw` · `ip` `ap` | Word · paragraph |
| `i"` `i'` `` i` `` · `i(` `i[` `i{` `i<` | Inside quotes · inside brackets |
| `it` `at` | Inside / around an HTML or JSX tag |
| `if` `af` · `ic` `ac` | Function · class (treesitter) |
| `ia` `aa` | Function argument (targets.vim) |
| `an` · `in` | Grow / shrink the selection by syntax node (visual, needs LSP) |
| `ih` | Git hunk |

### Surround

| Keys | Action |
|---|---|
| `ysiw"` | Wrap a word in quotes |
| `cs"'` · `ds"` | Change `"` to `'` · delete the surrounding `"` |
| `S"` (visual) | Wrap the selection |
| `ysiwt` · `S` then `t` | Wrap a word · the selection in an HTML tag (asks for its name) |

### Visual, insert and macros

| Keys | Action |
|---|---|
| `v` · `V` · `<C-v>` | Visual characters · lines · block |
| `gv` · `o` | Reselect last selection · jump to the other end |
| `<S-j>` `<S-k>` (visual) | Move the selection down / up |
| `<C-v>` then `I` / `A` | Insert / append on every line of the block |
| `q{r}` … `q` · `@{r}` · `@@` | Record a macro into register r · play it · replay last |
| `<C-r>{r}` (insert) | Paste register r |
| `<C-w>` · `<C-u>` (insert) | Delete word / line before the cursor |

### Search and replace

| Keys | Action |
|---|---|
| `/text` · `?text` | Search forward / back; `<Esc>` clears the highlight |
| `:%s/old/new/g` | Replace in the file, previewed live while typing |
| `:s/old/new/g` (visual) | Replace in the selection |
| `<leader>rw` | Replace the word under the cursor, prefilled |
| `:cdo s/old/new/g` | Replace in every quickfix entry (after `<leader>F` and `<C-q>`) |

### Folds and marks

| Keys | Action |
|---|---|
| `za` · `zc` · `zo` | Toggle / close / open the fold under the cursor |
| `zM` · `zR` | Close all / open all |
| `m{a-z}` · `` `{a-z} `` | Set a mark · jump to it (capitals work across files) |
| `]s` `[s` · `z=` · `zg` | Next / previous misspelling · suggestions · add word |

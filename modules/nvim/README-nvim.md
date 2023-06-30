# Diablo-D3's Neovim Config

> Don’t put any lines in your vimrc that you don’t understand.
> <sup>-- tpope, possibly</sup>

I have used Vim for over 20 years, and recently filed for "vim config bankruptcy" and wiped away my old config when I transitioned to Neovim. My config sets out to only diverge from the standard when it actually makes sense to do so, and improves ergonomics.

This README mostly exists as a reminder to myself, but also as documentation to others to help them consider how to craft their own configs. This README does not serve as a tutorial to use Vim.

Vim functionalty can be divided into several important categories: core editing, syntax highlighting, autocompletion, navigation, formatting, and folding.

## Navigation

Navigation in Vim is done through several major methods; through the traditional `hjkl` keybinds, through buffer navigation, through pane navigation, through quickfix and the location list, and through `g` operators that serve as gotos, and `[`/`]` operator pairs.

### Panes

`CTRL-hljk` are frequently remapped to "move between panes", including being extended to also provide for Tmux navigation. Otherwise, their default mappings are "backspace, same as h", "redraw screen", "down, same as j", and the final being unmapped.

[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) is the most popular plugin to integrate Vim and Tmux navigation like this.

### Buffer navigation

I have never really found a way to effortlessly navigate through buffers that isn't more directed (`g` goto operators, project-wide fuzzy finders, etc), due to Vim never reusing buffer numbers. I wrote a plugin to map buffers to `CTRL-#` keys, [vim-yabs](https://github.com/Diablo-D3/vim-yabs).

I use [Trouble](https://github.com/folke/trouble.nvim) to manage quickfix, and [Fzf-Lua](https://github.com/ibhagwan/fzf-lua) to manage fuzzy finding.

| Map                 | Action                                |
| ------------------- | ------------------------------------- |
| `/`                 | In buffer fuzzy search                |
| `S-/`               | ... but continue with previous search |
| `C-/`               | Project-wide fuzzy search             |
| `C-S-/`             | ... but continue with previous search |
| `C-Tab`             | Previous buffer (formerly `C-6`)      |
| `C-1` through `C-9` | Select oldest non-hidden buffers      |
| `` C-` ``           | Fuzzy search buffers                  |
| `<leader>f`         | Fuzzy find files                      |
| `<leader>d`         | Diagnostics list                      |
| `<leader>t`         | Todo list                             |

### LSP and the `g` operators

The g operator means 'global', but also shares a mnemonic with 'goto'. Some of these are handled with Trouble or fzf-lua when available.

| Map     | Stock Neovim                  | nvim-lspconfig              |
| ------- | ----------------------------- | --------------------------- |
| `gd`    | Goto local declaration        | vim.lsp.buf.definition      |
| `gD`    | Goto global declaration       | vim.lsp.buf.declaration     |
| `gi`    | Unrelated (insert at '^ mark) | vim.lsp.buf.implementation  |
| `gq`    | Format                        | vim.lsp.buf.formatting      |
| `gt`    | Unrelated (goto next tab)     | vim.lsp.buf.type_definition |
| `gr`    | Unrelated (replace chars)     | vim.lsp.buf.rename          |
| `gR`    | Unrelated (replace chars)     | vim.lsp.buf.references      |
| `g.`    | Unbound                       | vim.lsp.buf.code_action     |
| `K`     | Run keywordprog               | vim.lsp.buf.hover           |
| `<C-k>` | Unrelated (diagraph)          | vim.lsp.buf.signature_help  |

### `[`/`]` operator pairs

Many of these take capitals to do first/last instead of next/prev, many of these take a count; the heavy lifting is handled by the various modules of [mini.nvim](https://github.com/echasnovski/mini.nvim). Formerly, I used [vim-unimpaired](https://github.com/tpope/vim-unimpaired).

| Map  | Action                            | Source           |
| ---- | --------------------------------- | ---------------- |
| `]b` | Buffers                           | Mini-bracketed   |
| `]c` | Comments                          | Mini-bracketed   |
| `]x` | Conflict                          | Mini-bracketed   |
| `]d` | Diagnostic                        | Mini-bracketed   |
| `]f` | File                              | Mini-bracketed   |
| `]i` | Indent                            | Mini-bracketed   |
| `]j` | Jump                              | Mini-bracketed   |
| `]l` | Location                          | Mini-bracketed   |
| `]o` | Oldfile                           | Mini-bracketed   |
| `]q` | Quickfix                          | Mini-bracketed   |
| `]t` | Treesitter                        | Mini-bracketed   |
| `]u` | Undo                              | Mini-bracketed   |
| `]w` | Window                            | Mini-bracketed   |
| `]y` | Yank                              | Mini-bracketed   |
| `g]` | Goto specified text object        | Mini-ai          |
| `]i` | Jump to start/end of indent scope | Mini-indentscope |

### Fugitive

[vim-fugitive](https://github.com/tpope/vim-fugitive) is the equivalent of Magit for Vim, yet better than Magit.

| Map         | Action                     |
| ----------- | -------------------------- |
| `<leader>g` | Toggle Fugitive window     |
| `<CR>/o`    | Open file in split         |
| `>`/`<`     | Inline diff open and close |
| `s` / `u`   | Stage or unstage hunk      |
| `]c`/`]c`   | Hunk forwards/backwards    |
| `cc`        | Commit                     |
| `ca`        | Amend commit               |

### Textobjects

Vim textobjects often come with `a`, `i`, and `o` prefixes, for around, inner, and outer; inner only selects whats inside the block, around selects whats inside and the block itself, and outer selects the entire block that contains the selector. Outer and around are usually the same thing.

[Mini-ai](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md) and [nvim-treesitter-textsubjects](https://github.com/RRethy/nvim-treesitter-textsubjects) adds flexibility to what I can do with textobjects. Formerly, I used [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects).

[Mini-comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md) allows you to comment code using the `gc` operator. Formerly, I used [vim-commentary](https://github.com/tpope/vim-commentary).

| Textobject | Action               | Source           |
| ---------- | -------------------- | ---------------- |
| `w`        | Word                 | Vim              |
| `s`        | Sentence             | Vim              |
| `p`        | Paragraph            | Vim              |
| `.`        | Smart                | TS-textsubjects  |
| `;`        | Outer Container      | TS-textsubjects  |
| `[`        | `[]` brackets        | Mini-ai enhanced |
| `(`        | `()` brackets        | Mini-ai enhanced |
| `{`        | `{}` brackets        | Mini-ai enhanced |
| `<`        | `<>` brackets        | Mini-ai enhanced |
| `b`        | Any kind of brackets | Mini-ai enhanced |
| `` ` ``    | Backtick quote       | Mini-ai enhanced |
| `'`        | Single quote         | Mini-ai enhanced |
| `"`        | Double quote         | Mini-ai enhanced |
| `q`        | Any kind of quote    | Mini-ai enhanced |
| `t`        | XML/SGML tag         | Mini-ai enhanced |
| `n`        | Next of same kind    | Mini-ai          |
| `l`        | Last of same kind    | Mini-ai          |
| `a`        | Argument (Paramter)  | Mini-ai          |
| `f`        | Function call        | Mini-ai          |
| `c`        | Class                | Mini-ai + TS     |
| `f`        | Function             | Mini-ai + TS     |
| `o`        | TS Block             | Mini-ai + TS     |
| `gc`       | Comment              | Mini-comment     |

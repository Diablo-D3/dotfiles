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

I use [Trouble](https://github.com/folke/trouble.nvim) to manage quickfix, and [Telescope](https://github.com/nvim-telescope/telescope.nvim) to manage fuzzy finding.

| Map                 | Action                           |
| ------------------- | -------------------------------- |
| `/`                 | In buffer fuzzy search           |
| `<leader>/`         | Project-wide fuzzy search        |
| `C-Tab`             | Previous buffer (formerly `C-6`) |
| `C-1` through `C-9` | Select oldest non-hidden buffers |
| `` C-` ``           | Fuzzy search buffers             |
| `<leader>f`         | Fuzzy find files                 |
| `<leader>d`         | Diagnostics list                 |
| `<leader>q`         | Quickfix list                    |
| `<leader>l`         | Location list                    |

### LSP and the `g` operator gotos

| Map         | Stock Neovim                  | nvim-lspconfig          |
| ----------- | ----------------------------- | ----------------------- |
| `gd`        | Goto local declaration        | lsp.buf.definition      |
| `gD`        | Goto global declaration       | lsp.buf.declaration     |
| `gi`        | Unrelated (insert at '^ mark) | lsp.buf.implementation  |
| `gt`        | Unrelated (goto next tab)     | lsp.buf.type_definition |
| `gq`        | Format                        | lsp.buf.buf.formatting  |
| `gr`        | Unrelated (replace chars)     | lsp.buf.references      |
| `K`         | Run keywordprog               | lsp.vim.lsp.hover       |
| `<leader>r` | Rename                        | lsp.buf.rename          |

`gr` will open in Trouble. Treesitter will implement `gd` and `<leader>r` when LSP isn't enabled.

### `[`/`]` operator pairs

Many of these take capitals to do first/last instead of next/prev, many of these take a count; the heavy lifting is provided by [vim-unimpaired](https://github.com/tpope/vim-unimpaired).

| Map      | Action              |
| -------- | ------------------- |
| `]a`     | Files in arg list   |
| `]b`     | Buffers             |
| `]l`     | Location list       |
| `]q`     | Quickfix list       |
| `]<SPC>` | Add _n_ blank lines |
| `]e`     | Move line by _n_    |
| `]p`     | Paste               |

`]q` is overridden by Trouble to do the same thing.

### Fugitive

[vim-fugitive](https://github.com/tpope/vim-fugitive) is the equivalent of Magit for Vim, yet better than Magit.

| Map         | Action                     |
| ----------- | -------------------------- |
| `<leader>g` | Open Fugitive status       |
| `<CR>/o`    | Open file in split         |
| `>`/`<`     | Inline diff open and close |
| `s`         | Stage hunk                 |
| `u`         | Unstage hunk               |
| `]c`/`]c`   | Hunk forwards/backwards    |
| `cc`        | Commit                     |
| `ca`        | Amend commit               |

### Motions and Commentary

Vim motions often come with `a`, `i`, and `o` prefixes, for any, inner, and outer; inner only selects whats inside the block, any selects whats inside and the block, and outer selects the entire block that contains the selector.

[vim-commentary](https://github.com/tpope/vim-commentary) allows you to comment code using the `gc` operator, and it takes motions.

| Motion    | Action               | Source     |
| --------- | -------------------- | ---------- |
| `w`       | Word                 | Vim        |
| `s`       | Sentence             | Vim        |
| `p`       | Paragraph            | Vim        |
| `[`       | `[]` block           | Vim        |
| `(` / `b` | `()` block           | Vim        |
| `{` / `B` | `{}` block           | Vim        |
| `<`       | `<>` block           | Vim        |
| `t`       | XML/SGML tag         | Vim        |
| `` ` ``   | Backtick quote       | Vim        |
| `'`       | Single quote         | Vim        |
| `"`       | Double quote         | Vim        |
| `c`       | Class                | Treesitter |
| `f`       | Function             | Treesitter |
| `a`       | Argument (Paramater) | Treesitter |
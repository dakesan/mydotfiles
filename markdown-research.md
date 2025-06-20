# Lightweight Markdown Enhancement Alternatives for Neovim

## 研究結果サマリー

Neovimで軽量なマークダウン拡張を実現するため、以下の観点から調査を行いました：
1. 重いsyntaxファイルの読み込みを避ける
2. vim syntaxの代わりにtreesitterを使用
3. パフォーマンスへの影響を最小限に
4. 複雑な依存関係なしで視覚的な拡張を提供

## 問題の背景

現在コメントアウトされている`render-markdown.nvim`プラグインは、パフォーマンスの問題があることが判明しています。主な原因は：
- Treesitterとvim syntaxの両方が同時に動作する可能性
- 大きなマークダウンファイル（500行以上）でパフォーマンスが低下
- 追加のsyntaxファイルの読み込みによるオーバーヘッド

## 軽量な代替案

### 1. Treesitterのみを使用する最小構成

最も軽量なアプローチは、Neovimの組み込みTreesitter機能を直接使用することです：

```lua
-- treesitter.lua
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'markdown', 'markdown_inline' },
        highlight = {
          enable = true,
          -- 重要：vim syntaxを無効化してTreesitterのみを使用
          additional_vim_regex_highlighting = false,
        },
        -- 大きなファイルでパフォーマンスを維持
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      })
    end,
  },
}
```

### 2. mini.hipatterns による軽量パターンハイライト

特定のパターンのみをハイライトする最小限のアプローチ：

```lua
-- mini-hipatterns.lua
return {
  {
    'echasnovski/mini.hipatterns',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- マークダウン内のTODO、FIXME等をハイライト
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          
          -- 色コードのハイライト（例：#ff0000）
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
}
```

### 3. headlines.nvim - 軽量なマークダウン視覚拡張

`render-markdown.nvim`より軽量な代替案：

```lua
-- headlines.lua
return {
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    ft = { 'markdown' },
    config = function()
      require('headlines').setup({
        markdown = {
          headline_highlights = {
            'Headline1',
            'Headline2',
            'Headline3',
            'Headline4',
            'Headline5',
            'Headline6',
          },
          codeblock_highlight = 'CodeBlock',
          dash_highlight = 'Dash',
          quote_highlight = 'Quote',
          -- パフォーマンスのために一部機能を無効化
          fat_headlines = false,
          fat_headline_upper_string = '',
          fat_headline_lower_string = '',
        },
      })
    end,
  },
}
```

### 4. 最小限のカスタムTreesitterクエリ

Treesitterクエリを使用して特定の要素のみをハイライト：

```lua
-- 例：after/queries/markdown/highlights.scm
-- コードブロックの言語識別子をハイライト
(fenced_code_block
  (info_string) @keyword)

-- 見出しレベルごとに異なるハイライト
(atx_heading
  (atx_h1_marker) @markdown.h1.marker
  heading_content: (_) @markdown.h1)

(atx_heading
  (atx_h2_marker) @markdown.h2.marker
  heading_content: (_) @markdown.h2)
```

## パフォーマンス最適化のヒント

### 1. Conceallevelの制御

```lua
-- マークダウンファイルでのみconcealを無効化
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
```

### 2. 大きなファイルでの自動無効化

```lua
-- 500行以上のファイルで拡張機能を無効化
vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*.md',
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count > 500 then
      -- Treesitterやその他の重い機能を無効化
      vim.b.no_markdown_enhancements = true
    end
  end,
})
```

### 3. 遅延読み込みの活用

```lua
-- Lazy.nvimでの遅延読み込み設定
{
  'plugin-name',
  ft = { 'markdown' }, -- マークダウンファイルでのみ読み込み
  cmd = { 'MarkdownCommand' }, -- 特定のコマンドで読み込み
  event = 'VeryLazy', -- 起動後に読み込み
}
```

## 推奨構成

最もバランスの取れた軽量構成：

1. **基本**: nvim-treesitter（vim syntax無効化）
2. **視覚的拡張**: headlines.nvim（軽量設定）
3. **パターンハイライト**: mini.hipatterns（必要最小限）
4. **既存プラグイン**: autolist.nvimとmarkdown-preview.nvimは維持

この構成により、パフォーマンスを維持しながら、必要な視覚的拡張を実現できます。

## 実装例

```lua
-- plugins/markdown-lightweight.lua
return {
  -- Treesitter（最小構成）
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost *.md', 'BufNewFile *.md' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'markdown', 'markdown_inline' },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
      })
    end,
  },
  
  -- 軽量な視覚拡張
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    ft = 'markdown',
    opts = {
      markdown = {
        headline_highlights = false, -- 最小限の設定
        codeblock_highlight = 'CodeBlock',
        dash_highlight = 'Dash',
        quote_highlight = 'Quote',
      },
    },
  },
  
  -- 既存のautolistとmarkdown-previewは維持
}
```

## まとめ

`render-markdown.nvim`の代わりに、Treesitterベースの軽量なアプローチを採用することで、パフォーマンスを大幅に改善できます。特に：

1. vim syntaxを無効化してTreesitterのみを使用
2. 大きなファイルでの自動無効化
3. 必要最小限の視覚的拡張のみを有効化

これらの対策により、快適なマークダウン編集環境を維持しながら、パフォーマンスの問題を解決できます。
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

これは個人のdotfilesリポジトリで、主にZsh、Neovim、その他の開発ツールの設定を管理しています。ホスト名に基づいて自動的に環境を切り替える仕組みを採用しています（home/work/aws）。

## 主要コマンド

### セットアップ
```bash
# 全dotfilesをホームディレクトリにシンボリックリンクで配置
./deploy.sh

# RStudio用フォントのインストール
./rstudio-fonts.sh
```

### 設定の再読み込み
```bash
reload  # zshrcを再読み込み
```

### 設定ファイルの編集
```bash
zshconfig   # .zshrcを編集
vimconfig   # nvim設定を編集
```

## アーキテクチャ構造

### 環境切り替えシステム
- `.zshrc`がホスト名を判定し、適切な環境設定ファイルを読み込む
  - `DESKTOP-DLL*` → `.zsh/.zshhome`
  - `hpc*` → `.zsh/.zshwork`
  - `ip*` → `.zsh/.zshaws`
  - `hodake*` → `.zsh/.zshhome`

### 設定ファイル配置
```
dotfiles/
├── シェル設定（.zshrc, .zshenv, .zshfunc）
├── .zsh/（環境別設定）
│   ├── .zshhome
│   ├── .zshwork
│   └── .zshaws
├── .config/（各ツール設定）
│   ├── nvim（サブモジュール）
│   ├── yazi（サブモジュール）
│   ├── tmux/
│   ├── zellij/
│   └── その他ツール設定
└── oh-my-posh/（プロンプトテーマ）
```

### 依存関係
- Neovimとyaziはgitサブモジュールとして管理
- 多数のRust製CLIツール（bat、zoxide、sheldon等）を使用
- oh-my-poshでプロンプトをカスタマイズ

## 開発時の注意点

1. **シンボリックリンク管理**: `deploy.sh`が全てのシンボリックリンクを管理。新しい設定ファイルを追加する場合は必ずこのスクリプトを更新する

2. **環境別設定**: 新しい環境固有の設定は`.zsh/`ディレクトリ内の対応するファイルに追加

3. **サブモジュール**: nvimやyaziの設定を更新する場合は、サブモジュールのコミットも忘れずに更新

4. **プロキシ設定**: work環境では`proxy/proxy_adress.zsh`でプロキシ設定を管理（gitignoreされている）

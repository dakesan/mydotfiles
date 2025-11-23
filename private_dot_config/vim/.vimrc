" OSC 52を利用して、ヤンクした内容をシステムのクリップボードに送る設定
" by https://github.com/ojroques/vim-oscyank

if &term =~ '^(screen|tmux|rxvt|iterm)' || has('nvim')
  let s:osc_cmd = has('nvim') ? "\<Esc>]52;c;%s\<Bel>" : "\<Esc>]52;c;%s\x07"

  " ヤンクした内容をBase64エンコードしてOSC 52シーケンスを生成・出力する関数
  function! s:OSCYank()
    let text = getreg(v:register) " ヤンクした内容を取得
    if text == ''
      return
    endif
    " Base64エンコード (改行を削除)
    let b64_text = system('printf %s', shellescape(text)) . '| base64 | tr -d ''\n'''
    " OSC 52シーケンスを出力
    silent execute '!' . printf('printf -- ' . shellescape(s:osc_cmd), b64_text)
  endfunction

  " yキーとdキーにマッピング
  nnoremap <silent> y :set opfunc=<SID>OSCYank<CR>g@
  vnoremap <silent> y :<C-u>call <SID>OSCYank()<CR>
  nnoremap <silent> d :set opfunc=<SID>OSCYank<CR>g@
  vnoremap <silent> d :<C-u>call <SID>OSCYank()<CR>
endif

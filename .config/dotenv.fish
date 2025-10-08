# .env形式（KEY=VALUE行）を読み込みexportする簡易ローダー
function load_dotenv --description 'Load KEY=VALUE lines from a .env-style file'
    set -l file $argv[1]
    if test -z "$file"
        echo "Usage: load_dotenv /path/to/.env" >&2
        return 1
    end
    if not test -f "$file"
        return 0
    end

    # 行ごとに処理：空行/コメント(#)をスキップ、exportする
    # 注意: 値にスペースや引用符がある複雑ケースは最低限対応（両端の引用符を剥がす）
    while read -l line
        # trim前後空白
        set line (string trim -- $line)

        # スキップ条件
        if test -z "$line"
            continue
        end
        if string match -q '#*' -- $line
            continue
        end

        # KEY=VALUE に分割（最初の=のみ）
        set -l key (string split -m1 '=' -- $line)[1]
        set -l val (string split -m1 '=' -- $line)[2]

        # 無効行はスキップ
        if test -z "$key" -o -z "$val"
            continue
        end

        # 両端の引用符(" or ')を除去
        set val (string trim --chars='"' -- (string trim --chars="'" -- (string trim -- $val)))

        # export（fishは set -x で環境へ）
        # 既存値を上書きしたくない場合は条件を入れる: if not set -q $key; end
        set -x -- $key $val
    end < $file
end

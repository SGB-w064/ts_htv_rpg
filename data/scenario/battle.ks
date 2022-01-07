;各キャラのステータス定義
;プレイヤーの変数を配列に格納。[HP,Atk,Int,Speed]の順に格納
[eval exp="f.MyStatus = [100,25,30,12]"]
[eval exp="f.EnemyStatus = [100,18,0,10]"]
;HP表示のためのウインドウ表示
[layopt layer=message1 visible=true]
[current layer="message0"]
;確認用
敵味方のステータスを表示します。[r]
味方　HP:[emb exp="f.MyStatus[0]"],攻撃力:[emb exp="f.MyStatus[1]"],
魔力:[emb exp="f.MyStatus[2]"].素早さ:[emb exp="f.MyStatus[3]"][r]
敵　　HP:[emb exp="f.EnemyStatus[0]"],攻撃力:[emb exp="f.EnemyStatus[1]"],
魔力:[emb exp="f.EnemyStatus[2]"].素早さ:[emb exp="f.EnemyStatus[3]"][r][l][er]
;素早さ判定
*SpeedChk
[current layer="message0"]
素早さを判定します[r]
[iscript]
tf.randomMS = Math.floor(Math.random()*(15-1) + 1);
tf.randomES = Math.floor(Math.random()*(20-1) + 1);
[endscript]
[eval exp="f.MyStatus[3] = f.MyStatus[3] * tf.randomMS"]
[eval exp="f.EnemyStatus[3] = f.EnemyStatus[3] * tf.randomES"]
;素早さ確認用
味方の素早さ:[emb exp="f.MyStatus[3]"][r]
敵の素早さ:[emb exp="f.EnemyStatus[3]"][l][er]
[if exp="f.EnemyStatus[3]>f.MyStatus[3]"]
[eval exp="f.EF = 1"]
敵の先制攻撃![r]
@jump target=*EneAtk
[else]
[eval exp="f.MF = 1"]
先手を取りました!
@jump target=*main
[endif]
[s]

*main
[current layer="message0"]
自分のターンです。コマンドを選択してください
;バトルコマンドの表示
[glink x="120" y="610" width="200" text="攻撃" target="*MyAtk" color="green" size=20]
[glink x="500" y="610" width="200" text="魔法" target="*Mymagic" color="blue" size=20]
;HPウインドウの再読み込み
[current layer="message1"]
[er]
HP:[emb exp="f.MyStatus[0]"](自分)[r]
HP:[emb exp="f.EnemyStatus[0]"](敵)
[s]

;プレイヤーの攻撃ターン
*MyAtk
[current layer="message0"]
攻撃を選択しました[r]
;攻撃の数値処理
[iscript]
tf.randomM = Math.floor(Math.random()*(5-1) + 1);
tf.PA = Math.floor(f.MyStatus[1] * ((tf.randomM * 0.1) + 1))
[endscript]
;HP数値処理
[eval exp="f.EnemyStatus[0] = f.EnemyStatus[0] - tf.PA"]
[if exp="f.EnemyStatus[0] <= 0"]
[eval exp="f.EnemyStatus[0] = 0"]
[endif]
;HPの再読み込み
[current layer="message1"]
[er]
HP:[emb exp="f.MyStatus[0]"](自分)[r]
HP:[emb exp="f.EnemyStatus[0]"](敵)
;ダメージ表示
[current layer="message0"]
敵に[emb exp="tf.PA"]のダメージ[r][l][er]
;勝った時
[if exp="f.EnemyStatus[0] <= 0"]
@jump target=*debugW
[endif]
;敵のターンへ移動
@jump target=*EneAtk
[s]

;敵の攻撃ターン
*EneAtk
敵の攻撃ターンです[r][wait time="200"]
[iscript]
tf.randomE = Math.floor(Math.random()*(3-1) + 1);
tf.EA = Math.floor(f.EnemyStatus[1] * ((tf.randomE * 0.1) + 1))
[endscript]
[eval exp="f.MyStatus[0] = f.MyStatus[0] - tf.EA"]
[if exp="f.MyStatus[0] <= 0"]
[eval exp="f.MyStatus[0] = 0"]
[endif]
[current layer="message1"]
[er]
HP:[emb exp="f.MyStatus[0]"](自分)[r]
HP:[emb exp="f.EnemyStatus[0]"](敵)
[current layer="message0"]
味方に[emb exp="tf.EA"]のダメージ[r][l][er]
[if exp="f.MyStatus[0] <= 0"]
@jump target=*debugL
[endif]
@jump target=*main
[s]

*Mymagic
[current layer="message0"]
魔法を選択しました[r]
[eval exp="f.EnemyStatus[0] = f.EnemyStatus[0] - f.MyStatus[2]"]
[if exp="f.EnemyStatus[0] <= 0"]
[eval exp="f.EnemyStatus[0] = 0"]
[endif]
;HPの再読み込み
[current layer="message1"]
[er]
HP:[emb exp="f.MyStatus[0]"](自分)[r]
HP:[emb exp="f.EnemyStatus[0]"](敵)
;ダメージ表示
[current layer="message0"]
敵に[emb exp="f.MyStatus[2]"]のダメージ[r][l][er]
;勝った時
[if exp="f.EnemyStatus[0] <= 0"]
@jump target=*debugW
[endif]
;敵のターンへ移動
@jump target=*EneAtk
[s]

*debugL
[current layer="message0"]
プレイヤーの負け[l][er]
@jump storage="first.ks"
[s]

*debugW
[current layer="message0"]
プレイヤーの勝ち[wait time="3000"][er]
@jump storage="first.ks"
[s]
;------ボタンでコマンド操作する時-----------------------------------------------
; [button name="atk" graphic="button/攻撃.png" x="100" y="105" target=*MyAtk]
; [button name="def" graphic="button/防御.png" x="100" y="325" target=*MyDef]



;フォントの設定
[deffont color="0xffffff"]
[resetfont]
;キャラの表示
; [chara_new name="akane" storage="chara/akane/normal.png" jname="あかね"]
; [chara_show name="akane" left= "900"]
; [chara_new name="yamato" storage="chara/yamato/normal.png" jname="やまと"]
; [chara_show name="yamato" left= "10"]
[chara_new  name="picto" storage="chara/picto/normal.png" jname="ピクト" ]
[chara_show name="picto" left= "900"]
;背景の表示
[bg storage=pictoroom.jpg time = 0]
;メインのメッセージウィンドウに定義
[position layer="message0" left=0 top=500 width=1280 height=220 visible=true]
[position layer=message0 margint="30" marginl="100" marginr="210" marginb="20"]
;HP表示のためのウィンドウ定義(戦闘開始まで隠す)
[position layer="message1" left=150 top=120 width=400 height=130 visible=true]
[position layer=message1 margint="30" marginl="-10" marginr="0" marginb="0"]
[layopt layer=message1 visible=false]
;戦闘開始待ち
*first
戦闘を開始しますか？
[glink x="120" y="610" width="200" text="はい" target="*start" color="green" size=20]
[glink x="500" y="610" width="200" text="いいえ" target="*end" color="blue" size=20]
[s]
;battleへ飛ぶ
*start
@jump storage="battle.ks"
戦闘を開始します[wait time="500"][er]
[s]
*end
戦闘を開始させます[wait time="500"][er]
@jump storage="battle.ks"
[s]



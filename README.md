# tabero
グループ課題

###top.jsp 
指定した場所近辺の飲食店を探すための検索フォームを配置
フォームの入力をshop-list.jspに送信

###shop-list.jsp
フォームから受け取った情報をぐるなびのapiに送信
ぐるなびのapiからのレスポンスを新たにresponse.txtに書き出す(shop.jspで読み出す用)
飲食店をリスト表示
各店舗を選択するとshop.jspにジャンプ

###shop.jsp
response.txtを読み出し、shop-list.jspで選択された店舗情報を表示
最寄り駅からその店舗までの経路を表示するためのフォームを設置

###route.jsp
shop.jspのフォームからの情報をYOLPのapiに送信して経路の地図を表示する

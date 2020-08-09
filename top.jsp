<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.net.*" %>


<html>
<head>
<title>
食べ路
</title>
<style>



body {
  background: #eeebe7;
  padding: 100px 20px;
  text-align: center;
}

  div {
  	text-alige : center;
  	color: black;

  }
  h1{
  margin: 0 0 0 0;
  }
  h2{
    margin: 0 0 0 0;
  	color: red;
  	font-family : fantasy;
  	font-size : 6em;
  	text-align: center;
    background-color: #FFF5EE;
  	}
    p{
    font-size : 25px;
  	color: black;
  	font-family : sens-serif;
  	text-align: center;
  	}
/*  	.midasi1{
  	padding: 0.5em 1.0em;
    margin: 0 0 0 0;
    background: #ffebe9;
    border-top: solid 10px #ff7d6e;
    text-align: left;
    color: blue;
  	}
*/



.cp_ipselect {
	position: relative;
	width: 40%;
	margin: 2em auto;
	text-align: center;
}
.cp_sl06 {
	position: relative;
	font-family: inherit;
	background-color: transparent;
	width: 100%;
	padding: 10px 10px 10px 0;
	font-size: 18px;
	border-radius: 0;
	border: none;
	border-bottom: 1px solid rgba(0,0,0, 0.3);
}
.cp_sl06:focus {
	outline: none;
	border-bottom: 1px solid rgba(0,0,0, 0);
}
.cp_ipselect .cp_sl06 {
	appearance: none;
	-webkit-appearance:none
}
.cp_ipselect select::-ms-expand {
	display: none;
}
.cp_ipselect:after {
	position: absolute;
	top: 18px;
	right: 10px;
	width: 0;
	height: 0;
	padding: 0;
	content: '';
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-top: 6px solid rgba(0, 0, 0, 0.3);
	pointer-events: none;
}
.cp_sl06_selectlabel {
	color: rgba(0,0,0, 0.5);
	font-size: 18px;
	font-weight: normal;
	position: absolute;
	pointer-events: none;
	left: 0;
	top: 10px;
	transition: 0.2s ease all;
}
.cp_sl06:focus ~ .cp_sl06_selectlabel, .cp_sl06:valid ~ .cp_sl06_selectlabel {
	color: #da3c41;
	top: -20px;
	transition: 0.2s ease all;
	font-size: 14px;
}
.cp_sl06_selectbar {
	position: relative;
	display: block;
	width: 100%;
}
.cp_sl06_selectbar:before, .cp_sl06_selectbar:after {
	content: '';
	height: 2px;
	width: 0;
	bottom: 1px;
	position: absolute;
	background: #da3c41;
	transition: 0.2s ease all;
}
.cp_sl06_selectbar:before {
	left: 50%;
}
.cp_sl06_selectbar:after {
	right: 50%;
}
.cp_sl06:focus ~ .cp_sl06_selectbar:before, .cp_sl06:focus ~ .cp_sl06_selectbar:after {
	width: 50%;
}
.cp_sl06_highlight {
	position: absolute;
	top: 25%;
	left: 0;
	pointer-events: none;
	opacity: 0.5;
}

.kakomi-box {
 margin: 2em auto;
 padding: 1em;
 width: 90%;
 background-color: #FFF5EE; /* 背景色 */
 box-shadow: 0 0 5px 1px #ccc; /* 影 */
}

.abab {
 font-size: 20px;
 margin: 2em auto;
 padding: 1em;
 font-family : sens-serif;
 width: 90%;
 color: #555555; /* 文字色 */
 background-color: #FFFFE0; /* 背景色 */
 box-shadow: 0 0 5px 2px #ffa042, 0 0 5px 2px #ffa042 inset; /* 影 */
 border-radius: 2em .7em 3em .9em/.8em 3em .7em 2em; /*角の丸み*/

}

.subtitle{
	font-size: 30px;
	margin: 0 0 10px 0;
}

.btn {
  position: relative;
  display: inline-block;
  padding: 2em 4em;
  text-decoration: none;
  color: #FFF;
  background: red;/*色*/
  border-radius: 4px;/*角の丸み*/
  box-shadow: inset 0 2px 0 rgba(255,255,255,0.2), inset 0 -2px 0 rgba(0, 0, 0, 0.05);
  font-weight: bold;
  border: solid 2px #d27d00;/*線色*/
}

.btn:active {
  /*押したとき*/
  box-shadow: 0 0 2px rgba(0, 0, 0, 0.30);
}
  	</style>
</head>

<body>
<!--  marginは上、右、左、下 -->
<h1>～飲食店検索アプリ～</h1>
<h2>食べ路</h2>

<form action=  "shop-list.jsp" method="post">


		<p>自由に検索（フリーワード検索）<br><input type="text" name="x" size="70" placeholder = "(例)和食　和歌山　など"><br></p>

		<div class = kakomi-box>
		<div class = subtitle>条件を絞って検索<br><br></div>
		店舗名から検索<input type="text" name="u" size="70" placeholder = "店舗名を入力してね"><br>

		<div class="cp_ipselect">
		<select name = "t"  class = "cp_sl06" >
	        <option value="" selected>どこで食べる？（都道府県）</option>
			<optgroup label="北海道">
			<option value="PREF01">北海道</option>
			</optgroup>
			<optgroup label="東北">
			<option value="PREF02">青森県</option>
			<option value="PREF03">岩手県</option>
			<option value="PREF04">宮城県</option>
			<option value="PREF05">秋田県</option>
			<option value="PREF06">山形県</option>
			<option value="PREF07">福島県</option>
			</optgroup>
			<optgroup label="関東">
			<option value="PREF08">茨城県</option>
			<option value="PREF09">栃木県</option>
			<option value="PREF10">群馬県</option>
			<option value="PREF11">埼玉県</option>
			<option value="PREF12">千葉県</option>
			<option value="PREF13">東京都</option>
			<option value="PREF14">神奈川県</option>
			</optgroup>
			<optgroup label="中部">
			<option value="PREF15">新潟県</option>
			<option value="PREF16">富山県</option>
			<option value="PREF17">石川県</option>
			<option value="PREF18">福井県</option>
			<option value="PREF19">山梨県</option>
			<option value="PREF20">長野県</option>
			<option value="PREF21">岐阜県</option>
			<option value="PREF22">静岡県</option>
			<option value="PREF23">愛知県</option>
			</optgroup>
			<optgroup label="近畿">
			<option value="PREF24">三重県</option>
			<option value="PREF25">滋賀県</option>
			<option value="PREF26">京都府</option>
			<option value="PREF27">大阪府</option>
			<option value="PREF28">兵庫県</option>
			<option value="PREF29">奈良県</option>
			<option value="PREF30">和歌山県</option>
			</optgroup>
			<optgroup label="中国">
			<option value="PREF31">鳥取県</option>
			<option value="PREF32">島根県</option>
			<option value="PREF33">岡山県</option>
			<option value="PREF34">広島県</option>
			<option value="PREF35">山口県</option>
			</optgroup>
			<optgroup label="四国">
			<option value="PREF36">徳島県</option>
			<option value="PREF37">香川県</option>
			<option value="PREF38">愛媛県</option>
			<option value="PREF39">高知県</option>
			</optgroup>
			<optgroup label="九州">
			<option value="PREF40">福岡県</option>
			<option value="PREF41">佐賀県</option>
			<option value="PREF42">長崎県</option>
			<option value="PREF43">熊本県</option>
			<option value="PREF44">大分県</option>
			<option value="PREF45">宮崎県</option>
			<option value="PREF46">鹿児島県</option>
			<option value="PREF47">沖縄県</option>
			</optgroup>
		</select>
			<select name = "var"  class = "cp_sl06">
			<option value="" selected>何食べたい？（ジャンル）</option>

			<option value="RSFST9000">居酒屋</option>
			<option value="RSFST2000">日本料理・郷土料理</option>
			<option value="RSFST3000">寿司・魚料理・シーフード</option>
			<option value="RSFST4000">鍋</option>
			<option value="RSFST5000">焼肉・ホルモン</option>
			<option value="RSFST6000">焼き鳥・肉料理・串料理</option>
			<option value="RSFST01000">和食</option>
			<option value="RSFST07000">お好み焼き・粉もの</option>
			<option value="RSFST08000">ラーメン・麺料理</option>
			<option value="RSFST14000">中華</option>
			<option value="RSFST11000">イタリアン・フレンチ</option>
			<option value="RSFST13000">洋食</option>
			<option value="RSFST12000">欧米・各国料理</option>
			<option value="RSFST16000">カレー</option>
			<option value="RSFST15000">アジア・エスニック料理</option>
			<option value="RSFST17000">オーガニック・創作料理</option>
			<option value="RSFST10000">ダイニングバー・バー・ビアホール</option>
			<option value="RSFST21000">お酒</option>
			<option value="RSFST18000">カフェ・スイーツ</option>
			<option value="RSFST19000">宴会・カラオケ・エンターテイメント</option>
			<option value="RSFST20000">ファミレス・ファーストフード</option>
			<option value="RSFST90000">その他料理</option>

			</select>

			<select name = "so" class = "cp_sl06">
				<option value = "" selected>表示順を選ぶ</option>
				<option value="">指定なし</option>
				<option value="1">店舗名に沿って並べる</option>
				<option value="2">ジャンルによって並べる</option>
			</select>

			<span class="cp_sl06_highlight"></span>
			<span class="cp_sl06_selectbar"></span>
			<label class="cp_sl06_selectlabel"></label>
		</div>
	</div>

		<div class = "abab">
		<div class = "subtitle">欲しい項目にチェック！</div>
		ランチ営業あり
		<input type = "checkbox" name = "a" value = 1>
		  クレジットカード利用可
		<input type = "checkbox" name = "b" value = 1>
		   テイクアウトあり
		<input type = "checkbox" name = "c" value = 1><br>
		 駐車場あり
		<input type = "checkbox" name = "d" value = 1>
		電源あり
		<input type = "checkbox" name = "e" value = 1>
		Wi-Fiあり
		<input type = "checkbox" name = "f" value = 1><br>
		食べ放題あり
		<input type = "checkbox" name = "g" value = 1>
		ペット同伴あり
		<input type = "checkbox" name = "h" value = 1>
		デリバリーあり
		<input type = "checkbox" name = "i" value = 1><br>
		電子マネー利用可
		<input type = "checkbox" name = "j" value = 1>
		ランチビュッフェあり
		<input type = "checkbox" name = "k" value = 1>
		Web予約可
		<input type = "checkbox" name = "l" value = 1><br>
		</div>

			<input type="submit" class="btn" value="お店を検索する">


</form>

<a href="https://api.gnavi.co.jp/api/scope/" target="_blank">
	<img src="https://api.gnavi.co.jp/api/img/credit/api_90_35.gif" width="90" height="35" border="0" alt="グルメ情報検索サイト ぐるなび">
</a>
<a href="https://developer.yahoo.co.jp/about">
	<img src="https://s.yimg.jp/images/yjdn/yjdn_attbtn1_125_17.gif" title="Webサービス by Yahoo! JAPAN" alt="Web Services by Yahoo! JAPAN" width="125" height="17" border="0" style="margin:15px 15px 15px 15px">
</a>

</body>

</html>

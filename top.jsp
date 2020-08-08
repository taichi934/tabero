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
            background-color: #FFFFDD;
            text-align: center;
            background-image: url();
        }

        div {
            text-alige: center;
            color: #43FF6B;
        }

        h1 {
            margin: 0 0 0 0;
            color: red;
            font-family: fantasy;
            font-size: 7em;
            text-align: right;
            background-color: white;
            background-image: url(wasyoku1.jpg);
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            vertical-align: middle;
        }

        p {
            font-size: 3em;
            color: black;
            font-family: sens-serif;
            text-align: center;
            text-decoration: underline;
        }

        .midasi1 {
            padding: 0.5em 1.0em;
            margin: 0 0 0 0;
            background: #ffebe9;
            border-top: solid 10px #ff7d6e;
            text-align: left;
            color: blue;
        }

        .midasi2 {
            padding: 0.5em 1.0em;
            margin: 0 0 0 0;
            text-align: left;
        }

        .janru {
            margin: 20px 0 0 0;
            color: #474747;
            background: whitesmoke;
            /*背景色*/
            border-left: double 7px #4ec4d3;
            /*左線*/
            border-right: double 7px #4ec4d3;
            /*右線*/
        }
    </style>
</head>

<body>
    <!--  marginは上、右、左、下 -->
    <h2>~飲食店検索アプリ~</h2>
    <h1>食べ路<br>tabero</h1>
    <form action="shop-list.jsp" method="get">

        <p>キーワードから検索<br><input type="text" name="u" size="70"> <input type="submit" value="検索"><br></p>
        <div class="midasi1">
            条件を絞り込む
        </div><br>

        <div class="janru">
            <div class="midasi2">
                地域から検索
            </div>
            都道府県：
            <select name="t">
                <option value="" selected>都道府県</option>
                <option value="PREF01">北海道</option>
                <option value="PREF02">青森県</option>
                <option value="PREF03">岩手県</option>
                <option value="PREF04">宮城県</option>
                <option value="PREF05">秋田県</option>
                <option value="PREF06">山形県</option>
                <option value="PREF07">福島県</option>
                <option value="PREF08">茨城県</option>
                <option value="PREF09">栃木県</option>
                <option value="PREF10">群馬県</option>
                <option value="PREF11">埼玉県</option>
                <option value="PREF12">千葉県</option>
                <option value="PREF13">東京都</option>
                <option value="PREF14">神奈川県</option>
                <option value="PREF15">新潟県</option>
                <option value="PREF16">富山県</option>
                <option value="PREF17">石川県</option>
                <option value="PREF18">福井県</option>
                <option value="PREF19">山梨県</option>
                <option value="PREF20">長野県</option>
                <option value="PREF21">岐阜県</option>
                <option value="PREF22">静岡県</option>
                <option value="PREF23">愛知県</option>
                <option value="PREF24">三重県</option>
                <option value="PREF25">滋賀県</option>
                <option value="PREF26">京都府</option>
                <option value="PREF27">大阪府</option>
                <option value="PREF28">兵庫県</option>
                <option value="PREF29">奈良県</option>
                <option value="PREF30">和歌山県</option>
                <option value="PREF31">鳥取県</option>
                <option value="PREF32">島根県</option>
                <option value="PREF33">岡山県</option>
                <option value="PREF34">広島県</option>
                <option value="PREF35">山口県</option>
                <option value="PREF36">徳島県</option>
                <option value="PREF37">香川県</option>
                <option value="PREF38">愛媛県</option>
                <option value="PREF39">高知県</option>
                <option value="PREF40">福岡県</option>
                <option value="PREF41">佐賀県</option>
                <option value="PREF42">長崎県</option>
                <option value="PREF43">熊本県</option>
                <option value="PREF44">大分県</option>
                <option value="PREF45">宮崎県</option>
                <option value="PREF46">鹿児島県</option>
                <option value="PREF47">沖縄県</option>
            </select><br><br>

            エリア大：
            <select name="">
                <option value="">エリア大</option>
            </select><br><br>

            エリア中：
            <select name="">
                <option value="">エリア中</option>
            </select><br><br>

            エリア小：
            <select name="">
                <option value="">エリア小</option>
            </select><br><br>
        </div>

        <div class="janru">
            <div class="midasi2">食べ物のジャンルから検索：</div>
            <select name="">
                <option value="">大まかな業態</option>
            </select><br><br>

            <select name="">
                <option value="">細かな業態</option>
            </select><br><br>

            <select name="">
                <option value="">ソート</option>
            </select><br><br>
        </div>

        <div class="abab">
            ランチ営業あり
            <input type="checkbox" name="a" value=1><br>
            クレジットカード利用可
            <input type="checkbox" name="b" value=1><br>
            テイクアウトあり
            <input type="checkbox" name="c" value=1><br>
            駐車場あり
            <input type="checkbox" name="d" value=1><br>
            電源あり
            <input type="checkbox" name="e" value=1><br>
            Wi-Fiあり
            <input type="checkbox" name="f" value=1><br>
            食べ放題あり
            <input type="checkbox" name="g" value=1><br>
            ペット同伴あり
            <input type="checkbox" name="h" value=1><br>
            デリバリーあり
            <input type="checkbox" name="i" value=1><br>
            電子マネー利用可
            <input type="checkbox" name="j" value=1><br>
            ランチビュッフェあり
            <input type="checkbox" name="k" value=1><br>
            Web予約可
            <input type="checkbox" name="l" value=1><br>
        </div>
    </form>
    <!--
    <a href = "shop-list.jsp" ><img src = "spa1.png" alt = "次へ"width="300" height="200" ></a>
    後に画像をいれます
          <div id = "picture1">
          <img src="" alt="サンプル" width="300" height="200" >
          </div>
          /*.abab {
        padding: 0.5em 1em;
        margin: 0 350px 0 500px;
        background: #ffebe9;
        border-top: solid 10px #ff7d6e;
        text-align: left;
      color: red;
    }
    .drop {
        padding: 0.5em 1em;
        margin: 0 0 0 200px;
        background: #ffebe9;
        border-top: solid 10px #ff7d6e;
        text-align: left;
      color: blue;
      float: left;
      }
    -->

    <a href="https://api.gnavi.co.jp/api/scope/" target="_blank">
        <img src="https://api.gnavi.co.jp/api/img/credit/api_90_35.gif" width="90" height="35" border="0"
            alt="グルメ情報検索サイト ぐるなび">
    </a>
    <a href="https://developer.yahoo.co.jp/about">
        <img src="https://s.yimg.jp/images/yjdn/yjdn_attbtn1_125_17.gif" title="Webサービス by Yahoo! JAPAN"
            alt="Web Services by Yahoo! JAPAN" width="125" height="17" border="0" style="margin:15px 15px 15px 15px">
    </a>

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.net.*" %>
<%!
/* HTMLのいくつかの文字をエスケープし，改行の前に<br>を付ける */
String prettyPrintHTML(String s) {
	if (s == null)
	return "";
	return s.replace("&", "&amp;")
		.replace("\"", "&quot;")
		.replace("<", "&lt;")
		.replace(">", "&gt;")
		.replace("'", "&#39;")
		.replace("\n", "<br>\n");
}

String check (String s) {
  if (s == null) {
  s = "";
  }
  return s;
}

public class MyHttpClient {
	public String url = ""; /* URL */
	public String encoding = "UTF-8"; /* レスポンスの文字コード */
	public String header = ""; /* レスポンスヘッダ文字列 */
	public String body = ""; /* レスポンスボディ */
	// 2つの引数（URL，エンコーディング）をとるコンストラクタ
	public MyHttpClient(String url_, String encoding_) {
    url = url_;
    encoding = encoding_;
  }
  // 1つの引数（URL）をとるコンストラクタ
  public MyHttpClient(String url_) {
	  url = url_;
  }
  /* 実際にアクセスし，フィールドheaderおよびbodyに値を格納する */
  public void doAccess()
  throws MalformedURLException, ProtocolException, IOException {

    /* 接続準備 */
    URL u = new URL(url);
    HttpURLConnection con = (HttpURLConnection)u.openConnection();
    con.setRequestMethod("GET");
    con.setInstanceFollowRedirects(true);

    /* 接続 */
    con.connect();

    /* レスポンスヘッダの獲得 */
    Map<String, List<String>> headers = con.getHeaderFields();
    StringBuilder sb = new StringBuilder();
    Iterator<String> it = headers.keySet().iterator();
    while (it.hasNext()) {
      String key = (String) it.next();
      sb.append("  " + key + ": " + headers.get(key) + "\n");
    }

    /* レスポンスコードとメッセージ */
    sb.append("RESPONSE CODE [" + con.getResponseCode() + "]\n");
    sb.append("RESPONSE MESSAGE [" + con.getResponseMessage() + "]\n");
    header = sb.toString();

    /* レスポンスボディの獲得 */
    BufferedReader reader = new BufferedReader(
      new InputStreamReader(con.getInputStream(),
      encoding));
    String line;
    sb = new StringBuilder();
    while ((line = reader.readLine()) != null) {
      sb.append(line + "\n");
    }
    body = sb.toString();

    /* 接続終了 */
    reader.close();
    con.disconnect();
  }
}

// 店舗写真がなければ別の写真を返す
String checkImage(String image1, String image2) {
	if (image1 != "") return image1;
	else if (image2 != "") return image2;
	else return "http://design-ec.com/d/e_others_50/m_e_others_500.jpg";
}
%>
<%
//リクエスト・レスポンスとも文字コードをUTF-8に
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
String url_ = "";
String msg = ""; // 結果メッセージ
String s = "";// bodyの内容
MyHttpClient mhc; // HTTPで通信するためのインスタンス
// パラメータ
int shopNumber = Integer.parseInt(request.getParameter("shopNumber"));
int o_page = Integer.parseInt(request.getParameter("offset_page"));
String free = request.getParameter("freeword");
String shop = request.getParameter("name");
String pref = request.getParameter("pref");
String janru = request.getParameter("category_l");
String sort = request.getParameter("sort");
String lunch_ = request.getParameter("lunch");
String credit = request.getParameter("card");
String take_out = request.getParameter("takeout");
String parking = request.getParameter("parking");
String power = request.getParameter("outret");
String wifi = request.getParameter("wifi");
String alleat = request.getParameter("buffet");
String pet = request.getParameter("with_pet");
String delivery = request.getParameter("deliverly");
String ele_money = request.getParameter("e_money");
String l_alleat= request.getParameter("lunch_buffet");
String reservation = request.getParameter("web_reserve");

String params = "freeword=" + free + "&name=" + shop + "&pref=" + pref + "&category_l=" + janru + "&sort=" + sort +  "&lunch=" + lunch_ + "&card=" + credit + "&takeout=" + take_out + "&parking=" + parking + "&outret=" + power + "&wifi=" + wifi + "&buffet=" + alleat + "&with_pet=" + pet + "&deliverly=" + delivery + "&e_money=" + ele_money + "&lunch_buffet=" + l_alleat + "&web_reserve=" + reservation;

// 結果格納する配列
String id[] = new String[20];
String update_date[] = new String[20];
String name[] = new String[20];
String name_kana[] = new String[20];
String latitude[] = new String[20];
String longitude[] = new String[20];
String category[] = new String[20];
String url[] = new String[20];
String url_mobile[] = new String[20];
String pc[] = new String[20];
String mobile[] = new String[20];
String shop_image1[] = new String[20];
String shop_image2[] = new String[20];
String qrcode[] = new String[20];
String address[] = new String[20];
String tel[] = new String[20];
String tel_sub[] = new String[20];
String fax[] = new String[20];
String opentime[] = new String[20];
String holiday[] = new String[20];
String line[] = new String[20];
String station[] = new String[20];
String station_exit[] = new String[20];
String walk[] = new String[20];
String note[] = new String[20];
String parking_lots[] = new String[20];
String pr_short[] = new String[20];
String pr_long[] = new String[20];
String areacode[] = new String[20];
String areaname[] = new String[20];
String prefcode[] = new String[20];
String prefname[] = new String[20];
String areacode_s[] = new String[20];
String areaname_s[] = new String[20];
String category_code_l[] = new String[20];
String category_name_l[] = new String[20];
String category_code_s[] = new String[20];
String category_name_s[] = new String[20];
String budget[] = new String[20];
String party[] = new String[20];
String lunch[] = new String[20];
String credit_card[] = new String[20];
String e_money[] = new String[20];
String mobile_site[] = new String[20];
String mobile_coupon[] = new String[20];
String pc_coupon[] = new String[20];
double lati[] = new double[20];
double longi[] = new double[20];
double ido;
double keido;
// その他
int pos1 = 0;
int pos2 = 0;
int n = 0;
String count = ""; // 検索該当数
String pages = ""; // ページ数
String page_num = ""; // 表示ページ
int cou = 0;

url_ = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=e1634a8f3875638b03556ea66966bf88&hit_per_page=20&offset_page=" + o_page + "&" + params;

if (url_ != null) {
  try {
    mhc = new MyHttpClient(url_);
    mhc.doAccess();
    s += mhc.body;
  } catch(MalformedURLException e) {
    msg += "URLが不適切です。";
  } catch(ProtocolException e) {
    msg += "HTTPの通信に失敗しました。";
  } catch(IOException e) {
    msg += "何らかの不具合が発生しました。";
  }
}

// 結果格納
pos1 = s.indexOf("\"total_hit_count\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
count += "該当件数：" + s.substring(pos1 + "\"total_hit_count\": ".length(), pos2)+ "件";
pos1 = s.indexOf("\"hit_per_page\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
pages += "総ページ数：" + s.substring(pos1 + "\"hit_per_page\": ".length(), pos2);
pos1 = s.indexOf("\"page_offset\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
page_num += "現在ページ：" + s.substring(pos1 + "\"page_offset\": ".length(), pos2);
for (int i = 0; i < 20; i++) {
  pos1 = s.indexOf("\"id\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  if (n == -1) {
  break;
  }
  id[i] = s.substring(pos1 + "\"id\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"update_date\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  update_date[i] = s.substring(pos1 + "\"update_date\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"name\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("\",", n);
  name[i] = s.substring(pos1 + "\"name\": \"".length(), pos2);
  pos1 = s.indexOf("\"name_kana\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("\",", n);
  name_kana[i] = s.substring(pos1 + "\"name_kana\": \"".length(), pos2);
  pos1 = s.indexOf("\"latitude\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  latitude[i] = s.substring(pos1 + "\"latitude\": \"".length(), pos2-1);
  lati[i] = Double.parseDouble(latitude[i]);
  pos1 = s.indexOf("\"longitude\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  longitude[i] = s.substring(pos1 + "\"longitude\": \"".length(), pos2-1);
  longi[i] = Double.parseDouble(longitude[i]);
  pos1 = s.indexOf("\"category\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  category[i] = s.substring(pos1 + "\"category\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"url\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  url[i] = s.substring(pos1 + "\"url\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"url_mobile\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  url_mobile[i] = s.substring(pos1 + "\"url_mobile\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"pc\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  pc[i] = s.substring(pos1 + "\"pc\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"mobile\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("}", n);
  mobile[i] = s.substring(pos1 + "\"mobile\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"shop_image1\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  shop_image1[i] = s.substring(pos1 + "\"shop_image1\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"shop_image2\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  shop_image2[i] = s.substring(pos1 + "\"shop_image2\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"qrcode\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("}", n);
  qrcode[i] = s.substring(pos1 + "\"qrcode\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"address\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  address[i] = s.substring(pos1 + "\"address\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"tel\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  tel[i] = s.substring(pos1 + "\"tel\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"tel_sub\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  tel_sub[i] = s.substring(pos1 + "\"tel_sub\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"fax\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  fax[i] = s.substring(pos1 + "\"fax\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"opentime\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  opentime[i] = s.substring(pos1 + "\"opentime\": \"".length(), pos2-1).replaceAll("\\\\n", "<br>");
  pos1 = s.indexOf("\"holiday\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  holiday[i] = s.substring(pos1 + "\"holiday\": \"".length(), pos2-1).replaceAll("\\\\n", "<br>");
  pos1 = s.indexOf("\"line\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  line[i] = s.substring(pos1 + "\"line\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"station\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  station[i] = s.substring(pos1 + "\"station\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"station_exit\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  station_exit[i] = s.substring(pos1 + "\"station_exit\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"walk\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  walk[i] = s.substring(pos1 + "\"walk\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"note\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("}", n);
  note[i] = s.substring(pos1 + "\"note\": \"".length()+1, pos2);
  pos1 = s.indexOf("\"parking_lots\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  parking_lots[i] = s.substring(pos1 + "\"parking_lots\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"pr_short\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  pr_short[i] = s.substring(pos1 + "\"pr_short\": \"".length(), pos2-1).replaceAll("\\\\n", "<br>").replaceAll("\\\\\"", "\"");
  pos1 = s.indexOf("\"pr_long\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("}", n);
  pr_long[i] = s.substring(pos1 + "\"pr_long\": \"".length(), pos2-1).replaceAll("\\\\n", "<br>").replaceAll("\"", "");
  pos1 = s.indexOf("\"areacode\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  areacode[i] = s.substring(pos1 + "\"areacode\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"areaname\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  areaname[i] = s.substring(pos1 + "\"areaname\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"prefcode\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  prefcode[i] = s.substring(pos1 + "\"prefcode\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"prefname\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  prefname[i] = s.substring(pos1 + "\"prefname\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"areacode_s\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  areacode_s[i] = s.substring(pos1 + "\"areacode_s\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"areaname_s\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  areaname_s[i] = s.substring(pos1 + "\"areaname_s\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"category_code_l\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  category_code_l[i] = s.substring(pos1 + "\"category_code_l\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"category_name_l\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  category_name_l[i] = s.substring(pos1 + "\"category_name_l\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"category_code_s\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  category_code_s[i] = s.substring(pos1 + "\"category_code_s\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"category_name_s\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  category_name_s[i] = s.substring(pos1 + "\"category_name_s\": \"".length(), pos2-1);
  pos1 = s.indexOf("\"budget\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  budget[i] = s.substring(pos1 + "\"budget\": ".length(), pos2).replaceAll("\"", "");
  pos1 = s.indexOf("\"party\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  party[i] = s.substring(pos1 + "\"party\": ".length(), pos2).replaceAll("\"", "");
  pos1 = s.indexOf("\"lunch\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  lunch[i] = s.substring(pos1 + "\"lunch\": ".length(), pos2).replaceAll("\"", "");
  pos1 = s.indexOf("\"credit_card\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("\",", n);
  credit_card[i] = s.substring(pos1 + "\"credit_card\": \"".length(), pos2);
  pos1 = s.indexOf("\"e_money\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("\",", n);
  e_money[i] = s.substring(pos1 + "\"e_money\": \"".length(), pos2);
  pos1 = s.indexOf("\"mobile_site\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  mobile_site[i] = s.substring(pos1 + "\"mobile_site\": \"".length(), pos2);
  pos1 = s.indexOf("\"mobile_coupon\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf(",", n);
  mobile_coupon[i] = s.substring(pos1 + "\"mobile_coupon\": \"".length(), pos2);
  pos1 = s.indexOf("\"pc_coupon\":", n);
  n = pos1 + 1;
  pos2 = s.indexOf("}", n);
  pc_coupon[i] = s.substring(pos1 + "\"pc_coupon\": \"".length(), pos2);
  cou++;
}

url_ = "http://express.heartrails.com/api/json?method=getStations&x=" + longi[shopNumber] + "&y=" + lati[shopNumber];

if (url_ != null) {
	try {
		mhc = new MyHttpClient(url_);
		mhc.doAccess();
		s += mhc.body;
	} catch(MalformedURLException e) {
		msg += "URLが不適切です。";
	} catch(ProtocolException e) {
		msg += "HTTPの通信に失敗しました。";
	} catch(IOException e) {
		msg += "何らかの不具合が発生しました。";
	}
}

pos1 = s.indexOf("\"x\":");
n = pos1 + 1;
pos2 = s.indexOf(",", n);
keido = Double.parseDouble(s.substring(pos1 + "\"x\":".length(), pos2));
pos1 = s.indexOf("\"y\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
ido = Double.parseDouble(s.substring(pos1 + "\"y\":".length(), pos2));

// shop-listで条件を引き継げるようにparams を修正
String newParams = params.replace("freeword", "x")
	.replace("name", "u")
	.replace("category_l", "var")
	.replace("sort", "so")
	.replace("pref", "t")
	.replace("lunch", "a")
	.replace("card", "b")
	.replace("takeout", "c")
	.replace("parking", "d")
	.replace("outret", "e")
	.replace("wifi", "f")
	.replace("buffet", "g")
	.replace("with_pet", "h")
	.replace("deliverly", "i")
	.replace("e_money", "j")
	.replace("lunch_buffet", "k")
	.replace("web_reserve", "l");
%>

<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>店舗情報</title>
  <style>
    body {
      background-color: #FFF5EE;
    }

    .shop-upper {
      display: flex;
    }

    .shop-upper div {
      margin-left: 30px;
    }

    .shop-name .genre {
      margin-top: 30px;
      padding-bottom: 0px;
      margin-bottom: 0px;
    }

    .shop-name .name {
      font-size: 40px;
      padding-top: 10px;
      margin-top: 0px;
      padding-bottom: 0px;
      margin-bottom: 0px;
    }

    .shop-name .kana {
      margin-top: 0px;
      padding-top: 10px;
      margin-left: 15px;
    }

    .shop-body>div {
      margin-left: 30px;
    }

    .shop-details h4 {
      margin-bottom: 0px;
    }

    .details {
      margin-left: 30px;
    }

    .access {
      display: flex;
    }

    .access h4 {
      margin-bottom: 0px;
    }

    .access-info {
      margin-top: 30px;
      margin-left: 30px;
    }

    .back-btn {
      margin-top: 40px;
      margin-bottom: 40px;
    }

    .back {
      border: 2px solid #ffa042;
      border-radius: 5px;
      background-color: #FFFFE0;
      padding: 10px;
      text-align: center;
      color: #000000;
      width: 150px;
    }
  </style>
</head>

<body>

  <div class="shop">
    <div class="shop-upper">
      <div class="img">
        <img src="<%= checkImage(shop_image1[shopNumber], shop_image2[shopNumber]) %> " alt="店舗画像">
      </div>
      <div class="shop-name">
        <h4 class="genre"><%= category[shopNumber] %></h4>
        <h1 class="name"><%= name[shopNumber] %></h1>
        <h5 class="kana"><%= name_kana[shopNumber] %></h5>
      </div>
    </div>

    <hr>

    <div class="shop-body">
      <div class="pr">
        <h4><%= pr_short[shopNumber] %></h4>
        <p><%= pr_long[shopNumber] %></p>
      </div>
      <hr>
      <div class="shop-details">
        <div class="info">
          <h4>＜店舗情報＞</h4>
          <div class="details">
            住所：<%= address[shopNumber] %><br>
            電話番号：<%= tel[shopNumber] %><br>
            営業時間：<br>
            <%= opentime[shopNumber] %><br>
            休業日：<br>
            <%= holiday[shopNumber] %><br>
            駐車場台数：<%= parking_lots[shopNumber] %><br>
          </div>
        </div>
        <div class="payment">
          <h4>＜支払情報＞</h4>
          <div class="details">
            平均予算：<%= budget[shopNumber] %><br>
            ランチタイム平均予算：<%= lunch[shopNumber] %><br>
            利用可能クレジット会社：<%= credit_card[shopNumber] %><br>
            利用可能電子マネー：<%= e_money[shopNumber] %><br>
          </div>
        </div>
        <div class="website">
          <h4>＜ホームページ＞</h4>
          <div class="details">
            <a href="<%= url[shopNumber] %>">PC用サイトへ</a><br>
            <a href="<%= url_mobile[shopNumber] %>">スマホ用サイトへ</a><br>

            <% if (mobile_site[shopNumber] == "1") { %>
            モバイルサイトあり<br>
            <% } %>
            <% if (mobile_coupon[shopNumber] == "1") { %>
            モバイルクーポンあり<br>
            <% } %>
            <% if (pc_coupon[shopNumber] == "1") { %>
            PCクーポンあり<br>
            <% } %>
          </div>
        </div>
        <br>
        更新日時:<%= update_date[shopNumber] %>
      </div>
      <hr>
      <div class="access">
        <div class="route">
          <img class="route-map"
            src="https://map.yahooapis.jp/course/V1/routeMap?appid=dj00aiZpPUx3SzQ1a0JlNE52RiZzPWNvbnN1bWVyc2VjcmV0Jng9NzE-&route=<%= lati[shopNumber] %>0000000000,<%= longi[shopNumber] %>00000000000,<%= ido %>0000000000,<%= keido %>0000000000|color:0000ffff&width=500&height=500">
        </div>
        <div class="access-info">
          <h4>＜アクセス＞</h4>
          <div class="details">
            最寄り駅：<%= line[shopNumber] %><%= station[shopNumber] %><%= station_exit[shopNumber] %><br>
            徒歩：<%= walk[shopNumber] %>分<br>
            備考：<%= note[shopNumber] %><br>
          </div>
        </div>
      </div>
      <hr>
      <div class="back-btn">
        <a class="back" href="<%= "shop-list.jsp?p=" + o_page + "&" + newParams %>">検索結果に戻る</a>
      </div>

    </div>
    <!-- <div> //ユーザーの最寄り駅からの場合
			<div>
				<h3>店舗までの経路を検索</h3>
				<form action="route.jsp" method="get">
					<label for="nearest">最寄り駅</label>
					<input type="text" name="station" id="nearest" size="20" placeholder="渋谷駅">
					<button type="submit">経路を検索</button>
				</form>
			</div>
		</div> -->

</body>

</html>
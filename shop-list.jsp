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
String shop = request.getParameter("u");
if(shop == null) {
	shop = (String)session.getAttribute("shop");
}
shop = check(shop);
session.setAttribute("shop", shop);
String pref = request.getParameter("t");
if(pref == null) {
	pref = (String)session.getAttribute("pref");
}
pref = check(pref);
session.setAttribute("pref", pref);
String offset_page = request.getParameter("p");
if (offset_page == null) {
	offset_page = "1";
}
int pages = Integer.parseInt(offset_page);
String lunch_ = request.getParameter("a");
if(lunch_ == null) {
	lunch_ = (String)session.getAttribute("lunch_");
}
lunch_ = check(lunch_);
session.setAttribute("lunch_", lunch_);
String credit = request.getParameter("b");
if(credit == null) {
	credit = (String)session.getAttribute("credit");
}
credit = check(credit);
session.setAttribute("credit", credit);
String take_out = request.getParameter("c");
if(take_out == null) {
	take_out = (String)session.getAttribute("take_out");
}
take_out = check(take_out);
session.setAttribute("take_out", take_out);
String parking = request.getParameter("d");
if(parking == null) {
	parking = (String)session.getAttribute("parking");
}
parking = check(parking);
session.setAttribute("parking", parking);
String power = request.getParameter("e");
if(power == null) {
	power = (String)session.getAttribute("power");
}
power = check(power);
session.setAttribute("power", power);
String wifi = request.getParameter("f");
if(wifi == null) {
	wifi = (String)session.getAttribute("wifi");
}
wifi = check(wifi);
session.setAttribute("wifi", wifi);
String alleat = request.getParameter("g");
if(alleat == null) {
	alleat = (String)session.getAttribute("alleat");
}
alleat = check(alleat);
session.setAttribute("alleat", alleat);
String pet = request.getParameter("h");
if(pet == null) {
	pet = (String)session.getAttribute("pet");
}
pet = check(pet);
session.setAttribute("pet", pet);
String delivery = request.getParameter("i");
if(delivery == null) {
	delivery = (String)session.getAttribute("delivery");
}
delivery = check(delivery);
session.setAttribute("delivery", delivery);
String ele_money = request.getParameter("j");
if(ele_money == null) {
	ele_money = (String)session.getAttribute("ele_money");
}
ele_money = check(ele_money);
session.setAttribute("ele_money", ele_money);
String l_alleat = request.getParameter("k");
if(l_alleat == null) {
	l_alleat = (String)session.getAttribute("l_alleat");
}
l_alleat = check(l_alleat);
session.setAttribute("l_alleat", l_alleat);
String reservation = request.getParameter("l");
if(reservation == null) {
	reservation = (String)session.getAttribute("reservation");
}
reservation = check(reservation);
session.setAttribute("reservation", reservation);

// 結果格納する配列
String update_date[] = new String[20];
String name[] = new String[20];
String category[] = new String[20];
String shop_image1[] = new String[20];
String opentime[] = new String[20];
String holiday[] = new String[20];
String line[] = new String[20];
String station[] = new String[20];
String station_exit[] = new String[20];
String walk[] = new String[20];
String budget[] = new String[20];
//int ave[] = new int[20];

// その他
int pos1 = 0;
int pos2 = 0;
int n = 0;
String count = ""; // 検索該当数
String page_num = ""; // 表示ページ
int cou = 0;

String params = "name=" + shop + "&pref=" + pref + "&lunch=" + lunch_ + "&card=" + credit + "&takeout=" + take_out + "&parking=" + parking + "&outret=" + power + "&wifi=" + wifi + "&buffet=" + alleat + "&with_pet=" + pet + "&deliverly=" + delivery + "&e_money=" + ele_money + "&lunch_buffet=" + l_alleat + "&web_reserve=" + reservation;
url_ = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=e1634a8f3875638b03556ea66966bf88&hit_per_page=20&offset_page=" + offset_page + "&" + params;

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
count += s.substring(pos1 + "\"total_hit_count\": ".length(), pos2);
int allnum = Integer.parseInt(count);
pos1 = s.indexOf("\"page_offset\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
page_num += s.substring(pos1 + "\"page_offset\":".length(), pos2) + "ページ目";

for (int i = 0; i < 20; i++) {
	pos1 = s.indexOf("\"update_date\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
	if (n == 0) {
		break;
	}
  update_date[i] = s.substring(pos1 + "\"update_date\": \"".length(), pos2);
	
  pos1 = s.indexOf("\"name\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  name[i] = s.substring(pos1 + "\"name\": \"".length(), pos2);
  
  pos1 = s.indexOf("\"category\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  category[i] = s.substring(pos1 + "\"category\": \"".length(), pos2);

	pos1 = s.indexOf("\"shop_image1\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  shop_image1[i] = s.substring(pos1 + "\"shop_image1\": \"".length(), pos2);

	pos1 = s.indexOf("\"opentime\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  opentime[i] = s.substring(pos1 + "\"opentime\": \"".length(), pos2);
  opentime[i] = opentime[i].replace("\\n", "<br>");

	pos1 = s.indexOf("\"holiday\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  holiday[i] = s.substring(pos1 + "\"holiday\": \"".length(), pos2);
  holiday[i] = holiday[i].replace("\\n", "&emsp;");
  
	pos1 = s.indexOf("\"line\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  line[i] = s.substring(pos1 + "\"line\": \"".length(), pos2);

	pos1 = s.indexOf("\"station\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  station[i] = s.substring(pos1 + "\"station\": \"".length(), pos2);

	pos1 = s.indexOf("\"station_exit\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  station_exit[i] = s.substring(pos1 + "\"station_exit\": \"".length(), pos2);

	pos1 = s.indexOf("\"walk\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf("\",", n);
  walk[i] = s.substring(pos1 + "\"walk\": \"".length(), pos2);
	
  pos1 = s.indexOf("\"budget\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
  budget[i] = s.substring(pos1 + "\"budget\": ".length(), pos2);
    //ave[i] = Integer.parseInt(budget[i]);

    cou++;
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>食べ路</title>
        <style>
			body {
				background: #ffffdd;
			}

			.info {
				background: #f5f5f5;
				border: 2px solid #4ec4d3;
				overflow: hidden;
			}

			.page {
				text-align: right
			}

			.back {
				border: 2px solid #4ec4d3;
				border-radius: 5px;
				background-color: #ffffdd;
				padding: 20px;
				text-align: center;
				color: #000000;
				width: 150px;
			}

			.next {
				border: 2px solid #4ec4d3;
				border-radius: 5px;
				background-color: #ffffdd;
				padding: 20px;
				text-align: center;
				color: #000000;
				width: 150px;
			}

			h1 {
				color: #ff0000;
				font-size: 8ex;
				text-align: center;
			}

			h2 {
				text-align: center;
			}

			img {
				width: 260px;
				height: 260px;
				float: right;
			}
        </style>
    </head>
    <body>
    	<h1>店舗一覧</h1>
    	<div class = "page">
	    	ヒット件数：<%= allnum %>件<br>
	    	<% if (pages * 20 > allnum) { %>
		       	<%= page_num %>（<%= (pages - 1) * 20 + 1 %>件～<%= allnum %>件）<br>
		    <% } else {%>
		       	<%= page_num %>（<%= (pages - 1) * 20 + 1 %>件～<%= pages * 20 %>件）<br>
		    <% } %>
	    </div>
	    <br>
    	<% for (int i = 0; i < cou; i++) {%>
    		<div class = "info">
		        <a href="shop.jsp?shopNumber=<%= i + "&offset_page=" + pages + "&" + params %>">
		        	<h2><%= name[i] %></h2>
		        </a>
		        <% if (!shop_image1[i].isEmpty()) { %>
		        	<div style="text-align: right"><img src="<%= shop_image1[i] %>"></div><br>
		        <% } else {%>
		        	<div style="text-align: right"><img src="http://design-ec.com/d/e_others_50/m_e_others_500.jpg"></div><br>
		        <% } %>
		        ＜店舗情報＞<br>
		        カテゴリー：<%= category[i] %><br>
		        平均予算：
		        <% if (budget[i].length() < 3) { %>
		        	<br>
		        <% } else {%>
		        	<%= budget[i] %>円<br>
		        <% } %>
		        営業時間：<br>
		        	<%= opentime[i] %><br>
		        休業日：<%= holiday[i] %><br><br>
		        ＜アクセス＞
		        <%= line[i] %><%= station[i] %><%= station_exit[i] %>
		        <% if (walk[i].indexOf("車") == -1) { %>
		        	から徒歩<%= walk[i] %>分<br><br>
		        <% } else {%>
		        	から<%= walk[i] %>分<br><br>
		        <% } %>
		        ＜最終更新日時＞<%= update_date[i] %><br>
	        </div>
	        <br><br><br>
    	<% } %>
    	<% if (pages != 1) { %>
    		<a href="shop-list.jsp?p=<%= pages - 1 +"&"+params %>" class="back"><%= pages - 1 %></a>
    	<% } %>
    	<% if (allnum % 20 == 0) { %>
    		<% if (allnum / 20 >= pages + 1) { %>
    			<a href="shop-list.jsp?p=<%= pages + 1 +"&"+params %>" class="next"><%= pages + 1 %></a>
    		<% } %>
    	<% } else { %>
    		<% if ((allnum / 20) + 1 >= pages + 1) { %>
    			<a href=<a href="shop-list.jsp?p=<%= pages + 1 +"&"+params %>" class="next"><%= pages + 1 %></a>
    		<% } %>
    	<% } %>
    </body>
</html>
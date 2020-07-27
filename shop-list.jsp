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

String msg = ""; // 結果メッセージ
String s = ""; // bodyの内容
MyHttpClient mhc; // HTTPで通信するためのインスタンス

//boolean optionEscape = ("1".equals(request.getParameter("E"))); // レスポンスボディをHTMLエスケープするならtrue

// パラメータ
String shop = request.getParameter("u");
String pref = request.getParameter("pref");

// 結果格納する配列
String id[] = new String[10];
String update_date[] = new String[10];
String name[] = new String[10];
String name_kana[] = new String[10];
String latitude[] = new String[10];
String longitude[] = new String[10];
String category[] = new String[10];
String url[] = new String[10];
String url_mobile[] = new String[10];
String pc[] = new String[10];
String mobile[] = new String[10];
String image_url[] = new String[10];
String shop_image1[] = new String[10];
String shop_image2[] = new String[10];
String qrcode[] = new String[10];
String address[] = new String[10];
String tel[] = new String[10];
String tel_sub[] = new String[10];
String fax[] = new String[10];
String opentime[] = new String[10];
String holiday[] = new String[10];
String line[] = new String[10];
String station[] = new String[10];
String station_exit[] = new String[10];
String walk[] = new String[10];
String note[] = new String[10];
String parking_lots[] = new String[10];
String pr_short[] = new String[10];
String pr_long[] = new String[10];
String areacode[] = new String[10];
String areaname[] = new String[10];
String prefcode[] = new String[10];
String prefname[] = new String[10];
String areacode_s[] = new String[10];
String areaname_s[] = new String[10];
String category_code_l[] = new String[10]; //
String category_name_l[] = new String[10]; //
String category_code_s[] = new String[10]; //
String category_name_s[] = new String[10]; //
String budget[] = new String[10];
String party[] = new String[10];
String lunch[] = new String[10];
String credit_card[] = new String[10];
String e_money[] = new String[10];
String mobile_site[] = new String[10];
String mobile_coupon[] = new String[10];
String pc_coupon[] = new String[10];

// その他
int pos1;
int pos2;
int n = 0;
String count = ""; // 検索該当数
String pages = ""; // ページ数
String page_num = ""; // 表示ページ
int cou = 0;

String url_ = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=&name=" + shop + "&pref=" + pref; // keyidは未記入

if (url != null) {
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
count += "該当件数：" + s.substring(pos1 + "\"total_hit_count\":".length(), pos2) + "件";
pos1 = s.indexOf("\"hit_per_page\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
pages += "総ページ数：" + s.substring(pos1 + "\"hit_per_page\":".length(), pos2);
pos1 = s.indexOf("\"page_offset\":", n);
n = pos1 + 1;
pos2 = s.indexOf(",", n);
page_num += "現在ページ：" + s.substring(pos1 + "\"page_offset\":".length(), pos2);

for (int i = 0; i < 10; i++) {
	pos1 = s.indexOf("\"id\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
	if (n == -1) {
		break;
	}

    id[i] = s.substring(pos1 + "\"id\":".length(), pos2);

	pos1 = s.indexOf("\"update_date\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    update_date[i] = s.substring(pos1 + "\"update_date\":".length(), pos2);

	pos1 = s.indexOf("\"name\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    name[i] = s.substring(pos1 + "\"name\":".length(), pos2);

	pos1 = s.indexOf("\"name_kana\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    name_kana[i] = s.substring(pos1 + "\"name_kana\":".length(), pos2);

	pos1 = s.indexOf("\"latitude\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    latitude[i] = s.substring(pos1 + "\"latitude\":".length(), pos2);

	pos1 = s.indexOf("\"longitude\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    longitude[i] = s.substring(pos1 + "\"longitude\":".length(), pos2);

	pos1 = s.indexOf("\"category\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    category[i] = s.substring(pos1 + "\"category\":".length(), pos2);

	pos1 = s.indexOf("\"url\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    url[i] = s.substring(pos1 + "\"url\":".length(), pos2);

	pos1 = s.indexOf("\"url_mobile\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    url_mobile[i] = s.substring(pos1 + "\"url_mobile\":".length(), pos2);

	pos1 = s.indexOf("\"pc\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    pc[i] = s.substring(pos1 + "\"pc\":".length(), pos2);

	pos1 = s.indexOf("\"mobile\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    mobile[i] = s.substring(pos1 + "\"mobile\":".length(), pos2);

	pos1 = s.indexOf("\"shop_image1\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    shop_image1[i] = s.substring(pos1 + "\"shop_image1\":".length(), pos2);

	pos1 = s.indexOf("\"shop_image2\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    shop_image2[i] = s.substring(pos1 + "\"shop_image2\":".length(), pos2);

	pos1 = s.indexOf("\"qrcode\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    qrcode[i] = s.substring(pos1 + "\"qrcode\":".length(), pos2);

	pos1 = s.indexOf("\"address\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    address[i] = s.substring(pos1 + "\"address\":".length(), pos2);

	pos1 = s.indexOf("\"tel\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    tel[i] = s.substring(pos1 + "\"tel\":".length(), pos2);

	pos1 = s.indexOf("\"tel_sub\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    tel_sub[i] = s.substring(pos1 + "\"tel_sub\":".length(), pos2);

	pos1 = s.indexOf("\"fax\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    fax[i] = s.substring(pos1 + "\"fax\":".length(), pos2);

	pos1 = s.indexOf("\"opentime\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    opentime[i] = s.substring(pos1 + "\"opentime\":".length(), pos2);

	pos1 = s.indexOf("\"holiday\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    holiday[i] = s.substring(pos1 + "\"holiday\":".length(), pos2);

	pos1 = s.indexOf("\"line\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    line[i] = s.substring(pos1 + "\"line\":".length(), pos2);

	pos1 = s.indexOf("\"station\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    station[i] = s.substring(pos1 + "\"station\":".length(), pos2);

	pos1 = s.indexOf("\"station_exit\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    station_exit[i] = s.substring(pos1 + "\"station_exit\":".length(), pos2);

	pos1 = s.indexOf("\"walk\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    walk[i] = s.substring(pos1 + "\"walk\":".length(), pos2);

	pos1 = s.indexOf("\"note\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    note[i] = s.substring(pos1 + "\"note\":".length(), pos2);

	pos1 = s.indexOf("\"parking_lots\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    parking_lots[i] = s.substring(pos1 + "\"parking_lots\":".length(), pos2);

	pos1 = s.indexOf("\"pr_short\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    pr_short[i] = s.substring(pos1 + "\"pr_short\":".length(), pos2);

	pos1 = s.indexOf("\"pr_long\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    pr_long[i] = s.substring(pos1 + "\"pr_long\":".length(), pos2);

	pos1 = s.indexOf("\"areacode\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    areacode[i] = s.substring(pos1 + "\"areacode\":".length(), pos2);

	pos1 = s.indexOf("\"areaname\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    areaname[i] = s.substring(pos1 + "\"areaname\":".length(), pos2);

	pos1 = s.indexOf("\"prefcode\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    prefcode[i] = s.substring(pos1 + "\"prefcode\":".length(), pos2);

	pos1 = s.indexOf("\"prefname\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    prefname[i] = s.substring(pos1 + "\"prefname\":".length(), pos2);

	pos1 = s.indexOf("\"areacode_s\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    areacode_s[i] = s.substring(pos1 + "\"areacode_s\":".length(), pos2);

	pos1 = s.indexOf("\"areaname_s\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    areaname_s[i] = s.substring(pos1 + "\"areaname_s\":".length(), pos2);

	pos1 = s.indexOf("\"category_code_l\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    category_code_l[i] = s.substring(pos1 + "\"category_code_l\":".length(), pos2);

	pos1 = s.indexOf("\"category_name_l\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    category_name_l[i] = s.substring(pos1 + "\"category_name_l\":".length(), pos2);

	pos1 = s.indexOf("\"category_code_s\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    category_code_s[i] = s.substring(pos1 + "\"category_code_s\":".length(), pos2);

	pos1 = s.indexOf("\"category_name_s\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    category_name_s[i] = s.substring(pos1 + "\"category_name_s\":".length(), pos2);

	pos1 = s.indexOf("\"budget\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    budget[i] = s.substring(pos1 + "\"budget\":".length(), pos2);

	pos1 = s.indexOf("\"party\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    party[i] = s.substring(pos1 + "\"party\":".length(), pos2);

	pos1 = s.indexOf("\"lunch\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    lunch[i] = s.substring(pos1 + "\"lunch\":".length(), pos2);

	pos1 = s.indexOf("\"credit_card\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    credit_card[i] = s.substring(pos1 + "\"credit_card\":".length(), pos2);

	pos1 = s.indexOf("\"e_money\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    e_money[i] = s.substring(pos1 + "\"e_money\":".length(), pos2);

	pos1 = s.indexOf("\"mobile_site\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    mobile_site[i] = s.substring(pos1 + "\"mobile_site\":".length(), pos2);

	pos1 = s.indexOf("\"mobile_coupon\":", n);
	n = pos1 + 1;
	pos2 = s.indexOf(",", n);
    mobile_coupon[i] = s.substring(pos1 + "\"mobile_coupon\":".length(), pos2);

    pos1 = s.indexOf("\"pc_coupon\":", n);
    n = pos1 + 1;
    pos2 = s.indexOf("}", n);
    pc_coupon[i] = s.substring(pos1 + "\"pc_coupon\":".length(), pos2);

    cou++;
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>店舗一覧</title>
    </head>
    <body>
    	<%= count %>
    	<%= pages %>
    	<%= page_num %>
    	<% for (int i = 0; i < cou; i++) {%>
	        <%= id[i] %>
	        <%= update_date[i] %>
	        <%= name[i] %>
	        <%= name_kana[i] %>
	        <%= latitude[i] %>
	        <%= longitude[i] %>
	        <%= category[i] %>
	        <%= url[i] %>
	        <%= url_mobile[i] %>
	        <%= pc[i] %>
	        <%= mobile[i] %>
	        <%= image_url[i] %>
	        <%= shop_image1[i] %>
	        <%= shop_image2[i] %>
	        <%= qrcode[i] %>
	        <%= address[i] %>
	        <%= tel[i] %>
	        <%= tel_sub[i] %>
	        <%= fax[i] %>
	        <%= opentime[i] %>
	        <%= holiday[i] %>
	        <%= line[i] %>
	        <%= station[i] %>
	        <%= station_exit[i] %>
	        <%= walk[i] %>
	        <%= note[i] %>
	        <%= parking_lots[i] %>
	        <%= pr_short[i] %>
	        <%= pr_long[i] %>
	        <%= areacode[i] %>
	        <%= areaname[i] %>
	        <%= prefcode[i] %>
	        <%= prefname[i] %>
	        <%= areacode_s[i] %>
	        <%= areaname_s[i] %>
	        <%= category_code_l[i] %>
	        <%= category_name_l[i] %>
	        <%= category_code_s[i] %>
	        <%= category_name_s[i] %>
	        <%= budget[i] %>
	        <%= party[i] %>
	        <%= lunch[i] %>
	        <%= credit_card[i] %>
	        <%= e_money[i] %>
	        <%= mobile_site[i] %>
	        <%= mobile_coupon[i] %>
	        <%= pc_coupon[i] %>
    	<% } %>
		<%= s %>
    </body>
</html>
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
    public String url = "http://geoapi.heartrails.com/api/xml?method=searchByGeoLocation"; /* URL */
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
// 読み出すファイルが存在するのかチェック
private static boolean checkBeforeReadfile(File file){
    if (file.exists()){
      if (file.isFile() && file.canRead()){
        return true;
      }
    }

    return false;
}

private static String readXmlSavedInFile(void)  {
    String xml;
    try{
        File file = new File("response.txt");

        if (checkBeforeReadfile(file)){
            BufferedReader br = new BufferedReader(new FileReader(file));

            String str;
            while((str = br.readLine()) != null){
                xml+=str;
            }

            br.close();
            retun xml;
        }else{
            System.out.println("ファイルが見つからないか開けません");
        }
    }catch(FileNotFoundException e){
        System.out.println(e);
        msg+="読みだそうとしたファイルが見つかりませんでした";
    }catch(IOException e){
        System.out.println(e);
        msg+="ファイルを読み出す過程で問題が生じました";
    }
    return "";
}
%>
<%
//リクエスト・レスポンスとも文字コードをUTF-8に
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

String msg = ""; // 結果メッセージ
String s = ""; // bodyの内容

s = readXmlSavedInFile();

%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>店舗情報</title>
</head>

<body>
    <%= msg %>
    <input type="button" onclick="location.href='./form.jsp'" value="検索ページへ戻る">
    <div>
        <h3>店舗までの経路を検索</h3>
        <form action="route.jsp" method="get">
            <label for="nearest">最寄り駅</label>
            <input type="text" name="station" id="nearest" size="20" placeholder="渋谷駅">
            <button type="submit">経路を検索</button>
        </form>
    </div>
</body>

</html>
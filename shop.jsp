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
    String json;
    try{
        File file = new File("response.txt");

        if (checkBeforeReadfile(file)){
            BufferedReader br = new BufferedReader(new FileReader(file));

            String str;
            while((str = br.readLine()) != null){
                json+=str;
            }

            br.close();
            retun json;
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
    <!-- 後で写真や店舗名、説明分などはjavaの変数で置き換える -->
    <div class="shop">
        <img src="McDonalds.jpg" alt="店舗写真">
        <h3>店舗名</h3>
        <p>マクドナルドは世界約100ヶ国以上あり、トレーニングセンターは各国にありますが、ハンバーガー大学(HU)は7ヶ国にしかありません。その一つが東京です。1971年日本のハンバーガー大学は銀座1号店のオープンより1ヶ月早くオープンしています。マクドナルドのピープルビジネスを物語るストーリ―として、我々がいつも日本のハンバーガー大学を語るときに真っ先に皆に伝えるストーリーです。日本では年間約10000人の受講者がハンバーガー大学を卒業しています。
        </p>
    </div>
    <div>
        <div>
            <h3>店舗までの経路を検索</h3>
            <form action="route.jsp" method="get">
                <label for="nearest">最寄り駅</label>
                <input type="text" name="station" id="nearest" size="20" placeholder="渋谷駅">
                <button type="submit">経路を検索</button>
            </form>
        </div>
    </div>
</body>

</html>
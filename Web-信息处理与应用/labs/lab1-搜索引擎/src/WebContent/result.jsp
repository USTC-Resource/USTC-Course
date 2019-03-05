<%@ page import = "lucene.Search, java.util.Map, java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String queryText, queryPage, queryNext, queryLast;
    String strHistory;
    request.setCharacterEncoding("UTF-8");
    queryText = request.getParameter("query");
    queryPage = request.getParameter("page");
    queryLast = request.getParameter("last");
    strHistory = request.getParameter("history");
    if(strHistory == null)
        strHistory = "    ";
    if(strHistory != null && !strHistory.equals("null") && queryText != null && !strHistory.contains(queryText))
        strHistory = "    "+queryText + "<br>" +strHistory ;
    if(queryPage == null || queryPage.equals(""))
        queryPage = "1";
    queryNext = Integer.toString(Integer.parseInt(queryPage)+1);
    if(queryLast != null && !queryLast.equals(queryText)){
        queryPage = "1";
        queryNext = "2";
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%= queryText %> - 泽文的搜索引擎</title>
</head>

<body>

<form method = "POST" action = "result.jsp">
    <input type = "text" name = "query" style = "width:400px;height:40px" value="<%= queryText %>">
    <input type = "submit" value = "搜索" style = "width:80px;height:40px">
    <input type = "submit" value = "跳转到第" style = "width:70px;height:40px">
    <input type = "text" name = "page" style = "width:50px;height:40px" value="<%= queryNext %>" >
    <input type = "hidden" name = "history" value="<%= strHistory %>" >

    <input type = "hidden" name = "last" value="<%= queryText %>" >
    页
</form>
<br><br>
<%
    System.out.println(queryText);
    boolean flag = false;
    Search searcher = new Search();
    ArrayList<Map<String,String>> totalResults, results=new ArrayList<>();
    int Page = 1, size = 0;
    if( queryPage != null && queryPage.length()!=0)
        Page = Integer.parseInt(queryPage);
    if(queryText != null){

        totalResults = searcher.search(queryText);
        size = totalResults.size();
        out.println("<font color = \"green\" size = \"1\">" + "找到了 " + size + " 个结果");
        out.println("<font size = \"1\">" + "每页最多显示15条,当前是第 " + Page + " 页, 一共" + (size / 15 + 1) + "页");
        out.println("</font>" + "<br><br>");
        if(size > (Page-1)*15 && Page > 0)
            for (int i = 0; i < 15; i++) {
                if((Page-1)*15+i < size)
                    results.add(totalResults.get((Page-1)*15+i));
            }
        else if(size != 0){
            out.println("<font color = \"red\" size = \"4\">");
            out.print("抱歉,超出了页数范围: 1 - " + (size/15+1));
            out.println("</font>" + "<br>");
            flag = true;
        }
        if(results != null && results.size() != 0 ){
            String strBody, strTitle, strUrl, strScore, strKeywords;
            for(int i = 0 ; i < results.size() ; i ++){
                Map<String,String> map = results.get(i);

                strTitle = map.get("title");
                strBody = map.get("contents");
                strUrl = map.get("url");
                strScore = map.get("score");
                strKeywords = map.get("keywords");

                out.println("<font color = \"blue\" size = \"4\">");
                out.print("<a href=\"" + strUrl + "\">" + strTitle + "</a>");
                out.println("</font>" + "<br>");
                out.println("<font color = \"black\" size = \"1\">" + "<strong>score</strong>: " + strScore + "          <strong>关键字</strong>:" + (strKeywords==null?"":strKeywords));
                out.println("</font>" + "<br>");
                out.println("<font color = \"black\" size = \"3\">" + strBody + "<br>" + "<br>");
            }
            out.println("<br>");
        }
        else if(flag == false){
            out.println("<font color = \"red\" size = \"4\">");
            out.print("抱歉,没有找到" + queryText);
            out.println("</font>" + "<br>");
        }
        out.println("搜索记录:<br>");
        out.println("<font color = \"purple\" size = \"3\">");
        out.println(strHistory);
        out.println("</font>" + "<br>");
    }
%>


</body>
</html>
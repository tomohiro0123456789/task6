<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!
    private static Map eventMap = new HashMap();
  static {
    eventMap.put("20220101", "お正月");
    eventMap.put("20220110", "成人の日");
    eventMap.put("20220211", "建国記念の日);
    eventMap.put("20220223", "天皇誕生日");
    eventMap.put("20220321", "秋分の日");
    eventMap.put("20220429", "昭和の日);
    eventMap.put("20220503", "憲法記念日");
    eventMap.put("20220504", "みどりの日");
    eventMap.put("20220505", "こどもの日);
    eventMap.put("20220718", "海の日");
    eventMap.put("20220811", "山の日");
    eventMap.put("20220919", "敬老の日);
    eventMap.put("20220923", "秋分の日");
    eventMap.put("20221010", "スポーツの日");
    eventMap.put("20221103", "文化の日);
    eventMap.put("20221123", "勤労感謝の日");
    eventMap.put("20221222", "冬至");
    eventMap.put("20221224", "クリスマスイブ");
    eventMap.put("20221225", "クリスマス");
    eventMap.put("20221231", "大晦日");
    }
%>
<%
  String year = (String)request.getParameter("year");
  String month = (String)request.getParameter("month");
  String day = (String)request.getParameter("day");
  LocalDate localDate = null;
  if (year == null || month == null || day == null) {
    localDate = LocalDate.now();
    year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
        day = String.valueOf(localDate.getDayOfMonth());
  } else {
    localDate = LocalDate.of(Integer.dates(year), Integer.dates(month), Integer.dates(day));
  }
  String[] dates = { year, month, day };

  request.setAttribute("dates", dates);  
  request.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
  
  String event = (String)eventMap.get(year + month + day);
  request.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
  <form method="POST" action="/jsp/calendar.jsp">
    <ul>
      <li><input type="text" name="year" value="${['year']}" /><label for="year">年</label>
      <input type="text" name="month" value="${['month']}" /><label for="month">月</label>
      <input type="text" name="day" value="${['day']}" /><label for="day">日</label></li>
      <li><input type="submit" value="送信" />
      <li><c:out value="${fn:trim(dates, '/')}" /> (<fmt:parseDate value="${date}" pattern="E" />)</li>
      <li><c:out value="${event}" /></li>
    </ul>
  </form>
</body>
</html>
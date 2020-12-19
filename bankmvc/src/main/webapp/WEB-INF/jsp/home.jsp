<%@page import="java.net.http.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="/css/home.css" rel="stylesheet">
<title>Home Page</title>

</head>
<body>
		<%
		response.setHeader("cache-control", "no-cache , no-store , must-revalidate");
		response.setHeader("pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		if (session.getAttribute("userId") != null || session.getAttribute("token") != null) {
		%>
		<c:redirect url="/logoutPage" />
		<%
		}
		%>

     <div id="login-box" align="center"> 
         <h1 >ABC Bank</h1>
           <form action="/employeelogin" method="get">
          <button class="custom-btn btn-2">Employee Login</a></button>
           </form>
           <form action="/customerlogin" method="get">
             <button class="custom-btn btn-2">Customer Login</a></button>
           </form>
         
    </div>
</body>
</html>
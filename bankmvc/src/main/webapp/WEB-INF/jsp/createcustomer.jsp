<%@page import="java.net.http.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="css/register.css" rel="stylesheet">
<title>Create Customer</title>
<style>
#message
{
	color : red; 
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
</head>
<body>
<div align="center">
		
		
	<%
		
		if (session.getAttribute("token") == null) {
	%>
	<c:redirect url="/403" />
	<%
		}
	%>

          <h1>ABC Bank</h1>
	<div id="login-box">

    <h1 class="signup"> Customer Sign up</h1>
    <form:form action="/finishedCustomerCreation" method="post" modelAttribute="customer">
    
	    <form:input type="text" path="userid" name="Id" placeholder="Enter Id" autocomplete="off"/>
	    <form:input type="text" path="username" name="username" placeholder="username" autocomplete="off"/>
	    <form:input type="password" path="password" name="password" placeholder="Password" />
	    <form:input type="date" id="date" path="dateOfBirth" name="dob" placeholder="Date of Birth"/>
	    <form:input type="text" path="pan" name="pan" placeholder="Pan Number" autocomplete="off"/>
	    <form:input type="text" path="address" name="address" placeholder="address" autocomplete="off"/> 
	    <input type="submit" name="signup_submit" value="Create" />
    
    </form:form>
	<p id="message">${msg }</p>
    </div>
        

</div>
</body>
</html>
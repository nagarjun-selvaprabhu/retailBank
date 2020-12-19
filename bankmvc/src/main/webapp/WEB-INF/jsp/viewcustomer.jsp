<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Viewing Customer Details</title>
</head>
<body>
		<%
		response.setHeader("cache-control", "no-cache , no-store , must-revalidate");
		response.setHeader("pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		if (session.getAttribute("userId") == null || session.getAttribute("token") == null) {
	%>
	<c:redirect url="/403" />
	<%
		}
	%>

	<div align="center">
		<table border="2" cellpadding="5">
			<caption>
				<h2>Customer Details</h2>
			</caption>
			<tr >
				<th>CUSTOMER ID</th>
				<th>CUSTOMER NAME</th>
				<th>DOB</th>
				<th>PAN</th>
				<th>ADDRESS</th>
				<th>ACCOUNTS</th> 
			</tr>
			<tr>
				<td><c:out value="${customer.userid}" /></td>
				<td><c:out value="${customer.username}" /></td>
				<td><c:out value="${customer.dateOfBirth}" /></td>
				<td><c:out value="${customer.pan}" /></td>
				<td><c:out value="${customer.address}" /></td>
				<td><table border="1" cellpadding="5">

					<tr>
						<th>ACCOUNT ID</th>
						<th>CURRENT BALANCE</th>
						<th>ACCOUNT TYPE</th>
						<th>OWNER NAME</th>
					</tr>
					<c:forEach var="acc" items="${customer.accounts}">
					<tr>
							
								<td><c:out value="${acc.accountId}" /></td>
								<td><c:out value="${acc.currentBalance}" /></td>
								<td><c:out value="${acc.accountType}" /></td>
								<td><c:out value="${acc.ownerName}" /></td>
					</tr>
					</c:forEach>
				</table></td>

			</tr>
		</table>
		
		<%-- <table border="1" cellpadding="5">

					<tr>
						<th>sourceAccountId</th>
						<th>sourceOwnerName</th>
						<th>targetAccountId</th>
						<th>targetOwnerName</th>
						<th>amount</th>
						<th>initiationDate</th>
						<th>reference</th>
					</tr>
					<c:forEach var="trans" items="${customer.accounts.transactions}">
					<tr>
							
								<td><c:out value="${trans.sourceAccountId}" /></td>
								<td><c:out value="${trans.sourceOwnerName}" /></td>
								<td><c:out value="${trans.targetAccountId}" /></td>
								<td><c:out value="${trans.targetOwnerName}" /></td>
								<td><c:out value="${trans.amount}" /></td>
								<td><c:out value="${trans.initiationDate}" /></td>
								<td><c:out value="${trans.reference}" /></td>
					</tr>
					</c:forEach>
				</table> --%>
		
		<a href="/dashboard">Back</a>
	</div>
</body>
</html>
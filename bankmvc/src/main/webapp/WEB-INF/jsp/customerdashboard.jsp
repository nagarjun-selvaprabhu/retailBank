<%@page import="java.net.http.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
<!-- Required meta tags -->
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
html {
	height: 100%;
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
<body class="doodle">


	<%
		response.setHeader("cache-control", "no-cache , no-store , must-revalidate");
		response.setHeader("pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	if (session== null) {
	%>
	<c:redirect url="/403" />
	<%
		}
	%>



	<nav
		class="navbar navbar-expand-sm bg-secondary navbar-dark justify-content-between">
		<div class="navbar-brand">ABC Bank</div>
		<div class="form-inline">
			<a class="btn btn-outline-light my-2 my-sm-0" href="/logout">Logout</a>&nbsp;&nbsp;
		</div>
	</nav>
	<center>
		<h1>Welcome to ABC Bank</h1>
	</center>
	
		<div align="center">
			<caption>
				<h2>Customer Details</h2>
			</caption>
		<table border="2" cellpadding="5">
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
		
		

	</div>
	
	
	<div align="center">
			<caption>
				<h2>Transaction Details</h2>
			</caption>

		<form action="/customerdashboard/getTransactionsInCustomerdashboard" method="post">
			<select path="accountId" name="accountId">
								<c:forEach var="acc" items="${customer.accounts}">
								<option value="${acc.accountId }">${acc.accountId }</option>
								</c:forEach>
			</select>
			<input type="submit" value="Submit"/>
		</form>
		
		<c:if test="${!empty transactions}">
		
		<table border="1" cellpadding="5">

					<tr>
						<th>sourceAccountId</th>
						<th>sourceOwnerName</th>
						<th>targetAccountId</th>
						<th>targetOwnerName</th>
						<th>amount</th>
						<th>initiationDate</th>
						<th>reference</th>
					</tr>
					<c:forEach var="trans" items="${transactions}">
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
				</table> 
		
		
		</c:if>
		
		 

	</div>
	
	<div class="row">

		<div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 9em 120em 14em 14em;">
				<div class="card   " style="width: 400px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Withdraw Amount</h4>
						<form:form action="/withdraw" method="post" modelAttribute="accountinput">
							<form:select path="accountId" name="accountId">
								<c:forEach var="acc" items="${customer.accounts}">
								<form:option value="${acc.accountId }"></form:option>
								</c:forEach>
							</form:select>
							<form:input type="number" path="amount" name="amount" placeholder="Enter the amount" />
							<input type="hidden" name="reference" value="withdraw" />
							<br> <br> <input type="submit" name="View" value="Withdraw Amount" class="btn btn-primary" />
						</form:form>
						<p id="message">${msg}</p>
					</div>
				</div>
			</div>
		</div>


		<div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 9em 120em 14em 14em;">
				<div class="card   " style="width: 400px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Transfer Amount</h4>
						<form:form action="/transfer" method="post" modelAttribute="accountinput">
						<form:select path="accountId" name="accountId">
								<c:forEach var="acc" items="${customer.accounts}">
								<form:option value="${acc.accountId }"></form:option>
								</c:forEach>
							</form:select>
							<input type="number"  name="targetAccount" placeholder="Enter the Target Account ID" />
							<input type="number"  name="amount" placeholder="Enter the amount" />
							<input type="hidden" name="reference" value="transfer" />
							<br> <br> <input type="submit" name="View" value="Transfer Amount" class="btn btn-primary" />
						</form:form>
						<p id="message">${transfermsg}</p>
					</div>
				</div>
			</div>
		</div>

	</div>


</body>
</html>
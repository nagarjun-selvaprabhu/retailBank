<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="register.css" rel="stylesheet">
<title>Create Customer</title>
<style>
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

		<h1>ABC Bank</h1>
		<div id="login-box">

			<h1 class="signup">Customer Account Creation</h1>
			<form:form action="/finishedAccountCreation" method="post"
				modelAttribute="account">

				<form:input type="text" path="customerId" name="customerId"
					value="${userId}" readonly="true" />
				<form:input type="number" path="accountId" name="accountId"
					placeholder="AccountId" />
				<form:input type="number" path="currentBalance"
					name="currentBalance" placeholder="Amount" value="0" />
				<form:select type="text" path="accountType" name="accountType">
					<form:option value="Savings"></form:option>
					<form:option value="Current"></form:option>
				</form:select>
				<form:input type="text" path="ownerName" name="ownerName"
					placeholder="OwnerName" />

				<input type="submit" name="signup_submit" value="Create Account" />

			</form:form>

		</div>


	</div>
</body>
</html>
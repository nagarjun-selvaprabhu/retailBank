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
    input[type="text"],
input[type="number"],
select[type="text"]
{
  display: block;
  box-sizing: border-box;
  margin-bottom: 20px;
  padding: 4px;
  width: 220px;
  height: 32px;
  border: none;
  border-bottom: 1px solid #AAA;
  font-family: 'Roboto', sans-serif;
  font-weight: 400;
  font-size: 15px;
  transition: 0.2s ease;
}

input[type="text"]:focus,
input[type="number"]:focus {
  border-bottom: 2px solid #16a085;
  color: #16a085;
  transition: 0.2s ease;
}

input[type="submit"] {
  margin-top: 28px;
  width: 120px;
  height: 32px;
  background: #16a085;
  border: none;
  border-radius: 2px;
  color: #FFF;
  font-family: 'Roboto', sans-serif;
  font-weight: 500;
  text-transform: uppercase;
  transition: 0.1s ease;
  cursor: pointer;
}

input[type="submit"]:hover,
input[type="submit"]:focus {
  opacity: 0.8;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
  transition: 0.1s ease;
}

input[type="submit"]:active {
  opacity: 1;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
  transition: 0.1s ease;
}

    </style>
</head>
<body style=background-color:#ffe6ff >

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
			<br>
			<form:form action="/finishedAccountCreation" method="post"
				modelAttribute="account">

				<form:input type="text" path="customerId" name="customerId"
					value="${customerId}" readonly="true" />
				<form:input type="number" path="accountId" name="accountId"
					placeholder="AccountId" autocomplete="off" />
				<form:input type="number" path="currentBalance" min="0"
					name="currentBalance" placeholder="Amount" value="0" autocomplete="off" />
				<form:select type="text" path="accountType" placeholder="Account Type" name="accountType" autocomplete="off">
					<form:option value="Savings"></form:option>
					<form:option value="Current"></form:option>
				</form:select>
				<form:input type="text" path="ownerName" name="ownerName"
					placeholder="OwnerName" autocomplete="off" />

				<input type="submit" name="signup_submit" value="Create" />

			</form:form>
			<p> <a href="/dashboard?custmsg=Customer Created">Go Back</a> and create account Later....</p>
		</div>


	</div>
</body>
</html>

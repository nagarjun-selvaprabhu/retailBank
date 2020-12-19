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
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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

#message
{
	color : red; 
}
#accmsg
{
	color : green; 
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

		if (session.getAttribute("userId") == null || session.getAttribute("token") == null) {
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
	<br>
		<h1 align="center">Welcome to ABC Bank</h1>
	
	<div class="row">

		<div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 5em 10em 2em 3em;">
				<div class="card  " style="width: 400px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Create Customer</h4>
						<p class="card-text">Click the button to create the customer</p>
						<br> <a href="/createCustomer" class="btn btn-primary">Create</a>
					</div>
					<p id="message">${custmsg}</p>
				</div>
			</div>
		</div>


		<div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 5em 10em 2em 3em;">
				<div class="card" style="width: 400px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Create Account for Customer</h4>
						<form action="/createAccount" method="post">
							<input type="text" name="customerId" placeholder="Enter the CustomerId" autocomplete="off"/>
							<br> <br> <input type="submit" name="View" value="Create Account" class="btn btn-primary" />
						</form>
						<p id="message">${accmsg}</p>
					</div>
				</div>
			</div>
		</div>

  <div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 5em 10em 2em 3em;">
				<div class="card" style="width: 400px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Delete Customer</h4>
						<form action="/deleteCustomer" method="post">
							<input type="text" name="customerId" id="customerId" placeholder="Enter the customerId" autocomplete="off"/>
							<br> <br> <input type="submit" name="Delete" value="Delete" class="btn btn-primary" />
						</form>
						<p id="message">${deletemsg}</p>
					</div>
					
				</div>
			</div>
		</div>
	</div>


	<div class="row">

		<div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 4em 10em 14em 3em;">
				<div class="card" style="width:400px;height:210px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">View the Customer</h4>
						<form action="/viewCustomer" method="get">
							<input type="text" name="userId" id="userId" placeholder="Enter the UserId" autocomplete="off"/>
							<br> <br> <input type="submit" name="View" value="View"
								class="btn btn-primary" />
						</form>
					</div>

				</div>
			</div>
		</div>
		
		<div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 4em 0em 0em 3em;">
				<div class="card" style="width:400px;height:210px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Deposit Amount</h4>
						<form action="/deposit" method="post">
							<input type="number"  name="accountId" placeholder="Enter the AccountId" autocomplete="off"/><br>	
							<input type="number" name="amount" placeholder="Enter the amount" autocomplete="off"/>
							<br> <br> 
							<input type="submit" name="View" value="Deposit Amount" class="btn btn-primary" />
						</form>
						<p id="message">${msg}</p>
					</div>
				</div>
			</div>
		</div>
        <div class="col-xs-12 col-sm-6 col-md-4">
			<div style="margin: 4em 10em 14em 3em;">
				<div class="card" style="width:400px;height:210px; background-color: #f3d8d8">
					<div class="card-body">
						<h4 class="card-title">Service Charge Detection</h4>
                        <p class="card-text">Charges will be detected for not maintaining minimum balance </p>
						<form action="/deductServiceTax" method="post">
                         <input type="submit" name="View" value="View" class="btn btn-primary" />
						</form>
						<p id="message">${servicemsg}</p>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	

</body>
</html>

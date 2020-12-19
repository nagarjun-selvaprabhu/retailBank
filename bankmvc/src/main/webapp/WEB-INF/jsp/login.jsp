<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>User Login</title>
  <link href="https://fonts.googleapis.com/css?family=Karla:400,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.materialdesignicons.com/4.8.95/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/loginUser.css">
</head>
<body>
	

  <main class="d-flex align-items-center min-vh-100 py-3 py-md-0">
    <div class="container">
      <div class="card login-card">
        <div class="row no-gutters">  
          <div class="col-md-7">
            <div class="card-body">
              <div class="brand-wrapper" align="center">
                  <h1 class="header">ABC Bank</h1>
              </div>
              <p class="login-card-description">Sign In</p>
              <form:form action="/login" method="post" modelAttribute="login">
                  <div class="form-group">
                    <form:label for="email" path="userid" class="sr-only">UserId</form:label>
                    <form:input type="text" path="userid" name="Id" id="Id" class="form-control" placeholder="UserId" autocomplete="off"/>
                  </div>
                  <div class="form-group mb-4">
                    <form:label for="password" path="password" class="sr-only">Password</form:label>
                    <form:input type="password" path="password" name="password" id="password" class="form-control" placeholder="password"/>
                  </div>
                  <form:input type="hidden" path="role" name="role" id="role" class="form-control" value="${role}"/>
                  <input name="login" id="login" class="btn btn-block login-btn mb-4" type="submit" value="Login"/>
                </form:form>
                <p id="errorMessage">${msg}</p>
                <a href="#!" class="forgot-password-link">Forgot password?</a>
                <p class="login-card-footer-text">Don't have an account? <a href="#!" class="text-reset">Register here</a></p>
                <nav class="login-card-footer-nav">
                  <a href="#!">Terms of use.</a>
                  <a href="#!">Privacy policy</a>
                </nav>
            </div>
          </div>
            <div class="col-md-5">
            <img src="Images/loginUser.jpg" alt="login" class="login-card-img">
          </div>
        </div>
      </div>
    </div>
  </main>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>
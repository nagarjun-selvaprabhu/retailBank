Name
----------
Retail Banking System

Introduction
--------------------

Retail Banking System helps customer to register and create an account with the help of employee. Customer will perform withdrawal, deposit and transfer amount within the retail bank.

Microservices
-----------------------
1.Authentication Microservice

2.Customer Microservice

3.Account Microservice

4.Transaction Microservice

5.Rules Microservice

Description
------------------
1.Employee needs to login to the web portal using user Id and password and later get authenticated with the help of JWT tokens. Once the employee is authenticated JWt token is generated and the JWT token is validated every time using "/validateToken" in the Authorization microservice.

2.Employee will create the customer by passing the customer information using "/createCustomer" in customer microservice. Employee can also delete the existing customer using "/deleteCustomer".

3. After successful creation of customer, the customer service will interact with account service to create the customer’s account using "/createAccount". The Customer can view their account details using "/getCustomerDetails".

4.The Customer can initiate the transactions like deposit (using "/deposit"), withdraw (using "/withdraw") and transfer (using "/transfer") within the retail bank. Before performs withdraw and transfer transaction service interact with rules service for checking the minimum balance criteria using "/evaluateMinBal". If criteria are satisfied transaction will happen and transaction details is stored in transaction service database and updated account details is stored in account service database.

5.The Customer can view their transaction history by using "/getTransaction" in transaction service. 

6.Service Charges will detect from account if the customer doesn’t maintain the minimum balance criteria in rules service. 

7. Once the admin decides to log out, he/she cannot view any other pages previously viewed in the logged out state. To do so, they need to login again.


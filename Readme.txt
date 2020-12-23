Name
----------
Retail Banking Management System

Description
------------
•The Retail bank requires High Availability for their operations to be available to their clients & bank employees without disruption.
•The Retail bank requires dynamic scaling. The bank periodically launches offers to its customers. On a given day, week, month of the year, the bank may experience heavy traffic. They would like to leverage the elastic features of cloud for saving costs.
•The Retail bank is currently constratined by the legacy system for depicting transaction data which is 80% of the customer traffic to the site & is extremely slow with an increasing customer base. The new system should be extremely performant for this use case
•The bank requires rapid development & deployment. It is also desired to use separate development teams to work in parallel on the core services supporting Account management, Transaction management, Customer Management services and their supporting applications simultaneously. This should accelerate development and delivery times.


Introduction
--------------------
International Patient Treatment Management System helps patients to get registered to the system with the help of admin, choose the treatment packages for the patient, assign specialists for the patient, and finally helps in claiming insurance for the patients.

Microservices
-----------------------
1. Authentication Microservice

2. Customer Microservice

3. Account Microservice

4.Transaction Microservice

5.Rules Microservice

Description
------------------
1. There are two users Bank Employee and Customer the bank users.The Employee login to the bank using "/adminlogin" endpoint and creates a account for a user.And the Employee can deposit a amount to the Customers account.

2. The customer is allowed only to create a profile in the bank using "/createCustomer" endpoint.He/She can view the details "/getCustomerDetails/{id}" endpoint.

2. For an user to login, he/she needs to enter his/her userid and password in the web portal and later get authenticated with the help of jwt tokens. Once the user is authenticated, the jwt token is validated everytime and the admin is authorized when he/she needs to go to a specific web page. The authentication is done with the help of  "/authenticate" and validated eveytime with the help of "/validate" in the Authorization microservice.

3. Only the Employee can register a Account with the Customer details and then the details are added to the database.

4. The Employee can then formulate a Service Charges plan for a Customer specifically, with the help of "/servicecharge" and can check minimum balance with the help of "/minimumbalance" endpoint in the Rules microservice.

5. The user can transfer the amount using the account id and the amount in the "/tranfer" endpoint.He/she can withdraw amount using "/withdraw" endpoint.

6. Once the admin decides to log out, he/she cannot view any other pages prviously viewed in the logged out state. To do so, they need to login again.


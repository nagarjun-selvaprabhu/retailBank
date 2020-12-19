package com.cognizant.bankmvc;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cognizant.bankmvc.feign.AccountFeign;
import com.cognizant.bankmvc.feign.AuthenticationFeign;
import com.cognizant.bankmvc.feign.CustomerFeign;
import com.cognizant.bankmvc.feign.TransactionFeign;
import com.cognizant.bankmvc.model.Account;
import com.cognizant.bankmvc.model.AccountInput;
import com.cognizant.bankmvc.model.AppUser;
import com.cognizant.bankmvc.model.CustomerEntity;
import com.cognizant.bankmvc.model.Transaction;
import com.cognizant.bankmvc.model.TransactionInput;

@Controller
public class MvcController  {

	HttpSession session;

	@Autowired
	private AuthenticationFeign authFeign;

	@Autowired
	private CustomerFeign custFeign;

	@Autowired
	private AccountFeign accountFeign;

	@Autowired
	private TransactionFeign transFeign;

	@RequestMapping("/")
	public ModelAndView home(Model model) {
		return new ModelAndView("home");
	}

	@GetMapping("/employeelogin")
	public ModelAndView employeeLogin(@RequestParam(defaultValue = "") String msg, Model model) {
		model.addAttribute("role", "EMPLOYEE");
		model.addAttribute("msg", msg);
		model.addAttribute("login", new AppUser());
		return new ModelAndView("login");
	}

	@GetMapping("/customerlogin")
	public ModelAndView customerLogin(@RequestParam(defaultValue = "") String msg,Model model) {
		model.addAttribute("role", "CUSTOMER");
		model.addAttribute("msg", msg);
		model.addAttribute("login", new AppUser());
		return new ModelAndView("login");
	}

	@PostMapping("/login")
	public ModelAndView login(@ModelAttribute("login") AppUser user, HttpServletRequest request, Model model) {
		session = request.getSession();
		String token = "Bearer ";
		AppUser loginUser = null;
		try {
			loginUser = authFeign.login(user);
		} catch (Exception ex) {
			String dir = "";
			if (user.getRole().equalsIgnoreCase("EMPLOYEE")) {
				dir = "employeelogin";
			} else {
				dir = "customerlogin";
			}
			return new ModelAndView("redirect:/" + dir + "?msg=Invalid Credentials");
		}
		token += loginUser.getAuthToken();
		session.setAttribute("userId", loginUser.getUserid());
		session.setAttribute("token", token);
		if (user.getRole().equalsIgnoreCase("CUSTOMER")) {
			CustomerEntity customer = custFeign.getCustomerDetails(token, loginUser.getUserid());
			System.out.println(customer);
			model.addAttribute("customer", customer);
			model.addAttribute("accountinput", new AccountInput());
			return new ModelAndView("redirect:/customerdashboard");
		}
		return new ModelAndView("redirect:/dashboard");

	}

	@GetMapping("/logoutPage")
	public ModelAndView logoutPage() {
		return new ModelAndView("logoutPage");
	}

	@GetMapping("/logout")
	public String logout() {
		if(session != null)
		{
			session.removeAttribute("token");
			session.removeAttribute("userId");
			session.invalidate();			 
		}
		return "redirect:/";
	}

	@GetMapping("/createCustomer")
	public ModelAndView createCustomer(@RequestParam(defaultValue = "") String msg,Model model) {
		model.addAttribute("role", "EMPLOYEE");
		model.addAttribute("msg", msg);
		model.addAttribute("customer", new CustomerEntity());
		return new ModelAndView("createcustomer");
	}

	@GetMapping("/viewCustomer")
	public ModelAndView viewCustomer(HttpServletRequest request, Model model) {
		model.addAttribute("role", "EMPLOYEE");
		try {
			String id = request.getParameter("userId");
			String token = (String) session.getAttribute("token");
			CustomerEntity customer = custFeign.getCustomerDetails(token, id);
			System.out.println(customer);
			model.addAttribute("customer", customer);
			return new ModelAndView("viewcustomer");
		} catch (Exception ex) {

			return null;
		}
	}

	@PostMapping("/createAccount")
	public ModelAndView createAccount(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		String id = request.getParameter("userId");
		model.addAttribute("role", "EMPLOYEE");
		model.addAttribute("id", id);
		model.addAttribute("account", new Account());
		return new ModelAndView("createaccount");
	}

	@GetMapping("/403")
	public ModelAndView errorpage( Model model) {
		return new ModelAndView("403");
	}

	@PostMapping("/finishedCustomerCreation")
	public ModelAndView createAccountAndAccount(@ModelAttribute("customer") CustomerEntity customer, Model model,
			RedirectAttributes redirectAttributes) {
		model.addAttribute("role", "EMPLOYEE");
		try {
			String token = (String) session.getAttribute("token");
			CustomerEntity createdCustomer = custFeign.saveCustomer(token, customer);
			model.addAttribute("role", "EMPLOYEE");
			model.addAttribute("userId", customer.getUserid());
			model.addAttribute("account", new Account());
			return new ModelAndView("createaccount");
		} catch (Exception ex) {

			return new ModelAndView("redirect:/createCustomer?msg=Account Not created");
		}

	}

	@PostMapping("/finishedAccountCreation")
	public ModelAndView createAccount(@ModelAttribute("account") Account account, Model model) {
		model.addAttribute("role", "EMPLOYEE");
		CustomerEntity customer = null;
		try {
			String token = (String) session.getAttribute("token");
			customer = custFeign.getCustomerDetails(token, account.getCustomerId());
		} catch (Exception ex) {
			return new ModelAndView("redirect:/createAccount?msg=Invalid CustomerID");
		}
		System.out.println(customer);
		System.out.println("Customer Entity" + customer + "\nAccount" + account);
		List<Account> list = new ArrayList<Account>();
		list.add(account);
		customer.setAccounts(list);
		try {
			String token = (String) session.getAttribute("token");
			System.out.println("Ready to create");
			accountFeign.createAccount(token, account.getCustomerId(), account);
		} catch (Exception ex) {
			System.out.println("Failed to create");
			return new ModelAndView("redirect:/createCustomer?msg=Account Not created");
		}
		return new ModelAndView("redirect:/dashboard?Accmsg=Account Created Successfully");
	}

	@PostMapping("/deposit")
	public ModelAndView deposit(HttpServletRequest request) {
		long accountId = Long.parseLong(request.getParameter("accountId"));
		double amount = Double.parseDouble(request.getParameter("amount"));
		AccountInput input = new AccountInput(accountId, amount);

		try {
			String token = (String) session.getAttribute("token");
			accountFeign.deposit(token, input);
			return new ModelAndView("redirect:/dashboard?msg=Amount Deposited to the Account");
		} catch (Exception ex) {

			return new ModelAndView("redirect:/dashboard?msg=Provide correct Details");
		}

	}

	@GetMapping("/dashboard")
	public ModelAndView showdashboard(@RequestParam(defaultValue = "") String msg, Model model) {
		model.addAttribute("msg", msg);
		return new ModelAndView("dashboard");
	}

	@PostMapping("/withdraw")
	public ModelAndView withdraw(HttpServletRequest request) {
		long accountId = Long.parseLong(request.getParameter("accountId"));
		double amount = Double.parseDouble(request.getParameter("amount"));
		AccountInput input = new AccountInput(accountId, amount);

		try {
			String token = (String) session.getAttribute("token");
			accountFeign.withdraw(token, input);
			return new ModelAndView("redirect:/customerdashboard?msg=Amount Withdrawen from the Account");
		} catch (Exception ex) {

			return new ModelAndView("redirect:/customerdashboard?msg=Provide correct Details");
		}
	}

	@PostMapping("/transfer")
	public ModelAndView transaction(HttpServletRequest request) {
		long sourceAccountId = Long.parseLong(request.getParameter("accountId"));
		long targetAccountId = Long.parseLong(request.getParameter("targetAccount"));
		String reference = (request.getParameter("reference"));

		double amount = Double.parseDouble(request.getParameter("amount"));
		AccountInput sourceInput = new AccountInput(sourceAccountId, amount);
		AccountInput targetInput = new AccountInput(targetAccountId, amount);
		TransactionInput transaction = new TransactionInput();
		transaction.setSourceAccount(sourceInput);
		transaction.setTargetAccount(targetInput);
		transaction.setReference(reference);
		transaction.setAmount(amount);
		System.err.println(sourceInput);
		System.err.println(targetInput);

		try {
			String token = (String) session.getAttribute("token");
			accountFeign.transaction(token, transaction);
			return new ModelAndView("redirect:/customerdashboard?transfermsg=Amount transfered from the Account");
		} catch (Exception ex) {

			return new ModelAndView("redirect:/customerdashboard?transfermsg=Provide correct Details");
		}
	}

	@GetMapping("/customerdashboard")
	public ModelAndView showcustomerdashboard(@RequestParam(defaultValue = "") String msg, Model model) {
		model.addAttribute("msg", msg);
		String token = (String) session.getAttribute("token");
		String userId = (String) session.getAttribute("userId");
		CustomerEntity customer = custFeign.getCustomerDetails(token, userId);
		System.out.println(customer);
		model.addAttribute("customer", customer);
		model.addAttribute("accountinput", new AccountInput());
		return new ModelAndView("customerdashboard");
	}

	@PostMapping("/customerdashboard/getTransactionsInCustomerdashboard")
	public ModelAndView getTransactionsInCustomerdashboard(HttpServletRequest request, Model model) {
		
		if(session==null)
		{
			return new ModelAndView("redirect:/403");
		} 
		
		String token = (String) session.getAttribute("token");
		String userId = (String) session.getAttribute("userId");
		CustomerEntity customer = custFeign.getCustomerDetails(token, userId);
		System.out.println(customer);
		model.addAttribute("customer", customer);
		model.addAttribute("accountinput", new AccountInput());
		long accountId = Long.parseLong(request.getParameter("accountId"));
		List<Transaction> transactions = transFeign.getTransactionsByAccId(token, accountId);
		model.addAttribute("transactions", transactions);
		return new ModelAndView("customerdashboard");
	}


}

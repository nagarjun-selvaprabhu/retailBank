package com.cognizant.bankmvc.feign;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import com.cognizant.bankmvc.model.CustomerEntity;

import javax.validation.Valid;

import org.springframework.cloud.openfeign.FeignClient;



@FeignClient(name = "customer", url = "${feign.url-customer-service}")
public interface CustomerFeign {

	
	@PostMapping("/createCustomer")
	public ResponseEntity<?> createCustomer(@RequestHeader("Authorization") String token,@RequestBody CustomerEntity customer);
	
	@GetMapping("/getCustomerDetails/{id}")
	public CustomerEntity getCustomerDetails(@RequestHeader("Authorization") String token, @PathVariable(name="id") String id);
	
	@PostMapping("/saveCustomer")
	public CustomerEntity saveCustomer(@RequestHeader("Authorization") String token,@Valid@RequestBody CustomerEntity customer);

	@PostMapping("/updateCustomer")
	public CustomerEntity updateCustomer(@RequestHeader("Authorization") String token,@Valid@RequestBody CustomerEntity customer);
}

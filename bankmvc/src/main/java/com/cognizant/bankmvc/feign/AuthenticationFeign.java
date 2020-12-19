package com.cognizant.bankmvc.feign;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.cognizant.bankmvc.model.AppUser;



@FeignClient(name = "auth-ms", url = "${feign.url-auth-service}")
public interface AuthenticationFeign {

	@PostMapping(value = "/login")
	public AppUser login(@RequestBody AppUser appUserloginCredentials);
}

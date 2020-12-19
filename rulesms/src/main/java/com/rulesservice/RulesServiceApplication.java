package com.rulesservice;

import java.util.Collections;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.hystrix.EnableHystrix;
import org.springframework.cloud.netflix.hystrix.dashboard.EnableHystrixDashboard;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;

import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
@EnableFeignClients
@EnableSwagger2
@SpringBootApplication
@EnableHystrix
@EnableHystrixDashboard
public class RulesServiceApplication {
	//To run rules microservice
	public static void main(String[] args) {
		SpringApplication.run(RulesServiceApplication.class, args);
	}
	
	
	@Bean
	//Swagger fetching the mapping from rules Controller
	public Docket swaggerConfiguration() {

		return new Docket(DocumentationType.SWAGGER_2).select()
				.apis(RequestHandlerSelectors.basePackage("com.rulesservice.controller")).build().apiInfo(apiInfo());

	}
//Extra information in swagger
	private ApiInfo apiInfo() {
		return new ApiInfo("RulesService", "MFPE project service", "API", "Terms of service",
				new Contact("ABC Bank", "", "abcbanking@gmail.com"), "License of API", "", Collections.emptyList());
	}
}

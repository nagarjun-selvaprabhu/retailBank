package com.cognizant.customerservice.exception;

import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.cognizant.customerservice.model.CustomErrorResponse;


@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({ CustomerNotFoundException.class })
	public ResponseEntity<CustomErrorResponse> handleConsumerNotFoundException(CustomerNotFoundException ex) {

		CustomErrorResponse response = new CustomErrorResponse();
		response.setTimestamp(LocalDateTime.now());
		response.setMessage(ex.getMessage());
		response.setStatus(HttpStatus.NOT_FOUND);
		response.setReason("Invalid Consumer Id Provided");

		return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);

	}
	
	@ExceptionHandler({ ConsumerAlreadyExistException.class })
	public ResponseEntity<CustomErrorResponse> handleConsumerExistException(ConsumerAlreadyExistException ex) {

		CustomErrorResponse response = new CustomErrorResponse();
		response.setTimestamp(LocalDateTime.now());
		response.setMessage(ex.getMessage());
		response.setStatus(HttpStatus.NOT_ACCEPTABLE);
		response.setReason("Invalid Consumer Id Provided");

		return new ResponseEntity<>(response, HttpStatus.NOT_ACCEPTABLE);

	}

	@ExceptionHandler({ AccessDeniedException.class })
	public ResponseEntity<CustomErrorResponse> handleAccessDeniedException(AccessDeniedException ex) {

		CustomErrorResponse response = new CustomErrorResponse();
		response.setTimestamp(LocalDateTime.now());
		response.setMessage(ex.getMessage());
		response.setStatus(HttpStatus.CONFLICT);
		response.setReason("Access Denied");

		return new ResponseEntity<>(response, HttpStatus.CONFLICT);

	}
	
	@ExceptionHandler({ LoginFailedException.class })
	public ResponseEntity<CustomErrorResponse> handleLoginFailedException(AccessDeniedException ex) {

		CustomErrorResponse response = new CustomErrorResponse();
		response.setTimestamp(LocalDateTime.now());
		response.setMessage(ex.getMessage());
		response.setStatus(HttpStatus.CONFLICT);
		response.setReason("Login Failed");

		return new ResponseEntity<>(response, HttpStatus.CONFLICT);

	}

}

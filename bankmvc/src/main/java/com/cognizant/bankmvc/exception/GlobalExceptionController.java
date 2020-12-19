package com.cognizant.bankmvc.exception;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ValidationException;

import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpServerErrorException.InternalServerError;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionController {

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ModelAndView handleError405(HttpServletRequest request, Exception e) {
        ModelAndView mav = new ModelAndView("/405");
        mav.addObject("exception", e);  
        mav.addObject("errorcode", "405");
        return mav;
    }
    
    @ExceptionHandler(InternalServerError.class)
    public ModelAndView handleError500(HttpServletRequest request, Exception e) {
        ModelAndView mav = new ModelAndView("/500");
        mav.addObject("exception", e);  
        mav.addObject("errorcode", "500");
        return mav;
    }
    
    @ExceptionHandler(NoHandlerFoundException.class)
    public ModelAndView handleError404(HttpServletRequest request, Exception e) {
        ModelAndView mav = new ModelAndView("/404");
        mav.addObject("exception", e);  
        mav.addObject("errorcode", "404");
        return mav;
    }
    
    @ExceptionHandler(ValidationException.class)
    public HashMap<String, Object> handlevalidationError(HttpServletRequest request, Exception e) {
    	HashMap<String, Object> map = new HashMap<>();
        map.put("key1", "Validation Error");
        map.put("Exception", e);
        return map;
    }
}
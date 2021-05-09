package com.mb.base.atp.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/")
public class TestController {
	
//	@Autowired
//	private InfoAdicionalToken additionalTokenInfo;
//	
//	@Autowired
//	private ClientRepository clientRepo;
	
	@GetMapping("test1")
	public String test1() {
		return "test1";
	}
	
	@GetMapping("test4")
	public String test4() {
		return "test4";
	}
	
//	@GetMapping("test2")
//	public String test2() {
//		Map<String, Object> additionalClaims = new HashMap<>();
//		additionalClaims.put("city", "Tres Ríos 2");
//		additionalTokenInfo.setAditionalClaims(additionalClaims);
//		return "test2";
//	}
//	
//	@GetMapping("test3")
//	public String test3() {
//		for(OAuthClient client : clientRepo.findAll()) {
//			System.out.println(client.getClientName());
//		}
//		return "test3";
//	}
	
}

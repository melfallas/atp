package com.mb.base.atp.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	//private Logger logger = LoggerFactory.getLogger(UsuarioService.class);
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		
		if(username.isEmpty()) {
			//logger.error("Error en el login: no existe el usuario '"+username+"' en el sistema!");
			throw new UsernameNotFoundException("Error en el login: no existe el usuario '"+username+"' en el sistema!");
		}
		
//		List<GrantedAuthority> authorities = usuario.getRoles()
//				.stream()
//				.map(role -> new SimpleGrantedAuthority(role.getNombre()))
//				.peek(authority -> logger.info("Role: " + authority.getAuthority()))
//				.collect(Collectors.toList());
		
		List<GrantedAuthority> authorities = new ArrayList<>();
		return new User("user", "$2a$10$C3Uln5uqnzx/GswADURJGOIdBqYrly9731fnwKDaUdBkt/M3qvtLq", true, true, true, true, authorities);
	}

}

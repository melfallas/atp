package com.mb.base.atp.model.entity;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Data;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
@Table(name="Client")
public class OAuthClient {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name="client_id")
	private String clientId;
	
	@Column(name="client_name")
	private String clientName;
	
	@Column(name="grant_type")
	private String grantType;
	
	@Column(name="client_type")
	private String clientType;
	
	@Column(name="secret_key")
	private String secretKey;
	
	@Column(name="scope")
	private String scope;
	
	@Column(name="token_vality")
	private int tokenVality;
	
	@Column(name="refresh_vality")
	private int refreshVality;

}
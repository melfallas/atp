package com.mb.base.atp.config.oauth;

import java.util.Map;
import java.util.HashMap;
import org.springframework.stereotype.Component;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;

@Component
public class AdditionalTokenInfo implements TokenEnhancer {
	
	Map<String, Object> additionalClaims = new HashMap<>();

	@Override
	public OAuth2AccessToken enhance(OAuth2AccessToken accessToken, OAuth2Authentication authentication) {
		Map<String, Object> info = new HashMap<>();
		info.put("info_adicional", "Hola que tal!: ".concat(authentication.getName()));
		info.putAll(additionalClaims);
		((DefaultOAuth2AccessToken) accessToken).setAdditionalInformation(info);
		
		return accessToken;
	}
	
	public Map<String, Object> getAditionalClaims() {
		return additionalClaims;
	}

	public void setAditionalClaims(Map<String, Object> aditionalClaims) {
		aditionalClaims.put("location", "Tres Ríos");
		this.additionalClaims = aditionalClaims;
	}

}

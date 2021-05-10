package com.mb.base.atp.config.oauth;

import java.util.Arrays;
import java.util.HashMap;
import org.springframework.context.annotation.Bean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.config.annotation.builders.InMemoryClientDetailsServiceBuilder;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.TokenEnhancerChain;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.JwtTokenStore;

import com.mb.base.atp.model.entity.OAuthClient;
import com.mb.base.atp.model.repository.ClientRepository;

@Configuration
@EnableAuthorizationServer
public class AuthorizationServerConfig extends AuthorizationServerConfigurerAdapter {

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	//@Qualifier("authenticationManager")
	private AuthenticationManager authenticationManager;
	
	@Autowired
	private AdditionalTokenInfo additionalTokenInfo;
	
	@Autowired
	private ClientRepository clientRepo;
	
	private final String SINGING_KEY = "secretKey1";

	@Override
	public void configure(AuthorizationServerSecurityConfigurer security) throws Exception {
		security.tokenKeyAccess("permitAll()")
		.checkTokenAccess("isAuthenticated()");
	}
	
	private String[] getScopeArray(String scopes) {
		//return Arrays.stream(scopes.split(", ")).map(scope -> scope.trim()).toArray();
		return scopes.split(", ");
	}
	
	@Override
	public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
		InMemoryClientDetailsServiceBuilder inMemoryBuilder = clients.inMemory ();
        for(OAuthClient client : clientRepo.findAll()) {
            //OAuthClientProperties client = authServerProperties.getClient ().get ( clientKey );
            inMemoryBuilder.withClient(client.getClientId())
			.authorizedGrantTypes(client.getGrantType())
			.secret(client.getSecretKey())
			.scopes(getScopeArray(client.getScope()))
			.accessTokenValiditySeconds(client.getTokenVality())
			.refreshTokenValiditySeconds(client.getRefreshVality())
			;
        }
		
//		clients.inMemory()
//		.withClient("clientapp1")
//			.authorizedGrantTypes("client_credentials")
//			.secret(passwordEncoder.encode(JwtConfig.LLAVE_SECRETA))
//			.scopes("read", "write")
//			.accessTokenValiditySeconds(3600)
//			.refreshTokenValiditySeconds(3600)
//		;
//		clients.inMemory()
//		.withClient("clientapp2")
//			.authorizedGrantTypes("client_credentials")
//			.secret(passwordEncoder.encode(JwtConfig.LLAVE_SECRETA1))
//			.scopes("read")
//			.accessTokenValiditySeconds(3600)
//			.refreshTokenValiditySeconds(3600)
//		;
//		clients.inMemory()
//		.withClient("clientapp1")
//			.authorizedGrantTypes("client_credentials")
//			.secret(passwordEncoder.encode(JwtConfig.LLAVE_SECRETA))
//			.scopes("read", "write")
//			.accessTokenValiditySeconds(3600)
//			.refreshTokenValiditySeconds(3600)
//		.and()
//		.withClient("clientapp2")
//			.authorizedGrantTypes("client_credentials")
//			.secret(passwordEncoder.encode(JwtConfig.LLAVE_SECRETA1))
//			.scopes("read")
//			.accessTokenValiditySeconds(3600)
//			.refreshTokenValiditySeconds(3600)
//		.and()
//		.withClient("passclient1")
//			.secret(passwordEncoder.encode("12345"))
//			.scopes("read", "write")
//			.authorizedGrantTypes("password", "refresh_token")
//			.accessTokenValiditySeconds(3600)
//			.refreshTokenValiditySeconds(3600)
//			;
	}

	@Override
	public void configure(AuthorizationServerEndpointsConfigurer endpoints) throws Exception {
		TokenEnhancerChain tokenEnhancerChain = new TokenEnhancerChain();
		//infoAdicionalToken.setAditionalClaims(new HashMap<>());
		tokenEnhancerChain.setTokenEnhancers(Arrays.asList(additionalTokenInfo, accessTokenConverter()));
		
		endpoints.authenticationManager(authenticationManager)
		.tokenStore(tokenStore())
		.accessTokenConverter(accessTokenConverter())
		.tokenEnhancer(tokenEnhancerChain);
	}

	@Bean
	public JwtTokenStore tokenStore() {
		return new JwtTokenStore(accessTokenConverter());
	}

	@Bean
	public JwtAccessTokenConverter accessTokenConverter() {
		JwtAccessTokenConverter jwtAccessTokenConverter = new JwtAccessTokenConverter();
		jwtAccessTokenConverter.setSigningKey(SINGING_KEY);
//		jwtAccessTokenConverter.setSigningKey(JwtConfig.RSA_PRIVADA);
//		jwtAccessTokenConverter.setVerifierKey(JwtConfig.RSA_PUBLICA);
		return jwtAccessTokenConverter;
	}
	

}

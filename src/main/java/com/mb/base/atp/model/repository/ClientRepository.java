package com.mb.base.atp.model.repository;

import java.util.List;
import com.mb.base.atp.model.entity.OAuthClient;
import org.springframework.data.repository.CrudRepository;


public interface ClientRepository extends CrudRepository<OAuthClient, String> {
	public List<OAuthClient> findAll();
	public List<OAuthClient> findByClientId(String clientId);
}

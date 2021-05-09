/* Client Table */

INSERT INTO client (client_id, client_name, grant_type, client_type, secret_key, scope, token_vality, refresh_vality) VALUES ('clientapp1', 'ClienteIST 1', 'client_credentials', 'confidential', '$2a$10$J7usyAJWBzpuKVSNIHUh3eltFpaMnQawAQQeRuDuY1es/K5tCRKSi', 'read', '3600', '600');
INSERT INTO client (client_id, client_name, grant_type, client_type, secret_key, scope, token_vality, refresh_vality) VALUES ('clientapp2', 'ClienteIST 2', 'client_credentials', 'confidential', '$2a$10$eky0GmNMeRi.n0Gw69Jzx.l2biYbqWvRIOY7t/wB72N5tk29A3Mqa', 'read, write', '1800', '300');
INSERT INTO client (client_id, client_name, grant_type, client_type, secret_key, scope, token_vality, refresh_vality) VALUES ('clientapp3', 'ClienteIST 3', 'client_credentials', 'confidential', '$2a$10$t6r/im2BDRP24AEI2wSWmuuXwd1Nu3OpkOX/eeUwq2UcwI2fUvTCW', 'read, write, create', '900', '150');

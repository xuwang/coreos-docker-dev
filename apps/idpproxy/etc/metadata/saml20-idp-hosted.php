<?php

$metadata['https://idpproxy.example.com/idp'] = array(
  'host' => 'idpproxy.example.com',

  /* X.509 key and certificate. Relative to the cert directory. */
  'privatekey' => 'idpproxy.key',
  'certificate' => 'idpproxy.pem',

  'auth' => 'default-sp',
//  'auth' => 'multiauth',
  
  'scope' => array ('example.com'),

  'signature.algorithm' => 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256',
  'attributes.NameFormat' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:uri',
  'authproc' => array(
    1 => array(
      'class' => 'saml:TransientNameID',
    ),
    2 => array(
      'class' => 'saml:PersistentNameID',
      'attribute' => 'eduPersonPrincipalName',
    ),
    3 => array(
      'class' => 'saml:AttributeNameID',
      'attribute' => 'mail',
      'Format' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    ),
    // Convert LDAP names to oids; keep original named attributes
    99 => array(
      'class' => 'core:AttributeMap',
      'name2oid',
      '%duplicate',
    ),
    // Some SPs want email & name rather than mail & displayName
    100 => array(
      'class' => 'core:AttributeMap',
      'mail' => array('mail', 'email'),
      'displayName' => array('displayName', 'name'),
    ),
  ),
);

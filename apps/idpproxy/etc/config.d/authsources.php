<?php

$config = array(
  'admin' => array(
    'core:AdminPassword',
  ),

  'default-sp' => array(
    'saml:SP',
    'privatekey'  => 'idpproxy.key',
    'certificate' => 'idpproxy.pem',   
    'entityID'    => 'https://idpproxy.example.com/',
    'idp'         => 'https://idp.example.com/',

    'authproc'  => array(
      20  => 'saml:NameIDAttribute',
    ),


  )

);

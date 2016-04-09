<?php

$metadata['https://idp.example.com/idp/shibboleth'] = array(
  'name' => array(
    'en' => 'Example IT Lab IdP',
  ),
  'description'         => 'Example IT Lab IdP',
  'SingleSignOnService' => 'https://idp.example.com/idp/profile/SAML2/Redirect/SSO',
  'certFingerprint'     => 'AA:D2:5D:74:6E:49:49:B0:7B:D3:22:D6:31:32:14:81:B1:74:46:39'
);

$metadata['https://idpproxy.example.com/idp'] = array (
  'name' => array(
    'en' => 'Example IT Lab IdP Proxy',
  ),
  'description'         => 'Example IT Lab IdP Proxy',
  'SingleSignOnService' => 'https://idpproxy.example.com/simplesamlphp/saml2/idp/SSOService.php',
  'certFingerprint'     => 'DD:04:2D:D3:AF:AC:E8:CB:70:95:18:DF:B5:A3:88:73:1F:F1:6C:3F',
);

$metadata['https://idp-dev.example.edu/'] = array(
  'name' => array(
    'en' => 'Example Test WebAuth',
  ),
  'description'         => 'Example Test WebAuth',
  'SingleSignOnService' => 'https://idp-dev.Example.edu/idp/profile/SAML2/Redirect/SSO',
  'certFingerprint'     => '0F:6F:50:00:54:B6:13:3B:99:17:61:FD:F3:AD:62:F7:86:D4:F1:5B'
);

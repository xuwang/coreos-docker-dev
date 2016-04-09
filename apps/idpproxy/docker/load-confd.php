
# load extra config files from config.d
foreach (glob("/var/simplesamlphp/config.d/*.php") as $file) {
  require_once  $file;
};


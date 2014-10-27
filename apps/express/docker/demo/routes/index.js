var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { 
	  	title: 'NodeJS Demo',
		hello: process.env.HELLO,
	    host: process.env.HOST,
	    hostname: process.env.HOSTNAME,
	    container: process.env.CONTAINER
	});
});

module.exports = router;

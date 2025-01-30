var mysql = require('mysql');
var connection = mysql.createConnection({
	host:'my-database.clltcz5rxr1s.ap-southeast-1.rds.amazonaws.com',
	user:'root',
	password:'password',
	database:'my-database'
});
connection.connect(function(error){
	if(!!error) {
		console.log(error);
	} else {
		console.log('Connected..!');
	}
});

module.exports = connection;
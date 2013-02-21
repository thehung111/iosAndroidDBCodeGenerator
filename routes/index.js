
var config = require('../config').config;
var sqlite3 = require('sqlite3').verbose();
var tables = []; // table information
var async =   require('async');


/*
 * DB calls
 */

var readTablesInfo = function(db, callback){
 
  db.serialize(function() {
	  db.all("SELECT * FROM sqlite_master WHERE type='table' ", function(err, rows) {
	  	  tables = rows;
	  	  db.close();
          
          callback("done");
      });
  });
	
}

var readColumnsInfo = function(db, tableName, callback){
 
  var query = "PRAGMA table_info('" + tableName  + "') ";
  
  
  db.serialize(function() {
	  db.all(query, function(err, rows) {
	  	  db.close();
          callback("done", rows);
      });
  });
	
}


/////////////////////////////////

// views
// https://github.com/developmentseed/node-sqlite3/blob/master/examples/simple-chaining.js
// http://blog.millermedeiros.com/node-js-as-a-build-script/

exports.viewtable = function(req, res){
/* 	 console.log(req.route);	 */

	config.refreshTemplate();

	var tableName = req.route.params['name'];
	
	
	async.waterfall(
  	[
	    function(callback){
	        
	        var db = new sqlite3.Database(config.dbPath  , sqlite3.OPEN_READONLY, 
  				// database callback
			  	function(err){
					callback(err, db);
			  	}
			);
	        
	        
	    },
	  
	    function(db, callback){
	    	//console.log("Open database successfully");
	    	
	    	
			readColumnsInfo(db, tableName, function(err, rows){
				callback(null, rows);
				
			} );
			        

	        
	    }
	], 
	function (err, result) {
	   
	   
	   // result now equals 'done'
	   if(err)
	   	console.log("There is an error when trying to open database");
	   
	   res.render('viewtable', { title: tableName ,
							  dbErr: err,
							  dbPath: config.dbPath,
							  result: result,
							  dataTypeMappingStr: JSON.stringify(config.dataTypeMapping) ,
							  config: config
							} 
	   );
	}
  );


}


exports.index = function(req, res){
  
  console.log("Accessing sqlite db path: " + config.dbPath);
 
  async.waterfall(
  	[
	    function(callback){
	        
	        var db = new sqlite3.Database(config.dbPath  , sqlite3.OPEN_READONLY, 
  				// database callback
			  	function(err){
					callback(err, db);
			  	}
			);
	        
	        
	    },
	  
	    function(db, callback){
	    	console.log("Open database successfully");
	    	
	    	
			readTablesInfo(db, function(){
				callback(null, 'done');
				
			} );
			        

	        
	    }
	], 
	function (err, result) {
	   
	   console.log("table.length " + tables.length);
	   
	   // result now equals 'done'
	   if(err)
	   	console.log("There is an error when trying to open database");
	   
	   res.render('index', { title: 'iOS & Android DB Code Generator for sqlite' ,
							  dbErr: err,
							  dbPath: config.dbPath,
							  tables: tables
							  
							} 
	   );
	}
  );
 
  
  
};

// documentation page
exports.guide = function(req, res){

	res.render('guide', { title: 'Guide'} );

};


var fs = require('fs');

var serverConfig ={
    dbPath: 'db/test.db' ,   // file path to sqlite database that we want to generate code 
    						// driver: https://github.com/developmentseed/node-sqlite3/wiki
    dataTypeMapping: {      // mapping for data type in sqlite to android and ios
	    'TEXT' : {'ios' : 'NSString*', 'android' : 'String' } ,
	    'NUMERIC' : {'ios' : 'int', 'android' : 'int' } ,
	    'REAL' : {'ios' : 'float', 'android' : 'float' } // blob are not supported for now
    },
    
    // template paths
    iosModelHeaderTemplatePath: 'template/ios_model_header.h',
    iosModelImpTemplatePath: 'template/ios_model_imp.m',
    androidModelTemplatePath: 'template/android_model.java' ,
    
    // crud paths
    iosCRUDHeaderTemplatePath: 'template/ios_crud_header.h',
    iosCRUDImpTemplatePath: 'template/ios_crud_impl.m',
    androidCRUDTemplatePath: 'template/android_crud.java',
    
    refreshTemplate: function(){
	    // read the template files and store it into the configuration
		var iosModelHeaderCode = fs.readFileSync(serverConfig.iosModelHeaderTemplatePath, "utf8");
		serverConfig['iosModelHeaderCode'] = iosModelHeaderCode;
		
		var iosModelImpCode = fs.readFileSync(serverConfig.iosModelImpTemplatePath, "utf8");
		serverConfig['iosModelImpCode'] = iosModelImpCode;
		
		var androidModelCode = fs.readFileSync(serverConfig.androidModelTemplatePath, "utf8");
		serverConfig['androidModelCode'] = androidModelCode;
		
		var iosCRUDHeaderCode = fs.readFileSync(serverConfig.iosCRUDHeaderTemplatePath, "utf8");
		serverConfig['iosCRUDHeaderCode'] = iosCRUDHeaderCode;
		
		var iosCRUDImpCode = fs.readFileSync(serverConfig.iosCRUDImpTemplatePath, "utf8");
		serverConfig['iosCRUDImpCode'] = iosCRUDImpCode;
		
		var androidCRUDCode = fs.readFileSync(serverConfig.androidCRUDTemplatePath, "utf8");
		serverConfig['androidCRUDCode'] = androidCRUDCode;
    }
    
};

serverConfig.refreshTemplate();


exports.config = serverConfig;
CRUD DB Code Generator for Android & iOS
=========================

The aim of this project is to generate basic CRUD code for both Android/iOS for local sqlite database access so that the code can be 
shared between the 2 platforms.

## Setup
        	
This application is developed using ExpressJS 3.0. 

1. First install Node.JS &amp; Express. 
2. Run the app with "node app.js" .  
3. Access the server app via http://localhost:3000 after installing. 


## Instructions

<ol>
	<li>Create a SQLite Database.</li>
	<li>Update configuration path under config folder &gt; index.js. Update dbPath to point to the created database.</li>
	<li>The default test database is under db folder(test.db)</li>
	<li>Currently only supported TEXT/NUMERIC/REAL column data types generation. 
		There must not be spaces or special characters for the table and column names;
	</li>
	<li>This project generate <a href="https://github.com/ccgus/fmdb">fmdb</a> wrapper model/crud code for iOS, 
		and <a href="https://github.com/jgilfelt/android-sqlite-asset-helper">SQLiteAssetHelper</a> wrapper for Android.</li>
	<li>The code templates are put under the <b>template</b> folder. All special parameters are marked with {{template_Variable}} </li>	
		
	<li>Majority of the code generation is put under viewtable.ejs</li>
	
</ol>



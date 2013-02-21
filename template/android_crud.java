package com.example.helper;  // TODO: PLEASE UPDATE THE PACKAGE NAME and import
import com.example.model.{{ClassName}};

import java.util.ArrayList;
import java.util.List;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.readystatesoftware.sqliteasset.SQLiteAssetHelper;  // wrapper for SQLiteAssetHelper

public class DBHelper  extends SQLiteAssetHelper{

	// the zip file must be testdb.zip
	// inside the zip file there must be a testdb-v1.db or testdb-v2.db
	// sqlitehelper dependencies. Please read documentation
	// the zip file must be under assets > databases folder
	private static final String DATABASE_NAME = "testdb";  // TODO: update the database name to be your database
	private static final int DATABASE_VERSION = 1;
	
	private static final String {{TABLE_NAME_CAPITAL}}_TABLE_NAME = "{{TABLE_NAME}}" ; // table name
	
	// column names 
{{COLUMN_NAMES}}
	
	
	private static final String[] {{TABLE_NAME_CAPITAL}}_TABLE_COLUMNS = {  {{TABLE_COL_LIST}}   } ;
	
	public DBHelper(Context context)
	{
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}
	
	// CRUD for {{ClassName}}

	public boolean insert{{ClassName}}({{ClassName}} entry)
	{
		if(entry!=null){
			SQLiteDatabase db = this.getWritableDatabase();
			ContentValues values = new ContentValues();
			
{{CONTENT_VALUE_LIST}}
			
			return (db.insert({{TABLE_NAME_CAPITAL}}_TABLE_NAME, null, values) != -1);	
		}
		
		
		return false;
	}
	
	public boolean update{{ClassName}}({{ClassName}} entry)
	{
		if(entry == null)
			return false;
		
		SQLiteDatabase db = this.getWritableDatabase();
		ContentValues values = new ContentValues();
		
{{CONTENT_VALUE_LIST}}
		
		db.update({{TABLE_NAME_CAPITAL}}_TABLE_NAME, values, "{{pkDBCol}} = ?", 
									new String[]{ String.valueOf(  entry.get{{camelPkCol}}() ) } );
		
		return true;
	}
	
	// check primary key, insert if not exist, update if exist
	public boolean save{{ClassName}}({{ClassName}} entry)
	{
		if(entry == null)
			return false;
		
		boolean isExist = this.is{{ClassName}}Exist(entry.get{{camelPkCol}}() );
		
		if(isExist)
			return update{{ClassName}}(entry);
		else
			return insert{{ClassName}}(entry);
		
	}
	
	// deletion
	public int deleteAll{{ClassName}}s()
	{
		SQLiteDatabase db = this.getWritableDatabase();
		int noOfRowsAffected = db.delete({{TABLE_NAME_CAPITAL}}_TABLE_NAME, null, null);
		return noOfRowsAffected;
	}
	
	public int delete{{ClassName}}ByPK({{pkType}} {{pkCol}})
	{
		SQLiteDatabase db = this.getWritableDatabase();
		int noOfRowsAffected = db.delete({{TABLE_NAME_CAPITAL}}_TABLE_NAME, "{{pkDBCol}} = ?", 
											new String[]{ String.valueOf(  {{pkCol}} ) });
		return noOfRowsAffected;
	}
	
	
	private List<{{ClassName}}> process{{ClassName}}Cursor(Cursor c)
	{
		List<{{ClassName}}> results = new ArrayList<{{ClassName}}>();
		
		int numRows = c.getCount();
		c.moveToFirst();
			
		for (int i = 0; i < numRows; i++) {
			
			{{ClassName}} entry = new {{ClassName}}();
			
			
{{RETRIEVE_DATA}}
			
			results.add(entry);
			
			c.moveToNext();
		}
		
		c.close();
		
		return results;
	}
	
	public List<{{ClassName}}> findAll{{ClassName}}s()
	{
		SQLiteDatabase db = getReadableDatabase();
		
		Cursor c = db.query({{TABLE_NAME_CAPITAL}}_TABLE_NAME, 
							{{TABLE_NAME_CAPITAL}}_TABLE_COLUMNS, 
							null, null, // where arguments 
							null, null, null // groupby, having, orderby
				); 
		
		return process{{ClassName}}Cursor(c);

	}
	

	public {{ClassName}} find{{ClassName}}ByPK({{pkType}} {{pkCol}} )
	{
		
		SQLiteDatabase db = getReadableDatabase();
		
		Cursor c = db.query({{TABLE_NAME_CAPITAL}}_TABLE_NAME, 
							{{TABLE_NAME_CAPITAL}}_TABLE_COLUMNS, 
							"{{pkDBCol}} = ?", new String[]{ String.valueOf(  {{pkCol}} ) }, // where arguments
							null, null, null // groupby, having, orderby
				); 
		
		List<{{ClassName}}> results = process{{ClassName}}Cursor(c);
		if(results == null || results.size() == 0)
			return null;
		else
			return results.get(0);
	}
	

	public boolean is{{ClassName}}Exist( {{pkType}} {{pkCol}} )
	{
		{{ClassName}} entry = find{{ClassName}}ByPK({{pkCol}});
		return (entry!=null);
	}
	
	


		
}

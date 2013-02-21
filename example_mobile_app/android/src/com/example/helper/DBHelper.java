package com.example.helper;  // TODO: PLEASE UPDATE THE PACKAGE NAME and import
import com.example.model.User;

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
	
	private static final String USER_TABLE_NAME = "User" ; // table name
	
	// column names 
    private static final String USERID = "userId" ; 
    private static final String NAME = "name" ; 
    private static final String HANDPHONE = "handphone" ; 
    private static final String EMAIL = "email" ; 

	
	
	private static final String[] USER_TABLE_COLUMNS = {  USERID ,NAME ,HANDPHONE ,EMAIL    } ;
	
	public DBHelper(Context context)
	{
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}
	
	// CRUD for User

	public boolean insertUser(User entry)
	{
		if(entry!=null){
			SQLiteDatabase db = this.getWritableDatabase();
			ContentValues values = new ContentValues();
			
    values.put(USERID, entry.getUserId() ) ; 
    values.put(NAME, entry.getName() ) ; 
    values.put(HANDPHONE, entry.getHandphone() ) ; 
    values.put(EMAIL, entry.getEmail() ) ; 

			
			return (db.insert(USER_TABLE_NAME, null, values) != -1);	
		}
		
		
		return false;
	}
	
	public boolean updateUser(User entry)
	{
		if(entry == null)
			return false;
		
		SQLiteDatabase db = this.getWritableDatabase();
		ContentValues values = new ContentValues();
		
    values.put(USERID, entry.getUserId() ) ; 
    values.put(NAME, entry.getName() ) ; 
    values.put(HANDPHONE, entry.getHandphone() ) ; 
    values.put(EMAIL, entry.getEmail() ) ; 

		
		db.update(USER_TABLE_NAME, values, "userId = ?", 
									new String[]{ String.valueOf(  entry.getUserId() ) } );
		
		return true;
	}
	
	// check primary key, insert if not exist, update if exist
	public boolean saveUser(User entry)
	{
		if(entry == null)
			return false;
		
		boolean isExist = this.isUserExist(entry.getUserId() );
		
		if(isExist)
			return updateUser(entry);
		else
			return insertUser(entry);
		
	}
	
	// deletion
	public int deleteAllUsers()
	{
		SQLiteDatabase db = this.getWritableDatabase();
		int noOfRowsAffected = db.delete(USER_TABLE_NAME, null, null);
		return noOfRowsAffected;
	}
	
	public int deleteUserByPK(int userId)
	{
		SQLiteDatabase db = this.getWritableDatabase();
		int noOfRowsAffected = db.delete(USER_TABLE_NAME, "userId = ?", 
											new String[]{ String.valueOf(  userId ) });
		return noOfRowsAffected;
	}
	
	
	private List<User> processUserCursor(Cursor c)
	{
		List<User> results = new ArrayList<User>();
		
		int numRows = c.getCount();
		c.moveToFirst();
			
		for (int i = 0; i < numRows; i++) {
			
			User entry = new User();
			
			
int userId = c.getInt(0); 
    entry.setUserId(userId); 
String name = c.getString(1); 
    entry.setName(name); 
int handphone = c.getInt(2); 
    entry.setHandphone(handphone); 
String email = c.getString(3); 
    entry.setEmail(email); 

			
			results.add(entry);
			
			c.moveToNext();
		}
		
		c.close();
		
		return results;
	}
	
	public List<User> findAllUsers()
	{
		SQLiteDatabase db = getReadableDatabase();
		
		Cursor c = db.query(USER_TABLE_NAME, 
							USER_TABLE_COLUMNS, 
							null, null, // where arguments 
							null, null, null // groupby, having, orderby
				); 
		
		return processUserCursor(c);

	}
	

	public User findUserByPK(int userId )
	{
		
		SQLiteDatabase db = getReadableDatabase();
		
		Cursor c = db.query(USER_TABLE_NAME, 
							USER_TABLE_COLUMNS, 
							"userId = ?", new String[]{ String.valueOf(  userId ) }, // where arguments
							null, null, null // groupby, having, orderby
				); 
		
		List<User> results = processUserCursor(c);
		if(results == null || results.size() == 0)
			return null;
		else
			return results.get(0);
	}
	

	public boolean isUserExist( int userId )
	{
		User entry = findUserByPK(userId);
		return (entry!=null);
	}
	
	


		
}
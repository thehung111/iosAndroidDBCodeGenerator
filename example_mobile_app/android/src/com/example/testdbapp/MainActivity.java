package com.example.testdbapp;

import java.util.List;

import com.example.helper.DBHelper;
import com.example.model.User;

import android.os.Bundle;
import android.app.Activity;
import android.util.Log;
import android.view.Menu;

public class MainActivity extends Activity {

	private DBHelper dbHelper;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		
		dbHelper = new DBHelper(this);
		
//		testDelete();
		
//		testSave();
		
		// test finders
		testFinders();
		
		
	}
	
	public void testDelete()
	{
		dbHelper.deleteUserByPK(9);
	}
	
	public void testSave()
	{
		User u = new User();
		u.setUserId(1111);
		u.setHandphone(222);
		u.setName("Dragon");
		u.setEmail("tttt@ttt.cookie");
		
		dbHelper.insertUser(u);
		
		u.setUserId(999);
		dbHelper.saveUser(u);
		
		
		u.setUserId(5);
		dbHelper.saveUser(u);
		
		
	}
	
	
	public void testFinders()
	{
		Log.i("TEST", "id 5 exist? " + dbHelper.isUserExist(5));
		Log.i("TEST", "id 5444 exist? " + dbHelper.isUserExist(5444));
		
		User user = dbHelper.findUserByPK(5);
	
		Log.i("TEST" , "userId: " + user.getUserId() + ", name: " + user.getName() + ", hp: " + user.getHandphone() + ", email: " + user.getEmail() );
		
		List<User> users = dbHelper.findAllUsers();
		
		for(User u: users)
		{
			Log.i("TEST" , "--userId: " + u.getUserId() + ", name: " + u.getName() + ", hp: " + u.getHandphone() + ", email: " + u.getEmail() );
			
		}
		
	}
	
	
	@Override
	protected void onDestroy() {
		super.onDestroy();
		dbHelper.close();
	}


	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}

}

package com.example.model; // PLEASE CHANGE THIS TO THE CORRECT PACKAGE

public class User {

    private int userId ; 
    private String name ; 
    private int handphone ; 
    private String email ; 

	

    // getter and setter

	public void setUserId(int userId ) {
		this.userId = userId;
	}

	public int getUserId() {
		return userId;
	}


	public void setName(String name ) {
		this.name = name;
	}

	public String getName() {
		return name;
	}


	public void setHandphone(int handphone ) {
		this.handphone = handphone;
	}

	public int getHandphone() {
		return handphone;
	}


	public void setEmail(String email ) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}




}
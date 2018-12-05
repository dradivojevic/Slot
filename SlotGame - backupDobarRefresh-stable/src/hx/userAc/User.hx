package hx.userAc;

/**
 * ...
 * @author Dusan Radivojevic
 *
 *Klasa User za registrovane korisnike
 */

 
class User 
{
	var userId:Int;
	var name:String;
	var username:String;
	var password:String;
	var credit:Float;

	public function new(userId, name, username, password, credit ) 
	{
		this.userId = userId;
		this.name = name;
		this.username = username;
		this.password = password;
		this.credit = credit;
	}
	public function toString(){
		return "Created user " + username;
	}
	
}
package hx.slotGame;
import hx.mashine.Spinner;
import hx.userAc.User;

/**
 * ...
 * @author Dusan Radivojevic
 */
class Game 
{

	public function new() 
	{
		var user = new User(1,"Dusan","dr","pass",1000);
		var spinner = new Spinner();
		spinner.spinn(1, 3);
		
	}
	
}
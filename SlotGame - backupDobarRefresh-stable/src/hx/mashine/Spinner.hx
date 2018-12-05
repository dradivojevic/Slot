package hx.mashine;
import hx.slotGame.Results;
import hx.slotGui.TestSlotGui;

/**
 * ...
 * @author Dusan Radivojevic
 * 
 * Klasa koja pokrece tockice spinuje ih tako sto inicira objekat klase reel
 * ideja je da se kasnije odabirom igre bira broj tockica 
 * 
 */
class Spinner
{
	var spinnerId:Int;
	var nrOfReels:Int;
	var _results = new Array(); 
	var _resultsId = new Array();
	
	public function new()
	{
		
	}

	public function spinn(spinnerId,nrOfReeels)
	{
		this.nrOfReels = nrOfReeels;
		this.spinnerId = spinnerId;
			
		var i = 0;
		
		while (i < nrOfReeels)
		{
			var reel = new Reel(i);
			
			reel.getChosen();
			_results.push(reel.getChosen());
			_resultsId.push(reel.getChosenId());
			
			i++;
		}
		var results = new Results();
		results.SetRes(_results);
		
		var gui = new TestSlotGui();
		gui.setResults(_resultsId);
		//trace("array "  +_results);
		

	}
	function setResultsId(resultsid)
	{
		this._resultsId = resultsid;
	}
	public function get_ResultsId(){
		return _resultsId;
	}

}
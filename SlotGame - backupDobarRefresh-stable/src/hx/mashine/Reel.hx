
package hx.mashine;
import hx.mashine.Symbols;
import Random;
import js.html.rtc.IdentityAssertion;

/**
 * ...
 * @author Dusan Radivojevic
 *
 * Klasa tockic za inicijalizaciju slicica koje se vrte
 * u samom konstuktoru se nalaze svi objekti klase Symbols.
 * Pozivom konstruktora, pokrece se random odabir slicice koji simulira okretanje tocka.
 *
 */
class Reel
{
	var reelId:Int;
	var rndm:Int;
	var fruit = new Array();
	var chosen:String;
	var chosenId:Int;
	//var

	public function new(reelId)
	{
		this.reelId = reelId;

		//test da li moze u konstruktoru

		fruit[0] = new Symbols(1, "kruska");
		fruit[1] = new Symbols(2, "zvezda");
		fruit[2] = new Symbols(3, "jagoda");
		fruit[3] = new Symbols(4, "7");
		fruit[4] = new Symbols(5, "tresnja");
		fruit[5] = new Symbols(6, "limun");
		fruit[6] = new Symbols(7, "BAR");
		fruit[7] = new Symbols(8, "banana");
		fruit[8] = new Symbols(9, "kruna");

		var ran =  Random.int(0, fruit.length-1);

		try
		{
			trace("------RAN----- " + ran);
			this.chosen = fruit[ran].GetSymbol();
			this.chosenId = fruit[ran].GetId()-1;
		}
		catch (err:Dynamic)
		{
			trace("!!!!!!!!!!!UFATIO!!!!!!!!!!!");
		}

	}
	/**
		//pomocna f-ja
		function choseFruit(r:Array)
		{
			var ran =  Random.int(0, r);
			this.chosen = r[ran].GetSymbol();
			trace("iz pomocne " + r);

		} */

//geteri i seteri
	/**private function setChosen(chosen)
	{
		this.chosen = chosen;
		trace("rucno setovana izabrana slika" + chosen);
	}*/
	public function getChosen()
	{

		return chosen;

	}
	public function getChosenId()
	{

		return chosenId;

	}

}
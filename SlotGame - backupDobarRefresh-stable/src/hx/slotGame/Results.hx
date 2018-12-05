package hx.slotGame;

/**
 * ...
 * @author Dusan Radivojevic
 * klasa u kojoj se obradjuje rezultat spinovanja tockica
 *
 */
class Results
{
	var res = new Array();

	public function new()
	{

	}
	//proverava elemente u nizu da li su identicni
	//dodato null za ukoliko res vrati null
	public function checkWin()
	{
		var isWin:Bool = true;
		var i:Int = 0;
		while (i < res.length)
		{
			if (res[i]==null ? res[0]==null :res[0]!=res[i])
			{
				isWin = false;
				break;

			}
			else
			{
				isWin = true;

			}
			i++;

		}
		if (isWin)
		{
			trace("CESTITAMOOO");
		}
		else
		{
			trace("pokusaj ponovo");
		}
	}

	public function SetRes(res)
	{
		this.res = res;
		trace("REZULTAT " + res);
		checkWin();
	}
	public function get_res()
	{
		return res;
		trace("ressss" + res);
	}
}
package hx.mashine;

/**
 * ...
 * @author Dusan Radivojevic
 * 
 * Klasa za identifikaciju Simbola
 * ideja za kasnije - dodati koeficijent verovatnoce dobitka kao parametar
 */
class Symbols 
{
	var symbolsId:Int;
	var symbol:String;

	public function new(symbolsId,symbol ) 
	{
		this.symbol = symbol;
		this.symbolsId = symbolsId;
	}
	public function GetSymbol():String{
		return symbol;
	}
	public function GetId(){
		return symbolsId;
	}
}
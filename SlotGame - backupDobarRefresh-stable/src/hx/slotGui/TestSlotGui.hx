package hx.slotGui;

/**
 * ...
 * @author Dusan Radivojevic
 */
import hx.mashine.Spinner;
import hx.slotGame.Game;
import hx.slotGame.Results;
import js.Browser;
import pixi.core.display.Container;
import pixi.core.sprites.Sprite;
import pixi.core.text.Text;
import pixi.core.text.DefaultStyle;
import pixi.core.textures.Texture;
import pixi.extras.TilingSprite;
import pixi.filters.blur.BlurFilter;

import pixi.loaders.Loader;
import pixi.loaders.ResourceLoader;
import pixi.plugins.app.Application;
import pixi.core.renderers.Detector;

class TestSlotGui extends Application
{
	var game:Game;
	var _results=[];

	var mashineGuiIMG = "/img/masina.png";
	var sybolsReelIMG = "/img/symbols.png";
	var spinButtonIMG = "/img/spin button.png";
	var spinButtonPressedIMG = "/img/spin button pressed.png";

	var _label:Text;

	var buttonTexture:Texture;
	var pressedButtonTexture:Texture;
	var buttonSprite:Sprite;
	var _swap:Bool;
	
	var buttonSprite2:Sprite;

	var blurFilter:BlurFilter;
	var _count:Float;

	var startState = 0;
	var running = 1;
	var spinning = 2;
	var isWin = 3;

	var nrOfReels = 3;//kasnije moze da se inicira na drugi nacin prilikom kreiranja nove partije ako igrac hoce vise tockica
	var inititalX = 25;//x pozicija crtanja tockica
	var symbolHeight = 100; // visina slicice - simbola, zavisi od toga kako je nacrtana u symbols.png - kod mene je visina 100 i sisrina 100 px
	var symbolWidth = 100;
	var nrOfSpinning = 3; //broj krugova koliko ce po tockicu da se svi simboli izvrte
	var nrOfSymbols = 9;//ukupan broj simbola koji se vrte (kod mene je 9 nacrtano i 9 se bira u drugoj klasi-logici)

	var gameStatus = 0; // pocetak igre in
	var yPosChosen = [];//pozicija izabranih slicica
	var slotSprite = []; //sprite slot masine lista tockica
	var initPosition = []; //prechosed position pocetna pozicija tocikca pre nego sto se zavrte
	var speed = [ 15, 20, 25 ];//brzina okretanja tockica

	//var reelTexture = Texture.fromImage(sybolsReelIMG);
	//slotSprite[] =  new TilingSprite(reelTexture, symbolWidth, symbolHeight+27);

	public function new()
	{
		super();
		_init();

	}
	function _init()
	{
		backgroundColor = 0x000000;
		antialias = false;
		transparent = false;
		onUpdate = _onUpdate;
		super.start();

		Browser.document.body.appendChild(renderer.view);

		//text ispod dugmeta
		var style:DefaultStyle = {};
		style.fill = 0xf7ef07;
		style.fontSize = 24;
		style.fontFamily = "Courier";
		_label = new Text("",style);
		_label.position.set(0, 550);

		//ucitavanje slicica preko loadera

		trace("pocetak ucitavanja");

		var loader = new Loader();

		loader.add(mashineGuiIMG);
		loader.add(sybolsReelIMG);
		loader.add(spinButtonIMG);
		loader.add(spinButtonPressedIMG);

		loader.on("progress", loading);

		loader.load(setup);

	}
	function loading()
	{
		_label.text ="ucitavam";
		trace("ucitavam");
	}
	function setup()
	{
		gameStatus = startState;
		_label.text="ucitano";
		trace("ucitano");
		//prikaz slike masine
		var masinaSprite = new Sprite(Texture.fromImage(mashineGuiIMG));
		masinaSprite.x = 0;
		masinaSprite.y = 0;
		stage.addChild(masinaSprite);

		//prikaz slike tockica
		initPosition = [1, 1, 1];//inicijalne pozicije slicice tockica
		var reelTexture = Texture.fromImage(sybolsReelIMG);

		for (i in 0...nrOfReels)
		{
			slotSprite[i] =  new TilingSprite(reelTexture, symbolWidth, symbolHeight+27);
			slotSprite[i].tilePosition.x = 0;
			slotSprite[i].tilePosition.y = ( -initPosition[i] * symbolHeight) + 3;
			slotSprite[i].x = inititalX + i* 117; //0 prva pozicija, 1 druga kucica, 2 treca kucica
			slotSprite[i].y = 190;
			stage.addChild(slotSprite[i]);

		}

		//dugme
		_swap = false;
		buttonTexture = Texture.fromImage(spinButtonIMG);
		pressedButtonTexture = Texture.fromImage(spinButtonPressedIMG);

		buttonSprite = new Sprite(buttonTexture);
		buttonSprite.buttonMode = true;
		buttonSprite.x = 100;
		buttonSprite.y = 370;
		buttonSprite.scale.set(0.2, 0.2);
		buttonSprite.interactive = true;
		buttonSprite.buttonMode = true;
		
		//test dugme 2 za reset
		buttonSprite2 = new Sprite(buttonTexture);
		buttonSprite2.buttonMode = true;
		buttonSprite2.x = 250;
		buttonSprite2.y = 370;
		buttonSprite2.scale.set(0.2, 0.2);
		buttonSprite2.interactive = true;
		buttonSprite2.buttonMode = true;

		//promena texture kada se predje kursorom preko
		buttonSprite.mouseover = function(e)
		{
			buttonSprite.texture = pressedButtonTexture;
			//_swap = !_swap;
			_label.text = "Over";
			trace(" over");
		}
		buttonSprite.mouseout = function(e)
		{
			//_swap = !_swap;
			buttonSprite.texture = buttonTexture;
			_label.text = "out";
			trace(" out");

		}
		stage.addChild(_label);

		buttonSprite
		.on("click", spinReels);
		
		buttonSprite2
		.on("click", resetGame);//test drugo dugme za reset

		stage.addChild(buttonSprite);
		stage.addChild(buttonSprite2);//test drugo dugme za reset
		
		renderer.render(stage);

		//blur
		blurFilter = new BlurFilter();
		masinaSprite.filters = [blurFilter];
		_count = 0;

	}
	function resetGame()
	{
		var res =  new Spinner();
		trace(" get result " + res.get_ResultsId());
		Main;
	}

	function spinReels()
	{
		_swap = !_swap;
		_label.text = "stisnuto dugme "+_swap;
		trace("stisnuto dugme"+_swap);
		buttonSprite.texture = (_swap) ? pressedButtonTexture : buttonTexture;
		
		spinAnimate();

	}
	function  _onUpdate(elapsedTime:Float)
	{
		_count += 0.01;

		var blurAmount1 = Math.cos(_count);
		blurFilter.blur = 5 * (blurAmount1);

	}

	function spinAnimate()
	{
		if (gameStatus==isWin||gameStatus==startState)
		{

			//initPosition = [2, 5, 9];//arucno setovanje rezultata
			initPosition = _results;//rezultat iz logike
		
			for (i in 0...nrOfReels)
			{
				slotSprite[i].tilePosition.y = ( -initPosition[i] * symbolHeight) + 27;
				yPosChosen[i] = (nrOfSpinning * symbolHeight * nrOfSymbols);
				//_label.text = "y " + yPosChosen[i] + " nrOfSpinning " + nrOfSpinning + " symbolH " + symbolHeight + "  nr " +nrOfSymbols;

			}
			//Browser.window.requestAnimationFrame(cast draw);
			gameStatus = spinning;
			draw();
			return;
		}

	}

	function draw()
	{

		if (gameStatus == spinning)
		{

			for (i in 0...nrOfReels)
			{
				if ( yPosChosen[i] > 0 )
				{
					//_label.text = " brzina "+speed;
					slotSprite[i].tilePosition.y = slotSprite[i].tilePosition.y + speed[i];
					yPosChosen[i] = yPosChosen[i] - speed[i];
					_label.text = " brzina "+yPosChosen[i];

				}
				if (yPosChosen[0]-5<=0)
				{
					gameStatus = isWin;
				}
			}

			Browser.window.requestAnimationFrame(cast draw);

		}
		

		trace("resultat U DRAW" + _results);
		
		//trace("resultat U DRAW get res" + res);

		return;

	}
	
	
	public function setResults(results)
	{
		this._results = results;
		trace(" iz gui rezultat " + results);
	}
	public function getResults()
	{
		return _results;
	}

}
package;

import openfl.display.Sprite;
import openfl.display.MovieClip;
import swf.exporters.animate.AnimateLibrary;
import openfl.utils.Assets;
import swf.exporters.animate.AnimateSymbol;

class SwfCharacter extends Sprite
{
    public var library:AnimateLibrary;
    public var current:MovieClip;
    public var currentSymbol:String;
	private var symbolsByClassName:Map<String, AnimateSymbol>;

    public function new(lib:AnimateLibrary)
    {
        super();
        this.library = lib;
    }

    public function play(symbol:String):Void
    {
        var clip = library.getMovieClip(symbol);

        if (clip == null)
        {
            trace("[SwfCharacter] Symbol not found: " + symbol);
            return;
        }

        if (current != null && current.parent == this)
            removeChild(current);

        current = clip;
        currentSymbol = symbol;
        current.gotoAndPlay(1);
        addChild(current);
    }

    public function listSymbols():Array<String>
    {
        return symbolsByClassName;
    }
}

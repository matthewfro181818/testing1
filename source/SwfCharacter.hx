package;

import openfl.display.Sprite;
import openfl.display.MovieClip;
import swf.exporters.animate.AnimateLibrary;
import openfl.utils.Assets;

class SwfCharacter extends Sprite
{
    public var library:AnimateLibrary;
    public var current:MovieClip;
    public var currentSymbol:String;

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
}

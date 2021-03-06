//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.display;

// Ermm, this and MouseEvent don't really belong in flambe.display. flambe.events?
class KeyEvent
{
    // The key's character code. This value is platform dependent, so be sure to test thoroughly,
    // especially across different browsers in the HTML target: http://unixpapa.com/js/key.html
    public var charCode (default, null) :Int;

    public function new (charCode :Int)
    {
        this.charCode = charCode;
    }
}

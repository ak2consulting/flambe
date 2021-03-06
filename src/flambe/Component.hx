//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe;

import flambe.util.Disposable;
import flambe.Visitor;

@:autoBuild(flambe.macro.Build.buildComponent())
class Component
    implements Disposable
{
    public var owner (default, null) :Entity;

    public function getName () :String
    {
        return null; // Subclasses will automagically implement this
    }

    public function onAdded ()
    {
    }

    public function onRemoved ()
    {
    }

    public function onDispose ()
    {
    }

    public function onUpdate (dt :Int)
    {
    }

    public function dispose ()
    {
        if (owner != null) {
            owner.remove(this);
        }
        onDispose();
    }

    public function visit (visitor :Visitor)
    {
        visitor.acceptComponent(this);
    }

    inline public function _internal_setOwner (entity :Entity)
    {
        owner = entity;
    }
}

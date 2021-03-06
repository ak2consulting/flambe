//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.util;

using Lambda;

class SignalImpl
{
    public function new ()
    {
        _connections = [];
    }

    public function connect (listener :Dynamic, prioritize :Bool) :SignalConnection
    {
        var connection = new SignalConnection(this, listener);

        _connections = _connections.copy();
        if (prioritize) {
            _connections.unshift(connection);
        } else {
            _connections.push(connection);
        }

        return connection;
    }

    public function disconnect (connection :SignalConnection) :Bool
    {
        var idx = _connections.indexOf(connection);
        if (idx >= 0) {
            connection._internal_signal = null;
            _connections[idx] = null;
            return true;
        }
        return false;
    }

    public function disconnectAll ()
    {
        for (ii in 0..._connections.length) {
            _connections[ii]._internal_signal = null;
            _connections[ii] = null;
        }
        _connections = [];
    }

    // FIXME(bruno): Adding another listener during an emit is broken
    public function emit (args :Array<Dynamic>)
    {
        var ii = 0;
        while (ii < _connections.length) {
            var connection = _connections[ii];
            if (connection != null) {
                Reflect.callMethod(null, connection._internal_listener, args);
            }
            if (connection == null || !connection.stayInList) {
                _connections.splice(ii, 1);
            } else {
                ++ii;
            }
        }
    }

    private var _connections :Array<SignalConnection>;
}

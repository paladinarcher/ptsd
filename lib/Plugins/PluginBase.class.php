<?php

namespace Plugins;

abstract class PluginBase {

    public static function GetActivePlugins($govnah) {

        $plugins = array();
        $conn = \Database\Connection\Factory::Get()->query("SELECT Class, Pname FROM Plugins WHERE Enabled=1 ORDER BY Priority ASC"); //AND UserLevel <= ". \Common\User::UserLevel()."
        $pdata = $conn->resultset();
        foreach($pdata as $row) {
            $class = $row['Class'];
            $plugins[] = new $class($govnah);
        }
        return $plugins;

    }

    protected $_name;
    protected $_govnah;

    protected function _isMe($op) {
        //error_log("I am ".get_class($this)." trying to run $op");
        return (substr($op, 0, strlen(get_class($this))) == get_class($this));
    }

    protected function _parseSubCommands($op) {
        $bits = explode("-", $op);
        return $bits;
    }

    public function __construct($name, $governor) {
        $this->_name = $name;
        $this->_govnah = $governor;
    }

    public function Name() { return $this->_name; }

    public abstract function Run($op, $args, &$buffer);

    public function Governor() { return $this->_govnah; }
}

?>

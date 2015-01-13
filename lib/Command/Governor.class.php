<?php

namespace Command;

class Governor {

    private $_plugins = array();
    private $_serializer = null;

    public function __construct() {
        $this->loadPlugins();
    }

    protected function loadPlugins() {
        $this->_plugins = \Plugins\PluginBase::GetActivePlugins($this);
    }

    public function Serializer($serializer = null) {
        if($serializer instanceof \Text\Serializing\ISerializer) {
            $this->_serializer = $serializer;
            return $this;
        }
        if(!($this->_serializer instanceof \Text\Serializing\ISerializer)) {
            $this->_serializer = new \Text\Raw();
        }
        return $this->_serializer;
    }

    public function Run($command, $args) {
        $buffer = array();
        foreach($this->_plugins as $plugin) {
            error_log("running $command with ".print_r($args, true));
            $out = $plugin->Run($command, $args, $buffer);
            if(!$out) {
                break;
            }
        }
        return $this->Serializer()->Data($buffer)->Serialize();
    }
    public function Display($command, $args) {
        echo $this->Run($command, $args);
    }
}

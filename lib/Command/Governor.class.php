<?php

namespace Command;

class Governor {

    private $_plugins = array();
    private $_serializer = null;
    private $_userLevel;
    private $_lastStep;

    public function __construct() {
        $this->_userLevel = \Common\User::UserLevel();
        if(isset($_SESSION['lastStep'])) {
            $this->_lastStep = $_SESSION['lastStep'];
        }
        $this->loadPlugins();
    }

    protected function registerStep($command, $args) {
        $_SESSION['lastStep'] = array($command, $args);
        $this->_lastStep = $_SESSION['lastStep'];
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
    protected function _runLastStep() {
        if(!$this->_lastStep) {
            $this->registerStep('Plugins\Main-showDashboard', array());
        }
        return $this->Run($this->_lastStep['command'], $this->_lastStep['args']);
    }
    public function Run($command, $args) {
        $buffer = array();
        try {
            foreach($this->_plugins as $plugin) {
                error_log("running $command with ".print_r($args, true));
                $out = $plugin->Run($command, $args, $buffer);
                if(!$out) {
                    break;
                }
            }
        } catch (\Exceptions\Authentication $ex) {
            error_log(print_r($ex, true));
            $this->registerStep($command, $args);
            return $this->Run('Plugins\User-showLogin', array('errormsg'=>'You need to signin to see that page.', 'errortitle'=>'Oops!'));
        } catch (\Exceptions\RunLastStep $ex) {
            return $this->_runLastStep();
        }
        return $this->Serializer()->Data($buffer)->Serialize();
    }
    public function Display($command, $args) {
        echo $this->Run($command, $args);
    }
}

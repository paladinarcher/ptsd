<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Plugins;

/**
 * Description of User
 *
 * @author Jay
 */
class User extends PluginBase {

    public function __construct($governor) {
        parent::__construct("User Operations Plugin", $governor);
    }

    public function Run($op, $args, &$buffer) {
        if(!$this->_isMe($op)) { return true; }
        $subs = $this->_parseSubCommands($op);
        if(!isset($subs[1])) { $subs = array($subs, 'showLogin'); }
        error_log("Running $op with ".print_r($args, true));
        switch($subs[1]) {
            case "showLogin":
                $this->_loginPage($buffer);
                break;
            case "doLogin":
                try {
                    $u = \Common\User::Login($args['email'], $args['password']);
                } catch (\Exception $ex) {
                    error_log(print_r($ex, true));
                    $u = false;
                }
                if(!$u) {
                    $this->_loginPage($buffer, "Doh!", "We couldn't log you in with that email and password... Try again?");
                } else {
                    header('Location: /');
                }
                break;
        }
        return true;
    }
    
    private function _loginPage(&$buffer, $errortitle = '', $errormsg = '') {
        $buffer['title'] = 'Please login!';
        $buffer['description'] = 'Login for PTSD.';
        $buffer['errortitle'] = $errortitle;
        $buffer['errormsg'] = $errormsg;
        $this->_govnah->Serializer()->SetOption('maintemplate', 'tmp/templates/signinpage.tpl');
        return $this;
    }
}

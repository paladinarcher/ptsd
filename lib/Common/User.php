<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Common;

/**
 * Description of User
 *
 * @author Jay
 */
class User extends \Database\Base {
    private static $_CURRENT;
    public static function UserLevel() { 
        if(self::Current()) {
            return self::Current()->Level();
        }
        return 0;
    }
    public static function Current() {
        if(!self::$_CURRENT) {
            if(isset($_SESSION['uid'])) {
                self::$_CURRENT = new User($_SESSION['uid']);
            }
        }
        return self::$_CURRENT;
    }
    public static function Login($email, $password) {
        $us = self::LoadBy(array('Email'=>$email, 'Password'=>md5($password)));
        if($us) {
            foreach($us as $u) {
                $_SESSION['uid'] = $u->ID;
                return $u;
            }
        }
        return null;
    }
    public static function TableName() {
        return "User";
    }
    public static function GetUser($id) {
        return new User($id);
    }
    public function Level() { return 1000; }
    public function __construct($arrId) {
        parent::__construct($arrId);
    }
    
    public function Logout() {
        session_destroy();
    }
}

<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Text\Smarty;
require_once(BASE_DIR.'/lib/3rd/Smarty-3.1.21/libs/Smarty.class.php');

/**
 * Description of Factory
 *
 * @author Jay
 */
class Factory {
    private static $factory;
    public static function Get() {
        if (!self::$factory) {
            self::$factory = new Factory();
        }
        return self::$factory;
    }

    private $smarty;

    public function getSmarty() {
        if (!$this->smarty) {
            $this->smarty = new \Smarty();
            $dir = (defined(MYSMARTY_DIR)?MYSMARTY_DIR:"/tmp/");
            $this->smarty->template_dir = $dir.'templates/';
            $this->smarty->compile_dir  = $dir.'templates_c/';
            $this->smarty->config_dir   = $dir.'configs/';
            $this->smarty->cache_dir    = $dir.'cache/';
        }
        return $this->smarty;
    }

}

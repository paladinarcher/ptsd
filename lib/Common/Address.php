<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Common;

/**
 * Description of Address
 *
 * @author Jay
 */
class Address extends \Database\Base {
    protected $_persons;
    protected $_images;
    protected $_steps;
    public static function TableName() { return "Address"; }
    public static function Persons() {
        if(!$this->_persons) {
            
        }
        return $this->_persons;
    }
}

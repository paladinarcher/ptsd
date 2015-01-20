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
    public function Images() {
        if(!$this->_images) {
            error_log(print_r($this, true));
            $this->_images = \Common\Image::LoadBy(array('AddressID' => $this->_data['ID']), array('Weight'=>'DESC'));
        }
        return $this->_images;
    }
    public function Persons() {
        if(!$this->_persons) {
            
        }
        return $this->_persons;
    }
    protected function _toArray(array $array) {
        $array['images'] = array();
        foreach($this->Images() as $img) {
            $array['images'][] = $img->ToArray();
        }
        return $array;
    }
}

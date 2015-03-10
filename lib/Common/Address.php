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
    public function AddStep($name, $description, $startedNow = false, $dueDate = false) {
        $step = new \Common\Step();
        $step->Name = $name;
        $step->Description = $description;
        if($startedNow) {
            //date('Y-m-d H:j:s')
            $step->StartedOn = $startedNow;
        }
        if($dueDate) {
            $step->DueDate = $dueDate;
        }
        $step->CreatedBy = \Common\User::Current()->ID;
        $step->AddressID = $this->_data['ID'];
        $step->Save();
        error_log("Step saved: ".print_r($step, true));
        return $step;
    }
    public function AddNote($text) {
        $note = new \Common\Note();
        $note->NoteText = $text;
        $note->CreatedBy = \Common\User::Current()->ID;
        $note->AddressID = $this->_data['ID'];
        $note->Save();
        return $note;
    }
    public function Images() {
        if(!$this->_images) {
            try {
                $this->_images = \Common\Image::LoadBy(array('AddressID' => $this->_data['ID']), array('Weight'=>'DESC'));
            } catch(\Exceptions\ItemNotFound $ex) {
                $this->_images = array();
            }
        }
        return $this->_images;
    }
    public function Steps() {
        if(!$this->_steps) {
            try {
                $this->_steps = \Common\Step::LoadBy(array('AddressID' => $this->_data['ID']), array('StartedOn'=>'DESC'));
            } catch (\Exceptions\ItemNotFound $ex) {
                $this->_steps = array();
            }
        }
        return $this->_steps;
    }
    public function Persons() {
        if(!$this->_persons) {
            
        }
        return $this->_persons;
    }
    protected function _toArray(array $array) {
        $array['Images'] = array();
        foreach($this->Images() as $img) {
            $array['Images'][] = $img->ToArray();
        }
        $array['Steps'] = array();
        foreach($this->Steps() as $step) {
            $array['Steps'][] = $step->ToArray();
        }
        return $array;
    }
}

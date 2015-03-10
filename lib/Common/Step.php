<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Common;

/**
 * Description of Step
 *
 * @author Jay
 */
class Step extends \Database\Base {
    private $_notes;
    
    public static function TableName() {
        return "Step";
    }
    
    public function AddNote($text) {
        $note = new \Common\Note();
        $note->NoteText = $text;
        $note->CreatedBy = \Common\User::Current()->ID;
        $note->StepID = $this->_data['ID'];
        $note->Save();
        return $note;
    }
    public function Notes() {
        if(!$this->_notes) {
            try {
                $this->_notes = \Common\Note::LoadBy(array('StepID'=>$this->_data['ID']), array('NoteTime'=>'DESC'));
            } catch (\Exceptions\ItemNotFound $ex) {
                $this->_notes = array();
            }
        }
        return $this->_notes;
    }
    
    protected function _toArray(array $array) {
        $array['Notes'] = array();
        foreach($this->Notes() as $note) {
            $array['Notes'][] = $note->ToArray();
        }
        return $array;
    }
}

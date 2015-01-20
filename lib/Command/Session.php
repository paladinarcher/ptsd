<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Command;

/**
 * Description of Session
 *
 * @author Jay
 */
class Session {
    private $_db;
    public function __construct() {
        $this->_db = \Database\Connection\Factory::Get();
        session_set_save_handler(
            array($this, "Open"),
            array($this, "Close"),
            array($this, "Read"),
            array($this, "Write"),
            array($this, "Destroy"),
            array($this, "Gc")
        );
        session_start();
    }
    /**
    * Open
    */
    public function Open(){
        // If successful
        if($this->_db){
            // Return True
            return true;
        }
        // Return False
        return false;
    }
    
    /**
    * Close
    */
    public function Close(){
        // Close the database connection
        // If successful
        if($this->_db->close()){
            // Return True
            return true;
        }
        // Return False
        return false;
    }
    
    /**
    * Read
    */
    public function Read($id){
        // Set query
        $this->_db->query('SELECT Data FROM PhpSessions WHERE ID = :id');

        // Bind the Id
        $this->_db->bind(':id', $id);

        // Attempt execution
        // If successful
        if($this->_db->execute()){
            // Save returned row
            $row = $this->_db->single();
            // Return the data
            return $row['Data'];
        }else{
            // Return an empty string
            return '';
        }
    }
    
    /**
    * Write
    */
    public function Write($id, $data){
        // Create time stamp
        $access = time();

        // Set query  
        $this->_db->query('REPLACE INTO PhpSessions VALUES (:id, :access, :data)');

        // Bind data
        $this->_db->bind(':id', $id);
        $this->_db->bind(':access', $access);  
        $this->_db->bind(':data', $data);

        // Attempt Execution
        // If successful
        if($this->_db->execute()){
            // Return True
            return true;
        }

        // Return False
        return false;
    }
    
    /**
    * Destroy
    */
    public function Destroy($id){
        // Set query
        $this->_db->query('DELETE FROM PhpSessions WHERE ID = :id');

        // Bind data
        $this->_db->bind(':id', $id);

        // Attempt execution
        // If successful
        if($this->_db->execute()){
            // Return True
            return true;
        }

        // Return False
        return false;
    }
    
    /**
    * Garbage Collection
    */
    public function Gc($max){
        // Calculate what is to be deemed old
        $old = time() - $max;

        // Set query
        $this->_db->query('DELETE FROM PhpSessions WHERE Access < :old');

        // Bind data
        $this->_db->bind(':old', $old);

        // Attempt execution
        if($this->_db->execute()){
            // Return True
            return true;
        }

        // Return False
        return false;
    }
}

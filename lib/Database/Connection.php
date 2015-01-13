<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Database;

/**
 * Description of Connection
 *
 * @author Jay
 */
class Connection {
 
    private $dbh;
    private $error;
    private $stmt;
 
    public function __construct($dsn, $user, $pass){
        // Set options
        $options = array(
            \PDO::ATTR_PERSISTENT    => true,
            \PDO::ATTR_ERRMODE       => \PDO::ERRMODE_EXCEPTION,
            \PDO::ATTR_TIMEOUT       => 30
        );
        // Create a new PDO instanace
        try{
            $this->dbh = new \PDO($dsn, $user, $pass, $options);
        }
        // Catch any errors
        catch(PDOException $e){
            $this->error = $e->getMessage();
        }
    }
    
    public function query($query){
        $this->stmt = $this->dbh->prepare($query);
        return $this;
    }
    public function bind($param, $value, $type = null){
        if (is_null($type)) {
            switch (true) {
                case is_int($value):
                    $type = \PDO::PARAM_INT;
                    break;
                case is_bool($value):
                    $type = \PDO::PARAM_BOOL;
                    break;
                case is_null($value):
                    $type = \PDO::PARAM_NULL;
                    break;
                default:
                    $type = \PDO::PARAM_STR;
            }
        }
        $this->stmt->bindValue($param, $value, $type);
    }
    public function close() {
        $this->dbh = null;
        return true;
    }
    public function execute(){
        return $this->stmt->execute();
    }
    public function resultset(){
        $this->execute();
        return $this->stmt->fetchAll(\PDO::FETCH_ASSOC);
    }
    public function single(){
        $this->execute();
        return $this->fetch();
    }
    
    public function errorInfo() { return $this->stmt->errorInfo(); }
    public function fetch() { return $this->stmt->fetch(\PDO::FETCH_ASSOC); } 
    public function rowCount(){
        return $this->stmt->rowCount();
    }
    public function lastInsertId(){
        return $this->dbh->lastInsertId();
    }
    public function beginTransaction(){
        return $this->dbh->beginTransaction();
    }
    public function endTransaction(){
        return $this->dbh->commit();
    }
    public function cancelTransaction(){
        return $this->dbh->rollBack();
    }
    public function debugDumpParams(){
        return $this->stmt->debugDumpParams();
    }
    
}

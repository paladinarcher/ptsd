<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Database\Connection;

/**
 * Description of Factory
 *
 * @author Jay
 */
class Factory {
    public static function Get() {
        global $db_args;
        if(!self::$_dbh) {
            $f = new Factory();
            if($db_args) {
                $f->type($db_args['type'])->name($db_args['name'])->host($db_args['host']);
                $f->user($db_args['user'])->password($db_args['password'])->dbname($db_args['dbname']);
            }
            self::$_dbh = $f->create();
        } 
        return self::$_dbh;
    }
    private static $_dbh = null;
    
    private $type="mysql"; //defaults
    private $name;
    private $host="localhost";
    private $user;
    private $password;
    private $dbname;

    public function create()
    {
        //guards again
        if (empty($this->name)) { throw new \Exception("Name is not optional"); }
        //if (empty($user)) throw ...
        //if (empty($password)) $passwordToUse=$user; //fallback to default
        //else $passwordToUse=$password;

        $statement = "{$this->type}:host={$this->host};dbname={$this->dbname}";
        $dbh = new \Database\Connection(
            $statement, 
            $this->user, 
            $this->password
        );
        // Return DBH
        return $dbh;
    }

    public function type ($type)
    {
        $this->type=$type;
        return $this;
    }
    
    public function name ($name)
    {
        $this->name=$name;
        return $this;
    }
    public function host ($host)
    {
        $this->host=$host;
        return $this;
    }
    public function user ($user)
    {
        $this->user=$user;
        return $this;
    }
    public function password ($password)
    {
        $this->password=$password;
        return $this;
    }
    public function dbname ($dbname)
    {
        $this->dbname=$dbname;
        return $this;
    }
}

<?php

namespace Database;

abstract class Base {

        public static function LoadBy(array $whereArray) {
                $conn = Factory::getFactory()->getConnection();
                $sql = "SELECT * FROM ".static::TableName()." WHERE ";
                foreach(array_keys($whereArray) as $col) {
                        $sql .= "`$col` = :$col,";
                }
                $sql = rtrim($sql, ',');
                $q = $conn->prepare($sql);
                foreach($whereArray as $col => $val) {
                        $q->bindParam(':'.$col, $val);
                }
                $ret = array();
                if($q->execute()) {
                        if($q->rowCount() < 1) {
                                throw new \Exceptions\ItemNotFound("Item not found in ".static::TableName().".");
                        }
                        while($row = $q->fetch(\PDO::FETCH_ASSOC)) {
                                $ret[] = new static($row);
                        }
                }
                return $ret;
        } 
        abstract public static function TableName();

        protected $_data = array();
        protected $_nData = array();

        public function __construct($arrId = null) {
                if($arrId === null) { return; }
                if(is_array($arrId)) {
                        $this->_data = $arrId;
                } else {
                        $this->_loadById($arrId);
                }
        }
        public function __get($name) { 
                if(isset($this->_nData[$name])) { return $this->_nData[$name]; }
                if(isset($this->_data[$name])) { return $this->_data[$name]; }
                return null;
        }
        public function __set($name, $value) {
                $this->_nData[$name] = $value;
        }
        public function Insert() {
                return $this->_sqlSave("INSERT INTO");
        }
        public function Save() {
                if($this->IsNew()) { return $this->Insert(); }
                return $this->_sqlSave("UPDATE", "WHERE ".$this->_where());
        }
        protected function _sqlSave($sqlStart, $sqlEnd = '') {
                if($this->Dirty()) {
                        $sql = $sqlStart." ".static::TableName()." SET";
                        foreach(array_keys($this->_nData) as $col) { $sql .= " `$col` = :$col,"; }
                        $sql = rtrim($sql, ',')." ".$sqlEnd; 
                        #error_log($sql);
                        $conn = Factory::getFactory()->getConnection();
                        $q = $conn->prepare($sql);
                        foreach($this->_nData as $col => $val) {
                                #error_log("binding :$col => $val");
                                $q->bindValue(":$col", $val, (is_numeric($val) ? \PDO::PARAM_INT : \PDO::PARAM_STR));
                        }
                        #$q->debugDumpParams();
                        if($q->execute()) {
                                if($q->rowCount() < 1) { error_log(" ZERO ROWS AFFECTED! "); }
                                error_log(print_r($q->errorInfo(), true));
                                $this->_data = array_merge($this->_data, $this->_nData);
                                $this->_nData = array();
                        } else {
                                error_log(print_r($q->errorInfo(), true));
                        }
                }
                return $this;
        }
        public function IsNew() { return empty($this->_data); }
        public function Dirty() { return !empty($this->_nData); }
        public function __isset($name) { return isset($this->_data[$name]); }
        public function __unset($name) { unset($this->_data[$name]); }
        public function ToArray() { return array_merge($this->_data, $this->_nData); }
        protected function _where() {
                $where = '';
                $count = 0;
                foreach($this->_data as $col => $val) {
                        if($val) {
                                $where .= "`$col` = ".(is_numeric($val) ? $val : "'$val'")." AND ";
                                $count++;
                        }
                        if($count >= 10) { break; }
                }
                return rtrim($where, ' AND ');
        }
        protected function _loadById($id) {
                $conn = Factory::getFactory()->getConnection();
                $q = $conn->prepare("SELECT * FROM ".static::TableName()." WHERE id = :id");
                $q->bindParam(':id', $id);
                if($q->execute()) {
                        if($q->rowCount() < 1) {
                                throw new \Exceptions\ItemNotFound("$id not found in ".static::TableName().".");
                        }
                        $this->_data = $q->fetch(\PDO::FETCH_ASSOC);
                }
        }


}
?>

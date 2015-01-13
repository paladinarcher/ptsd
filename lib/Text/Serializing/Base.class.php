<?php

namespace Text\Serializing;

abstract class Base implements ISerializer {

	protected $_data = null;
	protected $_options = array();

	public function GetOption($option) {
		return $this->_options[$option];
	}
	public function SetOption($option, $value) {
		$this->_options[$option] = $value;
		return $this;
	}
	public function Data($data = null) {
		if($data === null) { return $this->_data; }
		$this->_data = $data;
		return $this;
	}

}

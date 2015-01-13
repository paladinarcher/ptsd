<?php
namespace \Text;

class Raw extends \Text\Serializing\SerializerBase {

	public function Serialize() {
		return $this->_data.'';
	}	

}

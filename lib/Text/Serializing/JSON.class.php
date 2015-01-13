<?php

namespace Text\Serializing;

class JSON extends Base {

	public function Serialize() {
		return json_encode($this->_data);
	}

}

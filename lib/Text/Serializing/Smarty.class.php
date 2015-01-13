<?php

namespace Text\Serializing;

class Smarty extends Base {

	protected $_smarty;

	public function __construct($template = false) {
            if($template !== false) {
                $this->SetOption('template', $template);
            }
            $this->_smarty = \Text\Smarty\Factory::Get()->getSmarty();
	}

	public function setTemplate($template) {
            $this->SetOption('template', $template);
	} 

	public function Serialize() {
            foreach($this->_options as $optname => $val) {
                $this->_smarty->assign($optname, $val);
            }
            foreach($this->_data as $name => $val) {
                $this->_smarty->assign($name, $val);
            }
            return $this->_smarty->fetch($this->_options['template']);
	}
}

<?php

namespace Plugins;

class Testing extends PluginBase {

	public function __construct($governor) {
		parent::__construct("RTS Test Plugin", $governor);
	}

	public function Run($op, $args, &$buffer) {
		if($op == 'test' || $op == 'testing' || $this->_isMe($op)) {
			$this->_govnah->Serializer()->SetOption('mainpage', 'modules/gpanel2/gpanel.testing.main.tpl');
			ob_start();
			try {
				$u = \Cmn\User::LoadBy(array('city'=>1));
				var_dump($u);
				//$s = \Command\Server::GetMainServer();
				//var_dump($s->Api('mail', array('simple'=>1,'to'=>5,'from'=>5,'m'=>'testing','t'=>'This is a test')));
			} catch (\Exception $ex) {
				var_dump($ex);
			}
			$buffer['test'] = ob_get_contents();
			ob_end_clean();
			
		}
		return true;
	}

}

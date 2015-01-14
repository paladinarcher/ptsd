<?php

require_once('init.php');

$mod = 'Plugins\Main';
$cmd = 'showDashboard';
$args = array();
$op = '';
if(isset($_REQUEST['op']))   { $op = $_REQUEST['op'];     }
if(isset($_REQUEST['mod']))  { $mod = $_REQUEST['mod'];   }
if(isset($_REQUEST['cmd']))  { $cmd = $_REQUEST['cmd'];   }
if(isset($_REQUEST['args'])) { $args = $_REQUEST['args']; }

$gov = new \Command\Governor();
$gov->Serializer(new \Text\Serializing\Smarty('tmp/templates/main.tpl'));
$gov->Display(($op ? $op : $mod.($cmd ? '-'.$cmd : '')), $args);

?>

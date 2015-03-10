<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Plugins;

/**
 * Description of Main
 *
 * @author Jay
 */
class Main extends PluginBase {

    public function __construct($governor) {
        parent::__construct("Main Plugin", $governor);
    }

    public function Run($op, $args, &$buffer) {
        if(!$this->_isMe($op)) { return true; }
        if(\Common\User::UserLevel() < 1000) { throw new \Exceptions\Authentication(); }
        $subs = $this->_parseSubCommands($op);
        if(!isset($subs[1])) { $subs = array($subs, 'showDashboard'); }
        error_log("Running $op with ".print_r($args, true));
        
        $this->_govnah->Serializer()->SetOption('maintemplate', 'tmp/templates/mainpage.tpl');
        switch($subs[1]) {
            case "addStep":
                try {
                    $p = new \Common\Address($args['pid']);
                } catch (\Exceptions\ItemNotFound $ex) {
                    error_log(print_r($ex, true));
                    $this->_dashboard($buffer);
                    break;
                }
                $step = $p->AddStep($args['name'], $args['desc'], $args['starton'], $args['duedate']);
                if($step) {
                    $buffer['step'] = $step->ToArray();
                } else {
                    error_log(print_r($step, true));
                    $buffer['error'] = "Didn't like making that step, I guess";
                }
                break;
            case "showProperty" :
                try {
                    $p = new \Common\Address($args['pid']);
                } catch (\Exceptions\ItemNotFound $ex) {
                    error_log(print_r($ex, true));
                    $this->_dashboard($buffer);
                    break;
                }
                $buffer['title'] = "{$p->HouseNumber} {$p->Street}";
                $buffer['subTitle'] = "{$p->City}, {$p->State} {$p->Zip}".($p->Zip4 ? $p->Zip4 : "");
                $buffer['description'] = "{$p->TagLine} {$p->HouseNumber} {$p->Street}";
                $buffer['biLine'] = "{$p->TagLine}";
                $buffer['test'] = print_r($p, true);
                $buffer['property'] = $p->ToArray();
                $this->_govnah->Serializer()->SetOption('subpage', 'tmp/templates/propertyView.tpl');
                break;
            case "AddAddress":
                $args['pid'] = null;
            case "EditAddress":
                try {
                    $a = new \Common\Address($args['pid']);
                    error_log("Input is ... ".print_r($args, true));
                    $a->TagLine = $args['TagLine'];
                    $a->ParcelID = $args['ParcelID'];
                    $a->HouseNumber = $args['HouseNumber'];
                    $a->Street = $args['Street'];
                    $a->City = $args['City'];
                    $a->State = $args['State'];
                    $a->Zip = $args['Zip'];
                    $a->Zip4 = $args['Zip4'];
                    $a->LegalDescription = $args['LegalDescription'];
                    $a->County = $args['County'];
                    error_log("Just before altering: ".print_r($a, true));
                    $a->Save();
                    $buffer['property'] = $a->ToArray();
                    error_log("After altering: ".print_r($a, true));
                } catch (Exception $ex) {
                    error_log(print_r($ex, true));
                    throw $ex;
                }
                break;
            case "showDashboard":
            default:
                $this->_dashboard($buffer);
                break;
        }
        return true;
    }
    protected function _dashboard(&$buffer) {
        $buffer['title'] = "Properties";
        $buffer['description'] = "This is the main PTSD Dashboard";
        $set = \Database\Connection\Factory::Get()->query("SELECT 
	A.`ID`,
	A.`ParcelID`,
	A.`TagLine`,
	A.`HouseNumber`,
	A.`Street`,
	A.`State`,
	A.`City`,
	A.`County`,
	A.`Zip`,
	A.`Zip4`,
	GROUP_CONCAT(DISTINCT CONCAT(P.`First`, ' ', P.`Last`) ORDER BY AP.`StartTime` ASC SEPARATOR ', ') AS `Owners`,
	GROUP_CONCAT(DISTINCT AI.`File` ORDER BY AI.`Weight` DESC SEPARATOR ', ') AS ImageFiles,
	S.`StartedOn`,
	S.`AssignedTo`,
	S.`Name`,
	S.`Description`,
	S.`ID` AS StepID
FROM 
	Address A
	LEFT JOIN AddressToPerson AP ON (A.`ID` = AP.`AddressID` AND AP.`EndTime` IS NULL)
	LEFT JOIN Person P ON (AP.`PersonID` = P.`ID`)
	-- LEFT JOIN Relationships R ON (AP.`RelationShipID` = R.`ID`)
	LEFT JOIN Image AI ON (A.`ID` = AI.`AddressID`)
	LEFT JOIN Step S ON (A.`ID` = S.`AddressID` AND S.`StartedOn` IS NOT NULL AND S.`CompletedOn` IS NULL)
WHERE
	1=1
GROUP BY 
	A.`ID`")->resultSet();
        $buffer['properties'] = array();
        foreach($set as $s) {
            $s['ImageFile'] = explode(', ', $s['ImageFiles']);
            $buffer['properties'][] = $s;
        }
        $this->_govnah->Serializer()->SetOption('subpage', 'tmp/templates/propertiessub.tpl');
    }
}

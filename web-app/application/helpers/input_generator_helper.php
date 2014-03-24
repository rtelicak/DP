<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

function createOptions($items, $includeFirstEmpty = false, $id_identifier = false, $picked = false)
{

	$options = array();
	if($includeFirstEmpty)
	{
		$options[] = '<option value="0">-== Vyberte ==-</option>';
	}
	
	
	for($i=0;$i<count($items);$i++)
	{
		if(!$id_identifier)
		{
			if($items[$i]->id == $picked)
			{
				$seledted = "selected='selected'";
			}
			else
			{
				$selected = '';
			}
			$options[] = '<option '.$selected.' value="'.$items[$i]->id.'">'.$items[$i]->nazov.'</option>';
		}
		else
		{
			$itemID = $items[$i]->$id_identifier;
			if($itemID == $picked)
			{
				$selected = "selected='selected'";
			}
			else
			{
				$selected = '';
			}
			$options[] = '<option '.$selected.' value="'.$items[$i]->$id_identifier.'">'.$items[$i]->nazov.' ['.$items[$i]->$id_identifier.']</option>';
		}
		
	}
	
	return $options;
}

function debug($value, $stop = true)
{
	echo "<pre>";
	print_r($value);
	echo "</pre>";
	
	if($stop)
	{
		exit;
	}
	else
	{
		return true;
	}
}
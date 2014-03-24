<?php

function inHour($data, $hour)
{
	$in_hour = array();
	foreach ($data as $key => $parms)
	{
		if (($data[$key]->cislo) == $hour) {
			$in_hour[] = $key;
		}
	}
	return $in_hour;
}

function processDayHour($in_hour,$schedule, $a)
{
 	$class = '';
	if($in_hour)
	{
		$class .= ' item item-blue';
	}
	if(!empty($in_hour) && !$schedule[$in_hour[0]]->prednaska)
	{
		$class .= ' item-lecture';
	}
	
	if ($a % 2 == 0) {
	  $class = 'break';
	}
				
	$return = "<td class='".$class."'>";
	if($in_hour && $class != 'break')
	{
		$itemID = $in_hour[0];
		$dataAttrs = '';
					

		if($schedule[$itemID]->prednaska == 1)
		{
			$schedule[$itemID]->prednaska_typ = 'Prednáška';
		}
		else
		{
			$schedule[$itemID]->prednaska_typ = 'Cvičenie';
		}
		
		// DAY
		$dataAttrs .= ' data-day="'.$schedule[$itemID]->den.'"';
		// TITLE
		$dataAttrs .= ' data-title="'.$schedule[$itemID]->nazov_predmetu.'"';
		// CAS
		$dataAttrs .= ' data-hour="'.$schedule[$itemID]->cas_od.' - '.$schedule[$itemID]->cas_do.'"';
		// ROOM
		$dataAttrs .= ' data-room="'.$schedule[$itemID]->lokacia.'"';
		// TYPE
		$dataAttrs .= ' data-type="'.$schedule[$itemID]->prednaska_typ.'"';
		//TEACHER
		$dataAttrs .= ' data-teacher="'.$schedule[$itemID]->titul.' '.$schedule[$itemID]->meno.' '.$schedule[$itemID]->priezvisko.' '.$schedule[$itemID]->titul_za.'"';

		$return .= '<div class="item-content" '.$dataAttrs.'>';
		$return .= '<p class="title">'.$schedule[$itemID]->skratka.'</p><br>';
		$return .= '<p class="room pull-right mb-0">'.$schedule[$itemID]->lokacia.'</p>';
		$return .= "</div>";
						
		}
		else
		{
			$return .= "&nbsp;";
		}
		
		$return .= "</td>";
		return $return;
	}
?>

<table width="100%" border="0" class="table table-bordered table-striped" id="schedule">
  <colgroup>
  <col class="first">
  <col class="scheduled-hour">
  <col class="break">
  <col class="scheduled-hour">
  <col class="break">
  <col class="scheduled-hour">
  <col class="break lunch-break">
  <col class="scheduled-hour">
  <col class="break">
  <col class="scheduled-hour">
  <col class="break">
  <col class="scheduled-hour">
  <col class="break">
  <col class="scheduled-hour">
  </colgroup>
  <tbody>
    <tr class="table-heading">
      <td class="day">&nbsp;</td>
      <td>7:30 - 9:00</td>
      <td class="break">&nbsp;</td>
      <td>9:15 - 10:45</td>
      <td class="break">&nbsp;</td>
      <td>11:00 - 12:30</td>
      <td class="break">&nbsp;</td>
      <td>13:30 - 15:00</td>
      <td class="break">&nbsp;</td>
      <td>15:15 - 16:45</td>
      <td class="break">&nbsp;</td>
      <td>17:00 - 18:30</td>
      <td class="break">&nbsp;</td>
      <td>18:35 - 20:05</td>
    </tr>
    <tr>
    	<td class="day">Po.</td>
      <?php
			// PONDELOK; VAR: $schedule[0]
			// MAKE SCHEDULE
				$a = 1;
				$hour = 1;
				for($a;$a<=13;$a++)
				{
					$in_hour = inHour($schedule[0],$hour);

					$dayData = processDayHour($in_hour,$schedule[0], $a);
					echo $dayData;
										
					if ($a % 2 != 0) {
					  $hour++;
					}
				}
			?>
    </tr>
    <tr>
      <td class="day">Ut.</td>
      <?php 
			 	// UTOROK; VAR: $schedule[1]
				// MAKE SCHEDULE
				$a = 1;
				$hour = 1;
				for($a;$a<=13;$a++)
				{
					$in_hour = inHour($schedule[1],$hour);
	
					$dayData = processDayHour($in_hour,$schedule[1], $a);
					echo $dayData;
										
					if ($a % 2 != 0) {
					  $hour++;
					}
				}
				?>
    </tr>
    <tr>
      <td class="day">St.</td>
      <?php 
			 	// STREDA; VAR: $schedule[2]
				// MAKE SCHEDULE
				$a = 1;
				$hour = 1;
				for($a;$a<=13;$a++)
				{
					$in_hour = inHour($schedule[2],$hour);
		
					$dayData = processDayHour($in_hour,$schedule[2], $a);
					echo $dayData;
										
					if ($a % 2 != 0) {
					  $hour++;
					}
				}
				?>
    </tr>
    <tr>
      <td class="day">Št.</td>
      <?php 
			 	// STVRTOK; VAR: $schedule[3]
				// MAKE SCHEDULE
				$a = 1;
				$hour = 1;
				for($a;$a<=13;$a++)
				{
					$in_hour = inHour($schedule[3],$hour);
			
					$dayData = processDayHour($in_hour,$schedule[3], $a);
					echo $dayData;
										
					if ($a % 2 != 0) {
					  $hour++;
					}
				}
				?>
    </tr>
    <tr>
      <td class="day">Pi.</td>
      <?php
			 	// PIATOK; VAR: $schedule[3]
				// MAKE SCHEDULE
				$a = 1;
				$hour = 1;
				for($a;$a<=13;$a++)
				{
					$in_hour = inHour($schedule[4],$hour);
			
					$dayData = processDayHour($in_hour,$schedule[4], $a);
					echo $dayData;
										
					if ($a % 2 != 0) {
					  $hour++;
					}
				}
				?>
    </tr>
    <tr class="table-heading">
      <td class="day">&nbsp;</td>
      <td>7:30 - 9:00</td>
      <td class="break">&nbsp;</td>
      <td>9:15 - 10:45</td>
      <td class="break">&nbsp;</td>
      <td>11:00 - 12:30</td>
      <td class="break">&nbsp;</td>
      <td>13:30 - 15:00</td>
      <td class="break">&nbsp;</td>
      <td>15:15 - 16:45</td>
      <td class="break">&nbsp;</td>
      <td>17:00 - 18:30</td>
      <td class="break">&nbsp;</td>
      <td>18:35 - 20:05</td>
    </tr>
  </tbody>
</table>

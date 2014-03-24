<?php
Class Schedule extends CI_Model
{
	
	function getFaculties()
	{
		
		$qry = "SELECT * FROM fakulta; ";
		
		$query = $this->db->query($qry);
		$results = $query->result();
		
		
		return $results;
	} 
	
	function getFacultyDetail($id)
	{
		
		$this -> db -> select('*');
		$this -> db -> from('fakulta');
		$this -> db -> where('id_fakulta = ' . "'" . $id . "'"); 
		
		$query = $this -> db -> get();
		
		if($query -> num_rows() == 1){
			return $query->row();
		}else{
			return false;
		}
		
	}
	
	function getDisciplines()
	{
		
		$qry = "SELECT * FROM odbor; ";
		
		$query = $this->db->query($qry);
		$results = $query->result();
		
		return $results;
	} 
	
	function getDisciplineDetail($id)
	{
		
		$this -> db -> select('*');
		$this -> db -> from('odbor');
		$this -> db -> where('id_odbor = ' . "'" . $id . "'"); 
		
		$query = $this -> db -> get();
		
		if($query -> num_rows() == 1){
			return $query->row();
		}else{
			return false;
		}
		
	}
	
	function getStudyGroups()
	{
		$qry = "SELECT * FROM kruzok; ";
		
		$query = $this->db->query($qry);
		$results = $query->result();
		
		return $results;
	}
	
	function getStudyGroupDetail($id)
	{
		
		$this -> db -> select('*');
		$this -> db -> from('kruzok');
		$this -> db -> where('id_kruzok = ' . "'" . $id . "'"); 
		
		$query = $this -> db -> get();
		
		if($query -> num_rows() == 1){
			return $query->row();
		}else{
			return false;
		}
		
	}
	
	function getSchedule($form)
	{
		
		$data = array();
		$i = 0;
		for($day=1;$day<=5;$day++)
		{
			$this -> db -> select('vyuka.*, kruzok.*, hodina.*, predmet.kod AS kod, predmet.nazov AS nazov_predmetu,
														predmet.skratka AS skratka, predmet.vymera AS vymera, predmet.semester AS semester,
														miestnost.*, miestnost.nazov AS lokacia, ucitel.*, den.*');
			$this -> db -> from('vyuka');
			$this -> db -> join('kruzok', 'kruzok.id_kruzok = vyuka.id_kruzok');
			$this -> db -> join('odbor', 'odbor.id_odbor = kruzok.id_odbor');
			$this -> db -> join('hodina', 'hodina.id_hodina = vyuka.id_hodina');
			$this -> db -> join('predmet', 'predmet.id_predmet = vyuka.id_predmet');
			$this -> db -> join('miestnost', 'miestnost.id_miestnost = vyuka.id_miestnost');
			$this -> db -> join('ucitel', 'ucitel.id_ucitel = vyuka.id_ucitel');
			$this -> db -> join('den', 'den.id_den = vyuka.id_den');
			$this -> db -> where("den.id_den = '". $day . "'");
			$this -> db -> where("odbor.rocnik = '".$form['study_year']."'");
			$this -> db -> where("kruzok.id_kruzok = ".$form['study_group']['id'].""
														);
			$query = $this -> db -> get();

			$data[$i] = $query->result();
			$i++;
		}
		//echo $this->db->last_query();

		return $data;
	}
    
    function filterDiscipline($faculty) {
        $qry = "SELECT * FROM odbor WHERE id_fakulta = '" . $faculty . "'; ";
		
		$query = $this->db->query($qry);
		$results = $query->result();
        
        return $results;
    }        
    
    function filterStudyGroup($odbor) {
        $qry = "SELECT * FROM kruzok WHERE id_odbor = '" . $odbor . "'; ";
		
		$query = $this->db->query($qry);
		$results = $query->result();
        
        return $results;
    }
	
	function debug($value, $stop = true){
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
	
}
?>
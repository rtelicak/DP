<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/*
*	This service controller provides data primary for iphone app
*	9 tables: FAKULTA, HODINA, KATEDRA, KRUZOK, MIESTNOST, ODBOR, PREDMET, UCITEL, VYUKA
*/

class Svc extends CI_Controller {

	function __construct(){
		parent::__construct();
	}

	function index(){
		
		// LOAD VIEW TO USER
		$this->load->view('svc');
	}

	// FAKULTA
	function getFaculty() {
		$result = [];
		$query = $this->db->get('fakulta');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		// consider wrapping data to entity name e.g. faculty
		// echo json_encode(array('faculty'=>$events));
		echo json_encode($result);
	}

	// HODINA
	function getLesson() {
		$result = [];
		$query = $this->db->get('hodina');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// KATEDRA
	function getInstitute() {
		$result = [];
		$query = $this->db->get('katedra');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// KRUZOK
	function getGroup() {
		$result = [];
		$query = $this->db->get('kruzok');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// MIESTNOST
	function getRoom() {
		$result = [];
		$query = $this->db->get('miestnost');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// ODBOR
	function getDepartment() {
		$result = [];
		$query = $this->db->get('odbor');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// PREDMET
	function getSubject() {
		$result = [];
		$query = $this->db->get('predmet');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// UCITEL
	function getTeacher() {
		$result = [];
		$query = $this->db->get('ucitel');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// VYUKA
	function getLecture() {
		$result = [];
		$query = $this->db->get('vyuka');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}

	// VYUKA
	function getDay() {
		$result = [];
		$query = $this->db->get('den');

		foreach ($query->result() as $row){
			array_push($result, $row);
		}

		echo json_encode($result);
	}











	function test(){
		$a = array();
		$a['prop'] = "value";

		$this->d($a);
		echo json_encode($a);
	}





















	// basic debug error message
	function d($s) {
		echo "<pre>";
		print_r($s);
		echo "</pre>";
	}
}
?>
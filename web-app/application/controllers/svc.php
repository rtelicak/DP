<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Svc extends CI_Controller {

	function __construct(){
		parent::__construct();
	}

	function index(){
		
		// LOAD VIEW TO USER
		$this->load->view('svc');
	}

	function test(){
		$a = array();
		$a['prop'] = "value";

		$this->d($a);
		echo json_encode($a);
	}

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



















	// basic debug error message
	function d($s) {
		echo "<pre>";
		print_r($s);
		echo "</pre>";
	}
}
?>
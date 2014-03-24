<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Statistic extends CI_Controller {

	function __construct(){
		parent::__construct();
	}

	function index(){
		if($this->session->userdata('logged_in')){  
			$session_data = $this->session->userdata('logged_in');  
			$data['username'] = $session_data['username'];
		}
		else{
			//If no session, redirect to login page
			redirect('login', 'refresh');
		}
		
		// get chart data
		$data['chart1'] = $this->getChartData1();
		$data['chart2'] = $this->getChartData2(); 
		$data['chart3'] = $this->getChartData3(); 
		
		
		$this->load->view('statistic_view',$data);
	}                                             
	
	function getChartData1(){
		$query = $this->db->query("SELECT COUNT(tasks.id) as count, state.state from tasks LEFT JOIN state ON tasks.id_state = state.id GROUP BY id_state");
		$results = $query->result();
		
		return $results;
	}       

	function getChartData2(){
		$query = $this->db->query("SELECT COUNT(tasks.id) as count, priority.priority from tasks LEFT JOIN priority ON tasks.id_priority = priority.id GROUP BY id_priority");
		$results = $query->result();
		
		return $results;
	}       
	
	function getChartData3(){
		$query = $this->db->query("SELECT COUNT(tasks.id) as count, users.username from tasks LEFT JOIN users ON tasks.id_assigned_user = users.id GROUP BY id_assigned_user");
		$results = $query->result();
		
		return $results;
	}       
	
}
?>
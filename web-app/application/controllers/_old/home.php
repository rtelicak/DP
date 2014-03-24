<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
session_start(); //we need to call PHP's session object to access it through CI
class Home extends CI_Controller {

	function __construct(){
		parent::__construct(); 
		$this->load->model('user','',TRUE);
	}

	function index(){
		$this->load->helper('form');
		
		if($this->session->userdata('logged_in')){  
			$session_data = $this->session->userdata('logged_in');  
			$data['username'] = $session_data['username'];
			
			$result = $this->user->getLastLogin($session_data['id']); 
			$data['lastLogin'] = $result->lastLogin; 
			
			// get users tasks status
			$data['tasks_stats'] = $this->user->getTasksStatus($session_data['id']);; 
			
			// get chart data
			$data['chart1'] = $this->getChartData1($session_data['id']);
			$data['chart2'] = $this->getChartData2($session_data['id']);
			// echo "<pre>";print_r($session_data); echo "</pre>";exit;
			
			// echo "string";exit;
			$data = $this->get_dashboard_tasks($data);
			$this->load->view('home_view', $data);
		}
		else{
			//If no session, redirect to login page
			redirect('login', 'refresh');
		}
	}
	
	function logout(){
		$this->session->unset_userdata('logged_in');
		session_destroy();
		redirect('home/loggedout', 'refresh');
	}
	
	function loggedout() {
		$data = array(
               'msg' => 'Boli ste úspešne odhlásený!'
          );
		$this->load->helper('form');
	    $this->load->view('login_view', $data);
	}
	
	function displayTaskForm(){
		$this->load->view('task_form');
	}
	
	function get_dashboard_tasks($data){
		$query = $this->db->query("SELECT id, title, deadline, id_state FROM tasks ORDER BY created DESC LIMIT 6");
		$result = $query->result();
		$tasks = array();

		foreach ($result as $task => $value) { 
			$tasks[] = (array) $value;
		}
		
		$data['tasks'] = $tasks;
		return $data;
	}
	
	function getChartData1($id){
		$query = $this->db->query("SELECT COUNT(tasks.id) as count, state.state from tasks LEFT JOIN state ON tasks.id_state = state.id WHERE id_assigned_user = ".$id." GROUP BY id_state");
		$results = $query->result();
		
		return $results;
	}       

	function getChartData2($id){
		$query = $this->db->query("SELECT COUNT(tasks.id) as count, priority.priority from tasks LEFT JOIN priority ON tasks.id_priority = priority.id WHERE id_assigned_user = ".$id." GROUP BY id_priority");
		$results = $query->result();
		
		return $results;
	}       
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
?>
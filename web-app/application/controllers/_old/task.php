<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Task extends CI_Controller {

	function __construct(){
		parent::__construct();
	
		if($this->session->userdata('logged_in')){  
			$session_data = $this->session->userdata('logged_in');
			
			$this->load->helper('form'); 
			$this->load->library('form_validation');   
			$this->form_validation->set_rules('title', 'Nazov', 'required');
			$this->form_validation->set_rules('desc', 'Popis ulohy', 'required');
			$this->form_validation->set_rules('deadline', 'Deadline', 'required');		}
		else{
			//If no session, redirect to login page
			redirect('login', 'refresh');
		}
	}

	function index(){
		$this->task_list();
		// $this->load->view('task_list');
	}
	
	function task_list($id = null, $deadline_query = null, $keyword = null){ 
		$this->load->helper('url'); 
		
		// print_r($this->uri);exit;
		
		$url  = parse_url(current_url());
		$users_tasks = pathinfo($url['path']);
		$users_tasks = $users_tasks['basename'];
		
		
		// hack to find wheter displaying user's or all tasks
		$users_tasks += 0;
		
		if ($id != null){
			$query = "SELECT users.username, tasks.title, tasks.id AS id, tasks.deadline, priority.priority, state.state FROM tasks LEFT JOIN users ON tasks.id_assigned_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id WHERE users.id = ".$id."";
		} else if ($id ==  null){
			$query = "SELECT users.username, tasks.title, tasks.id AS id, tasks.deadline, priority.priority, state.state FROM tasks LEFT JOIN users ON tasks.id_assigned_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id ORDER BY tasks.created DESC";
		}
		
		if ($deadline_query != null){
			$query = $deadline_query;
		}
		
		$query = $this->db->query($query);

		$tasks = array();
		foreach ($query->result() as $row){
			$tasks[] = $row;
		}                   
		
		$data = array(); 
		$data['deadline_tasks'] = $deadline_query ? true : false;
		$data['tasks'] = $tasks;
		$session_data = $this->session->userdata('logged_in');
		// print_r($session_data);exit;  
		$data['username'] = $session_data['username']; 
		$data['user_id'] = $session_data['id'];
		
		$data['users_tasks'] = $users_tasks;
		
		if($keyword!=NULL) {
			$data['keyword']= $keyword;
		} else {
			$data['keyword']= false;
		}
		
		$data['role'] = $session_data['role'];
		$this->load->view('task_list', $data);
	}
	
	function delete($id_task){
		$this->db->delete('tasks', array('id' => $id_task));
		redirect("task/task_list", 'refresh'); 
	} 
	
	function before_deadline(){ 
		$today = date("Y-m-d"); 
		$next_week = date("Y-m-d",strtotime("+1 week"));
		// echo $next_week;exit;

		$query = "SELECT users.username, tasks.title, tasks.id AS id, tasks.deadline, priority.priority, state.state FROM tasks LEFT JOIN users ON tasks.id_assigned_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id WHERE tasks.deadline between '".$today."' and '".$next_week."'";
		$this->task_list(null, $query);
	}
	
	function add_task(){                  
		$data = $this->populate_data_array();
		$this->load->view('task_form', $data);
	}
	
	function search(){                  
		$data = $_POST;
		$query = "SELECT users.username, tasks.title, tasks.id AS id, tasks.deadline, priority.priority, state.state FROM tasks LEFT JOIN users ON tasks.id_assigned_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id WHERE tasks.title LIKE '%".$data['keyword']."%'";
		//die($query);
		$this->task_list(null, $query, $data['keyword']);
	}
		
	function save(){
		$data = $_POST;
		
		if ($this->form_validation->run() == FALSE){ 
				// save failed, fill form with posted data
				$data = $this->populate_other_data($data);
				$this->load->view('task_form', $data);
		}else{
			if ($data['id_task']){
				// update task  
				$id_task = $data['id_task'];
				unset($data['id_task']);  
				
				// perform update database
				$this->db->where('id', $id_task);
				$this->db->update('tasks', $data);
				
				// redirect to task detail we just updated
				redirect("task/detail/".$id_task."", 'refresh');
			} else{
				// create task 
				unset($data['id_task']);
				
				// default properties when creating task
				$data['created'] = date("Y-m-d"); 
				$data['id_state'] = 1;
				
				$this->db->insert('tasks', $data);
				redirect('task', 'refresh');
			}
		}
	}
	
	function detail($id_task){
		$task = $this->get_task($id_task);
		$data = array();
		
		foreach($task as $key => $value) {
			$data[$key] = $value;
		} 
		
		$data = $this->populate_other_data($data); 
	   // echo "<pre>"; print_r($data); echo "</pre>"; exit;
		$data = $this->get_comments($id_task, $data);

		$this->load->view('task_detail', $data);
	}
	
	function edit_task($id){
		$data = $this->populate_data_array($id);
		$this->load->view('task_form', $data);
	}
	
	function add_comment(){
		$_POST['dateTime'] = date("Y-m-d H:i:s");
		$this->db->insert('comments', $_POST); 
		redirect("task/detail/".$_POST['id_task']."", 'refresh');
	} 
	
	function set_to_progress($id_task){
		$data = array('id_state' => 2); // 2 means In Progress
		$this->db->where('id', $id_task);
		$this->db->update('tasks', $data);
		
		redirect('task/detail/'.$id_task.'', 'refresh');
	}
	
	function solve($id_task){
		$data = array('id_state' => 4); // 4 means Resolved, still needs to be confirmed with role 1 user
		$this->db->where('id', $id_task);
		$this->db->update('tasks', $data);
		
		redirect('task/detail/'.$id_task.'', 'refresh');
	}

	function reopen($id_task){
		$data = array('id_state' => 1); // 1 means Opened
		$this->db->where('id', $id_task);
		$this->db->update('tasks', $data);
		
		redirect('task/detail/'.$id_task.'', 'refresh');
	}

	function close($id_task){
		$data = array('id_state' => 5); // 5 means Closed
		$this->db->where('id', $id_task);
		$this->db->update('tasks', $data);
		
		redirect('task/detail/'.$id_task.'', 'refresh');
	}
	
	
	/****** private functions ******/
	
	function populate_data_array($task_id = null){
		// one master array, returned at the end
		$data = array();
		// property of task
		$task_properties = array("id_task", "title", "desc", "deadline", "id_priority", "assigned_user", "id_assigned_user");
		// get task or null
		$task = $task_id ? $this->get_task($task_id) : null;
		
		// fill master array with task properties or empty string
		foreach ($task_properties as $key) {
			$data[$key] = $task ? $task->$key : "";
		}
		
		$data = $this->populate_other_data($data);
		
		return $data;
	}
	
	function populate_other_data($data){
		// other data required for view (fill selectboxes, send session data ...)
		$data['users'] = $this->get_users();
		$data['priorities'] = $this->get_priorities();
		$session_data = $this->session->userdata('logged_in');
		// print_r($session_data);exit;
		$data['username'] = $session_data['username'];
		$data['id_logged_user'] = $session_data['id'];
		$data['role'] = $session_data['role'];
		return $data;
	}
	
	function get_comments($id_task, $data){
		$comments = $this->db->query("SELECT comments.id, comments.body, comments.dateTime, users.username as user FROM comments LEFT JOIN users ON comments.id_user = users.id WHERE id_task = ".$id_task." ORDER BY comments.dateTime DESC");
		$comments = $comments->result();
		// print_r($comments); 
		$data['comments'] = $comments;

		return $data;
	}
	 
	function get_task($id){
		try {
			$task = $this->db->query("SELECT users.username as assigned_user, users.id as id_assigned_user, tasks.id as id_task, tasks.title, tasks.desc, tasks.created, tasks.deadline, priority.id as id_priority, priority.priority, state.state FROM tasks LEFT JOIN users ON tasks.id_assigned_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id WHERE tasks.id = ".$id."");
		} catch (Exception $e) {
			  print_r($e);
		}
		
		return $task->row();
	}
	
	function get_users(){
		$query = $this->db->query("SELECT DISTINCT username, id FROM users");
		$result = array();
				
		foreach ($query->result() as $row){
			$result[$row->id] = $row->username;
		}
		
		return $result;
	}
	
	function get_priorities(){
		$query = $this->db->query("SELECT DISTINCT priority, id FROM priority");
		$result = array();
				
		foreach ($query->result() as $row){
			$result[$row->id] = $row->priority;
		}
		
		return $result;
	}
	
	function debug($data){
		echo '<pre>';
		print_r($data);
		echo '</pre>';
	}
	
}
?>
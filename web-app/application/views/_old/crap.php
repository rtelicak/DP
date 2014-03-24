                                    <?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Task extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->library('form_validation');   
	    $this->form_validation->set_rules('title', 'Nazov', 'required');
		$this->form_validation->set_rules('desc', 'Popis ulohy', 'required');
		$this->form_validation->set_rules('deadline', 'Deadline', 'required');
	}

	function index(){
		
	}
	
	function task_list(){              
		$query = $this->db->query("SELECT users.username, tasks.title, tasks.id AS id, tasks.deadline, priority.priority, state.state FROM tasks LEFT JOIN users ON tasks.id_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id");
		$tasks = array();  
		
		foreach ($query->result() as $row){
			$tasks[] = $row;
		}                   
		
		$data = array();
		$data['tasks'] = $tasks;
		$session_data = $this->session->userdata('logged_in');  
		$data['username'] = $session_data['username']; 
		$this->load->view('task_list', $data);
	}
	
	function edit_task($id){
		$data = $this->populate_data_array($id);
		// print_r($data); exit;
		$this->load->view('task_form', $data);
	}
	
	function add_task(){                  
		$data = $this->populate_data_array();
		$this->load->view('task_form', $data);
	}
	
	function get_posted_data(){
		$data = array();
		foreach ($_POST as $key => $value) {
			print_r($_POST);
			$data[$key] = $value;
		}
	}
	
	function save(){
		$data = $this->get_posted_data();
		$data = $this->populate_other_data();
		print_r($data);exit
		// $id = $_POST['id'];
		// $data = array(
		// 	'title'		=>	$_POST['title'],
		// 	'desc'		=> $_POST['desc'],
		// 	'deadline'	=> $_POST['deadline'],
		// 	'id_priority' => $_POST['priority'],
		// 	'assigned_user'	=>	$_POST['user'],
		// );

		
		if ($this->form_validation->run() == FALSE){ 
				$data = array();
				// $data['']
				// $data = $this->populate_other_data($data); 
				$this->load->view('task_form');
		}else{
			if ($id){
				// update task
				$this->db->where('id', $id);
				$this->db->update('tasks', $data);  
			} else{
				// create task
				unset($data['id']);
				unset($data['assigned_user']);
				
				$data['created'] = date("Y-m-d"); 
				$data['id_state'] = 1;
				// print_r($data);exit;
				$this->db->insert('tasks', $data);
			}
			// TODO: redirect somewhere
			// $this->load->view('');
		}
	}
	
	function detail($id_task){
		$result = $this->get_task($id_task);
		$data = array();
		
		foreach($result as $key => $value) {
			$data[$key] = $value;
		} 
		
		// atribut username je dole presetovany, koli vypisu lognuteho usera v nav bare
		$data['assigned_user']  = $data['username'];
		
		$session_data = $this->session->userdata('logged_in');  
		$data['username'] = $session_data['username'];
		$this->load->view('task_detail', $data);
	}
	
	function populate_data_array($task_id = null){
		// one master array, returned at the end
		$data = array();
		// property of task
		$task_properties = array("id", "title", "desc", "deadline", "id_priority", "assigned_user");
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
		$data['username'] = $session_data['username'];
		
		return $data;
	}
	
	function get_task($id){
		try {
			$task = $this->db->query("SELECT users.username, users.id as assigned_user, tasks.id, tasks.title, tasks.desc, tasks.created, tasks.deadline, priority.priority, priority.id as id_priority, state.state FROM tasks LEFT JOIN users ON tasks.id_user = users.id LEFT JOIN state ON tasks.id_state = state.id LEFT JOIN priority ON tasks.id_priority = priority.id WHERE tasks.id = ".$id."");
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
	
}
?>
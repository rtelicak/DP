<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class User extends CI_Controller {

	function __construct(){
		parent::__construct();
		//var_dump($this->session->userdata);
		if($this->session->userdata('logged_in')){  
			$session_data = $this->session->userdata('logged_in');  
			  
			if($this->session->userdata['logged_in']['role']!=1) {
				$this->session->set_flashdata('error', '<strong>Prístup používateľským kontám je len pre administrátorov TASK MANAŽÉRA!</strong>');
            	redirect("home", "refresh");
			}
			
			$this->load->helper('form'); 
			$this->load->library('form_validation');   
			$this->form_validation->set_rules('password', 'Password', 'required');
	   		$this->form_validation->set_rules('username', 'Používateľské meno', 'required');
		}
		else{
			//If no session, redirect to login page
			redirect('login', 'refresh');
		}
	}

	function index(){        
	}
	
	function user_list(){              

		$query = $this->db->query("SELECT id, username, blocked FROM users");
		$userQuery = $query->result();

		$query_tasks = $this->db->query("SELECT tasks.id_assigned_user AS id_user, tasks.id, state.state FROM tasks LEFT JOIN users ON tasks.id_assigned_user = users.id LEFT JOIN state ON tasks.id_state = state.id");
		$tasksQuery = $query_tasks->result();

		foreach ($userQuery as $user) {
			$user->action = array();
			if($user->blocked==0) {
				$user->action['operation'] = 1;
				$user->action['btnTitle'] = "Zakázať";
				$user->action['btnClass'] = "warning";
			}
			else {
				$user->action['operation'] = 0;
				$user->action['btnTitle'] = "Povoliť";
				$user->action['btnClass'] = "success";
			}
			$user->tasks = array();
			$user->tasks['resolved']=0;
			$user->tasks['unresolved']=0;
			$user->tasks['total']=0;
			foreach ($tasksQuery as $task) {
				if ($task->id_user == $user->id){
					if($task->state == "Resolved") {
						$user->tasks['resolved']++;
					}
					else {
						$user->tasks['unresolved']++;
					}
					$user->tasks['total']++;
				}
			}
		}
		
		//$this->debug($userQuery);
		
		$data = array();
		$data['users'] = $userQuery;
		$session_data = $this->session->userdata('logged_in'); 
		 
		$data['username'] = $session_data['username']; 
		$data['role'] = $session_data['role']; 
		// print_r($data);exit;
		$this->load->view('user_list', $data);
	}
	
	function detail($id_user){ 
		$data = array();
		$session_data = $this->session->userdata('logged_in');  
		$data['username'] = $session_data['username'];
		$data['user'] = $this->get_user($id_user);
		$data['user']->role = $this->get_role_list($id_user, NULL);
		$data['user']->add = false;
		$data['user']->msg = false;
		$this->load->view('user_detail', $data);
	} 
	
	function get_role_list($id=NULL, $role=NULL){
		if($id) {
		$query = $this->db->query("SELECT role FROM users WHERE id=".$id."");
		$role = $query->row('role');
		}
		
		$out = '<select name="role" name="role">';
		if($role == 1) {
			$out .= '<option value="1" selected="selected">Administrátor</option>';
			$out .= '<option value="2">Používateľ</option>';
		}
		else {
			$out .= '<option value="1">Administrátor</option>';
			$out .= '<option value="2" selected="selected">Používateľ</option>';
		}
		$out .= "</select>";

		//$this->debug($out);
				
		return $out;
	}
	
	function deleteUser() {
		$id = $this->uri->segment(3);
		
		$session_data = $this->session->userdata('logged_in');  
		if($session_data['id']==$id) {
			$this->session->set_flashdata('error', '<strong>Tento používateľ je prihlásený!</strong> Nemôžete zmazať samého seba, keď ste prihlásený!');
            redirect("user/user_list", "refresh");
		}
		
		$query = $this->db->query("SELECT username FROM users WHERE id=".$id." ");
		$userData = $query->result();
		
		$this->db->delete('users', array('id' => $id));
		
		$msg = "Používateľ <strong>".$userData[0]->username."</strong> bol úspešne zmazaný!";

		$this->session->set_flashdata('message', $msg);
		redirect("user/user_list", "refresh");
	}
	
	function changeUserStatus() {
		$id = $this->uri->segment(3);
		$val = $this->uri->segment(4);
		
		$session_data = $this->session->userdata('logged_in');  
		if($session_data['id']==$id) {
			$this->session->set_flashdata('error', '<strong>Tento používateľ je prihlásený!</strong> Nemôžete zablokovať samého seba, keď ste prihlásený!');
            redirect("user/user_list", "refresh");
		}
						
		$data = array('blocked' => $val);
		
		$this->db->where('id', $id);
		$result = $this->db->update('users', $data);
		
		if(!$result) {
			$this->session->set_flashdata('error', '<strong>ERROR pri ukladaní dát do databázy</strong>');
            redirect("user/user_list", "refresh");
		}
		
		$query = $this->db->query("SELECT username FROM users WHERE id=".$id." ");
		$userData = $query->result();
		
		$result = "Blokovaný";
		if($val==0) { $result = "Povolený"; }
				
		$msg = "Prístup používateľa <strong>".$userData[0]->username."</strong> do task manažéra bol úspešne zmenený
		na: <strong>".$result."</strong>";

		$this->session->set_flashdata('message', $msg);
		redirect("user/user_list", "refresh");
	}
	
	function debug($data){
		echo '<pre>';
		print_r($data);
		echo '</pre>';
	}
	
	function get_users(){
		$query = $this->db->query("SELECT DISTINCT username, id FROM users");
		$result = array();
				
		foreach ($query->result() as $row){
			$result[$row->id] = $row->username;
		}
		
		return $result;
	}
	
	function get_user($id) {
		try {
			$user = $this->db->query("SELECT * FROM users WHERE id=".$id."");
		} catch (Exception $e) {
			  print_r($e);
		}
		
		return $user->row();
	}
	
	function get_last_login($id) {
    	$result = $this->db->query("SELECT * FROM users WHERE id=".$id."")->row_array();
    	return $result['lastLogin'];
	}
	
	
	function add_user(){                  
		// TO DO - CHECK USER PERMISSION TO ADD USERS
		
		$data = $this->prepare_data_array();
		$this->load->view('user_detail', $data);
	}
	
	function save(){
		$data = $_POST;
//		$this->debug($data);

		$this->form_validation->set_rules('password', 'Heslo', 'trim|min_length[6]|matches[passwordReply]');
		$this->form_validation->set_rules('passwordReply', 'Overenie hesla', 'trim');
		
		if ($this->form_validation->run() == FALSE){ 
				// save failed, fill form with posted data
				$data = $this->prepare_data_array($data);
				//$this->debug($data);
				$this->load->view('user_detail', $data);
		}else{
			if ($data['id']){
				// update user  
				$id_user = $data['id'];
				unset($data['id_user']);  
				unset($data['passwordReply']);
				unset($data['add']);
				$data['password'] = md5($data['password']);

				// perform update database
				$this->db->where('id', $id_user);
				$this->db->update('users', $data);
				
				$msg = "Používateľ <strong>".$data['username']."</strong> bol úspešne <strong>aktualizovaný</strong>";

				$this->session->set_flashdata('message', $msg);
				
				// redirect to user detail we just updated
				redirect("user/detail/".$id_user."", 'refresh');
			} else{
				if(!$this->userCheck($data['username'])) {
					
					// save failed, fill form with posted data
					$data = $this->prepare_data_array($data);
					
					$msg = "Používateľ s menom <strong>".$data['user']->username."</strong> už existuje!";
					$data['user']->msg = $msg;

					$this->load->view('user_detail', $data);
				}
				else {
				// create user 
				unset($data['id_user']);
				unset($data['passwordReply']);
				unset($data['add']);
				$data['password'] = md5($data['password']);
				
				$this->db->insert('users', $data);
				$msg = "Používateľ <strong>".$data['username']."</strong> bol úspešne <strong>pridaný</strong>";

				$this->session->set_flashdata('message', $msg);
				
				redirect('user/user_list', 'refresh');
				}
			}
		}
	}
	
	/****** private functions ******/
	
	function prepare_data_array($sentData = null){
		$data = array();
		$session_data = $this->session->userdata('logged_in');  
		$data['username'] = $session_data['username'];

		if(!$sentData) {
		$user_atts = array("id", "username", "password", "role", "blocked", "lastLogin", "msg");
		
		$data['user'] = new StdClass;
		// fill master array with empty string
		foreach ($user_atts as $key) {
			$data['user']->$key = "";
		}
		
		$data['user']->role= $this->get_role_list(NULL,2);
		$data['user']->add=true;
		
		} else {
			$data['user'] = new StdClass;
				// fill master array with data
			foreach ($sentData as $key => $value){
				if($key=='role') {
					//echo $value;
					$data['user']->$key = $this->get_role_list(NULL,$value);
				} 
				else {
					$data['user']->$key = $value;
				}
			}
			
			if($data['user']->add == 0 ) {
				$data['user']->lastLogin = $this->get_last_login($sentData['id']);
			}
			
		}
		return $data;
	}
	
	function userCheck($username) {
		$query = $this->db->query("SELECT * FROM users WHERE username='".$username."'");
		$records = $query->row('id');
		if(empty($records))
		{
			return true;
		}
		else {
			return false;
		}
	}


}
?>
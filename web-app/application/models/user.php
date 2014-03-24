<?php
Class User extends CI_Model
{
	function login($username, $password){
		$this -> db -> select('id, username, password, role, blocked');
		$this -> db -> from('users');
		$this -> db -> where('username = ' . "'" . $username . "'"); 
		$this -> db -> where('password = ' . "'" . md5($password) . "'"); 
		$this -> db -> limit(1);
		
		$query = $this -> db -> get();
		
		if($query -> num_rows() == 1){
			return $query->result();
		}else{
			return false;
		}

	} 
	
	function getLastLogin($id){
		// get last login  
		$this->db->select('lastLogin');
		$result = $this->db->get_where('users', array('id' => $id));
		                 
		// and set new one
		$actualDate = date("Y-m-d H:i:s");
		$data = array('lastLogin' => $actualDate);

		$this->db->where('id', $id);
		$this->db->update('users', $data);  
		
		return $result->row();
	} 
	
	function getTasksStatus($id){
		$query = $this->db->query("SELECT COUNT(tasks.id) as count, state.state from tasks LEFT JOIN state ON tasks.id_state = state.id WHERE id_assigned_user = ".$id." GROUP BY id_state");
		$results = $query->result();
		
		$tasks = array();
		$total = 0;
		
		foreach ($results as $result) {
			$total += $result->count;
			$tasks[$result->state] = $result->count;
		}
		
		$tasks['Total'] = $total;
		// $this->debug($tasks);
		return $tasks;
	} 
	
	function debug($value){
		echo "<pre>";
		print_r($value);
		echo "</pre>";
		exit;
	}
} 


















?>
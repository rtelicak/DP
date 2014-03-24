<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
	session_start(); //we need to call PHP's session object to access it through CI

class Home extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('user','',TRUE);
	}

	function index(){
		$this->load->helper('form');
		// $this->d($this->session);
		// exit;

		if($this->session->userdata('logged_in')){

			$this->load->view('admin/home');
		}
		else{
			//If no session, redirect to login page
			redirect('admin/login', 'refresh');
		}
	}

	function logout(){
		$this->session->unset_userdata('logged_in');
		session_destroy();
		redirect('admin/login', 'refresh');
	}

	function d ($s) {
		echo "<pre>";
		print_r($s);
		echo "</pre>";
	}
}

?>
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller {

	function __construct(){
		parent::__construct();
	}

	function index(){
		// $this->d($this->session);
		$data = array('msg' => 'Vitajte, prosím zadajte svoje prihlasovacie údaje!');
		$this->load->helper('form');
		$this->load->view('admin/login', $data);
	}

	function d ($s) {
		echo "<pre>";
		print_r($s);
		echo "</pre>";
	}
}

?>
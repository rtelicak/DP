<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Import extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->helper('parse_import');
		$this->load->helper(array('form', 'url'));
		$this->load->helper('html');
	}

	function index(){

		$this->load->view('import');
	}

	function upload(){
		header("Content-Type: text/html; charset=UTF-8", true); 
		if (!count($_FILES)) {
			return;
		}

		$f = $_FILES['userfile']['tmp_name'];

		if (Parser::parse($f)){
			echo "success";
		} else {
			echo "fail";
		}
	}
}
?>
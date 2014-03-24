<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Import extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->helper('parse_import');
		$this->load->helper(array('form', 'url'));
	}

	function index(){
		$this->load->view('import');
	}

	function upload(){
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
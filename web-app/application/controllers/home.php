<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
session_start(); //we need to call PHP's session object to access it through CI

class Home extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('schedule','',TRUE);
	}

	function index(){
		
		// HELPER FOR MAKING FORM VARIABLES
		$this->load->helper('input_generator');
		
		// GET FORM VALUES
		// ONLY IF FACULTY WAS SUBMITTED
		if( $this->input->get('faculty'))
		{
			$form = array();
			$form['faculty']['id'] = $this->input->get('faculty');
			$form['faculty']['detail'] = $this->schedule->getFacultyDetail($form['faculty']['id']);
			
			if(!$form['faculty']['detail'])
			{
				// REDIRECT 
				$this->session->set_flashdata('error', 'Fakulta nebola nájdená / zvolená!');
				redirect('home/index');
			}
			
			$form['discipline']['id'] = $this->input->get('discipline');
			$form['discipline']['detail'] = $this->schedule->getDisciplineDetail($form['discipline']['id']);
			
			if(!$form['discipline']['detail'])
			{
				// REDIRECT 
				$this->session->set_flashdata('error', 'Odbor nebol nájdený / zvolený!');
				redirect('home/index');
			}
			
			$form['study_year'] = $this->input->get('study_year');
						
			if( $form['study_year']>5 or $form['study_year']<1 )
			{
				// REDIRECT 
				$this->session->set_flashdata('error', 'Rok štúdia nieje správny / zvolený!');
				redirect('home/index');
			}
			
			$form['study_group']['id'] = $this->input->get('study_group');
			$form['study_group']['detail'] = $this->schedule->getStudyGroupDetail($form['study_group']['id']);
			
			if(!$form['study_group']['detail'])
			{
				// REDIRECT 
				$this->session->set_flashdata('error', 'Krúžok nebol nájdený / zvolený!');
				redirect('home/index');
			}
			
			// GET SCHEDULE FROM DB
			$data['schedule'] = $this->schedule->getSchedule($form);
			
		}
		else
		{
			$form = false;
		}
		
		
		// GET DATA
		$data['faculties'] = $this->schedule->getFaculties();
		$data['faculties_options'] = createOptions($data['faculties'], true, 'id_fakulta', $form['faculty']['id']);
		
		$data['discipline'] = $this->schedule->getDisciplines();
		$data['discipline_options'] = createOptions($data['discipline'], true, 'id_odbor', $form['discipline']['id']);
		
		$data['study_groups'] = $this->schedule->getStudyGroups();
		$data['study_groups_options'] = createOptions($data['study_groups'], true, 'id_kruzok', $form['study_group']['id']);
		
		$data['form'] = $form;
		
		// LOAD VIEW TO USER
		$this->load->view('home', $data);
	}
    
    function filter() {
        $this->load->helper('input_generator');
        
        $value = (int)$_POST['value'];
        $prefix = $_POST['prefix'];
        if ($value != 0) {
            $function = 'filter' . $prefix;
            $results = $this->schedule->$function($value);
        }
        echo json_encode(createOptions($results, true, 'id_odbor'));         
    }
}
?>
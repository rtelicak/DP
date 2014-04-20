<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
* Base parser class reads input file via get_file_content().
* If no file is provided file stored in /miscellaneous/rozvrh.par is parsed.
* 
* time spent ~40 hours
* i dare you to refactor it
* 
* Parsing process logs are stored in /application/logs/log-YYYY-MM-DD
*/
class Parser {

	// only this method should be called from outside
	public static function parse($input_file = ''){
		log_message('debug', '--------------------------------------');
		log_message('debug', 'Parsing euba-rozvrh file initialized.');
		log_message('debug', '--------------------------------------');

		if ($input_file) {
			// validate and assign input file
			log_message('debug', 'NOTICE: parsing uploaded file');
			echo "NOTICE: parsing uploaded file <br />";
			$file = $input_file;
		} else {
			log_message('debug', 'NOTICE: parsing /miscellaneous/rozvrh.par file');
			echo "NOTICE: parsing /miscellaneous/rozvrh.par file <br />";
			$file = get_instance()->config->config['base_url'].'miscellaneous/rozvrh.par';
		}


		self::empty_tables();
		self::insert_days();

		// read file to array and trim it
		$file_content = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

		// d($file_content); exit;

		self::parse_file($file_content);

		return true;
	}

	private function parse_file ($file_content) {
		// d($file_content); exit;
		for ($i=0; $i < count($file_content); $i++) {
			switch ($file_content[$i]) {

				// read HODINY
				case strpos($file_content[$i], ".HODINY") :
				log_message('debug', 'Parsing HODINY ...');
				$i = self::handle_hours($file_content, $i);
				log_message('debug', 'Done.');
				break;

				// read KATEDRY
				case strpos($file_content[$i], ".KATEDRY") :
				log_message('debug', 'Parsing KATEDRY ...');
				$i = self::handle_institute($file_content, $i);
				log_message('debug', 'Done.');
				break;

				// read MIESTOSTI
				case strpos($file_content[$i], ".MIESTNOSTI") :
				log_message('debug', 'Parsing MIESTNOSTI ...');
				$i = self::handle_rooms($file_content, $i);
				log_message('debug', 'Done.');
				break;

				// read UCITELIA
				case strpos($file_content[$i], ".UCITELIA") :
				log_message('debug', 'Parsing UCITELIA ...');
				$i = self::handle_teachers($file_content, $i);
				log_message('debug', 'Done.');
				break;

				// read PARALELKY
				case strpos($file_content[$i], ".PARALELKY") :
				log_message('debug', 'Parsing PARALELKY ...');
				$i = self::handle_parallels($file_content, $i);
				log_message('debug', 'Done.');
				break;

				// read PREDMETY
				case strpos($file_content[$i], ".PREDMETY") :
				log_message('debug', 'Parsing PREDMETY ...');
				$i = self::handle_subjects($file_content, $i);
				log_message('debug', 'Done.');
				break;

				// TODO: read ROZSAH

				default: //echo "zle je";
				// dunno what to put here
				break;
			}
		}
		log_message('debug', 'Sucess!');
	}


	// private section

	// HODINY
	private function handle_hours($file, $row) {
		$hours = array();
		$result = array();

		$result = self::populate_items_from_file($file, $row);
		$hours = $result['items'];

		self::insert_hours($hours);

		return $result['row'];
	}

	// KATEDRY
	private function handle_institute($file, $row) {
		$institutes = array();
		$result = array();

		$result = self::populate_items_from_file($file, $row);
		$institutes = $result['items'];

		self::insert_institute($institutes);

		return $result['row'];
	}

	// MIESTNOSTI
	private function handle_rooms($file, $row) {
		$rooms = array();
		$result = array();

		$result = self::populate_items_from_file($file, $row);
		$rooms = $result['items'];

		self::insert_room($rooms);

		return $result['row'];
	}

	// UCITELIA
	private function handle_teachers($file, $row) {
		$teachers = array();
		$result = array();

		$result = self::populate_items_from_file($file, $row);
		$teachers = $result['items'];

		self::insert_teachers($teachers);

		return $result['row'];
	}

	// PALALELKY
	private function handle_parallels($file, $row) {
		$parallel = array();
		$result = array();

		$result = self::populate_items_from_file($file, $row);
		$parallel = $result['items'];

		// self::insert_faculties($parallel);
		self::insert_parallels($parallel);

		return $result['row'];
	}

	// PREDMETY
	private function handle_subjects ($file, $row) {
		$subjects = array();
		$result = array();

		$result = self::populate_items_from_file($file, $row);
		$subjects = $result['items'];

		self::insert_subjects($subjects);

		return $result['row'];
	}

	// HELPER FUNCTION
	private function populate_items_from_file($file, $row){
		// this array wil contain relevant items
		$items = array();
		// result array contains 2 objects: $items and $row
		$result = array();

		// ignore first item e.g. .KATEDRY, .MIESTNOSTI
		$row++;

		// while not match uppercase word begining with .
		while (!preg_match("/^\.[A-Z]+$/", $file[$row])) {
			array_push($items, $file[$row]);
			$row++;
		}

		// undo last item, because for loop adds one immediately
		$row--;

		$result['items'] = $items;
		$result['row'] = $row;

		return $result;
	}

	/////////////////////////
	// insert to db functions
	/////////////////////////
	private function empty_tables() {
		$ci =& get_instance();

		log_message('debug', 'Emptying tables ...');
		$ci->db->empty_table('users');
		$ci->db->empty_table('den');
		$ci->db->empty_table('hodina');
		$ci->db->empty_table('miestnost');
		$ci->db->empty_table('fakulta');
		$ci->db->empty_table('katedra');
		$ci->db->empty_table('ucitel');
		$ci->db->empty_table('odbor');
		$ci->db->empty_table('kruzok');
		$ci->db->empty_table('predmet');
		$ci->db->empty_table('vyuka');
		log_message('debug', 'Done.');

		// reset AUTO_INCREMENT
		$q = $ci->db->query("ALTER TABLE users AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE den AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE hodina AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE miestnost AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE fakulta AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE katedra AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE ucitel AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE odbor AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE kruzok AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE predmet AUTO_INCREMENT = 1");
		$q = $ci->db->query("ALTER TABLE vyuka AUTO_INCREMENT = 1");
	}

	// UCITELIA
	private function insert_teachers($teachers) {

		$dummy_teacher = array(
			"id_katedra" => 1,
			"kod" => 'dummy_teacher',
			"priezvisko" => 'Ucitel',
			"meno" => 'Neznamy',
			"titul" => null,
			"titul_za" => null
			);

		self::insert_teacher($dummy_teacher);
		self::insert_default_users();

		for ($i=0; $i < count($teachers); $i++) {
			if (preg_match("/([a-zA-Z]+)_([a-zA-Z]*)\s([a-zA-Z]+)\s([a-zA-Z]+)\s:\s([A-Z])/", $teachers[$i], $teachers_matches)) {
				// [0] => Adamkova_Hana KMZ Mgr : U
				// [1] => Adamkova
				// [2] => Hana
				// [3] => KMZ
				// [4] => Mgr
				// [5] => U


				// GET katedra_id
				$ci =& get_instance();
				$institute_code = $teachers_matches[3];

				$q = $ci->db->query("SELECT id_katedra from katedra WHERE kod = '$institute_code'");
				$institute = $q->row();

				$user = array(
					"meno" => $teachers_matches[2],
					"priezvisko" => $teachers_matches[1],
					"username" => $teachers_matches[1]."_".$teachers_matches[2],
					"password" => "e10adc3949ba59abbe56e057f20f883e", //123456
					"id_katedra" => $institute->id_katedra,
					"role_user" => 1,
					"role_admin" => 0,
					"role_manager" => 0,
					"blocked" => 0
					);

				self::insert_user($user);

				// teacher table structure: id, id_katedra, kod, priezvisko, meno, titul, titul_za
				$teacher = array(
					"id_katedra" => $institute->id_katedra,
					"kod" => $teachers_matches[1]."_".$teachers_matches[2],
					"priezvisko" => $teachers_matches[1],
					"meno" => $teachers_matches[2],
					"titul" => $teachers_matches[4],
					"titul_za" => null
					);

				self::insert_teacher($teacher);
			}
		}
	}

	// MIESTNOSTI
	private function insert_room ($rooms) {
		for ($i=0; $i < count($rooms); $i++) {
			if (preg_match("/([A-Z])\s([A-Z_0-9]+)\s([0-9]+)/", $rooms[$i], $rooms_matches)) {
				// [0] => U SM_I 80
				// [1] => U
				// [2] => SM_I
				// [3] => 80

				// table structure: id, kod, nazov, kapacita
				$room = array(
					"kod" => $rooms_matches[1],
					"nazov" => $rooms_matches[2],
					"kapacita" => $rooms_matches[3]
					);

				$ci =& get_instance();
				$ci->db->insert('miestnost', $room);
			}
		}
	}

	// KATEDRY
	private function insert_institute($institutes) {

		for ($i=0; $i < count($institutes); $i++) {
			if (preg_match("/([a-zA-Z_\x{c0}-\x{ff}]+)\s([a-zA-z]+)\s(\d+)\s(\d)/", $institutes[$i], $institutes_matches)) {
				// [0] => Katedra_medzinarodneho_obchodu KMO 359 0
				// [1] => Katedra_medzinarodneho_obchodu
				// [2] => KMO
				// [3] => 359
				// [4] => 0

				$institute = array(
					"kod" => $institutes_matches[2],
					"nazov" => $institutes_matches[1],
					"id_fakulta" => 0
					);

				$ci =& get_instance();
				$ci->db->insert('katedra', $institute);
			}
		}
	}

	// HODINY
	private function insert_hours($hours) {

		for ($i=0; $i < count($hours); $i++) {
			if (preg_match("/(\d)\s(\d+)\.(\d+)\s-\s(\d+)\.(\d+)/", $hours[$i], $hours_matches)) {
				// [0] => 1 7.30 - 9.00
				// [1] => 1
				// [2] => 7
				// [3] => 30
				// [4] => 9
				// [5] => 00

				// Structure table: id, cislo, cas_od, cas_do
				$hour = array(
					"cislo" => $hours_matches[1],
					"cas_od" => $hours_matches[2].":".$hours_matches[3],
					"cas_do" => $hours_matches[4].":".$hours_matches[5]
					);

				// global object in CI
				$ci =& get_instance();
				$ci->db->insert('hodina', $hour);
			} // end of if
		} // endo of for
	}

	// PARALELKY
	private function insert_parallels($parallels) {

		for ($i=0; $i < count($parallels); $i++) {

			if (preg_match("/\d_rocnik\s(\d)/", $parallels[$i], $year_matches)) {
				// [0] => 4_rocnik 4
				// [1] => 4

				$year = $year_matches[1];
				$i++;

				// d($parallels[$i]);
				// d(count($parallels));

				while (count($parallels) > $i && preg_match("/[$]\s([a-zA-Z_]*)\s([A-Z]*)/", $parallels[$i], $faculty_matches)) {
					// [0] =>  $ Narodohospodarska_fakulta NHF
					// [1] => Narodohospodarska_fakulta
					// [2] => NHF

					$i++;
					// echo "som tu";
					// d($parallels[$i]);

					// insert faculty to db
					$faculty_id = self::insert_faculty($faculty_matches[1], $faculty_matches[2]);

					while (count($parallels) > $i && preg_match("/[$]{2,3}\s([a-zA-Z_0-9\x{c0}-\x{ff}]+)\s([A-Za-z0-9]*)\s([0-9]*)\/?([0-9]*)-?([0-9]*)/", $parallels[$i], $department_matches)) {
						// [0] => $$ Financie_bankovnictvo_a_investovanie FBI 300/1-12
						// [1] => Financie_bankovnictvo_a_investovanie - name
						// [2] => FBI - code
						// [3] => 300 - number of students
						// [4] => 1 - number of first group
						// [5] => 12 - number of last group

						// insert odbor to db
						$departnemnt_id = self::insert_department($department_matches[1], $department_matches[2], $department_matches[3],$faculty_id, $year);

						// in case of Ekonomika_a_manazment_podniku (doesnt have any numbers)
						$first_group = is_numeric($department_matches[4]) ? $department_matches[4] : 1;
						// in case of only one group in department ($last_group == "")
						$last_group = is_numeric($department_matches[5]) ? $department_matches[5] : 1;

						for ($j=$first_group; $j <= $last_group; $j++) {
							$group = array(
								'nazov' => $department_matches[1],
								'id_odbor' => $departnemnt_id,
								'kod' => $department_matches[2],
								'cislo' => $j
								);

							// insert kruzok to db
							self::insert_group($group);
						}

						$i++;
					} // end of departments (odbory)
				} // end of faculties
				$i--;
			} // end of year
		}

		// echo "exit"; exit;
	}

	// KRUZOK
	private function insert_group($group) {
		// global object in CI
		$ci =& get_instance();

		// Structure table: id, kod, nazov, cislo, id_odbor
		$ci->db->insert('kruzok', $group);
	}

	// ODBOR
	private function insert_department($name, $code, $student_count, $id_faculty, $year) {
		// global object in CI
		$ci =& get_instance();

		// Structure table: id, kod, nazov, pocet_studentov, id_fakulta
		$data = array(
			'kod' => $code,
			'nazov' => $name,
			'pocet_studentov' => $student_count,
			'id_fakulta' => $id_faculty,
			'rocnik' => (int)$year
			);

		$ci->db->insert('odbor', $data);

		// return id of inserted faculty
		return $ci->db->insert_id();
	}

	// FAKULTA
	private function insert_faculty($name, $code) {
		// global object in CI
		$ci =& get_instance();

		// is such faculty already in db ?
		$query = $ci->db->query("SELECT id_fakulta from fakulta WHERE kod = '$code'");
		$result = $query->row();
		if ($result) {
			return $result->id_fakulta;
			// d($result->id_fakulta);
		}
		// else insert faculty

		// Structure table: id, kod, nazov
		$data = array(
			'kod' => $code,
			'nazov' => $name
			);

		$ci->db->insert('fakulta', $data);

		// return id of inserted faculty
		return $ci->db->insert_id();
	}

	// DNI
	private function insert_days() {
		log_message('debug', 'Parsing DAYS ...');
		$ci =& get_instance();
		$days = array("Pondelok", "Utorok", "Streda", "Štvrtok", "Piatok");

		for ($i=0; $i < 5; $i++) {
			$day = array(
				"id_den" => $i+1,
				"den" => $days[$i]
				);

			$ci->db->insert('den', $day);
		}
		log_message('debug', 'Done.');
	}

	private function insert_subjects($subjects) {
		// d($subjects); exit;
		// brace yourself magic incoming
		for ($i=0; $i < count($subjects); $i++) {
			// d("--------------------------------");
			// d($subjects[$i]);

			if (preg_match("/([1-5])_([A-Z]+)_?([A-Za-z0-9]*)_?[A-Z]*\s([0-9\/]+):\s([a-zA-Z]+):\s([A-Z]?)\s[0-9]*\s?([A-Z])\s\|\s([a-zA-Z_\/0-9\-]+)\s([a-zA-Z0-9\/_]+)\s([a-zA-Z_]+)\s([0-9\/]+)\s([0-9]+)\s;([0-9]+)/", $subjects[$i], $subjects_matches)){
				// d($subjects[$i]);
				// [0] => 1_FMV_MEV 31001/2: KAI: P V | InformatikaA INF Carachova_Magdalena 1/1 150 ;57
				// [1] => 1 - rocnik
				// [2] => FMV - fakulta
				// [3] => MEV - odbor
				// [4] => 31001/2 - kod predmetu
				// [5] => KAI - katedra
				// [6] => P - povinny predmet
				// [7] => V - vymera
				// [8] => InformatikaA - nazov predmetu
				// [9] => INF - skratka predmetu
				// [10] => Carachova_Magdalena - prednasajuci
				// [11] => 1/1 - vymera
				// [12] => 150 - pocet studentov na prednaske
				// [13] => 57 - poradie v .par subore (nerelevantny udaj xD)

				$prednaska = preg_match("/([0-9])\/([0-9])/", $subjects_matches[11], $prednaska_matches);
				// [0] => 1/1
				// [1] => 1 - pocet prednasok
				// [2] => 1 - pocet cvik


				// we have to fix entries like this 4_FPM_EMP_EP ... where there is another depratment mentioned
				// just switch first and second department
				preg_match("/([1-5])_([A-Z]+)_?([A-Za-z0-9]*)_?([A-Z]*)\s([0-9\/]+):\s([a-zA-Z]+):\s([A-Z]?)\s[0-9]*\s?([A-Z])\s\|\s([a-zA-Z_\/0-9\-]+)\s([a-zA-Z0-9\/_]+)\s([a-zA-Z_]+)\s([0-9\/]+)\s([0-9]+)\s;([0-9]+)/", $subjects[$i], $testing_matches);
				if (strlen($testing_matches[4])) {
					$subjects_matches[3] = $testing_matches[4];
				}
				// ([1-5])_([A-Z]+)_?([A-Za-z0-9]*)_?([A-Z]*)\s([0-9\/]+):\s([a-zA-Z]+):\s([A-Z]?)\s[0-9]*\s?([A-Z])\s\|\s([a-zA-Z_\/0-9\-]+)\s([a-zA-Z0-9\/_]+)\s([a-zA-Z_]+)\s([0-9\/]+)\s([0-9]+)\s;([0-9]+)

				// check if insert lectures for non mandatory subjects or insert separately
				preg_match("/([1-5])_([A-Z]+)_?([A-Za-z0-9]*)_?[A-Z]*\s([0-9\/]+):\s([a-zA-Z]+):\s([A-Z]?)\s([0-9]*)\s?([A-Z])\s\|\s([a-zA-Z_\/0-9\-]+)\s([a-zA-Z0-9\/_]+)\s([a-zA-Z_]+)\s([0-9\/]+)\s([0-9]+)\s;([0-9]+)/", $subjects[$i], $notMandatoryNumberCheck);
				// $notMandatoryNumberCheck = strlen($notMandatoryNumberCheck[7]) ? 1: 0;

				$prednaska = $prednaska_matches[1] > 0 ? 1 : 0;

				// Predmet table structure: id, kod, nazov, vymera, prednaska, semester
				$subject = array(
					"kod" => $subjects_matches[4],
					"nazov" => $subjects_matches[8],
					"vymera" => $subjects_matches[11],
					"prednaska" => $prednaska,
					"skratka" => $subjects_matches[9],
					"povinny" => $subjects_matches[6] == 'V' ? 0 : 1,
						// TODO: what to put here ?
					"semester" => 0
					);


				$subject_id = self::insert_subject($subject);

				// echo "subject_id: "; echo $subject_id;

				$i++;
				$lecture_regex = "/([\$|\&][1|2])\s([a-zA-z0-9_]+)\s(\d)\s(\d)\s([\d]+)\s?([a-zA-Z_0]*)\s?([a-zA-Z_0]*)/";
				$lectures_inserted = 0;

				if (preg_match("/[#]\s([\d\s]+)/", $subjects[$i], $group_matches)) {
					// [0] => # 1 2 3 4 5 6 7 8 9 10 11 
					// [1] => 1 2 3 4 5 6 7 8 9 10 11 
					$i++;
					$lec_pos = $i+1;
					$lectures_inserted = 1;

					// d($group_matches);

					preg_match($lecture_regex, $subjects[$lec_pos], $lec_matches);
					$lec = self::build_lecture($subjects_matches, $lec_matches, $subject_id);

					// create array from string
					$groups = explode(" ", $group_matches[1]);
					$groups = array_filter($groups);

					$faculty_id =  self::get_faculty_id_by_code($subjects_matches[2]);

					// odbor not specified, get all groups from faculty/year
					if (!preg_match("/[A-Z]+/", $subjects_matches[3])) {
						$ci =& get_instance();
						$q = $ci->db->query("SELECT id_kruzok FROM kruzok
							LEFT JOIN odbor on kruzok.id_odbor = odbor.id_odbor
							LEFT JOIN fakulta on odbor.id_fakulta = fakulta.id_fakulta
							WHERE fakulta.id_fakulta = '$faculty_id' AND odbor.rocnik = '$subjects_matches[1]'
							");

						self::insert_multiple_lectures($q, $lec, $groups);

					} else {
						$ci =& get_instance();
						// echo $faculty_id; exit;
						$q = $ci->db->query("SELECT id_kruzok FROM kruzok
							LEFT JOIN odbor on kruzok.id_odbor = odbor.id_odbor
							LEFT JOIN fakulta on odbor.id_fakulta = fakulta.id_fakulta
							WHERE fakulta.id_fakulta = '$faculty_id' AND odbor.kod = '$subjects_matches[3]' AND odbor.rocnik = '$subjects_matches[1]'
							");

						self::insert_multiple_lectures($q, $lec, $groups);
					}

				}


				$i++; // ignore second row (e.g.: ~ 654 0)

				while (count($subjects) > $i && preg_match($lecture_regex, $subjects[$i], $lecture_matches)) {
					// echo $lecture_matches[1]."<br \>";

					// [0] => $1 B1_04 4 4 0 Carachova_Magdalena
					// [1] => $1 - prednaska ($1) / cvicenie (&1)
					// [2] => B1_04 - miestnost
					// [3] => 4 - cislo dna
					// [4] => 4 - cislo hodiny
					// [5] => 0 - cislo kruzku (pri prednaske je to 0)
					// [6] => Carachova_Magdalena - prednasajuci
					$lecture = self::build_lecture($subjects_matches, $lecture_matches, $subject_id);

					// if its a lecture add lecture for every group and wasn't previously inserted
					if (!$lectures_inserted && preg_match("/[$](\d)/", $lecture_matches[1], $lecture_count)) {
						$lecture['prednaska'] = 1;

						$lecture_count = $lecture_count[1];
						// it there is more than 1 lecture to insert e.g. $2 D111 1 5 0 Holub_Dusan
						for ($c=0; $c < $lecture_count; $c++) { 
							$lecture['id_hodina'] += $c;
							// d($lecture);

							if (!strlen($subjects_matches[3])) {
							// get all departments in such faculty/year
								$ci =& get_instance();
								$q = $ci->db->query("SELECT odbor.kod FROM odbor
									LEFT JOIN fakulta ON odbor.id_fakulta = fakulta.id_fakulta
									WHERE fakulta.kod = '$subjects_matches[2]' AND odbor.rocnik = '$subjects_matches[1]'");

								foreach ($q->result() as $row) {
									self::insert_lecture_for_each_group($subjects_matches[1], $row->kod, $lecture);
								}

							} else {
							// @params: rocnik, department_code, lecture
								self::insert_lecture_for_each_group($subjects_matches[1], $subjects_matches[3], $lecture);
							}

						}

						// d($lecture_count);

						//TODO: add multiple lectures

						// if no department provided

					} else if (preg_match("/\&/", $lecture_matches[1])){
						 // it's an excersise
						$lecture['prednaska'] = 0;

						// $lecture_matches[7] is cviciaci
						if (preg_match("/[a-zA-z_]+/", $lecture_matches[7])) {
							$ci =& get_instance();
							$q = $ci->db->query("SELECT id_ucitel from ucitel WHERE kod = '$lecture_matches[7]'");
							// echo "SELECT id_ucitel from ucitel WHERE kod = '$lecture_matches[7]'";
							$result = $q->row();
							$lecture['id_ucitel'] = $result->id_ucitel;
						}

						// if its not required subject insert excercise for each group in each department
						if ($subjects_matches[6] == 'V') {
							// echo "som tu";
							$ci =& get_instance();
							$faculty_id =  self::get_faculty_id_by_code($subjects_matches[2]);

							// if department exits
							if (strlen($subjects_matches[3])) {
								$q = $ci->db->query("SELECT id_kruzok FROM kruzok
									LEFT JOIN odbor on kruzok.id_odbor = odbor.id_odbor
									LEFT JOIN fakulta on odbor.id_fakulta = fakulta.id_fakulta
									WHERE fakulta.id_fakulta = '$faculty_id' AND odbor.kod = '$subjects_matches[3]' AND odbor.rocnik = '$subjects_matches[1]'
									");

								// d($subjects[$i]);

								$group_ids_array = [];
								foreach ($q->result() as $row) {
									$group_ids_array[] = $row->id_kruzok;
								}

								foreach ($group_ids_array as $g) {
									$lecture['id_kruzok'] = $g;
									self::insert_lecture($lecture);
								}
							} else {
								$q = $ci->db->query("SELECT id_kruzok FROM kruzok
									LEFT JOIN odbor on kruzok.id_odbor = odbor.id_odbor
									LEFT JOIN fakulta on odbor.id_fakulta = fakulta.id_fakulta
									WHERE fakulta.id_fakulta = '$faculty_id' AND odbor.rocnik = '$subjects_matches[1]'
									");
								// echo "som tu";

								$group_ids_array = [];
								foreach ($q->result() as $row) {
									$group_ids_array[] = $row->id_kruzok;
								}

								foreach ($group_ids_array as $g) {
									$lecture['id_kruzok'] = $g;
									self::insert_lecture($lecture);
								}
							}
							
						} else if (!strlen($subjects_matches[3])){
							// we dont have department and subject is required (compulsory)
							$ci =& get_instance();
							$faculty_id =  self::get_faculty_id_by_code($subjects_matches[2]);

							$q = $ci->db->query("SELECT id_kruzok FROM kruzok
								LEFT JOIN odbor on kruzok.id_odbor = odbor.id_odbor
								LEFT JOIN fakulta on odbor.id_fakulta = fakulta.id_fakulta
								WHERE fakulta.id_fakulta = '$faculty_id' AND odbor.rocnik = '$subjects_matches[1]'
								");
								// echo "som tu";

							$group_ids_array = [];
							foreach ($q->result() as $row) {
								$group_ids_array[] = $row->id_kruzok;
							}

							// insert lecture for current group number
							$lecture['id_kruzok'] = $group_ids_array[$lecture_matches[5] - 1];
							self::insert_lecture($lecture);


						} else {
							self::insert_lecture($lecture);
						}
					}

					$i++;
				} // end of inserting rows to VYUKA table
				$i--;
			} // end of inserting rows to PREDMET table
		} // end of for loop
	}

	/////////////////////////////
	// insert single row to table
	/////////////////////////////

	private function insert_lecture($lecture) {
		// d($lecture);
		$ci =& get_instance();
		$ci->db->insert('vyuka', $lecture);
		// d($ci->db->insert_id());
	}

	private function insert_subject($subject) {
		$ci =& get_instance();
		$ci->db->insert('predmet', $subject);
		return $ci->db->insert_id();
	}

	private function insert_teacher($teacher) {
		$ci =& get_instance();
		$ci->db->insert('ucitel', $teacher);
	}

	private function insert_user($user) {
		$ci =& get_instance();
		$ci->db->insert('users', $user);
	}

	private function insert_default_users() {
		$admin = array(
			"username" => "admin",
			"password" => "21232f297a57a5a743894a0e4a801fc3",
			"role_user" => 1,
			"role_manager" => 1,
			"role_admin" => 1,
			"blocked" => 0
			);

		self::insert_user($admin);
	}

	////////////////////
	// helper functions
	////////////////////

	private function get_group_id($year, $department_code, $group_number){
		$ci =& get_instance();


		if ($group_number == 0 || !is_string($department_code)) {
			return 0; 
			// because it's lecture and not an excercise, this lecture is common for all groups in that department/year
			// problem with data with no department code :/
		}

		// get department_id
		$department_id = self::get_department_id_by_code_year($department_code, $year);

		$q = "SELECT id_kruzok FROM kruzok
		LEFT JOIN odbor ON kruzok.id_odbor=odbor.id_odbor
		LEFT JOIN fakulta on odbor.id_fakulta = fakulta.id_fakulta
		WHERE cislo = '$group_number' AND odbor.rocnik = '$year' AND kruzok.id_odbor = '$department_id'";

		$q = $ci->db->query($q);
		$result = $q->row();

		// if such group doesn't exit, create it (workaround for buggy source file)
		if (empty($result)) {

			// department name == group name
			$group_name = self::get_department_name_by_code($department_code);

			// Structure table: id, kod, cislo, nazov, id_odbor
			$new_group = array(
				"kod" => $department_code,
				"cislo" => $group_number,
				"nazov" => $group_name,
				"id_odbor" => $department_id
				);

			$ci->db->insert('kruzok', $new_group);
			$new_group_id = $ci->db->insert_id();
			// echo $new_group_id; exit;
			log_message('debug', 'Aditional group created, id_group: '.$new_group_id.'');
			return $new_group_id;
		}


		return $result->id_kruzok;
	}

	// create lecture row for all groups in such year/department
	private function insert_lecture_for_each_group($year, $department_code, $lecture){
		$ci =& get_instance();

		// get department_id
		$department_id = self::get_department_id_by_code_year($department_code, $year, $lecture);

		// echo "som tu";

		$q = $ci->db->query("SELECT COUNT(id_kruzok) AS group_count FROM kruzok WHERE id_odbor = '$department_id'");
		$result = $q->row();
		$group_count = $result->group_count;
		// d($department_code);

		for ($i=1; $i <= $group_count ; $i++) { 
			$group_id = self::get_group_id($year, $department_code, $i);
			$lecture['id_kruzok'] = $group_id;

			self::insert_lecture($lecture);
		}
	}

	private function insert_multiple_lectures($q, $lec, $groups) {
		$group_ids_array = [];
		foreach ($q->result() as $row) {
			$group_ids_array[] = $row->id_kruzok;
		}

		// echo $subjects_matches[8];
		$groups_to_insert = [];

		for ($i=0; $i < count($groups); $i++) { 
			array_push($groups_to_insert, $group_ids_array[$groups[$i] - 1]);
		}
		
		// $groups_to_insert = array_intersect($group_ids_array, $groups);
		// echo "all from db: ";
		// d($group_ids_array);
		// d($groups);
		// d($groups_to_insert);
		// exit;
		// d("---------------");

		// d($groups_to_insert);

		foreach ($groups_to_insert as $g) {
			$lec['id_kruzok'] = $g;
			$lec['prednaska'] = 1;
			self::insert_lecture($lec);
		}

	}

	private function build_lecture($subjects_matches, $lecture_matches, $subject_id){
		$room_name = $lecture_matches[2];
		$teacher_code = $lecture_matches[6];

		$ci =& get_instance();

		// d($lecture_matches);

		// get room id
		$q = $ci->db->query("SELECT id_miestnost from miestnost WHERE nazov = '$room_name'");
		$result = $q->row();
		$id_room = $result->id_miestnost;

		// get dummy teacher, will be needed later, as substitute for no teacher
		$q = $ci->db->query("SELECT id_ucitel from ucitel WHERE kod = 'dummy_teacher'");
		$result = $q->row();
		$id_dummy_teacher = $result->id_ucitel;

		// get teacher id
		if (preg_match("/[a-zA-z_]+/", $teacher_code)) {
			$q = $ci->db->query("SELECT id_ucitel from ucitel WHERE kod = '$teacher_code'");
			$result = $q->row();
			$id_teacher = $result->id_ucitel;
		} else {
			// set dummy teacher
			$id_teacher = $id_dummy_teacher; 
		}

		// odbor kod can be "" lol
		$subjects_matches[3] = preg_match("/[A-Z]+/", $subjects_matches[3])? $subjects_matches[3] : 0;

		// d($lecture_matches);

		// get group id
		// @params rocnik(int), odbor(kod), poradie kruzku(int)
		$group_id = self::get_group_id($subjects_matches[1], $subjects_matches[3], $lecture_matches[5]);

		// Vyuka table structure: id, id_kruzok, id_hodina, id_den, id_predmet, prednaska, id_miestnost, id_ucitel, polrok, id_rozvrh
		return array(
			"id_kruzok" => $group_id,
			"id_den" => $lecture_matches[3],
			"id_predmet" => $subject_id,
			"id_hodina" => $lecture_matches[4],
			"id_miestnost" => $id_room,
			"id_ucitel" => $id_teacher,
			"polrok" => null,
			"id_rozvrh" => null
			);
	}

	private function get_faculty_id_by_code($faculty_code){
		$ci =& get_instance();
		$q = $ci->db->query("SELECT id_fakulta from fakulta WHERE kod = '$faculty_code'");
		$result = $q->row();

		return $result->id_fakulta;
	}

	private function get_department_id_by_code_year($department_code, $year){
		$ci =& get_instance();
		$q = $ci->db->query("SELECT id_odbor from odbor WHERE kod = '$department_code' AND rocnik = '$year'");
		$result = $q->row();
		// echo "SELECT id_odbor from odbor WHERE kod = '$department_code' AND rocnik = '$year'";
		return $result->id_odbor;
	}

	private function get_department_name_by_code($department_code) {
		$ci =& get_instance();
		$q = $ci->db->query("SELECT nazov from odbor WHERE kod = '$department_code' LIMIT 1");
		$result = $q->row();

		return $result->nazov;
	}
}

// basic debug error message
function d ($s) {
	echo "<pre>";
	print_r($s);
	echo "</pre>";
}

<?php include('includes/head.php'); ?>
<?php include('includes/topnav.php'); ?>
<?php include('includes/menu.php'); ?>

        <div class="content">
            <div class="header">
                <div class="stats">
                    <p class="stat"><span class="number"><?php print_r($tasks_stats['Total']); ?></span>Úloh celkovo</p>
                    <p class="stat"><span class="number"><?php print_r(isset($tasks_stats['Closed']) ? $tasks_stats['Closed'] : 0); ?></span>Zatvorených</p>
					<p class="stat"><span class="number"><?php print_r(isset($tasks_stats['Resolved']) ? $tasks_stats['Resolved'] : 0); ?></span>Vyriešených</p>
					<p class="stat"><span class="number"><?php print_r(isset($tasks_stats['Reopened']) ? $tasks_stats['Reopened'] : 0); ?></span>Znovuotvorených</p>
					<p class="stat"><span class="number"><?php print_r(isset($tasks_stats['In Progress']) ? $tasks_stats['In Progress'] : 0); ?></span>Rozpracovaných</p>
					<p class="stat"><span class="number"><?php print_r(isset($tasks_stats['Open']) ? $tasks_stats['Open'] : 0); ?></span>Priradených</p>
                </div>
                <h1 class="page-title">Dashboard</h1>
            </div>
            <ul class="breadcrumb">
                <li><a href="<?php echo base_url() ?>home">Domov</a> <span class="divider">/</span></li>
                <li class="active">Dashboard</li>
            </ul>
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="row-fluid">
                    	<?php 
						if($this->session->flashdata('message')) {
							echo '<div class="alert alert-info">';
							echo $this->session->flashdata('message');
							echo "</div>";
						}
						else if($this->session->flashdata('error')) {
							echo '<div class="alert alert-danger">';
							echo $this->session->flashdata('error');
							echo '</div>';
						}
						else {
						?>
                        <div class="alert alert-info">
                            <strong>Dobrý deň, naposledy ste boli prihlásení:</strong> <?php echo $lastLogin ?>
                        </div>
                        <?php } ?>
                        <div class="block">
                            <a href="#page-stats" class="block-heading" data-toggle="collapse">Najnovšie priradené úlohy</a>
                            <div id="page-stats" class="block-body collapse in">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Názov</th>
                                            <th>Deadline</th>
                                            <th>Stav</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<?php foreach ($tasks as $task => $value): ?>
											<tr>
												<td><a href="<?php echo base_url(); ?>task/detail/<?php print_r($value['id']) ?>"><?php print_r($value['title']) ?></a></td>
												<td><?php print_r($value['deadline']); ?></td>
												<td>
												<?php 
													if ($value['id_state'] != 5){ //ak je solved
														echo "<span class=\"label label-important\">Nevyriešená</span>";
													} else {
														echo "<span class=\"label label-success\">Vyriešená</span>";
													}
												?>
												</td>
											</tr>
										<?php endforeach ?>
                                    </tbody>
                                </table>
                                <p><a href="<?php echo base_url() ?>task/task_list" class="btn btn-link"><i class="icon-th-list"></i> Zobraziť všetky</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="block span6">
                        <a href="#widget1" class="block-heading" data-toggle="collapse">Graf 1</a>
                        <div id="chart1" style="width: 459px; height: 300px;" class="block-body collapse in">
                            <h2>Graf title</h2>
                        </div>
                    </div>
                    <div class="block span6">
                        <a href="#widget2" class="block-heading" data-toggle="collapse">Graf 2</a>
                        <div id="chart2" style="width: 459px; height: 300px;" class="block-body collapse in">
                            <h2>Graf title</h2>
                        </div>
                    </div>
                </div>
            </div>
            <footer>
                <hr>
                <p class="pull-right">Task manager v1.0.4 b</p>
                <div class="clearfix">&nbsp;</div>
            </footer>
        </div>
        </div>
        </div>
        <script src="<?php echo base_url() ?>resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script type="text/javascript">
            $("[rel=tooltip]").tooltip();
            $(function() {
                $('.demo-cancel-click').click(function(){return false;});
            });
        </script>
        
		<!-- js chart section -->
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	    <script type="text/javascript">
	      google.load("visualization", "1", {packages:["corechart"]});
	      google.setOnLoadCallback(drawChart);
	      function drawChart() {
		
			var stateData = <?php print_r(json_encode($chart1)); ?>;
			var priorityData = <?php print_r(json_encode($chart2)); ?>;
			var stateArray = []; 
			var priorityArray = [];
			
			var stateTitle = ['state', 'count'];
			stateArray.push(stateTitle);
			
			var priorityTitle = ['priority', 'count'];
			priorityArray.push(priorityTitle);
			
			// parse state data
			for(var i = 0; i < stateData.length; i++){
				var tmp = [];
				tmp.push(stateData[i].state);
				tmp.push(parseInt(stateData[i].count));
				
				stateArray.push(tmp);
			}
			    
			// parse priority data
			for(i = 0; i < priorityData.length; i++){
				var tmp = [];
				tmp.push(priorityData[i].priority);
				tmp.push(parseInt(priorityData[i].count));
				
				priorityArray.push(tmp);
			}
			

			var options1 = {
				title: 'Rozdelenie úloh podľa stavu',
				is3D: true
	        };
	
			var options2 = {
				title: 'Rozdelenie úloh podľa priority',
				is3D: true
	        };

	        var chart1 = new google.visualization.PieChart(document.getElementById('chart1'));
	        chart1.draw(google.visualization.arrayToDataTable(stateArray), options1);
	
	        var chart2 = new google.visualization.PieChart(document.getElementById('chart2'));
	        chart2.draw(google.visualization.arrayToDataTable(priorityArray), options2);
	      }
	    </script>
    </body>
</html>
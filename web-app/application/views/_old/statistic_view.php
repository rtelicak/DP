<?php include('includes/head.php'); ?>
<?php include('includes/topnav.php'); ?>
<?php include('includes/menu.php'); ?>
<div class="content">
	<div class="header">
		<h1 class="page-title">Štatistiky</h1>
	</div>
	<ul class="breadcrumb">
		<li><a href="<?php echo base_url() ?>home">Home</a> <span class="divider">/</span></li>
		<li class="active">Štatistiky</li>
	</ul>
	<div class="container-fluid">
		<div class="row-fluid">
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
			
			<div class="block">
                <a href="#widget1" class="block-heading" data-toggle="collapse">Graf 1</a>
                <div id="chart3" style="width: 800px; height: 400px; margin: 0 auto;" class="block-body collapse in">
                    <h2>Graf title</h2>
                </div>
			</div>
			<footer>
				<hr>
				<p class="pull-right">
					Task manager v1.0.4 b
				</p>
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
	var userData = <?php print_r(json_encode($chart3)); ?>;
	var stateArray = []; 
	var priorityArray = [];
	var userArray = [];
	
	var stateTitle = ['state', 'count'];
	stateArray.push(stateTitle);
	
	var priorityTitle = ['priority', 'count'];
	priorityArray.push(priorityTitle);

	var userTitle = ['user', 'count'];
	userArray.push(userTitle);
	
	
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

	for(i = 0; i < userData.length; i++){
		var tmp = [];
		tmp.push(userData[i].username);
		tmp.push(parseInt(userData[i].count));
		
		userArray.push(tmp);
	}

	var options1 = {
		title: 'Rozdelenie úloh podľa stavu',
		is3D: true
    };

	var options2 = {
		title: 'Rozdelenie úloh podľa priority',
		is3D: true
    };

	var options3 = {
		title: 'Rozdelenie úloh podľa pouzivatelov',
		is3D: true
    };
	
    var chart1 = new google.visualization.PieChart(document.getElementById('chart1'));
    chart1.draw(google.visualization.arrayToDataTable(stateArray), options1);

    var chart2 = new google.visualization.PieChart(document.getElementById('chart2'));
    chart2.draw(google.visualization.arrayToDataTable(priorityArray), options2);

    var chart3 = new google.visualization.PieChart(document.getElementById('chart3'));
    chart3.draw(google.visualization.arrayToDataTable(userArray), options3);
  }
</script>
</body>
</html>
<?php include('includes/head.php'); ?>
<?php include('includes/topnav.php'); ?>
<?php include('includes/menu.php'); ?>

	<div class="content">
		<div class="header">
			<h1 class="page-title">Zoznam používateľov</h1>
		</div>
		<ul class="breadcrumb">
			<li><a href="<?php echo base_url() ?>home">Domov</a> <span class="divider">/</span></li>
			<li class="active">Zoznam používateľov</li>
		</ul>
		<div class="container-fluid">
			<div class="row-fluid">
            	<?php 
				if($this->session->flashdata('message')) {
					echo '<div class="alert alert-info">';
					echo $this->session->flashdata('message');
					echo "</div>";
				}
				if($this->session->flashdata('error')) {
					echo '<div class="alert alert-danger">';
					echo $this->session->flashdata('error');
					echo '</div>';
				}
				?>
				<div class="btn-toolbar">
					<a href="<?php echo base_url() ?>user/add_user" class="btn btn-success"><i class="icon-user"></i> Nový používateľ</a>
				</div>
				<div class="">
					<table id="userTable" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Používateľ</th>
								<th>Stav úloh</th>
								<th>Štatistiky</th>
								<th>Operácia</th>
								<th>Úlohy</th>
							</tr>
						</thead>
						<tbody>
							<?php
								$i=0;
								foreach ($users as $user): 
							?>
							<tr class="line">
								<td width="20%;" class="font-120"><a href=<?php echo base_url() ?>user/detail/<?php echo $user->id?>><?php echo $user->username?></a></td>
								<td width="32%">Celkovo <span class="badge badge-info"><?php echo $user->tasks['total'];?></span> | Vyriešených <span class="badge badge-success"><?php echo $user->tasks['resolved'];?></span> | Nevyriešených <span class="badge badge-important"><?php echo $user->tasks['unresolved'];?></span></td>
								<td width="9%"><a href="#stats" class="btn btn-link btn-small stats" onClick="setStats(<?php echo $user->id?>,<?php echo $i?>)"><i class="icon-bar-chart"></i> <span>Zobraziť</span></a></td>
								<td width="19%">
                                	<div class="btn-cover pull-right">
									<a href="<?php echo base_url() ?>user/changeUserStatus/<?php echo $user->id?>/<?php echo $user->action['operation'];?>" class="btn btn-<?php echo $user->action['btnClass'];?> btn-small"><i class="icon-ban-circle"></i> <?php echo $user->action['btnTitle'];?> prístup</a>
									<a href="<?php echo base_url() ?>user/deleteUser/<?php echo $user->id?>" class="btn btn-danger btn-small"><i class="icon-trash"></i> Zmazať</a>
                                    </div>
								</td>
								<td width="9%"><a href="<?php echo base_url() ?>task/task_list/<?php echo $user->id; ?>";" class="btn btn-link btn-small"><i class="icon-bar-chart"></i><span> Zobraziť</span></a></td>
							</tr>
							<tr class='stats' style="display:none;">
								<td id="statscol<?php echo $i?>" opened=false colspan='4' />
							</tr>
							<?php
								$i++;
								endforeach; ?>
						</tbody>
					</table>
				</div>
				<div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h3 id="myModalLabel">Delete Confirmation</h3>
					</div>
					<div class="modal-body">
						<p class="error-text"><i class="icon-warning-sign modal-icon"></i>Are you sure you want to delete the user?</p>
					</div>
					<div class="modal-footer">
						<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
						<button class="btn btn-danger" data-dismiss="modal">Delete</button>
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
			$(function () {
					$("#userTable", "body").on({
						'click': function (event) {
							event.preventDefault();
							var content = $(this).find("span");
							var label = content.text() == 'Zobraziť' ? "Skryť" : "Zobraziť";
							content.text(label);   
							                      
							$(this).closest("tr.line").nextUntil("tr.line").toggle('slow');
						}
					},
						"a.stats", null);
				});
        </script>
        <script type='text/javascript' src='https://www.google.com/jsapi'></script>
		<script type="text/javascript">
		/*
		*
		* WELCOME DEAR CODE VIEWER! YOU SHALL PASS NOW!
		* For your mood improvement in dark coding times: http://www.mojevideo.sk/video/18925/pokazene_kozy.html
		*
		*/
		function setStats(uid, row){
			var isOpened = $("#statscol"+row).attr("opened");

			// quick return if we're just closing row
			if (isOpened == "false"){
				$("#statscol"+row).attr("opened", true);
			}else{
				$("#statscol"+row).attr("opened", false);
				return;
			}
			
			// add load class
			$("#statscol"+row).addClass("load");
			getStats(uid, row);
		}
			
		function getStats(uid, row){   
			var xmlhttp; 
			
			// Check for user id - quick return
			if (uid.length == 0){
				document.getElementById("statscol"+row).innerHTML="";
				return;
			} 
			
			if (window.XMLHttpRequest){
				xmlhttp=new XMLHttpRequest(); // kod pre IE7+, Firefox, Chrome, Opera, Safari
			}
			else{    
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP"); // kod pre IE6, IE5
			}
			
			xmlhttp.open("GET","<?php echo base_url() ?>application/webservices/getStats.php?uid="+uid,true);
			xmlhttp.send();
			
			xmlhttp.onreadystatechange=function(){ 
				 if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
				
					// Get JSON response
					var obj = JSON.parse(xmlhttp.responseText);
				
					// Create data vars for charts from JSON response
					var tasks = obj["tasks"];
					var state = obj["state"];                         
					
					var chartWrapper = $("#statscol"+row);
					
					// if never been opened before, has no children
					if(!chartWrapper.children().length){
						$("#statscol"+row).append("<div style=\"width:50%;\"></div><div style=\"width:50%;\"></div>");
					}
					
					// remove load class and draw charts
					chartWrapper.removeClass("load");
					var firstChartDiv = chartWrapper.children()[0];
					var secondChartDiv = chartWrapper.children()[1];
					
					drawChart(firstChartDiv, "Stav používateľových taskov:", tasks);
					drawChart(secondChartDiv, "Status používateľových taskov:", state);
				}
			}
		}
		
		google.load("visualization", "1", {packages:["corechart"]});
		
		function drawChart(container, title, obj) {
			var data = [];
			data.push(['Task priority', 'Count']);
			
			for (var prop in obj){
				if(obj.hasOwnProperty(prop)){
					var tmp = [];
					tmp.push(prop, parseInt(obj[prop]));
					data.push(tmp);
				} 
			}
			
			var data = google.visualization.arrayToDataTable(data);
			
			var options = {
				title: title,
				'width': 450,
				'height': 330,
				is3D: true
			};
	
			var chart = new google.visualization.PieChart(container);
			chart.draw(data, options);
		  }
		</script>
		
    </body>
</html>
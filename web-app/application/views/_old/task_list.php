<?php include('includes/head.php'); ?>
<?php include('includes/topnav.php'); ?>
<?php include('includes/menu.php'); ?>

        <div class="content">
            <div class="header">
                <h1 class="page-title">Zoznam úloh</h1>
            </div>
            <ul class="breadcrumb">
                <li><a href="<?php echo base_url() ?>home">Domov</a> <span class="divider">/</span></li>
                <li class="active">Zoznam úloh</li>
            </ul>
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="btn-toolbar">
						<?php if ($role == 1): ?>
                        	<a href="<?php echo base_url() ?>task/add_task"><button class="btn btn-primary"><i class="icon-plus"></i> Nová úloha</button></a>							
						<?php endif ?>
                        <a href="<?php echo base_url() ?>task/task_list/<?php echo $users_tasks == 0 ? $user_id : ""; ?>"><button style="margin-left: 10px;" class="btn btn-primary"><i class="icon-check"></i><?php echo $users_tasks == 0 ? " Zobraziť len moje úlohy" : " Zobraziť všetky úlohy"; ?></button></a>
						<?php if ($deadline_tasks): ?>
							<a href="<?php echo base_url() ?>task/task_list/"><button style="margin-left: 10px;" class="btn btn-primary"><i class="icon-check"></i> Zobraziť všetky úlohy</button></a>
						<?php endif ?>
                        <a href="<?php echo base_url() ?>task/before_deadline"><button style="margin-left: 10px;" class="btn btn-danger"><i class="icon-time"></i> Zobraziť úlohy pred deadlinom</button></a>
                        <div class="btn-group right">
                            <form id="tab" class="search form-inline mb-0" method="post" action="<?php echo base_url() ?>task/search">
                                <input type="text" name="keyword" id="keyword" placeholder="Vyhľadávanie v úlohách..">
                            </form>
                        </div>
                    </div>
                    <?php if($keyword != FALSE ) {
						echo '<div class="alert alert-info">';
						echo "Zobrazuje sa výsledok vyhľadávania pre: <b>\"".$keyword."\"</b>";
						echo "<a class='btn btn-danger pull-right' href='".base_url()."task/task_list'>Návrat na zoznam úloh</a>";
						echo "<div class='clearfix'></div>";
						echo "</div>";
                    } ?>
                    <div class="">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Názov</th>
                                    <th>Priradený</th>
                                    <th>Deadline</th>
                                    <th>Stav</th>    
									<th>Priorita</th>
									<?php if ($role == 1): ?>
										<th>Zmazať</th>     
									<?php endif ?>
                                </tr>
                            </thead>
                            <tbody> 
									<?php foreach ($tasks as $task): ?>
										<tr>
											<td><a href="<?php echo base_url() ?>task/detail/<?php echo $task->id?>"><?php echo $task->title?></a></td>
											<td><?php echo $task->username?></td>
											<td><?php echo $task->deadline?></td>
											<td><?php echo $task->state?></td> 
											<td><?php echo $task->priority?></td> 
											<?php if ($role == 1): ?>
												<td style="width: 90px;"><a class="btn btn-danger" href="<?php echo base_url() ?>task/delete/<?php echo $task->id?>"><i class="icon-trash icon-large"></i> Delete</a></td>
											<?php endif ?>
										</tr>
									<?php endforeach; ?>
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
        </script>
    </body>
</html>
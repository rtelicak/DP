<?php include('includes/head.php'); ?>
<?php include('includes/topnav.php'); ?>
<?php include('includes/menu.php'); ?>
    <div class="content">
        <div class="header">
            <h1 class="page-title">Detail úlohy</h1>
        </div>
        <ul class="breadcrumb">
            <li><a href="<?php echo base_url() ?>task/task_list">Úlohy</a> <span class="divider">/</span></li>
            <li class="active">Detail úlohy</li>
        </ul>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="item-content">
                    <div class="span9 offset1" style="padding-top:30px;"> 
						<div>
						<div class="row-fluid">
							<div class="span1">
								<h4>Nazov</h4>
							</div>
							<div class="span8 offset1">
								<h4><?php echo $title; ?></h4>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span1">
								<h4>Popis</h4>
							</div>
							<div class="span9 offset1">
								<p><?php echo $desc; ?></p>
							</div>
						</div> 
						<div class="row-fluid">
							<div class="span1">
								<h4>Priradený</h4>
							</div>
							<div class="span8 offset1">
								<p><?php echo $assigned_user; ?></p>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span1">
								<h4>Vytvorená</h4>
							</div>
							<div class="span8 offset1">
								<p><?php echo $created; ?></p>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span1">
								<h4>Deadline</h4>
							</div>
							<div class="span8 offset1">
								<p><?php echo $deadline; ?></p>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span1">
								<h4>Priorita</h4>
							</div>
							<div class="span8 offset1">
								<p><span class="label label-important"><?php echo $priority; ?></span></p>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span1">
								<h4>Stav</h4>
							</div>
							<div class="span8 offset1">
								<p><span class="label label-success"><?php echo $state; ?></span></p> 
							</div>
						</div>
						</div>                                                 
						<!-- display action btn according to user's role and task's status -->
                        <div class="mb-30" style="padding-top: 40px;"> 
							<?php if ($role == 1): ?>
								<a href="<?php echo base_url() ?>task/edit_task/<?php echo $id_task; ?>"><button class="btn btn-small btn-warning"><i class="icon-edit"></i> Upraviť úlohu</button></a>
								<a href="<?php echo base_url() ?>task/close/<?php echo $id_task; ?>"><button class="btn btn-small btn-danger"><i class="icon-off"></i> Zavrieť úlohu</button></a>  
							<?php endif ?>

							<?php if ($role == 1 && ($state == "Resolved" || $state == "Closed")): ?>
								<a href="<?php echo base_url() ?>task/reopen/<?php echo $id_task; ?>"><button class="btn btn-small btn-info"><i class="icon-off"></i> Znovuotvoriť úlohu</button></a> 
							<?php endif ?>
							
							</br><div style="padding-top: 20px;" />
							
							<?php if ($id_assigned_user == $id_logged_user && $state == "Open" || $state == "Reopened"): ?>
								<a href="<?php echo base_url() ?>task/set_to_progress/<?php echo $id_task ?>"><button class="btn btn-small btn-success"><i class="icon-bar-chart"></i> Začať pracovať na úlohe</button></a>
							<?php endif ?>
							
							<?php if ($id_assigned_user == $id_logged_user && $state == "In Progress"): ?>
								<a href="<?php echo base_url() ?>task/solve/<?php echo $id_task ?>"><button class="btn btn-small btn-success"><i class="icon-ok"></i> Vyriešiť úlohu</button></a>
							<?php endif ?>
                        </div>
                        <h3>Komentáre</h3>
						<ul class=comment-wrapper>
							<?php foreach ($comments as $comment): ?>
								<li class="comment">
									<div class="comment-info">
										<i class="icon-user"></i>&nbsp<?php echo $comment->user; ?></i><br/>
										<small><?php echo $comment->dateTime; ?></small>
										</div>
									<div class="comment-bubble"><p><?php echo $comment->body; ?></p></div>
								</li>
							<?php endforeach ?>
						</ul>
						<div class="add-comment-wrapper">
							<div class="comment-box">
	                        	<h4>Pridať nový komentár</h4>
								<?php echo form_open('task/add_comment'); ?> 
									<input type="hidden" name="id_user" id="id_user" value="<?php echo $id_logged_user ?>" />
									<input type="hidden" name="id_task" id="id_task" value="<?php echo $id_task ?>" />
		                        	<textarea name="body" id="commentarea" placeholder="Váš komentár.." rows="5" cols="15"></textarea>
		                            <div class="comment-btns">
										<button type="submit" class="btn btn-small btn-success pull-left mr-10"><i class="icon-ok"></i> Pridať komentár</button>
		    	                        <button type="button" class="btn btn-small btn-danger pull-left"><i class="icon-ban-circle"></i> Zmazať napísané</button>
		                            </div>
								</form>
							</div>
						</div>
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

	<script src="<?php echo base_url() ?>resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
</body>
</html>
<?php include('includes/head.php'); ?>
<?php include('includes/topnav.php'); ?>
<?php include('includes/menu.php'); ?>

        <div class="content">
            <div class="header">
                <h1 class="page-title">Nová úloha</h1>
            </div>
            <ul class="breadcrumb">
                <li><a href="<?php echo base_url() ?>home">Úlohy</a> <span class="divider">/</span></li>
                <li class="active"><?php echo is_numeric($id_task) ? "Upravenie úlohy" : "Nová úloha"; ?></li>
            </ul>
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="well">
                        <div class="form-cover">
                            <h2 class="page-title">
                            Parametre úlohy</h1>
                            <div class="tab-pane active in" id="home">
                                <?php echo validation_errors(); ?>
								<?php echo form_open('task/save'); ?>
									<input name="id_task" type="hidden" value="<?php echo $id_task ?>">
                                    <label>Názov</label>
                                    <input name="title" type="text" class="input-xxlarge" value="<?php echo $title; ?>">
                                    <label>Popis úlohy</label>
                                    <textarea name="desc" value="popis" rows="3" class="input-xxlarge"><?php echo $desc; ?></textarea>
                                    <label>Priradený používateľ</label>
									<?php echo form_dropdown('id_assigned_user', $users, $id_assigned_user); ?>
                                    <label>Priorita</label>
									<?php echo form_dropdown('id_priority', $priorities, $id_priority); ?>
                                    <label>Deadline</label>
                                    <input name="deadline" type="text" class="input-large" value="<?php echo $deadline; ?>">
				                    <div class="btn-toolbar">
				                        <button type="submit" class="btn btn-primary"><i class="icon-save"></i> Uložiť / Aktualizovať</button>
				                        <a href="#myModal" data-toggle="modal" class="btn btn-warning"><i class="icon-ban-circle"></i> Zrušiť</a>
				                    </div>
                                </form>
                            </div>
                        </div>    
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
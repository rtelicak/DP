<?php include('templates/head.php'); ?>

<div class="navbar">
	<div class="navbar-inner">
		<a class="brand" href="<?php echo base_url(); ?>"><span class="first">Euba rozvrh</span> - <span class="second">Admin mode login</span></a>
	</div>
</div>

<div class="row-fluid">
	<div class="dialog">
		<div class="block">
			<p class="block-heading">Prihlásenie</p>
			<div class="block-body"> 
				<?php
				if($msg!='') {
					echo '<div class="alert alert-info">';
					echo $msg;
					echo "</div>";
				} ?>
				<?php echo validation_errors(); ?>
				<?php echo form_open('/admin/verifylogin'); ?>
				<label>Prihlasovacie meno</label>
				<input name="username" id="username" type="text" class="span12">
				<label>Heslo</label>
				<input name="password" id="password" type="password"  class="span12">
				<input type="submit" name="Submit" value="Prihlásiť sa" class="btn btn-primary pull-right">
				<div class="clearfix"></div>
			</form>
		</div>
	</div>
</div>
</div>

</body>
</html>

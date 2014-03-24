<?php include('includes/head_frontend.php'); ?>


<header role="banner" class="navbar navbar-custom navbar-fixed-top">
  <div class="container">
    <?php include('includes/menu_frontend.php'); ?>
  </div>
</header>

<div id="masthead">
  <div class="container">
    <div class="row">
      <div class="col-xs-7">
        <h1>Euba rozvrhár
          <p class="lead">BETA</p>
        </h1>
      </div>
      <div class="col-xs-5">
        <div class="well well-lg">
          <div class="row">
            <div class="col-xs-12">
              <h2 class="notice-title">Aktuály semester: Leto / 2014</h2>
              <div class="top-notice alert alert-info mb-0">Posledná aktualizácia: 22.02.2014</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- /cont -->
  
  <div class="container">
    <div class="row">
      <div class="col-xs-12">
        <div class="top-spacer">
          <div class="panel">
            <div class="panel-body"> &nbsp; </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- /cont --> 
</div>

<!-- CONTENT BEGIN -->

<div class="container">
  <div class="row">
    <div class="col-xs-12">
      <div class="panel">
        <div class="panel-body">
        
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
					?>
        
          <div class="well well-sm no-img">
            <form action="<?php echo base_url() ?>home" method="get">
              <legend>Filter</legend>
              <div class="row">
                <div class="col-xs-2">
                	<strong>Fakulta:</strong>
                  <select id="faculty" name="faculty" class="form-control">
                    <?php 
											for($i=0;$i<count($faculties_options);$i++)
											{
												echo $faculties_options[$i];
											}
										?>
                  </select>
                </div>
                <div class="col-xs-2">
                	<strong>Odbor:</strong>
                  <select id="discipline" name="discipline" class="form-control" disabled="disabled">
                     <?php 
											for($i=0;$i<count($discipline_options);$i++)
											{
												echo $discipline_options[$i];
											}
										?>
                  </select>
                </div>
                <div class="col-xs-2">
                	<strong>Ročník:</strong>
                  <select id="study_year" name="study_year" class="form-control" disabled="disabled">
                  	<option value="0">-== Vyberte ==-</option>
                    <?php  
										for($r=1;$r<=5;$r++)
										{
											$selected = '';
											if($form && $form['study_year']==$r){
												$selected = "selected='selected'";
											}
											
											echo "<option value='".$r."' ".$selected.">".$r.". ročník</option>";
										}
										?>
                   </select>
                </div>
                <div class="col-xs-2">
                	<strong>Skupina:</strong>
                  <select id="study_group" name="study_group" class="form-control" disabled="disabled">
                    <?php 
											for($i=0;$i<count($study_groups_options);$i++)
											{
												echo $study_groups_options[$i];
											}
										?>
                  </select>
                </div>
                <div class="col-xs-3">
                	<br />
                  <button class="btn btn-sm mt-2 btn-success" type="submit"><i class="fa fa-calendar"></i> Načítať rozvrh</button>
                  <a class="btn btn-sm mt-2 btn-warning" href="<?php echo base_url() ?>home"><i class="fa fa-refresh"></i> Reset filtra</a>
                </div>
              </div>
              <hr>
              <?php if($form) { ?>
              <p><span class="current-filter label label-success">
              	Aktuálny filter: 
								<?php echo $form['faculty']['detail']->nazov; ?> &gt; 
                <?php echo $form['discipline']['detail']->nazov; ?> &gt; 
                <?php echo $form['study_year']?>. ročník &gt; 
								<?php echo $form['study_group']['detail']->nazov; ?>
                </span></p>
              <?php } else { ?>
              	<p><span class="current-filter label label-info">Filter nieje aktívny</span></p>
              <?php } ?>
              <div class="clearfix"></div>
            </form>
          </div>
          <?php if($form) { 
					// ODOSLALS FORMULAR DOSTANES ROZVRH
						
						include('includes/schedule_table.php');
					
					?>
          <?php } else { 
					// FORMULAR SI NEODOSLAL, IBA BASIC LOOK
					?>
          
          <table width="100%" border="0" class="table table-bordered table-striped" id="schedule">
            <colgroup>
            <col class="first">
            <col class="scheduled-hour">
            <col class="break">
            <col class="scheduled-hour">
            <col class="break">
            <col class="scheduled-hour">
            <col class="break lunch-break">
            <col class="scheduled-hour">
            <col class="break">
            <col class="scheduled-hour">
            <col class="break">
            <col class="scheduled-hour">
            <col class="break">
            <col class="scheduled-hour">
            </colgroup>
            <tbody>
              <tr class="table-heading">
                <td class="day">&nbsp;</td>
                <td>7:30 - 9:00</td>
                <td class="break">&nbsp;</td>
                <td>9:15 - 10:45</td>
                <td class="break">&nbsp;</td>
                <td>11:00 - 12:30</td>
                <td class="break">&nbsp;</td>
                <td>13:30 - 15:00</td>
                <td class="break">&nbsp;</td>
                <td>15:15 - 16:45</td>
                <td class="break">&nbsp;</td>
                <td>17:00 - 18:30</td>
                <td class="break">&nbsp;</td>
                <td>18:35 - 20:05</td>
              </tr>
              <tr>
                <td class="day">Po.</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="day">Ut.</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="day">St.</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="day">Št.</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td class="day">Pi.</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="break">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr class="table-heading">
                <td class="day">&nbsp;</td>
                <td>7:30 - 9:00</td>
                <td class="break">&nbsp;</td>
                <td>9:15 - 10:45</td>
                <td class="break">&nbsp;</td>
                <td>11:00 - 12:30</td>
                <td class="break">&nbsp;</td>
                <td>13:30 - 15:00</td>
                <td class="break">&nbsp;</td>
                <td>15:15 - 16:45</td>
                <td class="break">&nbsp;</td>
                <td>17:00 - 18:30</td>
                <td class="break">&nbsp;</td>
                <td>18:35 - 20:05</td>
              </tr>
            </tbody>
          </table>
          <?php } ?>
        </div>
      </div>
    </div>
    <!--/col-12-->
    
    <div class="modal fade" id="lecture-modal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
            <h4 id="item-title" class="modal-title">Detail predmetu</h4>
          </div>
          <div class="modal-body">
            <dl class="dl-horizontal mb-0">
              <dt>Predmet: </dt>
              <dd class="title strong"></dd>
              <dt>Typ hodiny: </dt>
              <dd class="type"></dd>
              <dt>Miestnosť: </dt>
              <dd class="room"></dd>
              <dt>Vyučujúci: </dt>
              <dd class="teacher"></dd>
              <dt>Čas: </dt>
              <dd class="time"></dd>
              <dt>Deň: </dt>
              <dd class="day"></dd>
            </dl>
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-block btn-danger" type="button">Zatvoriť</button>
          </div>
        </div>
        <!-- /.modal-content --> 
      </div>
      <!-- /.modal-dialog --> 
    </div>
    <!-- /.modal --> 
    
  </div>
</div>


<!--- EOF CONTENT -->


<?php include('includes/footer_frontend.php'); ?>
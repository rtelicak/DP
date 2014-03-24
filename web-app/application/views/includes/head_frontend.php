<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<title>Euba rozvrhár / Beta</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />

<!-- Optional theme -->
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="<?php echo base_url() ?>resources/stylesheets/theme_frontend.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" />

<!-- Latest compiled and minified JavaScript -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.js"></script>
    <![endif]-->

<script type="text/javascript">
jQuery(document).ready(function()
{
	jQuery("#schedule .item").click(function(){
		var item = jQuery(this).find('div.item-content');
		var data = [];

						jQuery(item).each(function() {
									  jQuery.each(this.attributes, function() {
																		/*if(this.specified) {
																		console.log(this.name, this.value);
																		}*/
																		data.push(this.value);
												});
						});
						var modalElm = jQuery('#lecture-modal');

						modalElm.find('.teacher').html(data[0]);
						modalElm.find('.type').html(data[1]);
						modalElm.find('.room').html(data[2]);
						modalElm.find('.time').html(data[3]);
						modalElm.find('.title').html(data[4]);
						modalElm.find('.day').html(data[5]);

						modalElm.modal("show");
    });
   
    jQuery("#faculty, #discipline, #study_year, #study_group").change(function() {
        if (jQuery(this).attr("id") == "faculty") {
            var data = {
                prefix: 'Discipline',
                value: jQuery("#faculty option:selected").attr("value")            
            }
            var element = jQuery("#discipline");
        }
        if (jQuery(this).attr("id") == "discipline") {            
            var element = jQuery("#study_year");
        }
        if (jQuery(this).attr("id") == "study_year") {
            var data = {
                prefix: 'StudyGroup',
                value: jQuery("#discipline option:selected").attr("value")            
            }
            var element = jQuery("#study_group");
        }                
        
        if (data) {
            jQuery.ajax({
                url: "/euba-rozvrh/home/filter",
                type: "POST",
                dataType: "json",
                data: data,
                success: function(options) {
                    element.empty();
                    for (var i in options) {
                        element.append(options[i]);                    
                    }                
                }
            });
        }
        if (element) {
            element.removeAttr("disabled");
        }                
    })        
});
</script>

</head>
<link href="css/propertyView.css" rel="stylesheet">
<div id="propertyLinks">
    <div class="link trulia"><a href="http://www.trulia.com/submit_search/?hsb=1&tst=h&locationId=&pid=&propertyIndex=&ac_index=&ac_entered_query=&topnav_extra=&display=&q=&search={$property.HouseNumber}+{$property.Street}+{$property.City}%2C+{$property.State}+{$property.Zip}" target="_blank"><img src="images/icon_trulia.png" alt="Trulia" /></a></div>
    <div class="link zillow"><a href="http://www.zillow.com/homes/{$property.HouseNumber}-{$property.Street}-{$property.City}%2C-{$property.State}-{$property.Zip}_rb/" target="_blank"><img src="images/icon_zillow.png" alt="Zillow" /></a></div>
    <div class="link county"></div>
</div>
<div class='PropertyInfo' data-property="{$property|json_encode|escape}">
    <ul class='propertyImages' id='propertyImages'>
        {foreach from=$property.Images item=image}
            <li><a target="_blank" href="images/properties/{$image.File}"><img src='images/properties/thumb_{$image.File}' title='{$image.Name}'/></a></li>
        {/foreach}
        <li id='addImage' class='addImage'>
            <img src='images/add-image.png' />
        </li>
    </ul>
    <div class="panel panel-default Step Notes" style='margin-left: 520px;'>
        <div class="panel-heading">To do list</div>
        <div class="panel-body">
            <div class="list-group">
                {foreach from=$property.Steps item=step}
                <a href="#" class="list-group-item StepItem{if $step.CompletedOn} Completed{/if}" data-step='{$step|json_encode|escape}'>
                    <span class="shortDueDate">{if $step.DueDate}{$step.DueDate}{/if}</span>
                    <span class="shortStartedDate">{if $step.StartedOn}{$step.StartedOn}{/if}</span>
                    <span class="shortCompletedDate">{if $step.CompletedOn}{$step.CompletedOn}{/if}</span>
                    <div class="StepShort">
                        <h4 class="list-group-item-heading StepName">{$step.Name}</h4>
                        <p class="list-group-item-text shortDescription">{$step.Description|truncate:60:"...":true}</p>
                    </div>
                    <div class="additionalDetails">
                        <form >
                            <div class="form-group">
                                <label for="args[name]">Title</label>
                                <input type="text" name="args[name]" class="form-control list-group-item-heading StepName" value="{$step.Name}" />
                            </div>
                            <div class="form-group">
                                <label for="args[desc]">Description</label>
                                <textarea class="form-control list-group-item-text fullDescription" style="height:200px;" name="args[desc]">{$step.Description}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="args[duedate]">Due Date</label>
                                <div class='input-group date duedatepicker'>
                                    <input type='text' class="form-control" name='args[duedate]' value="{$step.DueDate}" />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="args[starton]">Start Date</label>
                                <div class='input-group date startdatepicker'>
                                    <input type='text' class="form-control" name='args[starton]' value="{$step.StartedOn}" />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="args[completedon]">Completed Date</label>
                                <div class='input-group date completeddatepicker'>
                                    <input type='text' class="form-control" name='args[completedon]' value="{$step.CompletedOn}" />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <p class="list-group-item-text fullAssignedTo"></p>
                        </form>
                    </div>
                </a>
                {/foreach}
                <a href="#" id='AddStep' class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading">Add Task</h4>
                </a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="AddressEdit" tabindex="-1" role="dialog" aria-labelledby="addressLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="addressLabel">Edit Address Information</h4>
      </div>
      <div class="modal-body">
        <form action="json.php" method="post" enctype="multipart/form-data" id="EditAddress">
            <div class='form-group'>
                <input type='hidden' name='mod' value='Plugins\Main' />
                <input type='hidden' name='cmd' value='EditAddress' />
                <input type="hidden" name="args[HouseNumber]" value="{$property.HouseNumber}" />
                <input type="hidden" name="args[Street]" value="{$property.Street}" />
                <input type="hidden" name="args[Zip]" value="{$property.Zip}" />
                <input type="hidden" name="args[Zip4]" value="{$property.Zip4}" />
                <input type='hidden' name='args[pid]' value='{$property.ID}' />
                <div class='form-group'>
                    <label for="args[state]" style='width:100px;'>Tag Line</label>
                    <input type='text' name='args[TagLine]' value='{$property.TagLine}' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <label for="args[housenumber]" style='width:100px;'>Address</label>
                    <input type='text' id="tmpstreet" name='args[tmpstreet]' value='{$property.HouseNumber} {$property.Street}' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <label for="args[parcelid]" style='width:100px;'>Parcel ID</label>
                    <input type='text' name='args[ParcelID]' value='{$property.ParcelID}' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <label for="args[city]" style='width:100px;'>City</label>
                    <input type='text' name='args[City]' value='{$property.City}' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <div class='col-sm-2'>
                        <label for="args[state]" style='width:100px;'>State</label>
                        <input type='text' name='args[State]' value='{$property.State}' class="form-control" style="text-transform: uppercase" />
                    </div>
                    <div class='col-sm-4'>
                        <label for="args[zip]" style='width:100px;'>Zip Code</label>
                        <input type='text' name='args[zips]' value='{$property.Zip}{if $property.Zip4}-{$property.Zip4}{/if}' class="form-control" style="text-transform: uppercase" />    
                    </div>
                    <div class='col-sm-6'>
                        <label for="args[county]" style='width:100px;'>County</label>
                        <input type='text' name='args[County]' value='{$property.County}' class="form-control" style="text-transform: uppercase" />
                    </div>
                </div>
                <div class='form-group'>
                    
                </div>
                <div class='form-group'>
                    <label for="args[legaldesc]">Legal Description</label>
                    <textarea name='args[LegalDescription]' class="form-control" style='text-transform: uppercase;width:100%;height:200px;'>{$property.LegalDescription}</textarea>
                </div>
            </div>
        </form>
        <div id="output"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="SaveAddress" data-loading-text="Saving...">Save</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="fotoUpload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Photo Upload</h4>
      </div>
      <div class="modal-body">
        <form action="json.php" method="post" enctype="multipart/form-data" id="MyUploadForm">
            <div class='form-group'>
                <input type='hidden' name='mod' value='Plugins\ImageUpload' />
                <input type='hidden' name='cmd' value='UploadImages' />
                <input type='hidden' name='args[pid]' value='{$property.ID}' />
                <input name="images[]" id="imageInput" type="file" />
                <label for="args[weight]">Make Default?</label>
                <input type='checkbox' name='args[weight]' value='5000' /><br />
                <label for="args[name]">Description</label>
                <input type='text' name='args[name]' value='' /><br />
                <input type="submit" id="submit-btn" value="Upload" class="btn btn-primary" />
                <img src="images/ajax-loader.gif" id="loading-img" style="display:none;" alt="Please Wait"/>
            </div>
        </form>
        <div id="output"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--<button type="button" class="btn btn-primary">Upload</button>-->
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="AddStepModal" tabindex="-1" role="dialog" aria-labelledby="addStepLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="addStepLabel">Add Task</h4>
      </div>
      <div class="modal-body">
        <form action="json.php" method="post" enctype="multipart/form-data" id="AddStepForm">
            <div class='form-group'>
                <input type='hidden' name='mod' value='Plugins\Main' />
                <input type='hidden' name='cmd' value='addStep' />
                <input type='hidden' name='args[pid]' value='{$property.ID}' />
                <div class='form-group'>
                    <label for="args[name]">Title</label>
                    <input type='text' class='form-control' name='args[name]' style='text-transform:uppercase;' />
                    <!--<textarea name='args[desc]' class="form-control" style='text-transform: uppercase;width:100%;height:200px;'></textarea>-->
                </div>
                <div class='form-group'>
                    <label for="args[starton]">Start On</label>
                    <div class='input-group date' id='datetimepicker2'>
                        <input type='text' class="form-control" name='args[starton]' />
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
                <div class='form-group'>
                    <label for="args[duedate]">Due Date</label>
                    <div class='input-group date' id='datetimepicker1'>
                        <input type='text' class="form-control" name='args[duedate]' />
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
                <div class='form-group'>
                    <label for="args[desc]">Description</label>
                    <textarea name='args[desc]' class="form-control" style='text-transform: uppercase;width:100%;height:200px;'></textarea>
                </div>
            </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" data-loading-text="Adding..." id='AddStepFormBtn'>Add Task</button>
      </div>
    </div>
  </div>
</div>
<pre>{$test}</pre>
<script type="text/javascript" src="js/form-master/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
    var options = { 
            //target:   '#output',   // target element(s) to be updated with server response 
            dataType:'json',
            beforeSubmit:  beforeSubmit,  // pre-submit callback 
            resetForm: true,        // reset the form after successful submit 
            success: function (responseTxt) {
                $('#submit-btn').show(); //hide submit button
                $('#loading-img').hide(); //hide submit button
                $("#output").html("Upload successful."); 
                for(var img in responseTxt) {
                    var li = $('<li><img src="'+responseTxt[img].success+'" title="'+responseTxt[img].info.Name+'" /></li>');
                    var bTarget = $('#propertyImages li:'+((responseTxt[img].info.Weight+0 > 1000) ? 'first':'last'));
                    bTarget.before(li);
                }
            }
        }; 
    $('.page-header').click(function () {
        $('#AddressEdit').modal('show');
    });
    $('#propertyImages li').click(function () {
        if($(this).hasClass('addImage')) {
            $('#fotoUpload').modal('show');
        } else {
            $(this).data('imgsrc');
        }
    });
    $('.StepItem').each(function () {
        var s = $(this).data('step');
        var m;
        var now = moment();
        if(s.DueDate) {
            m = moment(s.DueDate);
            $(".shortDueDate", this).html("due "+m.from(now));
            $(".fullDueDate", this).html("due "+m.format("llll")+" ("+m.from(now)+")");
        }
        if(s.CompletedOn) {
            m = moment(s.CompletedOn);
            $(".shortCompletedDate", this).html("due "+m.from(now));
            $(".fullCompletedDate", this).html("completed "+m.format("llll")+" ("+m.from(now)+")");
        }
        if(s.StartedOn) {
            var m = moment(s.StartedOn);
            $(".shortStartedDate", this).html("start"+(m.diff(now) > 0 ? "s":"ed")+" "+m.from(now));
            $(".fullStartedDate", this).html("start"+(m.diff(now) > 0 ? "s":"ed")+" on "+m.format("llll")+" ("+m.from(now)+")");
        }
        $(this).addClass('list-group-item-success');
        console.log(s);
    }).click(function () {
        if(!$(".additionalDetails",this).is(":visible")) {
            $(".StepItem .StepShort").show(0);
            $(".StepItem .additionalDetails").hide(200);
            $(".StepShort", this).hide(0);
            $(".additionalDetails", this).show(200);
        }
        return false;
    });
    $('#datetimepicker1, #datetimepicker2').datetimepicker({ format: "YYYY-MM-DD HH:mm" });
    $('#fotoUpload').modal({ show:false });
    $('#AddressEdit').modal({ show:false });
    $('#AddStepModal').modal({ show:false });
    $('#AddStep').click(function () {
        $('#AddStepModal').modal('show');
        return false;
    });
    $('#AddStepFormBtn').click(function () {
        $('#AddStepForm input,textarea').each(function () { if(this.name.substring(0,5) === 'args[') { this.value = this.value.toUpperCase(); } });
        $('#AddStepFormBtn').button('loading');
        $('#AddStepForm').submit();
    });
    $('#AddStepForm').submit(function () {
        $(this).ajaxSubmit({
            //target:   '#output',   // target element(s) to be updated with server response 
            dataType:'json',
            beforeSubmit:  function (arr, $form, options) {
                console.log(arr, $form, options); 
            },  // pre-submit callback 
            resetForm: false,        // reset the form after successful submit 
            success: function (responseTxt) {
                
                $('#AddStepFormBtn').button('reset');
                $('#AddStepModal').modal('hide');
                console.log(responseTxt);
                
                location.reload();
            }
        });
        return false;
    });
    $('#SaveAddress').click(function () {
        $('#EditAddress input,textarea').each(function () { if(this.name.substring(0,5) === 'args[') { this.value = this.value.toUpperCase(); } });
        var fullStreet = $('#tmpstreet').val().trim();
        $('input[name="args[HouseNumber]"]').val(fullStreet.substring(0, fullStreet.indexOf(' ')));
        $('input[name="args[Street]"]').val(fullStreet.substring(fullStreet.indexOf(' ')+1));
        var zips = $('input[name="args[zips]"]').val().split('-');
        $('input[name="args[Zip]"]').val(zips[0]);
        if(zips.length > 1) {
            $('input[name="args[Zip4]"]').val(zips[1]);
        }
        $('#SaveAddress').button('loading');
        $('#EditAddress').submit();
    });
    $('#EditAddress').submit(function () {
        $(this).ajaxSubmit({
            //target:   '#output',   // target element(s) to be updated with server response 
            dataType:'json',
            beforeSubmit:  function (arr, $form, options) {
                console.log(arr, $form, options); 
            },  // pre-submit callback 
            resetForm: false,        // reset the form after successful submit 
            success: function (responseTxt) {
                
                $('#SaveAddress').button('reset');
                $('#AddressEdit').modal('hide');
                console.log(responseTxt);
                
                location.reload();
            }
        });
        return false;
    });
     $('#MyUploadForm').submit(function() { 
            $(this).ajaxSubmit(options);  //Ajax Submit form            
            // return false to prevent standard browser submit and page navigation 
            return false; 
        }); 
        //function to check file size before uploading.
function beforeSubmit(){
    //check whether browser fully supports all File API
   if (window.File && window.FileReader && window.FileList && window.Blob)
    {
        
        if( !$('#imageInput').val()) //check empty input filed
        {
            $("#output").html("Please select an image to upload first.");
            return false;
        }
        
        var fsize = $('#imageInput')[0].files[0].size; //get file size
        var ftype = $('#imageInput')[0].files[0].type; // get file type
        

        //allow only valid image file types 
        switch(ftype)
        {
            case 'image/png': case 'image/gif': case 'image/jpeg': case 'image/pjpeg':
                break;
            default:
                $("#output").html("<b>"+ftype+"</b> Unsupported file type!");
                return false
        }
        
        //Allowed file size is less than 1 MB (1048576)
        if(fsize>10485760) 
        {
            $("#output").html("<b>"+fsize +"</b> Too big Image file! <br />Please reduce the size of your photo using an image editor.");
            return false
        }
                
        $('#submit-btn').hide(); //hide submit button
        $('#loading-img').show(); //hide submit button
        $("#output").html("");  
    }
    else
    {
        //Output error to older browsers that do not support HTML5 File API
        $("#output").html("Please upgrade your browser, because your current browser lacks some new features we need!");
        return false;
    }
}
});</script>
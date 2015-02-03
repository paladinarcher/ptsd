<link href="css/propertyView.css" rel="stylesheet">
<div id="propertyLinks">
    <div class="link trulia"><a href="http://www.trulia.com/submit_search/?hsb=1&tst=h&locationId=&pid=&propertyIndex=&ac_index=&ac_entered_query=&topnav_extra=&display=&q=&search={$property.HouseNumber}+{$property.Street}+{$property.City}%2C+{$property.State}+{$property.Zip}" target="_blank"><img src="images/icon_trulia.png" alt="Trulia" /></a></div>
    <div class="link zillow"><a href="http://www.zillow.com/homes/{$property.HouseNumber}-{$property.Street}-{$property.City}%2C-{$property.State}-{$property.Zip}_rb/" target="_blank"><img src="images/icon_zillow.png" alt="Zillow" /></a></div>
    <div class="link county"></div>
</div>
<div class='PropertyInfo' data-property="{$property|json_encode}">
    <ul class='propertyImages' id='propertyImages'>
        {foreach from=$property.images item=image}
            <li><a target="_blank" href="images/properties/{$image.File}"><img src='images/properties/thumb_{$image.File}' title='{$image.Name}'/></a></li>
        {/foreach}
        <li id='addImage' class='addImage'>
            <img src='images/add-image.png' />
        </li>
    </ul>
</div>
<div class="modal fade" id="AddressEdit" tabindex="-1" role="dialog" aria-labelledby="addressLavel" aria-hidden="true">
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
    $('#fotoUpload').modal({ show:false });
    $('#AddressEdit').modal({ show:false });
    $('#SaveAddress').click(function () {
        $('#EditAddress input,textarea').each(function () { if(this.name.substring(0,5) == 'args[') { this.value = this.value.toUpperCase(); } });
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
<link href="css/propertyView.css" rel="stylesheet">
<div class='PropertyInfo'>
    <ul class='propertyImages' id='propertyImages'>
        {foreach from=$property.images item=image}
            <li><img src='images/properties/{$image.File}' title='{$image.Name}'/></li>
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
        <h4 class="modal-title" id="addressLabel">Photo Upload</h4>
      </div>
      <div class="modal-body">
        <form action="json.php" method="post" enctype="multipart/form-data" id="EditAddress">
            <div class='form-group'>
                <input type='hidden' name='mod' value='Plugins\Main' />
                <input type='hidden' name='cmd' value='EditAddress' />
                <input type='hidden' name='args[pid]' value='{$property.ID}' />
                <label for="args[weight]">Make Default?</label>
                <input type='checkbox' name='args[weight]' value='5000' /><br />
                <label for="args[name]">Description</label>
                <input type='text' name='args[name]' value='' /><br />
            </div>
        </form>
        <div id="output"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save</button>
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
    $('#propertyImages li').click(function () {
        if($(this).hasClass('addImage')) {
            $('#fotoUpload').modal({
                
            }).modal('show');
        } else {
            
        }
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
      <div class="row">
        {foreach from=$properties item=property}
        <div class="col-md-6">
            <div class='propertyCard thumbnail' data-property='{$property|json_encode}'>
                {if $property.ImageFile[0]}
              <img data-src="holder.js/150x84" class="img-thumbnail" alt="150x84" src="images/properties/icon_{$property.ImageFile[0]}" data-holder-rendered="true" style="width: 150px; height: 84px;">
                {else}
              <img data-src="holder.js/150x84" class="img-thumbnail" alt="150x84" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjxkZWZzLz48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9Ijc1LjUiIHk9IjEwMCIgc3R5bGU9ImZpbGw6I0FBQUFBQTtmb250LXdlaWdodDpib2xkO2ZvbnQtZmFtaWx5OkFyaWFsLCBIZWx2ZXRpY2EsIE9wZW4gU2Fucywgc2Fucy1zZXJpZiwgbW9ub3NwYWNlO2ZvbnQtc2l6ZToxMHB0O2RvbWluYW50LWJhc2VsaW5lOmNlbnRyYWwiPjIwMHgyMDA8L3RleHQ+PC9nPjwvc3ZnPg==" data-holder-rendered="true" style="width: 150px; height: 84px;">
                {/if}
              <div class='address'>
                  <span class='streetNumber'>{$property.HouseNumber}</span> <span class='streetName'>{$property.Street}</span><br />
                  <span class='city'>{$property.City}</span>, <span class='state'>{$property.State}</span> <span class='zip'>{$property.Zip}</span>{if $property.Zip4}-<span class='zip4'>{$property.Zip4}</span>{/if}
              </div>
              <div class='owners'>{$property.Owners}</div>
              <div class='tagLine'>{$property.TagLine}</div>
              <div class='nextStep'></div>
            </div>
        </div>
        {/foreach}
      </div>
<div class="modal fade" id="AddressAdd" tabindex="-1" role="dialog" aria-labelledby="addressLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="addressLabel">Add Address Information</h4>
      </div>
      <div class="modal-body">
        <form action="json.php" method="post" enctype="multipart/form-data" id="AddAddress">
            <div class='form-group'>
                <input type='hidden' name='mod' value='Plugins\Main' />
                <input type='hidden' name='cmd' value='AddAddress' />
                <input type="hidden" name="args[HouseNumber]" value="" />
                <input type="hidden" name="args[Street]" value="" />
                <input type="hidden" name="args[Zip]" value="" />
                <input type="hidden" name="args[Zip4]" value="" />
                <div class='form-group'>
                    <label for="args[state]" style='width:100px;'>Tag Line</label>
                    <input type='text' name='args[TagLine]' value='' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <label for="args[housenumber]" style='width:100px;'>Address</label>
                    <input type='text' id="tmpstreet" name='args[tmpstreet]' value='' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <label for="args[parcelid]" style='width:100px;'>Parcel ID</label>
                    <input type='text' name='args[ParcelID]' value='' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <label for="args[city]" style='width:100px;'>City</label>
                    <input type='text' name='args[City]' value='' class="form-control" style="text-transform: uppercase" />
                </div>
                <div class='form-group'>
                    <div class='col-sm-2'>
                        <label for="args[state]" style='width:100px;'>State</label>
                        <input type='text' name='args[State]' value='' class="form-control" style="text-transform: uppercase" />
                    </div>
                    <div class='col-sm-4'>
                        <label for="args[zip]" style='width:100px;'>Zip Code</label>
                        <input type='text' name='args[zips]' value='' class="form-control" style="text-transform: uppercase" />    
                    </div>
                    <div class='col-sm-6'>
                        <label for="args[county]" style='width:100px;'>County</label>
                        <input type='text' name='args[County]' value='' class="form-control" style="text-transform: uppercase" />
                    </div>
                </div>
                <div class='form-group'>
                    
                </div>
                <div class='form-group'>
                    <label for="args[legaldesc]">Legal Description</label>
                    <textarea name='args[LegalDescription]' class="form-control" style='text-transform: uppercase;width:100%;height:200px;'></textarea>
                </div>
            </div>
        </form>
        <div id="output"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="SaveAddress" data-loading-text="Adding...">Add</button>
      </div>
    </div>
  </div>
</div>
      <script language="javascript">
        var PTSD = {};
        PTSD.Properties = {$properties|json_encode};

        $(document).ready(function () {
            $('div.propertyCard').click(function () {
                console.log($(this).data('property'));
                window.location = "?mod=Plugins\\Main&cmd=showProperty&args[pid]="+$(this).data('property').ID;
            });
            $('#AddNewAddress').click(function () {
                $('#AddressAdd').modal('show');
            });
            $('#AddressAdd').modal({ show:false });
            $('#SaveAddress').click(function () {
                $('#AddressAdd input,textarea').each(function () { if(this.name.substring(0,5) === 'args[') { this.value = this.value.toUpperCase(); } });
                var fullStreet = $('#tmpstreet').val().trim();
                $('input[name="args[HouseNumber]"]').val(fullStreet.substring(0, fullStreet.indexOf(' ')));
                $('input[name="args[Street]"]').val(fullStreet.substring(fullStreet.indexOf(' ')+1));
                var zips = $('input[name="args[zips]"]').val().split('-');
                $('input[name="args[Zip]"]').val(zips[0]);
                if(zips.length > 1) {
                    $('input[name="args[Zip4]"]').val(zips[1]);
                }
                $('#SaveAddress').button('loading');
                $('#AddressAdd').submit();
            });
            $('#AddressAdd').submit(function () {
                $(this).ajaxSubmit({
                    //target:   '#output',   // target element(s) to be updated with server response 
                    dataType:'json',
                    beforeSubmit:  function (arr, $form, options) {
                        console.log(arr, $form, options); 
                    },  // pre-submit callback 
                    resetForm: false,        // reset the form after successful submit 
                    success: function (responseTxt) {
                
                        $('#SaveAddress').button('reset');
                        $('#AddressAdd').modal('hide');
                        console.log(responseTxt);
                
                        location.reload();
                    }
                });
                return false;
            });
        });
      </script>
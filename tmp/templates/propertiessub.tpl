      <div class="row">
        {foreach from=$properties item=property}
        <div class="col-md-6">
            <div class='propertyCard thumbnail' data-property='{$property|json_encode}'>
              <img data-src="holder.js/150x84" class="img-thumbnail" alt="150x84" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjxkZWZzLz48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9Ijc1LjUiIHk9IjEwMCIgc3R5bGU9ImZpbGw6I0FBQUFBQTtmb250LXdlaWdodDpib2xkO2ZvbnQtZmFtaWx5OkFyaWFsLCBIZWx2ZXRpY2EsIE9wZW4gU2Fucywgc2Fucy1zZXJpZiwgbW9ub3NwYWNlO2ZvbnQtc2l6ZToxMHB0O2RvbWluYW50LWJhc2VsaW5lOmNlbnRyYWwiPjIwMHgyMDA8L3RleHQ+PC9nPjwvc3ZnPg==" data-holder-rendered="true" style="width: 150px; height: 84px;">
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
      <script language="javascript">
        var PTSD = {};
        PTSD.Properties = {$properties|json_encode};

        $(document).ready(function () {
            $('div.propertyCard').click(function () {
                console.log($(this).data('property'));
                window.location = "?mod=Plugins\Main&cmd=showProperty&args[pid]="+$(this).data('property').ID;
            });
        });
      </script>
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  $("#command").submit(function(){
    $.post(
      "/shell/", 
      { command: $("#command_command").val(), authenticity_token: encodeURIComponent( AUTH_TOKEN ) },
      function(data){ 
        $("#command_command").attr('value', ''); 
        var result = JSON.parse(data, function(key, value) {
            var type;
            if (value && typeof value === 'object') {
                type = value.type;
                if (typeof type === 'string' && typeof window[type] === 'function') {
                    return new (window[type])(value);
                }
            }
            return value;
        });
        $(".result").append(result.result);
        $("#command_command").scrollTo();
      }
    );
  });
});

function checkJson(key, value) {
    var type;
    if (value && typeof value === 'object') {
        type = value.type;
        if (typeof type === 'string' && typeof window[type] === 'function') {
            return new (window[type])(value);
        }
    }
    return value;
}
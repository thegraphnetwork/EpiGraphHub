Shiny.addCustomMessageHandler('anim',
 function(x){

    var $box = $('#' + x.id + ' div.small-box');
    var value = x.value;

    var $icon = $box.find('i.fa');
    if(value <= 10 && $icon.hasClass('fa-arrow-up')){
      $icon.removeClass('fa-arrow-up').addClass('fa-arrow-down');
    }
    if(value > 10 && $icon.hasClass('fa-arrow-down')){
      $icon.removeClass('fa-arrow-down').addClass('fa-arrow-up');
    }

    var $s = $box.find('div.inner h3');
    var o = {value: 0};
    $.Animation( o, {
        value: value
      }, {
        duration: 1500
      }).progress(function(e) {
          $s.text('$' + (e.tweens[0].now).toFixed(1));
    });

  }
);
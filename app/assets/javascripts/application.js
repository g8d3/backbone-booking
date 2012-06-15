//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require underscore
//= require backbone
//= require hamlcoffee
//= require libs/will_pickdate
//= require booking
//= require bootstrap
//= require_tree .

jQuery(document).ready(function(){
    booking = new Booking();
});

$.fn.serializeObject = function(){
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

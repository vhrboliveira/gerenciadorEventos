/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $("#enable-unico").click(function () {
        // habilita o campo 
        $('div#unico').find(':input').prop('disabled', false);
        //$('div#multiplo').find(':input').prop('disabled', true);
        $('div#periodico').find(':input').prop('disabled', true);
    });
    $("#enable-periodico").click(function () {
        // habilita o campo 
        $('div#unico').find(':input').prop('disabled', true);
        //$('div#multiplo').find(':input').prop('disabled', true);
        $('div#periodico').find(':input').prop('disabled', false);
    });
});
$(function () {
    display(false)
    function display(bool) {
        if (bool) {
            $("#ffa2").fadeIn();
        } else {

            $("#ffa2").fadeOut();
        }
    }


    window.addEventListener('message', function(event) {
        var item = event.data;

            if (item.status == true) {
                display(true)
            $('.anzahl-getötet').text(item.plinks);
            $('.anzahl-gestorben').text(item.prechts);
            $('.anzahl-killstreak').text(item.bombe);


                
            } else {
                display(false)
                $('.kasten-autos').empty();
            }
        })  
    })
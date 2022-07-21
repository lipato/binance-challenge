let myvar = ""
$(document).ready(function () {
    $.getJSON('/top_symbols', {symbols:'BTC', field: 'volume'}, function (data){
        let content = ""
        $.each(data, function( index ){
            content = content + '<tr><th scope="row">' + (index+1) + '</th><td>' +
                this.symbol + '</td><td>' + this.volume + '</td></tr>';
        });
        $('#top_symbols_btc').html(content);
    });
    $.getJSON('/top_symbols', {symbols:'USDT', field: 'count'}, function (data){
         let content = ""
         $.each(data, function( index ){
            content = content + '<tr><th scope="row">' + (index+1) + '</th><td>' +
                this.symbol + '</td><td>' + this.volume + '</td></tr>';
        });
        $('#top_symbols_usdt').html(content);
    });
   $.getJSON('/notional_value', {symbols:'BTC', field: 'volume'}, function (data){
        let content = ""
        $.each(data, function( index ){
            content = content + '<tr><th scope="row">' + (index+1) + '</th><td>' +
                this.symbol + '</td><td>' + this.bids + '</td><td>' + this.asks + '</td></tr>';
        });
        $('#notional_value').html(content);
    });
   let old_data = {};
   $.getJSON('/price_spread', {symbols:'USDT', field: 'count'}, function (data){
        let content = ""
        $.each(data, function( index ){
            content = content + '<tr><th scope="row">' + (index+1) + '</th><td>' +
                this.symbol + '</td><td>' + this.price_spread + '</td></tr>';
        });
        $('#price_spread').html(content);
        old_data = data
    });
   setInterval(function(){
        $.ajax({
            type: "POST",
            url: "/spread_delta",
            contentType: 'application/json;charset=UTF-8',
            data: JSON.stringify({symbols:'USDT', field: 'count', old_spread: old_data}),
            success: function (data) {
                let content = ""
                $.each(data.items, function( index ){
                    let abs_delta_pos = ""
                    if (Math.sign(this.absolute_delta)>0) abs_delta_pos = 'class="table-success"'
                    if (Math.sign(this.absolute_delta)<0) abs_delta_pos = 'class="table-danger"'
                    content = content + '<tr><th scope="row">' + (index+1) + '</th><td>' +
                        this.symbol + '</td><td>' + this.price_spread + '</td><td ' +
                        abs_delta_pos  + '>' + this.absolute_delta + '</td></tr>';
                });
                $('#spread_delta').html(content);
            }
        });
      $.get('/metrics', {}, function (data){
            let content = ""
            myvar = data
            console.log(data)
            content = content + '<tr><th scope="row">#</th><td scope="row"><div>' + data.replace(/(?:\r\n|\r|\n)/g, '<br>') + '</div></td></tr>';
            $('#prometheus').html(content);
    });
   }, 10000);
});
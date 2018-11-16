var MongoClient = require ('mongodb');

function serveMe(items,logInfo){
    var http = require('http');
    http.createServer(function (req, res) {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.write(logInfo+'<br/><br/>');

        items.forEach(r =>{
            res.write(`<strong>${r.currency} - ${r.rate}</strong><br/>`);
            });
        res.end();
    }).
    listen(8080).on("listening", _ => {console.log('application listening on localhost, port 8080')});
}

MongoClient.connect('mongodb://localhost:30017/', function(err, db){
        var dbo = db.db("test");
        dbo.collection("rates").find({}).toArray(function(err, items){
            if(err) throw err;
            db.close();
            if(items.length==0) {
                var request = require('request');
                request("https://api.exchangeratesapi.io/latest", function(error, response, body) {
                   
                  var rates = JSON.parse(body).rates;

                   items =
                   Object.keys(rates).map(o =>{ return{currency:o, rate:rates[o]}; });

                   serveMe(items, `REST call: ${items.length} items found.`);

                });
            } else {
                serveMe(items, `MongoDB: ${items.length} items found`);
            }

        });
});
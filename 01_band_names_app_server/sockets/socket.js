
const {io} = require("../index.js");
const Band = require("../models/band.js");
const Bands = require("../models/bands");

const bands = new Bands();

bands.addBand(new Band("Queen"));
bands.addBand(new Band("Heroes del silencio"));
bands.addBand(new Band("Bon Jovi"));

io.on('connection', client => {
    let clientId = client.id;
    console.log("Cliente",clientId," conectado");

    client.emit('active-bands', bands.getBands());

    client.on('vote-band',(payload)=>{
        bands.voteBand(payload['id']);
        io.emit('active-bands', bands.getBands());
    });

    client.on('add-band',(payload)=>{
        bands.addBand(new Band(payload['name']));
        io.emit('active-bands', bands.getBands());
    });

    client.on('delete-band',(payload)=>{
        bands.deleteBand(payload['id']);
        io.emit('active-bands', bands.getBands());
    });

    client.on('mensaje', (payload)=>{   //Escuchar mensaje
        console.log("Servidor recibio mensaje:", payload);

        io.emit('mensaje', {remitente: "Server", mensaje: payload});    /*Emitir a todos los sockets*/

    });

    client.on('emitir-mensaje', (payload)=>{   //Escuchar mensaje
        console.log("Servidor recibio mensaje:", payload);
        client.broadcast.emit("nuevo-mensaje", payload);    //enviar mensaje a todos los clientes, menos al que lo envia(servidor)
    });

    client.on('disconnect', () => {
        console.log("Cliente",clientId," desconectado");
    });
});
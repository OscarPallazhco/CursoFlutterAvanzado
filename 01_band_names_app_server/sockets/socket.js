
const {io} = require("../index.js")

io.on('connection', client => {
    let clientId = client.id;
    console.log("Cliente",clientId," conectado");

    client.on('mensaje', (payload)=>{   //Escuchar mensaje
        console.log("Servidor recibio mensaje:", payload);

        io.emit('mensaje', {remitente: "Server", mensaje: payload});    /*Emitir a todos los sockets*/

    });

    client.on('disconnect', () => {
        console.log("Cliente",clientId," desconectado");
    });
});
const express = require('express');
const path = require('path');
require('dotenv').config();

const port = process.env.PORT;
const app = express();

const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));

const server = require('http').createServer(app);
const io = require('socket.io')(server);
io.on('connection', client => {
    let clientId = client.id;
    console.log("Cliente",clientId," conectado");
    client.on('disconnect', () => {
        console.log("Cliente",clientId," desconectado");
    });
});



server.listen(port, (error) => {
    if (error) {
        throw new Error(error);
    }
    console.log('Server running on port: ', port);
});
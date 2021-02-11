const express = require('express');
const path = require('path');
require('dotenv').config();

const port = process.env.PORT;
const app = express();

const publicPath = path.resolve(__dirname, 'public');

app.use(express.static(publicPath));

app.listen(port, (error) => {
    if (error) {
        throw new Error(error);
    }
    console.log('Server running on port: ', port);
});
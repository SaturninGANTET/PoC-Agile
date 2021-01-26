const express = require('express');
const app = express();
const morgan = require('morgan');
const multer = require('multer');
const bodyParser = require("body-parser");
const path = require('path');

app.use(express.static('public'));
app.use(bodyParser.json());
app.use(morgan('short'));


app.listen(3004, () => {
    console.log(`Server is up and listening on port 3004...`);
});

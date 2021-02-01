const express = require('express');
const app = express();
const morgan = require('morgan');
const multer = require('multer');
const bodyParser = require("body-parser");
const path = require('path');

app.use(express.static('public'));
app.use(bodyParser.json());
app.use(morgan('short'));

const storage = multer.diskStorage({
        destination: function(req,file,cb){
                cb(null,"public/puush/");
        },
        filename: function(req,file,cb){
                cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
        }
});

app.post('/api/puush/up',(req,res) => {
     let upload = multer({ storage: storage}).single('image');
     upload(req, res, function(err) {
        if(req.fileValidationError) {
                return res.send(req.fileValidationError);
        } else if (!req.file) {
                return res.send('Please select an image to upload');
        } else if (err instanceof multer.MulterError){
                return res.send(err);
        } else if (err) {
                return res.send(err);
        }

        res.send(`http://satutu.ddns.net:3004/puush/${req.file.filename}`);
    });
});

app.listen(3004, () => {
    console.log(`Server is up and listening on port 3004...`);
});

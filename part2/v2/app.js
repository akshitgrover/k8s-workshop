const { RSA_NO_PADDING } = require('constants');
const http = require('http');
const os = require('os');

const server = http.createServer({}, (req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html' })
    res.write("<h1>Hi There,</h1>")
    res.write(`<h2><b>Host</b>: ${os.hostname()}</h2>`);
    res.write(`<h2><b>OS</b>: ${os.platform()} ${os.release()}</h2>`)
    res.write(`<h2><b>Arch</b>: ${os.arch()}</h2>`);
    res.end();
});

server.listen(process.env.PORT || "3000");

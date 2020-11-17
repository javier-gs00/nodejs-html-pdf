const express = require("express");
const pdf = require("html-pdf");
const fs = require("fs");
const path = require("path");

const targetPath = path.resolve("tmp");
const phantomPath = path.resolve(
  "node_modules",
  "phantomjs-prebuilt",
  "bin",
  "phantomjs"
);

const app = express();

app.get("/", (req, res) => {
  const html = fs.readFileSync("./example.html", "utf-8");
  pdf
    .create(html, {
      directory: targetPath,
      phantomPath: phantomPath,
    })
    .toStream((err, stream) => {
      if (err) {
        return res.status(500).send(err);
      }

      stream.pipe(res);
    });
});

app.listen(8000, () => console.log('app listening on port 8000'))


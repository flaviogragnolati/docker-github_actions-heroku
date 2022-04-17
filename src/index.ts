import express from 'express';
import config from './config';

const { secret, port } = config;

const app = express();

app.get('/', (req, res) => {
  return res.status(200).send(`Hello World!!!. This is a Secret ${secret}`);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

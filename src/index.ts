import express from 'express';
import config from './config';

const { secret, port, env } = config;

const app = express();

app.get('/', (req, res) => {
  return res.status(200).send(`Hello World!!!. This is a Secret ${secret}. The stage of this instances is: ${env}`);
});

app.get('/health', (req, res) => {
  return res.status(200).send(`OK.STAGE:${env}`);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

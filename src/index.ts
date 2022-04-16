import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();

const port = process.env.PORT || 6060;
const secret = process.env.SECRET || 'ENV NOT LOADED';

app.get('/', (req, res) => {
  return res.status(200).send(`Hello World!!!. This is a Secret ${secret}`);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

import dotenv from 'dotenv';

dotenv.config();

export default {
  secret: process.env.SECRET || 6060,
  port: process.env.PORT || 'ENV NOT LOADED',
};

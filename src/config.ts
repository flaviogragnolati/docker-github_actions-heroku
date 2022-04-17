import dotenv from 'dotenv';

dotenv.config();

export default {
  secret: process.env.SECRET || 'ENV NOT LOADED',
  port: process.env.PORT || process.env.SERVER_PORT || 6060,
};

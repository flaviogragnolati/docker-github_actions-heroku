# pull base img node (node v16.14.2 & Debian 11.1)
FROM node:16-bullseye as base
LABEL MANTAINER="<flavio.gragnolati@gmail.com>"



#  creates & sets working directory
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app

# set env variables
# ENV NODE_ENV=production
ENV NODE_ENV ${STAGE}

# Change to non root user
USER node

# install all the dependencies
# Copy package.json and lock files before other files
# Utilise Docker cache to save re-installing dependencies if unchanged
COPY package.json package-lock*.json yarn.lock ./
RUN yarn install --frozen-lockfile && yarn cache clean
# RUN npm install --production && npm cache clean --force // if using npm

# copy new files to working directory
COPY --chown=node:node . .

# Install PM2 globally
# RUN npm install --global pm2 // if using pm2

# Rebuild the source code only when needed
FROM base as builder
WORKDIR /home/node/app
COPY --from=base /home/node/app/node_modules ./node_modules
# COPY . .
RUN yarn build
# RUN npm run build // if using npm

# Production image, copy all the files and run next
FROM base as runner
WORKDIR /home/node/app

# copy files
COPY --from=builder /home/node/app/ ./

# Random port assigned by HEROKU
EXPOSE ${PORT}


# run
CMD ["node", "./dist/index.js"]
# CMD ["yarn", "start"] // Start with yarn
# CMD ["npm", "start"] // Start with npm
# CMD [ "pm2-runtime", "npm", "--", "start" ] //Start with pm2
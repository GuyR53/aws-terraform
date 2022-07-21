#base image for app
FROM node:14.19.1-alpine3.15

#create app directory
WORKDIR /bootcamp-app

#install all dependencies
COPY package*.json ./
RUN npm install

# adding source code into the image
COPY . .
ENV PORT=8080
EXPOSE 8080

#run tests if present
CMD ["npm","run","test", "--if-present"]

#intialize db and start the app in PID1 
ENTRYPOINT ["/bin/sh", "-c" , "npm run initdb && npm run dev"]

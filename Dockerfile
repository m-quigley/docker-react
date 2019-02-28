# Base image
# Specify that this is the builder phase
FROM node:alpine as builder 

# Copy files - everything from current working directory 
# simpleweb to current working directory inside the container
WORKDIR '/app'
COPY package.json .

# Install dependencies
RUN npm install
COPY . .
RUN npm run build


### NEXT PHASE ###
FROM nginx
EXPOSE 80

# Copy the built artefacts from a different phase into the nginx server folder
COPY --from=builder /app/build /usr/share/nginx/html
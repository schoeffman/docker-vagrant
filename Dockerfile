FROM schoeffman/docker-node-nvm

COPY ./scripts/ /src

VOLUME ["/code"]

EXPOSE  9000

#CMD curl -s https://gist.githubusercontent.com/schoeffman/82852fa9ff033e442cc6/raw/initialize.sh | bash
CMD ./src/initialize.sh 

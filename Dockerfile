FROM node:14-alpine

RUN mkdir app

WORKDIR /tmp
ENV PHANTOMJS_VERSION=2.1.1
RUN apk add --update --no-cache curl &&\                                                                                                                                                                      
  cd /tmp && curl -Ls https://github.com/dustinblackman/phantomized/releases/download/${PHANTOMJS_VERSION}/dockerized-phantomjs.tar.gz | tar xz &&\                                                           
  cp -R lib lib64 / &&\                                                                                                                                                                                       
  cp -R usr/lib/x86_64-linux-gnu /usr/lib &&\                                                                                                                                                                 
  cp -R usr/share/fonts /usr/share &&\                                                                                                                                                                        
  cp -R etc/fonts /etc &&\                                                                                                                                                                                    
  curl -k -Ls https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 | tar -jxf - &&\                                                                            
  cp phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs &&\                                                                                                                   
  rm -rf /tmp/* &&\                                                                                                                                                                                           
  apk del curl

WORKDIR app

COPY . .
RUN npm i --production

EXPOSE 8000
CMD ["npm", "start"]

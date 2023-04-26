FROM node:latest as first
RUN apt-get update -y
RUN apt install git -y
RUN apt install curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
CMD echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install yarn -y
RUN git clone https://github.com/yarnpkg/example-yarn-package.git
RUN yarn init -y
RUN yarn install

FROM first as second
WORKDIR "./example-yarn-package"
RUN yarn install
RUN apt-get update
RUN yarn run test

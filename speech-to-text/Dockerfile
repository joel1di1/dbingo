FROM node:17

RUN wget https://alphacephei.com/vosk/models/vosk-model-spk-0.4.zip && unzip vosk-model-spk-0.4.zip && mv vosk-model-spk-0.4 model-spk && rm vosk-model-spk-0.4.zip
RUN wget https://alphacephei.com/vosk/models/vosk-model-en-us-0.22.zip && unzip vosk-model-en-us-0.22.zip && mv vosk-model-en-us-0.22 model && rm vosk-model-en-us-0.22.zip

RUN apt install g++ gcc make
WORKDIR /usr/local
COPY process.js .

RUN npm install vosk

ENTRYPOINT node process.js


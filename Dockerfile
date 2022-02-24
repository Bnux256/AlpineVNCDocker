FROM alpine:edge

RUN echo http:"//dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && apk upgrade && apk add --no-cache \
  xvfb x11vnc fluxbox supervisor xterm bash wqy-zenhei novnc websockify

RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

ADD supervisord.conf /etc/supervisord.conf
# ADD menu /root/.fluxbox/menu
ADD entry.sh /entry.sh

RUN chmod +x /entry.sh

ENV DISPLAY :0
ENV RESOLUTION=1024x768

EXPOSE 5901 6901

ENTRYPOINT ["/bin/bash", "-c", "/entry.sh"]

FROM alpine:edge

# update upgrade and install dependencies
RUN echo http:"//dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && apk upgrade && apk add --no-cache \
  xvfb x11vnc fluxbox supervisor xterm bash wqy-zenhei novnc websockify

# create symlink for noVNC config
RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

# move new supervisord config
ADD supervisord.conf /etc/supervisord.conf
ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

ENV DISPLAY :0
ENV RESOLUTION=1024x768

EXPOSE 5900 6900

ENTRYPOINT ["/bin/bash", "-c", "/entry.sh"]

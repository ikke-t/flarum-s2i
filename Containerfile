FROM registry.access.redhat.com/ubi9/php-82

# Add application sources to a directory that the assemble script expects them
# and set permissions so that the container runs without root access
USER 0
# ADD app-src /tmp/src
RUN git clone https://github.com/flarum/flarum.git /tmp/src -b v1.8.1
ENV DOCUMENTROOT=/public

RUN chown -R 1001:0 /tmp/src
USER 1001

# Install the dependencies
RUN /usr/libexec/s2i/assemble

# Set the default command for the resulting image
CMD /usr/libexec/s2i/run

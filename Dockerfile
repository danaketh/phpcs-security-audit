FROM composer:latest

# add unpriviledged user and
# create directory for the code to be scanned
RUN addgroup -S tool && adduser -S -G tool tool && \
    mkdir -p /opt/mount/

# Install phpcs-security-audit
RUN composer global require danaketh/phpcs-security-audit
RUN /tmp/vendor/bin/phpcs --config-set installed_paths /tmp/vendor/danaketh/phpcs-security-audit/
WORKDIR /tmp

# change user
USER tool

ENTRYPOINT [ "/tmp/vendor/bin/phpcs", "--standard=/tmp/vendor/danaketh/phpcs-security-audit/example_base_ruleset.xml", "/opt/mount/"]

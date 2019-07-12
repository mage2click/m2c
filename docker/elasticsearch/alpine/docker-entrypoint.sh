#!/bin/bash

set -e

umask 0002

declare -a es_opts

while IFS="=" read -r env_key env_value
do
    if [[ "$env_key" =~ ^[a-z0-9_]+\.[a-z0-9_]+ ]]; then
        if [[ ! -z ${env_value} ]]; then
          es_opt="-E${env_key}=${env_value}"
          es_opts+=("${es_opt}")
        fi
    fi
done < <(env)

export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ -Xms64m -Xmx64m $ES_JAVA_OPTS"

if [[ "${1:0:1}" = "-" ]]
then
	set -- elasticsearch "$@"
fi

if [[ "$1" = "elasticsearch" && "$(id -u)" = "0" ]]
then
    mkdir -p /usr/share/elasticsearch/{data,logs,tmp}
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/{data,logs,tmp}

	set -- su-exec elasticsearch "$@" "${es_opts[@]}"
fi

exec "$@"
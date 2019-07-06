#!/bin/sh

set -e

varnishd -F -f ${VARNISH_VCL} -s malloc,${VARNISH_CACHE_SIZE} ${VARNISHD_OPTS}
#!/usr/bin/env bash

rake assets:clean ; \
	RAILS_ENV=production rake assets:precompile ; rake setcdn:gzip ; rake as3:upload ; rake setcdn:set ; rake assets:clean

#!/usr/bin/env bash

rake assets:clean ; \
			 RAILS_ENV=production rake assets:precompile ; \
			 rake as3:upload ; \
			 rake assets:clean

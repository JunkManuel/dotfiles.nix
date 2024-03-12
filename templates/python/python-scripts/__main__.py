#!/usr/bin/env python3

##################################################
###########    START of Template     #############
##################################################

#Help pages:
#   argparse -> https://docs.python.org/es/3/library/argparse.html
#   sys -> https://docs.python.org/es/3/library/sys.html
#   os -> https://docs.python.org/es/3/library/os.html
#   logging -> https://docs.python.org/es/3/library/logging.html

import os,sys,argparse,logging
import src.shared.functions as f

parser = argparse.ArgumentParser (
    prog= "Basic Script",
    description= "Does Something",
    epilog= "Some necesary info for the program"
)


##################################################
#########    START of custom args     ############
##################################################



##################################################
##########    END of custom args     #############
##################################################

group_loglvl = parser.add_mutually_exclusive_group()
group_loglvl.add_argument(
    '-v', '--verbose',                  # on/off flag
    action='store_true'
)
group_loglvl.add_argument(
    '-q', '--quiet',
    action='store_true'
)


args = parser.parse_args()
# args.filename, args.count, args.verbose

log_level= logging.INFO
if args.verbose:
    log_level= logging.DEBUG
if args.quiet:
    log_level= logging.FATAL

logging.basicConfig(
    # format="%(asctime)s [%(levelname)s] %(msg)s",
    format="({asctime}) {name:<30} [{levelname:>8}] --- {message}",
    style="{",
    datefmt="%Y-%m-%d %H:%M:%S",
    handlers=[
        # handlers.RotatingFileHandler(
        #     'app/logs/run.log',
        #     maxBytes=10*1024*1024,
        #     backupCount=10
        # ),
        logging.StreamHandler(stream=sys.stdout)
    ],
    level=log_level
)
log = logging.getLogger(name=__name__)

##################################################
###########     END of Template      #############
##################################################



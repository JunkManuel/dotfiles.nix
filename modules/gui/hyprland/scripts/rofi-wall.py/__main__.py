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
    prog= "rofi-wallapaper",
    description= "shows an interactiave menu to select a wallpaper and apply a colorscheme based on that wallpaper",
    epilog= "si lees esto sos jei"
)

parser.add_argument(
    'filename',                         # positional argument
    default=f.random_name(),
    nargs = "?"
)
# parser.add_argument('-c', '--count')    # option that takes a value
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

import src.rofi as rofi

code,i,res= rofi.select(prompt="sel",options=["12,123","añsdjf","añsdjf"])
if i != -1:
    log.info(res)

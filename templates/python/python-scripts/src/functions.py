#!/usr/bin/env python3

import logging,string,random,os
log = logging.getLogger(name= __name__)

def _random_name(lenght:int = 25):
    '''
    Produce a random string of `lenght` characters
    '''
    alphabet = string.ascii_lowercase
    out = "".join(
        random.choice(alphabet) for i in range(lenght)
    )

    log.debug(f"{_random_name.__name__}: {out}")
    return out

# Example:
# def mkdir(location:str = os.getcwd(), name: str = _random_name()):
#     '''
#     Usage:
#         mkdir(location,name)
#             - location = where to create the directory (default = current working directory)
#             - name = name of the directory (default = 20 first chars of a randomly generated hexadecimal dump of a sha512)
#     '''
#
#     path = os.path.join(location,name)
#
#     try: 
#         os.mkdir(path)
#         log.debug(f"New directory: {path}")
#     except KeyboardInterrupt:
#         log.error("Interrupted by user input")
#     except:
#         log.error("Shit gone wrong")

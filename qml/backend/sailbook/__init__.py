"""
Created on Fri Jan  6 19:02:42 2017

@author: Dylan Van Assche
@title: Init module
@description: Init Sailbook module
"""

#Sailbook modules
import logger, filemanager, constants

#Init our cache directories
for directory in constants.filemanager.cache_dirs:
    current_dir = filemanager.Directory(directory, constants.filemanager.path["XDG_CACHE_HOME"])
    current_dir.create()

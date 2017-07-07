# -*- coding: utf-8 -*-
"""
Created on Thu Mar 16 18:32:07 2017

@author: Dylan Van Assche
@title: Network
@description: Handle all network requests
"""

import requests, time, constants, logger, sfos

class _Connection(object):
    """
    Start the Network stack:
        * Check ConnMan network state
        * Check if we are connected and launch the connection dialog when disconnected
    """
    def __init__(self):
        connman_data = sfos.connman.read() 
        self._current_network = ""
        
        if connman_data["NetworkState"][0] == "connected":
            self._current_network = connman_data["NetworkType"][0]
            logger.log_to_file.debug("Connected")
        else:
            sfos.connection_manager.launch_connection_dialog()
            logger.log_to_file.debug("Not connected, launch connection dialog")
        logger.log_to_file.debug("Init Connection class")
    
        """
    Check the connection:
        * Refresh ConnMan network state
        * Create a new session when the 'NetworkType' has been changed (Mobile/WiFi)
        * Return True when connected or False and launch the connection dialog when disconnected when disconnected
    """    
    def status(self): # RUN THIS FROM __INIT__ + UPDATE NETWORK STATE AFTER REFRESH
        connman_data = sfos.connman.read()            
        if connman_data["NetworkState"][0] == "connected":
            if self._current_network != connman_data["NetworkType"][0]: #Network change
                self._current_network = connman_data["NetworkType"][0]
                return 1
            return 2
        else:
            sfos.connection_manager.launch_connection_dialog()
            return 0
        """
    Send:
        * Check the ConnMan network state, if offline sleep until network is back
        * Check the connection stability
        * Perform a HTTP POST request on our current session
        * Check if the request was accepted and correctly replied by the server
        * Return data when OK or False when request failed
    DEFAULT ARGUMENTS:
        * payload = None -> A payload is not always required so default empty dictionary
        * http_type = 0 -> POST is default, GET=1, PUT=2 and DELETE=3
        * files = None -> Files to upload for example images
    """   
    def send(self, url, http_type=constants.http.TYPE["GET"], files=None, raw=False):
        limit_execution = 50
        wait_since = time.clock()
        while(not self.status()): #Wait until network is available
            time.sleep(0.5)
            limit_execution += 1
            if limit_execution > 150: #Limit calls to SFOS Connection Manager and logging
                logger.log_to_file.debug("Network unavailable: WiFi and cellular connection deactivated, already waited: " + str(round(time.clock() - wait_since,6)) + "s for a connection")
                sfos.connection_manager.notify_connection_state(False)
        else:
            logger.log_to_file.debug("Network available, processing request after waiting: " + str(round(time.clock() - wait_since, 6)) + "s for a connection")
            sfos.connection_manager.notify_connection_state(True)

        if requests.get(constants.http.TEST["IPV4"]).status_code == constants.http.SUCCESS["OK"] or requests.get(constants.http.TEST["IPV6"]).status_code == constants.http.SUCCESS["OK"]: # Check connection
            sfos.connection_manager.notify_connection_state(True)            
            if http_type == constants.http.TYPE["POST"]:
                response = requests.post(url, files=files, headers=constants.sailbook.headers)
            elif http_type == constants.http.TYPE["GET"]:
                response = requests.get(url, files=files, headers=constants.sailbook.headers)
            elif http_type == constants.http.TYPE["PUT"]:
                response = requests.put(url, files=files, headers=constants.sailbook.headers)
            elif http_type == constants.http.TYPE["DELETE"]:
                response = requests.delete(url, files=files, headers=constants.sailbook.headers)
            elif http_type == constants.http.TYPE["HEAD"]:
                response = requests.head(url, files=files, headers=constants.sailbook.headers)
                
            if response.status_code in constants.http.SUCCESS.values():
                logger.log_to_file.info("HTTP request " + str(url) + " OK")
                if raw:
                    logger.log_to_file.debug("HTTP " + list(constants.http.TYPE.keys())[list(constants.http.TYPE.values()).index(http_type)] +" request completed in " + str(response.elapsed.total_seconds()) + "s: raw content")  
                    return response.content
                logger.log_to_file.debug("HTTP " + list(constants.http.TYPE.keys())[list(constants.http.TYPE.values()).index(http_type)] +" request completed in " + str(response.elapsed.total_seconds()) + "s", response.url)          
                return response.url
            else:
                logger.log_to_file.error("HTTP " + list(constants.http.TYPE.keys())[list(constants.http.TYPE.values()).index(http_type)] + " server returned bad HTTP code: " + str(response.status_code))
                return False
        else:
            logger.log_to_file.error("Network unavailable: ipv4.jolla.com or ipv6.jolla.com unreachable, aborting request")
            sfos.connection_manager.notify_connection_state(False)
            return False
        
connection = _Connection()
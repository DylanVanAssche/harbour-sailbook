# -*- coding: utf-8 -*-
"""
Created on Thu Mar  9 21:35:16 2017

@author: Dylan Van Assche
@title: App main
@description: Main Python script for Sailbook, all the actions are performed from this script.
"""

# Import Sailbook modules
from sailbook import scraper, youtube, network, sfos

class _Facebook(object):
    def __init__(self):
        pass
    
    def getNotifications(self, html):
        scraper.notifications.parse(html)
        
    def followReferal(self, link):
        return scraper.url.follow(link)
        
    def downloadAttachment(self, location, name, url):
        extension = "." + url.split("/")[5].split(".")[1] #Magic code that substracts the extension from the FB CDN download url
        return scraper.url.download(location, name, url, extension)
        
class _YoutubeDL(object):
    def __init__(self):
        pass
    
    def getStream(self, url):
        return youtube.stream.getUrl(url)
 
class _Gallery(object):
    def __init__(self):
        pass
    
    def save(self, location, name, url):
        return scraper.url.download(location, name, url)
        
class _Connection(object):
    def __init__(self):
        pass
    
    def status(self):
        sfos.asynchronous.notify("network", network.connection.status())
        return network.connection.status()
        
       
facebook = _Facebook()
youtubedl = _YoutubeDL()
gallery = _Gallery()
connection = _Connection()
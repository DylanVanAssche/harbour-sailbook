# -*- coding: utf-8 -*-
"""
Created on Thu Mar 16 12:08:46 2017

@author: Dylan Van Assche
@title: Scraper
@description: Scrape HTML data from given pages.
"""

from bs4 import BeautifulSoup
import sfos, network, filemanager, constants

class _Notifications(object):
    def __init__(self):
        pass

    def parse(self, html):
        soup = BeautifulSoup(html, 'html.parser')
        notifications = [0,0,0,0,0,0,0,0,0]
        for index, count in enumerate(soup.find_all("span", "_59tg")):
            notifications[index] = str(count.string)
        sfos.asynchronous.data("notifications", notifications)

class _URL(object):
    def __init__(self):
        pass
    
    def follow(self, link):
        return network.connection.send(link, constants.http.TYPE["HEAD"])
        
    def download(self, location, name, link, extension=constants.filemanager.extension["JPG"]):
        if network.connection.status():
            data = network.connection.send(link, raw=True)
            file = filemanager.File(name, extension, location)
            return file.write(data, True)
        return False
        
notifications = _Notifications()
url = _URL()
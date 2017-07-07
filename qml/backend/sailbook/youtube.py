# -*- coding: utf-8 -*-
"""
Created on Thu Mar 16 12:08:46 2017

@author: Dylan Van Assche
@title: YoutubeDL
@description: Get Youtube videos info.
"""

import youtube_dl

class _Stream(object):
    def __init__(self):
        self.downloader = youtube_dl.YoutubeDL()
    
    def getUrl(self, url): 
        with self.downloader:
            result = self.downloader.extract_info(url, download=False)

        if 'entries' in result: #If playlist, choose the first video
            video = result['entries'][0]
        else:
            video = result

        videos = []    
        for element in video["formats"]: #Extract different resolutions urls
                if element["ext"] == "mp4" and element["format_note"] == "medium":
                    videos.append({"360p": element["url"]})
                elif element["ext"] == "mp4" and element["format_note"] == "hd720":
                    videos.append({"720p": element["url"]})
        return videos
        
stream = _Stream()
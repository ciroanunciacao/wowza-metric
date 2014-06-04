#!/usr/bin/python
"""
Python script to load and parse Wowza xml with connections info.

Author: Ciro Anunciacao
Copyright: Copyright 2014 Ciro Anunciacao
License: MIT
Version: 1.0.0
"""
import sys
import urllib2
import commands
from xml.dom.minidom import parseString

#Load the XML from Wowza host.
def loadxml(host, username, password):
    url = 'http://' + host + ':8086/connectioncounts'
    mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
    mgr.add_password(None,url,username,password)

    opener = urllib2.build_opener(urllib2.HTTPBasicAuthHandler(mgr), urllib2.HTTPDigestAuthHandler(mgr))

    urllib2.install_opener(opener)

    try:
        f = urllib2.urlopen(url)
        return f.read()
    except:
                return ''

#Parse Wowza XML.
def parsexml(xml):
        dom = parseString(xml)
        nodes = dom.getElementsByTagName('ConnectionsCurrent')
        if nodes:
                return nodes[0].firstChild.nodeValue
        else:
                return 0


#Set default variables.
_host = 'localhost'
_username = ''
_password = ''

#Set variables through command line arguments.
if len(sys.argv) > 1:
    _host = sys.argv[1]
if len(sys.argv) > 2:
    _username = sys.argv[2]
if len(sys.argv) > 3:
    _password = sys.argv[3]

#Load XML and set default _connections value
_xml = loadxml(_host, _username, _password)
_connections = 0

#If xml returns something, parse it to get the current connections value.
if len(_xml) > 0:
        _connections = parsexml(_xml)

#Just print the current connections.
print _connections
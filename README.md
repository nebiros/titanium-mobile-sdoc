titanium-mobile-sdoc
====================

A [Titanium Mobile API](http://www.appcelerator.com/products/titanium-mobile-application-development/) parser made with Ruby, it takes [api.json](http://developer.appcelerator.com/apidoc/mobile/1.4/api.json) file and dumps a SDOC file, add this file to your [NetBeans](http://netbeans.org) project (maybe Aptana), now you have __code completation__ of the API, yay! :D.

Usage
=====

Download API Reference as JSON (_api.json_) from [here](http://developer.appcelerator.com/apidoc/mobile/latest), move it to _dist/api.json_, then run default task:

	$ rake

It creates a SDOC file in the _dump/_ folder.

Install
=======

Copy _dump/titanium-mobile.sdoc_ file to your project.

License
=======

See LICENSE file.

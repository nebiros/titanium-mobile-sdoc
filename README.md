titanium-mobile-sdoc
====================

A [Titanium Mobile API](http://www.appcelerator.com/products/titanium-mobile-application-development/) parser made with Ruby, it takes [api.json](http://developer.appcelerator.com/apidoc/mobile/1.4/api.json) file and dumps a SDOC file, now, add the SDOC file to your [NetBeans](http://netbeans.org) project (I guess it works on Aptana) then you have __code completation__ of the API, yay! :D.

Usage
=====

Download API Reference as JSON (_api.json_) from [here](http://developer.appcelerator.com/apidoc/mobile/latest), move it to _dist/api.json_, then run default task:

	$ rake

It creates a SDOC file in the _dump/_ folder.

Install
=======

Copy _dump/titanium-mobile.sdoc_ file to your project.

![Demo](http://juan.im/files/ti_autocomplete_test.jpg)

Known Bugs
==========

* I don't know why the comments doesn't work, still, methods, params, etc, works fine.

License
=======

See LICENSE file.

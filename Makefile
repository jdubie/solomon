test:
	./node_modules/.bin/mocha \
		--compilers coffee:coffee-script

wipe:
	NODE_PATH=. DEBUG=wipe coffee tasks/wipe.coffee

upload:
	NODE_PATH=. DEBUG=upload coffee tasks/upload.coffee

download:
	NODE_PATH=. DEBUG=download coffee tasks/download.coffee

solr-wipe:
	NODE_PATH=. DEBUG=solr* coffee tasks/solr_wipe.coffee

solr-load:
	NODE_PATH=. DEBUG=solr* coffee tasks/solr_load.coffee

server:
	NODE_PATH=. DEBUG=server coffee server.coffee

rename:
	NODE_PATH=. DEBUG=rename coffee tasks/rename.coffee

upload-books:
	NODE_PATH=. DEBUG=upload* coffee tasks/upload_books.coffee


.PHONY: test

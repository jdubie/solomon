all: test

download:
	NODE_PATH=. DEBUG=download coffee tasks/download.coffee

setup_db: wipe upload rename upload_books order_books

test:
	./node_modules/.bin/mocha \
		--compilers coffee:coffee-script

order_books:
	NODE_PATH=. DEBUG=order* coffee tasks/order_books.coffee

wipe:
	NODE_PATH=. DEBUG=wipe coffee tasks/wipe.coffee

upload:
	NODE_PATH=. DEBUG=upload coffee tasks/upload.coffee

upload_books:
	coffee tasks/upload_books.coffee

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

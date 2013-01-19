wipe:
	NODE_PATH=. DEBUG=wipe coffee tasks/wipe

upload:
	NODE_PATH=. DEBUG=upload coffee tasks/upload

download:
	NODE_PATH=. DEBUG=download coffee tasks/download

solr-wipe:
	NODE_PATH=. DEBUG=solr* coffee tasks/solr_wipe

solr-load:
	NODE_PATH=. DEBUG=solr* coffee tasks/solr_load

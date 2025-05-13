from elasticsearch import Elasticsearch

# Create an Elasticsearch client
es = Elasticsearch("http://localhost:9200")

# Get version information
info = es.info()

# Print the version
print(info['version']['number'])

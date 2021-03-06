/**
*********************************************************************************
* Your Copyright
********************************************************************************
*/
component{

	// Module Properties
	this.title 				= "cbElasticSearch";
	this.author 			= "Jon Clausen <jclausen@ortussolutions.com>";
	this.webURL 			= "";
	this.description 		= "Coldbox Module with Fluent API for ElasticSearch";
	this.version			= "0.2.0+38";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "cbElasticsearch";
	// Model Namespace
	this.modelNamespace		= "cbElasticsearch";
	// CF Mapping
	this.cfmapping			= "cbElasticsearch";
	// Auto-map models
	this.autoMapModels		= true;
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "cbjavaloader" ];
	// Auto-parse parent settings
	this.parseParentSettings = true;
	
	variables.configStruct = {};


	function configure(){

		// Default settings
		settings = {
			//The native client Wirebox DSL for the transport client
			client="JestClient@cbElasticsearch",
			// The default hosts - an array of host connections
			//  - REST-based clients (e.g. JEST):  round robin connections will be used
			//  - Socket-based clients (e.g. Transport):  cluster-aware routing used
			hosts = [
				//The default connection is made to http://127.0.0.1:9200
				{
					serverProtocol : 'http',
					serverName     : '127.0.0.1',
					//Socket-based connections will use 9300
					serverPort     : '9200'
				}
			],
			// The default credentials for access, if any - may also be overridden when searching index collections 
			defaultCredentials = {
				"username" : "",
				"password" : ""
			},
			// The default index
			defaultIndex           = "cbElasticsearch",
			// The default number of shards to use when creating an index
			defaultIndexShards     = 3,
			// The default number of index replicas to create
			defaultIndexReplicas   = 0,
			// Whether to use separate threads for client transactions 
			multiThreaded          = true,
			// The maximum number of connections allowed per route ( e.g. search URI endpoint )
			maxConnectionsPerRoute = 10,
			// The maxium number of connectsion, in total for all Elasticsearch requests
			maxConnections         = 100,
			// Read timeout - the read timeout in milliseconds
			readTimeout            = 3000,
			// Connection timeout - timeout attempts to connect to elasticsearch after this timeout
			connectionTimeout      = 3000
		};

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		
		// load DB jars
		wirebox.getInstance( "loader@cbjavaloader" ).appendPaths( variables.modulePath & "/lib");
		
		/**
		* Main Configuration Object Singleton
		**/

		binder.map("Config@cbElasticsearch")
			.to( '#moduleMapping#.models.Config' )
			.threadSafe()
			.asSingleton();

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

		// Close all active pool connections - necessary for native driver implementation
		if( Wirebox.containsInstance( "Client@cbElasticsearch" ) ){

			Wirebox.getInstance( "Client@cbElasticsearch" ).close();		
		
		}

	}

}

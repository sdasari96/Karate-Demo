function fn() {    
  var env = karate.env; // get system property 'karate.env'
  /*karate.log('karate.env system property was:', env);*/
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	myVarName: 'someValue',
	url: 'https://some-host.in/'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    config.url = 'https://reqres.in/'
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}
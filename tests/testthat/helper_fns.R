# Check travis environment variables
check_travis_env = function() {
	if(Sys.getenv("TRAVIS_PULL_REQUEST") == "true") {
		skip("Skipping test because it comes from PR")
	}
}

fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios lint
```
fastlane ios lint
```

### ios unit_tests
```
fastlane ios unit_tests
```

### ios UiTests
```
fastlane ios UiTests
```

### ios build
```
fastlane ios build
```
Build debug version
### ios deploy
```
fastlane ios deploy
```
Deploy debug version
### ios owasp_dependency_check
```
fastlane ios owasp_dependency_check
```
Runs OWASP dependency analysis

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

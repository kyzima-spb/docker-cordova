## Supported tags and respective Dockerfile links

### [cordova-android@12](#compatibility-of-cordova-and-android-sdk-versions)

* `latest`,
  `android12`,
  `android12-node18`, `android12-bookworm-slim`, `android12-node18-bookworm-slim`

* `android12-bullseye-slim`, `android12-node18-bullseye-slim`

* `android12-node16`, `android12-node16-bookworm-slim`

* `android12-node16-bullseye-slim`

### [cordova-android@11](#compatibility-of-cordova-and-android-sdk-versions)

* `android11`,
  `android11-node18`, `android11-bookworm-slim`, `android11-node18-bookworm-slim`

* `android11-bullseye-slim`, `android11-node18-bullseye-slim`

* `android11-node16`, `android11-node16-bookworm-slim`

* `android11-node16-bullseye-slim`

### [cordova-android@10](#compatibility-of-cordova-and-android-sdk-versions)

* `android10`,
  `android10-node18`, `android10-bookworm-slim`, `android10-node18-bookworm-slim`

* `android10-bullseye-slim`, `android10-node18-bullseye-slim`

* `android10-node16`, `android10-node16-bookworm-slim`

* `android10-node16-bullseye-slim`

### [cordova-android@9](#compatibility-of-cordova-and-android-sdk-versions)

* `android9`,
  `android9-node18`, `android9-bookworm-slim`, `android9-node18-bookworm-slim`

* `android9-bullseye-slim`, `android9-node18-bullseye-slim`

* `android9-node16`, `android9-node16-bookworm-slim`

* `android9-node16-bullseye-slim`


## Compatibility of Cordova and Android SDK versions

| cordova-android | JDK            | Gradle | cmdline-tools | build-tools | platforms  |
|-----------------|----------------|--------|---------------|-------------|------------|
| 12.0.0          | openjdk@1.17-0 | 7.6    | 11.0          | 33.0.2      | android-33 |
|                 | openjdk@1.11-0 |        | 10.0          |             |            |
|                 |                |        |               |             |            |
| 11.x.x          | openjdk@1.17-0 | 7.4.2  | 11.0          | 32.0.0      | android-32 |
|                 | openjdk@1.11-0 |        | 10.0          |             |            |
|                 |                |        |               |             |            |
| 10.x.x          | openjdk@1.11-0 | 7.1.1  | 10.0          | 30.0.3      | android-30 |
|                 | zulu@1.8       |        | 8.0           |             |            |
|                 |                |        |               |             |            |
| 9.x.x           | zulu@1.8       | 6.5    | 8.0           | 29.0.2      | android-29 |
| 8.x.x           | zulu@1.8       | 4.10.3 | 8.0           | 28.0.3      | android-28 |


## Compatibility of Android cmdline-tools and Java versions

| cmdline-tools | Java | JDK            |
|---------------|------|----------------|
| 6.0 ... 11.0  | 17   | openjdk@1.17-0 |
| 6.0 ... 10.0  | 11   | openjdk@1.11-0 |
| 1.0 ... 8.0   | 8    | zulu@1.8       |


```shell
docker build -t kyzimaspb/cordova \
  --build-arg CORDOVA_VERSION=11 \
  --build-arg JAVA_VERSION=openjdk@1.11-0 \
  --build-arg ANDROID_CMDLINE_TOOLS_VERSION=8.0 \
  --build-arg ANDROID_BUILD_TOOLS_VERSION=30.0.3 \
  .
```


```shell
docker run --rm -it --privileged kyzimaspb/cordova bash

# Install apk to device, replace if exists
adb install -r app-debug.apk

# Uninstall apk
adb uninstall com.example.hello
```

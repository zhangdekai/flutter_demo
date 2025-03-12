### Refresh Gradle

Try refreshing Gradle dependencies:

Run this in your terminal:

```sh

./gradlew build --refresh-dependencies

```

Or delete the Gradle cache and rebuild:

```sh
rm -rf ~/.gradle/caches
./gradlew build

```

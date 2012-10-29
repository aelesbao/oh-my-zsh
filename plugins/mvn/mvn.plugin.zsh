function listMavenCompletions {
  reply=(
    cli:execute cli:execute-phase archetype:generate generate-sources compile clean install
    test test-compile deploy package cobertura:cobertura jetty:run gwt:run gwt:debug
    android:apk android:apklib android:deploy android:deploy-dependencies android:dex android:emulator-start
    android:emulator-stop android:emulator-stop-all android:generate-sources android:help android:instrument
    android:manifest-update android:pull android:push android:redeploy android:run android:undeploy
    android:unpack android:version-update android:zipalign android:devices
    -DskipTests -Dmaven.test.skip=true -DarchetypeCatalog=http://tapestry.formos.com/maven-snapshot-repository
    -Dtest= `if [ -d ./src ] ; then find ./src -type f | grep -v svn | sed 's?.*/\([^/]*\)\..*?-Dtest=\1?' ; fi`
  );
}

compctl -K listMavenCompletions mvn

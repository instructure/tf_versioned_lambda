javacOptions ++= Seq("-source", "1.8", "-target", "1.8", "-Xlint")

lazy val root = (project in file(".")).
  settings(
    name := "hello_world",
    version := "1.0",
    scalaVersion := "2.11.4",
    libraryDependencies += "com.amazonaws" % "aws-lambda-java-core" % "1.2.0",
    libraryDependencies += "com.amazonaws" % "aws-lambda-java-events" % "2.1.0",
    libraryDependencies += "com.amazonaws" % "aws-java-sdk-s3" % "1.11.163",
    libraryDependencies += "org.json4s" %% "json4s-native" % "3.2.10"
  )

assemblyMergeStrategy in assembly := {
   {
    case PathList("META-INF", xs @ _*) => MergeStrategy.discard
    case x => MergeStrategy.first
   }
}


assemblyJarName in assembly := "lambda.jar"

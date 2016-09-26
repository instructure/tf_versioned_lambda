package helloworld;

import scala.collection.JavaConverters._
import java.net.URLDecoder
import com.amazonaws.services.lambda.runtime.events.S3Event

object HelloConfig {
  var name: Option[String] = None

  def getRawJson(): String = {
    val stream = getClass.getResourceAsStream("/config.json")
    scala.io.Source.fromInputStream(stream).getLines.toSeq.mkString("")
  }

  def loadConfig(): Option[String] = {
    import org.json4s._
    import org.json4s.native.JsonMethods._
    implicit val formats = org.json4s.DefaultFormats

    try {
      val parsedJs = parse(getRawJson())
      Option((parsedJs \ "name").extract[String])
    } catch {
      case _: Throwable => None
    }
  }
  def getName(): String = {
    if (name.isDefined) {
      name.get
    } else {
      name = Option(loadConfig().getOrElse("default"))
      name.get
    }
  }
}

class Main {
  def sayHello(event: S3Event): java.util.List[String] = {
    println("Hello World " + HelloConfig.getName())
    return List(HelloConfig.getName()).asJava
  }
}

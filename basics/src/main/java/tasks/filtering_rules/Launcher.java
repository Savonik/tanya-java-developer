package tasks.filtering_rules;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author Tatiana Savonik
 */
public class Launcher {

    public static void main(String[] args) {

        InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("rules.xml");
        if (inputStream == null) {
            throw new IllegalArgumentException("File cannot be read");
        }
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser saxParser = factory.newSAXParser();
            FilterXML filterXML = new FilterXML();

            System.out.println("xml file parsing started...");
            saxParser.parse(inputStream, filterXML);
            System.out.println("xml file parsing finished.");

            filterXML.printXml();

            filterXML.writeXml();

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

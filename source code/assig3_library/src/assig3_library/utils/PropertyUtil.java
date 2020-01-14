package assig3_library.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;


public class PropertyUtil {
	
	
	public static String getValueByKey(String key) throws IOException{
		String value = "";
		Properties prop = new Properties();			
		
		InputStream in = PropertyUtil.class.getClassLoader().getResourceAsStream("resources\\config.properties");
		
		try {				
			prop.load(new InputStreamReader(in, "utf-8"));
			value = prop.getProperty(key);
		} finally {
			in.close();
		}
		return value;
	}	
	
}

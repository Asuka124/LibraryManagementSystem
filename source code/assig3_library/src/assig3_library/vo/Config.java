package assig3_library.vo;

import java.io.IOException;

import assig3_library.utils.PropertyUtil;


public class Config {	
	private String dirver;
	private String url;
	private String userName;
	private String passWord;	
	private int poolSize;
	
	private static volatile Config instance = null;
	
	private Config() {
		try {		
			dirver = PropertyUtil.getValueByKey("jdbc.driverClassName");
			url = PropertyUtil.getValueByKey("jdbc.url");
			userName = PropertyUtil.getValueByKey("jdbc.username");
			passWord = PropertyUtil.getValueByKey("jdbc.password");
			poolSize = Integer.parseInt(PropertyUtil.getValueByKey("jdbc.poolSize"));			
		} catch (IOException e) {			
			System.out.println("Fatal error: Config Read Error!");
			e.printStackTrace();			
			System.exit(0);
		}		
	}
	
	public static Config getInstance() {
		if(instance == null) {
			synchronized (Config.class) {
				if(instance == null) {
					instance = new Config();
				}
			}
		}
		return instance;
	}		

	public String getDirver() {
		return dirver;
	}

	public String getUrl() {
		return url;
	}

	public String getUserName() {
		return userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public int getPoolSize() {
		return poolSize;
	}

	
	public static void main(String[] args) {
		Config config = Config.getInstance();
		System.out.println(config.getDirver());
		System.out.println(config.getPoolSize());
	}
	
}

package com.vig;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class Jasypt {

	public static void main(String[] args) {
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
		pbeEnc.setAlgorithm("PBEWithMD5AndDES");
		pbeEnc.setPassword("Geon");
		String url = "AAAA";
		String username = "AAA";
		String password = "AAA";
		System.out.println("기존 URL :: " + url + " | 변경 URL :: " + pbeEnc.encrypt(url));
		System.out.println("기존 username :: " + username + " | 변경 username :: " + pbeEnc.encrypt(username));
		System.out.println("기존 password :: " + password + " | 변경 password :: " + pbeEnc.encrypt(password));
	}

}

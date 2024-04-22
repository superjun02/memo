package com.memo.common;

import java.io.File;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	public static final String FILE_UPLOAD_PATH = "C:\\이상준\\6_spring_project\\memo\\memo_workspace\\images/"; // 학원용
	// public static final String FILE_UPLOAD_PATH = "C:\\이상준\\6_spring_project\\memo\\memo_workspace\\images/"; // 집용
	
	// input: file 원본, 로그인 아이디_현재시간
	// output: imagePath 경로
	public String saveFile(String loginId, MultipartFile file) {
		// 폴더(디렉토리) 생성
		// 예: superjun02_18302020/penguin.jpg
		String directoryName = loginId + "_" + System.currentTimeMillis();
		String filePath = FILE_UPLOAD_PATH + directoryName; 
		// C:\\이상준\\6_spring_project\\memo\\memo_workspace\\images/superjun02_18302020/penguin.jpg
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			// 폴더 생성 실패시 이미지 경로 null 리턴
			return null;
		}
		
		// 실제 파일 업로드: byte 단위 업로드
		
		// 파일 업로드가 성공하면 경로(path) return
		return null;
	}
}

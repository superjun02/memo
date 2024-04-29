package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileManagerService {
	public static final String FILE_UPLOAD_PATH = "C:\\이상준\\6_spring_project\\memo\\memo_workspace\\images/"; // 학원용
	// public static final String FILE_UPLOAD_PATH = "C:\\이상준\\6_spring_project\\memo\\memo_workspace\\images/"; // 집용
	
	// input: file 원본, 로그인 아이디_현재시간
	// output: imagePath 경로
	public String saveFile(String loginId, MultipartFile file) {
		// 폴더(디렉토리) 생성
		// 예: superjun02_18302020/penguin.jpg
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName; 
		// C:\\이상준\\6_spring_project\\memo\\memo_workspace\\images/superjun02_18302020/
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			log.info("[파일매니저 업로드] 폴더 생성 실패");
			return null;
		}
		
		// 실제 파일 업로드: byte 단위 업로드
		try {
			byte[] bytes = file.getBytes();
			// ★★★★ 한글명 파일은 업로드 불가이므로 나중에 영문자로 바꾸기
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			log.error("[파일 업로드] 파일업로드 실패. path:{}", filePath);
		}
		
		// 파일 업로드가 성공하면 경로(path) return
		// 주소는 이렇게 될 것이다. (예언)
		//      /images/superjun02_18302020/penguin.png
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	public void deleteFile(String imagePath) {
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		
		// 삭제할 이미지가 존재하는가?
		if (Files.exists(path)) {
			// 이미지 파일 삭제
			try {
				Files.delete(path);
			} catch (IOException e) {
				log.warn("[파일 매니저] 이미지 삭제 실패. path:{}", path.toString());
				return;
			}
			
			// 폴더(디렉토리) 삭제
			path = path.getParent();
			
			if (Files.exists(path)) {
				try {
					Files.delete(path);
				} catch (IOException e) {
					log.warn("[파일 매니저] 이미지폴더 삭제 실패. path:{}", path.toString());
					return;
				}
			}
		}
	}
}

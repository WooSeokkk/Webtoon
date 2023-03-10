package vo;

import org.springframework.web.multipart.MultipartFile;

public class WebtoonVO2 {
	private int webtoon_idx, score, author_idx;		
	private String title, author , genre, filename, info, regdate, epipath;

	//사진을 받기위한 File 변수 선언
	private MultipartFile photo;
	
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
	
	public String getEpipath() {
		return epipath;
	}
	public void setEpipath(String epipath) {
		this.epipath = epipath;
	}

	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getWebtoon_idx() {
		return webtoon_idx;
	}
	public void setWebtoon_idx(int webtoon_idx) {
		this.webtoon_idx = webtoon_idx;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getAuthor_idx() {
		return author_idx;
	}
	public void setAuthor_idx(int author_idx) {
		this.author_idx = author_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}

}

package test.file.dto;

public class FileDto {
	
	//필드
	private int num;
	private String writer;
	private String title;
	private String orgFileName;
	private String saveFileName;
	//파일의 크기는 byte 단위로 저장하기 때문에 long integer type 이 필요하다.
	private long fileSize;
	private String regdate;
	//페이징 처리를 위한 필드
	private int StartRowNum;
	private int endRowNum;
	
	//디폴트 생성자
	public FileDto() {}

	//생성자
	public FileDto(int num, String writer, String title, String orgFileName, String saveFileName, long fileSize,
			String regdate, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.orgFileName = orgFileName;
		this.saveFileName = saveFileName;
		this.fileSize = fileSize;
		this.regdate = regdate;
		StartRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}

	//setter getter
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getSaveFileName() {
		return saveFileName;
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getStartRowNum() {
		return StartRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		StartRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
	
	
}

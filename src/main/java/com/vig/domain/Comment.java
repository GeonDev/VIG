package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Comment implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;

	private long commentId;
	private long feedId;
	private String commentText;
	private User user;
	private Date regDate;
	private Date editDate;
	


}

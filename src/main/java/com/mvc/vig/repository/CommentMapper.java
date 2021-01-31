package com.mvc.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mvc.vig.domain.Comment;
import com.mvc.vig.domain.Search;


@Mapper
public interface CommentMapper {
	public void addComment(Comment comment) throws Exception ; //댓글 작성
	
	public void deleteComment(int commentId)throws Exception; //댓글 삭제
	
	public Comment getComment(int commentId) throws Exception; //댓글 가져오기
	
	public int getLastCommentId() throws Exception; //마지막 댓글의ID 가져오기
	
	public List<Comment> getCommentFromFeed(int feedId) throws Exception; //해당피드의 댓글리스트 가져오기
	
	public List<Comment> getCommentFromUser(Search search)throws Exception; //해당 유저가 쓴 댓글리스트 가져오기
}

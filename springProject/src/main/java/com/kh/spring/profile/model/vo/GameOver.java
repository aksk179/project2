package com.kh.spring.profile.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GameOver {	
	private String userId1;
	private int user1Warn1;
	private int user1Warn2;
	private int user1Warn3;
	private int user1Warn4;
	private String resultValue1;
	
	private String userId2;
	private int user2Warn1;
	private int user2Warn2;
	private int user2Warn3;
	private int user2Warn4;
	private String resultValue2;
	
}

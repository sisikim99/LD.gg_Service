package com.ld.gg.dto.mentoringdto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("mentiTag")
public class MentiTagDTO {
	private String menti_email; //pk
	private int tag_id; //pk
	private String tag_note;
	private String tag_type;
	private String tag_info;
}

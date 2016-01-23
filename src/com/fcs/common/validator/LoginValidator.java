package com.fcs.common.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class LoginValidator extends Validator{

	@Override
	protected void handleError(Controller c) {
		validateRequiredString("userCode", "nameMsg", "请输入用户名"); 
		validateRequiredString("password", "passMsg", "请输入密码"); 
		
	}

	@Override
	protected void validate(Controller c) {
		c.keepPara("userCode"); 
		c.redirect("/admin");
	}

}

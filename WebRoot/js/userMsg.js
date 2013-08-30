var userName = "";
var email = "";
function checkUserName(inputName, labelName, nameText) {
	userName = $(inputName).val();
	$(inputName).blur(
			function() {
				if ($(this).val() != userName && $(this).val() != "") {
					$.post("hadRegister?name="
							+ encodeURIComponent($(this).val()),
							function(json) {
								if (json.error) {
									$(labelName).html("非法名字");
									$(labelName).css("display", "inline");
								} else {
									if (json.hadRegister) {
										$(labelName).html(nameText + "已注册");
										$(labelName).css("display", "inline");
									} else {
										$(labelName).css("display", "none");
									}
								}
							});
				} else {
					if (userName != "" && $(this).val() == userName) {
						$(labelName).css("display", "none");
					} else {
						$(labelName).html("请输入" + nameText + "名");
						$(labelName).css("display", "inline");
					}
				}
			});
}

function checkEmail(inputName, labelName) {
	email = $(inputName).val();
	$(inputName).blur(
			function() {
				if ($(this).val() != email && $(this).val() != "") {
					$.post("hadEmailRegister?email="
							+ encodeURIComponent($(this).val()),
							function(json) {
								if (json.error) {
									$(labelName).html("邮箱格式不正确");
									$(labelName).css("display", "inline");
								} else {
									if (json.hadRegister) {
										$(labelName).html("邮箱已注册");
										$(labelName).css("display", "inline");
									} else {
										$(labelName).css("display", "none");
									}
								}
							});
				} else {
					if (email != "" && $(this).val() == email) {
						$(labelName).css("display", "none");
					} else {
						$(labelName).html("请输入邮箱");
						$(labelName).css("display", "inline");
					}
				}
			});
}

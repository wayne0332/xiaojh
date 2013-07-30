var userName = "";
function checkUserName(inputName, labelName, nameText) {
	userName = $(inputName).val();
	$(inputName).blur(function() {
		if ($(this).val() != userName && $(this).val() != "") {
			$.post("hadRegister?name=" + $(this).val(), function(json) {
				if (json.hadRegister) {
					$(labelName).html(nameText + "已注册");
					$(labelName).css("display", "inline");
				} else {
					$(labelName).css("display", "none");
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

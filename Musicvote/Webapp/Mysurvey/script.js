
function isExist(){
	if (document.insertForm.musictype.value == ""){
		alert("입력하세요!");
		return;
	}
	document.insertForm.submit();
}

function modify(){
	// if else 쓰는 방법
	var musictype = document.getElementsByName("musictype");
	for(var i= 0; i < musictype.length; i++){
		if(musictype[i].checked == true){
			 document.modifyForm.check.value == musictype[i].value;
		}break;
	}
}
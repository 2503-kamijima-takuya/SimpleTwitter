window.onload = function(){
	let classDelete = document.getElementsByClassName("delete");

	classDelete[0].addEventListener("click", clicked);

	function clicked () {
		alert("本当に削除しますか？");
	}
}
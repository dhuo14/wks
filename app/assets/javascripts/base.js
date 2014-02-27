/*替换全部字符*/
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
  if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
    return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
  } else {
    return this.replace(reallyDo, replaceWith);
  }
};

//将字符串转换成对象，避免使用eval
function parseObj(strData) {
   return (new Function("return " + strData))();
}

// 自动适应高度textarea
function textarea_auto_height(textarea){
  textarea.style.height = "1px";
  textarea.style.height = (25+textarea.scrollHeight)+"px";
};

$.validator.methods.equal = function(value, element, param) {
	return value === param;
};
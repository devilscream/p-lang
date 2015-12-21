namespace Plang\Main;
 
class Plang {
 
	public static function main_engine(location) {
	var plang;
	// Setting index
	if(location == ""){
	let location = "index.p";
	}
	// 404 not found
	if(!file_exists(location)){
	header("HTTP/1.1 404 Not Found");
    header("Date: ".date("D, d M Y h:i:s T"));
    header("Content-Type: text/html; charset=iso-8859-1");
    header("X-Powered-By: P language");
    echo "404 Not Found";
	die();
	}
	
	if(pathinfo(location, PATHINFO_EXTENSION) == "p"){
    let plang = file_get_contents(location, true);
    let plang = str_replace("os.kernel()", "exec('uname -r');", plang);
    let plang = str_replace("os.user()", "exec('whoami');", plang);
    let plang = str_replace("os.type()", "exec('uname -o');", plang);
    let plang = str_replace("time.now()", "date('H:i:s');", plang);
    let plang = preg_replace("/http.get\((.*)\)/", "$_GET[$1];", plang); // http.get()
    let plang = preg_replace("/http.request\((.*)\)/", "$_REQUEST[$1];", plang); // http.request()
    let plang = preg_replace("/http.post\((.*)\)/", "$_POST[$1];", plang); // http.post()
    let plang = preg_replace("/cmd\((.*)\)/", "exec($1);", plang); // cmd($func)
    let plang = preg_replace("/import '(.*)'/", "include('$1');", plang); // import 'file'
    let plang = preg_replace("/var (.*) = (.*)/", "$$1 = $2;", plang); // $var = "text"
    let plang = preg_replace("/var (.*)/", "$$1", plang); // var text
    let plang = preg_replace("/plus (.*)/", "$$1 ++", plang); // var text
    let plang = preg_replace("/strlen.(.*)/", "strlen($$1)", plang); // strlen.variable
    let plang = preg_replace("/string.(.*)/", "$$1", plang); // string.variable
    let plang = preg_replace("/var.(.*)/", "$$1", plang); // var.variable
    let plang = preg_replace("/htmlescape.(.*)/", "htmlspecialchars($$1)", plang); // htmlescape.variable
    let plang = preg_replace("/write (.*)/", ";echo $1;", plang); // print text
    let plang = preg_replace("/print (.*)/", ";echo $1;", plang); // print text
    let plang = preg_replace("/return (.*)/", ";return $1;", plang); // return text
    let plang = preg_replace("/if (.*)/", "if($1){", plang); // if var.text == blalala
    let plang = preg_replace("/elseif (.*)/", "} else if($1){", plang); // elseif
    let plang = preg_replace("/for\((.*)\)/", "for($1){", plang); // for()
    let plang = preg_replace("/foreach\((.*)\)/", "foreach($1){", plang); // foreach()
    let plang = preg_replace("/(.*)\((.*)\)/", ";$1($2)", plang); // func name()
    let plang = preg_replace("/def (.*)/", "function $1{", plang); // def name()
    let plang = preg_replace("/else/", "}else{", plang); // else
    let plang = preg_replace("/end/", "}", plang); // end
    let plang = preg_replace("/class (.*)/", "class $1 {", plang); // class
    let plang = preg_replace("/def (.*)/", "function $1{", plang); // def name()
    let plang = preg_replace("/public (.*) = (.*)/", "public $$1 = $2", plang); // public name = hello
    let plang = preg_replace("/this->(.*)/", "$this->$1;", plang); // public name = hello
    eval(plang);
	}else{
	let plang = file_get_contents(location, true);
	echo plang;
	}
	}
 
}
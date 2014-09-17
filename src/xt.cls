//_______________________________________________________________________________________________________________
public without sharing virtual class xt {
//_______________________________________________________________________________________________________________
/*
* (c)2012-2014 elastify GmbH & Co. KG
* All rights reserved.
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
* Redistributions of source code must retain the above copyright notice,
* this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice,
* this list of conditions and the following disclaimer in the documentation
* and/or other materials provided with the distribution.
* 
* Neither the name of elastify GmbH & Co. KG nor the names of its contributors
* may be used to endorse or promote products derived from this software without
* specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
* OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
* THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
* OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
* OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


<class name="xt" longname="xtools">
	<description>
		force.com multi-purpose tool library
		(c)2012-2014 Novatec Systems
	<description>
	<require>
		// has no dependencies! keep it like that!
	</require>
	<changelog>
		<v n="1.5.9"> added License Block																	(2014-09-17) </v>
		<v n="1.5.8"> added denull(), setSort()																(2014-09-12) </v>
		<v n="1.5.7"> improved getPageParam()																(2014-09-11) </v>
		<v n="1.5.6"> added notBlank(), removed getComponent() in favour of xc.cls							(2014-09-03) </v>
		<v n="1.5.5"> added redundant version getType() to avoid dependency to xs.cls						(2014-09-03) </v>
		<v n="1.5.4"> added getComponent(), moved getUserProfile to xs.cls to avoid dependency				(2014-08-26) </v>
		<v n="1.5.3"> ROLLED BACK: added getUserProfile()                      								(2014-08-20) </v>
		<v n="1.5.2"> added encodeJs                                      									(2014-06-28) </v>
		<v n="1.5.1"> added getUrlBase()                                      								(2014-06-28) </v>
		<v n="1.5.0"> added getRecordCount() for more than 50k records                                      (2014-04-24) </v>
		<v n="1.4.9"> added getMicroTime(), wait()									 						(2014-03-25) </v>
		<v n="1.4.8"> added in header <require>, added '|' at explode()				 						(2014-03-23) </v>
		<v n="1.4.7"> added dump0										 									(2014-03-15) </v>
		<v n="1.4.6"> added listRemove, listContainsAll, refactored tests 									(2014-03-15) </v>
		<v n="1.4.5"> added msg(), listUnique(), coverage back to 100% :-) 									(2014-03-14) </v>
		<v n="1.4.4"> added listSort(): case insensitive sorting of lists, changed header to xml-format 	(2014-03-14) </v>
		<v n="1.4.3"> ... 																								 </v>
		<v n="1.4.1"> getDefaultPricebook fix 																			 </v>
		<v n="1.4.0"> renamed to xt  																					 </v>
		<v n="1.3.3"> refactoring 																						 </v>
		<v n="1.3.2"> refactoring 																						 </v>
		<v n="1.3.1"> added the long awaited dump() method!! ;-) 														 </v>
		<v n="1.3.0"> Major release, genaral refactoring 																 </v>
		<v n="1.2.1"> fixed buggy round function 																		 </v>
		<v n="1.2.0"> added triggerRollup 																				 </v>
		<v n="1.1.7"> start track 																						 </v>
	</changelog>
</class>
*/
//_______________________________________________________________________________________________________________


public static list<string> setSort( set<string> input ) {
	list<string> result = new list<string>( input );
	//result.sort();
	xt.listSort(result);
	return result;
}

public static map<string,map<string,string>> 	denull(map<string,map<string,string>> m) 	{ m.remove(null); return m; } 
public static map<string,string> 				denull(map<string,string> m)				{ m.remove(null); return m; } 
public static map<string,object> 				denull(map<string,object> m)				{ m.remove(null); return m; } 

// public static map<object,object> removeNullKeys(map<object,map<object,object>> m) { m.remove(null); return m; } 
// public static map<object,object> removeNullKeys(map<object,object> m) { m.remove(null); return m; } 

public static string notBlank(	object o) { if(o==null ) 	{ return ''; } else { return String.valueOf(o); } }
//public static string notNull(	string s) { if(s==null ) 			{ return '' } else { return s }; } // unnecessary

public static string getType(Object o) {
	if(o==null) return ''; // we can't say much about null
	if(o instanceof SObject) 			return ((SObject)o).getSObjectType().getDescribe().getName()+''; 
	if(o instanceof Boolean) 			return 'Boolean';
	if(o instanceof Id) 				return 'Id';
	if(o instanceof String) 			return 'String';
	if(o instanceof Blob) 				return 'Blob';
	if(o instanceof Date) 				return 'Date';
	if(o instanceof Datetime) 			return 'Datetime';
	if(o instanceof Time) 				return 'Time';
	if(o instanceof String) 			return 'String';
	if(o instanceof Integer) 			return 'Integer';
	if(o instanceof Long) 				return 'Long';
	if(o instanceof Decimal) 			return 'Decimal';
	if(o instanceof Double) 			return 'Double';
	if(o instanceof List<object>)		return 'List';
	//return getTypeDetect(o);
	return 'Object'; // actually we can't detect maps and sets
}


// public static ApexPages.Component getComponent(ApexPages.Component parent,ApexPages.Component[] children) {
// 	for(ApexPages.Component child : children) {
// 		if(child!=null) parent.childComponents.add(child);
// 	}
// 	return parent;
// }

public static string getPageParam(string param) {
	//try {
		return xt.stringEscapeJS( ApexPages.currentPage().getParameters().get( param ) );
	// } catch(exception e) {
	// 	return null;
	// }
	//return ApexPages.currentPage().getParameters().get( param );
}

public static string stringEscapeJS(string input) {
	if(input==null) return null;
	return input.escapeEcmaScript();
}

public static string getUrlBase() { // works only if vf context !!
	string result = ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To'); 
	result = result.replace('eu0.','emea.');
	return result;
}


public static integer getRecordCount(string objectName) {
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://'+URL.getSalesforceBaseUrl().getHost()+'/services/data/v20.0/query/?q=SELECT+name+from+'+objectName+'');
    req.setMethod('GET');
    string autho = 'Bearer '+ userInfo.getsessionId();
    req.setHeader('Authorization', autho);
    Http http = new Http();
    HTTPResponse res = http.send(req);
    string response = res.getBody();
    string totalCount = response.substring(response.indexOf('totalSize":')+11, response.indexOf(','));
    //xt.log('get the total count '+ totalCount);
    return integer.valueOf( totalCount );
}


public static integer getMicroTime() {
	datetime t = system.now();
	return 0
		+ t.minute()*1000*60
		+ t.second()*1000
		+ t.millisecond()
	;
}

public static void wait(integer ms) {
	integer start = getMicroTime();
	while( getMicroTime() < start + ms ) { } // just wait
}



public static string[] listRemove(string[] input, string[] remove) {
	if(input==null || remove==null) return new string[]{};
	string[] 		result 			= new string[]{};
	set<string>		removeSet 		= new set<string>( remove );
	for(string value : input) {
		if(!removeSet.contains( value )) result.add( value );
	}
	return result;
}

public static boolean listContains(string[] input, string search) {
	return xt.inList(input,search);
}

public static boolean listContainsAll(string[] input, string[] search) {
	if(input == null || search == null || search.size() == 0) return false;
	boolean 		result 			= true;
	set<string>		inputSet 		= new set<string>( input );
	for(string value : search) {
		if(!inputSet.contains( value )) result = false;
	}
	return result;
}

public static boolean listContainsAny(string[] input, string[] search) {
	if(input == null || search == null || search.size() == 0) return false;
	boolean 		result 			= false;
	set<string>		inputSet 		= new set<string>( input );
	for(string value : search) {
		if(inputSet.contains( value )) result = true;
	}
	return result;
}

public static string[] listSort(string[] input) {
	if(input==null) return new string[]{};
	for(integer i=0; i < input.size(); i++) input[i] = input[i].toUpperCase() + input[i];
	input.sort();
	for(integer i=0; i < input.size(); i++) input[i] = input[i].substring( input[i].length() / 2 );
	return input;
}

public static string[] listUnique(string[] input) {
	return new list<string>( new set<string>( input ));
}
public static void log(object o) {
	System.debug(logginglevel.WARN, system.JSON.serializePretty(o));
}

public static void log2(object o) {
	System.debug(logginglevel.WARN, (o));
}

public static string dump(Object o) {
	return system.JSON.serializePretty(o).replace('\n','<br>').replace('  ','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
}

public static string dump0(Object o) {
	return system.JSON.serializePretty(o);
}

public static string dump2(Object o) {
	return system.JSON.serializePretty(o).escapeXml().replace('\n','<br>').replace('  ','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
}

public static string dump3(Object o) {
	return system.JSON.serializePretty(o).replace('\n','<br>');
}

public static void msg(string message) {
	xt.msg(message,'info');
/*
	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, ''
			+ ''+ message +''
	));
*/
}

public static void msg(string message, string severity) {
	ApexPages.Severity aps = ApexPages.Severity.Info;
	if(severity=='confirm') 	aps = ApexPages.Severity.Confirm;
	if(severity=='error') 		aps = ApexPages.Severity.Error;
	if(severity=='fatal') 		aps = ApexPages.Severity.Fatal;
	if(severity=='info') 		aps = ApexPages.Severity.Info;
	if(severity=='warning') 	aps = ApexPages.Severity.Warning;
	ApexPages.addMessage(new ApexPages.Message( aps, ''
			+ ''+ message +''
	));
}

public static void msgp(string message) {
	xt.msgp(message,'info');
}

public static void msgp(string message, string severity) {
	xt.msg(''
		+'<img style="padding-right: 5px; padding-top: 1px; vertical-align: middle;" src="/img/packaging/spinner24.gif">'
		+message
	,severity);
}


//public static string


public static string stripHTMLTags(String html) {
	//string html = 'your html code';
	string result;
	if(html==null || html =='') return '';
    result = html;
    result = result.replaceAll('<li.*?>', '  * ');
    result = result.replaceAll('&nbsp;', ' ');
    result = result.replaceAll('<br/>', '\n');
	result = result.replaceAll('<br />', '\n');
	string HTML_TAG_PATTERN = '<.*?>';
	pattern myPattern = pattern.compile(HTML_TAG_PATTERN);
	matcher myMatcher = myPattern.matcher(result);
	result = myMatcher.replaceAll('');
	return result;
}


public static Boolean isObjectModified(SObject obj, SObject obj2) {
	Boolean result = false;
    map<string,object> objmap = (map<string,object>) Json.deserializeuntyped(JSON.serialize(obj));
    map<string,object> obj2map = (map<string,object>) Json.deserializeuntyped(JSON.serialize(obj2));
    objmap.remove('attributes');
    objmap.remove('url');
    obj2map.remove('attributes');
	String changes = '';
    for(string key : objmap.keyset()) {
        if(    objmap.get(key) != obj2map.get(key)
        	&& key != 'Id'					// id is empty in clone
        	&& key != 'LastModifiedDate' 	// in v26, only the dates dismatched
        	&& key != 'CreatedDate'
        	&& key != 'LastModifiedById' 	// in v27, also users dismatch...
        	&& key != 'CreatedById'
        ) {
        	changes += key + ' ';
        	result = true;
        }
    }
/*
 //DO NOT KILL THIS CODE
    //if(result) {
    if(true) {
    	LogObject__c l = new LogObject__c(
    		 Subject__c = objmap.get('Id') + ' : ' + obj2map.get('Name')
    		,Content__c = changes
    		,Detail1__c = (JSON.serialize(obj))
    		,Detail2__c = (JSON.serialize(obj2))

    	);
    	insert l;
    }
*/

    return result;
}


public static String implode(String glue,Set<String> pieces) {
	List<string> l = new List<string>();
	l.addAll(pieces);
	return xt.implode(glue, l);
}

public static String implode(String glue,List<String> pieces) {
	if(glue==null) 		glue 	= '';
	if(pieces==null)	return '';
	String result = '';
	for(String piece : pieces) {
		if(result!='') result += glue;
		result += piece;
	}
	return result;
}

public static List<String> explode(String delimiter,String s) {
	if(s==null)    s = '';
	if(delimiter==null) { List<String> result = new List<String>(); result.add(s); return result; }
	delimiter = delimiter // this list is NOT complete
		.replace('.','\\.')
		.replace('{','\\{')
		.replace('}','\\}')
		.replace('(','\\(')
		.replace(')','\\)')
		.replace('[','\\[')
		.replace(']','\\]')
		.replace('$','\\$')
		.replace('?','\\?')
		.replace('*','\\*')
		.replace('+','\\+')
		.replace('/','\\/')
		.replace('^','\\^')
		.replace('|','\\|')
	;
	return s.split(delimiter,0);
}

public static List<String> unique(List<String> strings) {
	Set<String> myset 	= new Set<String>();
	List<String> result = new List<String>();
	for(String s : strings) {
  		if (myset.add(s)) {
    		result.add(s);
  		}
  	}
  	return result;
}

public static String replace(String[] matches, String[] replacements, String s) {
	Integer i = 0;
	for(String match: matches) {
		s = s.replace(match,replacements[i]);
		i++;
	}
	return s;
}


public static boolean inList(list<string> haystack, string needle) {
	set<string> haystackSet = toSet(haystack);
	return haystackSet.contains(needle);
}


public static list<string> toList(set<string> input) {
	list<string> result = new list<string>();
	result.addAll(input);
	return result;
}

public static list<string> toListSorted(set<string> input) {
	list<string> result = toList(input);
	//result.sort();
	result = xt.listSort(result);
	return result;
}

public static list<integer> toList(set<integer> input) {
	list<integer> result = new list<integer>();
	result.addAll(input);
	return result;
}

public static set<string> toSet(list<string> input) {
	set<string> result = new set<string>();
	result.addAll(input);
	return result;
}

public static set<integer> toSet(list<integer> input) {
	set<integer> result = new set<integer>();
	result.addAll(input);
	return result;
}

public static List<string> notInSecondList(list<string> l1, list<string> l2) { // return all which are in l1 but not in l2
	List<string> result = new List<string>();
	set<string> s2 = new set<string>();
	s2.addAll(l2);
	for(string s : l1) {
		if( ! s2.contains(s) ) result.add(s);
	}
	return result;
}


public static Object getDefaultPricebook() {
    return Database.query(''
       +'select Id, CreatedById, CreatedDate, Description, IsActive, IsDeleted, IsStandard, LastModifiedById, LastModifiedDate, SystemModstamp '
       +'from Pricebook2 '
       +'where isStandard=true '
    ).get(0);
}


public static string roundNumber(decimal d, integer precision) {
	if(d == null) return '';
	string separator = (1.01).format().substring(1,2)  ;
	string pre 			= d.setScale(precision,System.RoundingMode.HALF_UP).format();
	string fraction 	= pre.substringAfter(separator).rightPad(precision).replace(' ','0');
	string nonFraction  = pre.substringBefore(separator);
	if(precision==0) separator = '';
	return ''+nonFraction + separator + fraction;
}

public static string soqlDate(Date d) { // format ISO-date
	if(d == null) return null;
	return ''
	   	+ Datetime.newInstance(
	    		d.year(),
	    		d.month(),
	    		d.day(),
	    0,0,0).format('yyyy-MM-dd')
	;
}

public static map<String,Decimal> mapAddToValue(Map<String,Decimal> m, String key, Decimal value) {
	if(value != null) {
		m.put( key,
			( m.get( key ) == null ?
				0 : m.get( key )
			)
			+ value
		);
	}
	return m;
}

public static map<String,String> mapAddToValue(Map<String,String> m, String key, String value, String delimiter) {
	if(delimiter==null) delimiter = '';
	if(value != null) {
		if(!m.containsKey( key )) delimiter = '';
		m.put( key,
			( m.get( key ) == null ?
				'' : m.get( key )
			)
			+ delimiter + value
		);
	}
	return m;
}

public static map<String,String> mapSwapKeyValue(Map<String,String> m) {
	Map<String,String> result = new Map<String,String>();
	for(string key : m.keySet()) {
		result.put(m.get(key),key);
	}
	return result;
}





public static testMethod void testList() { testListHelper(); }		// wrapper only
public static void testListHelper() { 								// this can be run outside test-context
	string[] haystack     = new string[]{'red','green','blue','white','blue'};
	string[] search       = new string[]{'whit_e','bl_ue'};
	string[] removeResult = xt.listRemove( haystack, search );
	boolean contains	  = xt.listContains( haystack, 'wh_ite' );
	boolean containsAll   = xt.listContainsAll( haystack, search );
	boolean containsAny   = xt.listContainsAny( haystack, search );
    string[] uniquResult  = xt.listUnique(haystack);
	xt.log( removeResult );
	xt.log( contains );
	xt.log( containsAll );
	xt.log( containsAny );
	xt.log( uniquResult );
}



@isTest(seeAllData=true)
public static void testPricebook() {
	Object pb = xt.getDefaultPricebook();

}

public static testMethod void testBase() {
	xt.log('test');
	xt.log2('test');
	xt.dump('test');
	xt.dump2('test');
	xt.dump3('test');
	xt.msg('test');
	xt.msg('test','confirm');
	xt.msg('test','error');
	xt.msg('test','fatal');
	xt.msg('test','warning');
	xt.msgP('test');
	String s = '';
	s = xt.roundNumber(10.5353,3);
	s = xt.stripHTMLTags('<b>test</b> more <i>stuff</i>');
	s = xt.soqlDate( date.newinstance(1960, 2, 17) );
	s = xt.soqlDate( null );

	Map<String,String> testSwapMap = new Map<String,String>();
	testSwapMap.put('123','345');
	testSwapMap = xt.MapSwapKeyValue(testSwapMap);
	testSwapMap.put('666','A');
	testSwapMap = xt.MapAddToValue(testSwapMap,'666','B','ää');

	Map<String,Decimal> testMap = new Map<String,Decimal>();
	testMap.put('1',1.77);
	xt.MapAddToValue(testMap, '1', 4.99);
	Account a1 = new Account(Name='Test1');
	Account a2 = new Account(Name='Test2');
	Boolean b = xt.isObjectModified(a1, a2);

	set<string> st = new set<string>(); st.add('asdfsdf1');st.add('asdfsdf2');st.add('asdfsdf3');st.add('asdfsdf4');
	s 	= implode(',',st);

	list<string> ss = new list<string>(); ss.add('asdfsdf1');ss.add('asdfsdf2');ss.add('asdfsdf3');ss.add('asdfsdf4');
	list<string> s2 = new list<string>(); s2.add('asdfsdf1');s2.add('asdfsdf2');
	ss 	= xt.listSort(ss);
	s 	= xt.implode(',',ss);
	ss 	= explode(',',s);
	ss 	= unique(ss);

	s 	= xt.replace(ss, ss, 'f.oorrece.coom.ort');
	ss 	= xt.toList(st);
	ss 	= xt.toListSorted(st);
	b 	= xt.inList(ss,'sdf');

	set<integer> intSet =  new set<integer>(); intSet.add(1); intSet.add(4);
	xt.toList( intSet );

	list<integer> intList =  new list<integer>(); intList.add(1); intList.add(4);
	xt.toSet( intList );

	string[] s3 = xt.notInSecondList(ss,s2);
	System.assertEquals( true, true );

}





}
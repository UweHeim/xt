//_______________________________________________________________________________________________________________
public without sharing class xs {     
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


<class name="xs" longname="xschema"> 
	<description>
		dynamic access to saleforce schema
	<description>
	<require>
		<c n="xt"></c>
		<c n="xr"></c>
	</require>
	<changelog>
		<v n="1.5.1"> added License Block																(2014-09-17) </v>
		<v n="1.5.0"> added xsObject.fieldExists()														(2014-09-10) </v>
		<v n="1.4.9"> added getObjects() and getPrefixes()    (TESTING NEEDED!) 						(2014-09-04) </v>
		<v n="1.4.8"> added more properties for xsField													(2014-09-02) </v>
		<v n="1.4.7"> fixed getObjectType(), getObjectNamespacePrefix(): access m-package failed		(2014-09-02) </v>
		<v n="1.4.6"> added spikes at getType() (show actually only what doesn't work)					(2014-08-29) </v>
		<v n="1.4.5"> improved getType() to work more generally on Object instead of SObject			(2014-08-28) </v>
		<v n="1.4.4"> added getUserProfile() from xt.cls, cleanup, reordered sections					(2014-08-26) </v>
		<v n="1.4.3"> improved test() to increase coverage												(2014-08-23) </v>
		<v n="1.4.2"> added xs.getField(reference)														(2014-08-23) </v>
		<v n="1.4.1"> improved xsObject.referenceType for polymorphic Owner-field at xsOrg.get()		(2014-08-22) </v>
		<v n="1.4.0"> added more properties at xsObject    												(2014-08-22) </v>
		<v n="1.3.9"> added getPicklistValues()            												(2014-08-07) </v>
		<v n="1.3.8"> excludeChatterFields                 												(2014-07-16) </v>
 		<v n="1.3.7"> cleanup	                        												(2014-06-30) </v>
		<v n="1.3.6"> added Workaround for Spring14 Schema bug at xsOrg.get()	                        (2014-05-05) </v>
		<v n="1.3.5"> added getInstalledPackages()			                                            (2014-04-29) </v>
		<v n="1.3.4"> fixed serious bug in getObjectType()	                                            (2014-04-24) </v>
		<v n="1.3.3"> added getOrgNamespacePrefix()			                                            (2014-04-14) </v>
		<v n="1.3.2"> added soql(), which build a string for database.query			 					(2014-04-13) </v>
		<v n="1.3.1"> improved query()												 					(2014-03-23) </v>
		<v n="1.3.0"> added query(), added dependency to xr							 					(2014-03-23) </v>
		<v n="1.2.4"> added in header <require>										 					(2014-03-23) </v>
		<v n="1.2.3"> changed header to xml. added getObjectType() 										(2014-03-20) </v>
		<v n="1.2.2"> refactoring 																					 </v>
		<v n="1.2.1"> refactoring																					 </v>
		<v n="1.2.0"> renamend to xs 																				 </v>
		<v n="1.1.6"> refactoring 																					 </v>
		<v n="1.1.5"> refactoring																					 </v>
		<v n="1.1.4"> refactoring and new functions																	 </v>
		<v n="1.1.3"> xsOrg: object and field names are now stored CaseSensitive, but queryable caseinsensiteve either </v>
		<v n="1.1.1"> added comment, moved legacy code down													 		 </v>
		<v n="1.1.0"> Major Release: genaral refactoring, new functions										   		 </v>
		<v n="1.0.4"> added isXXX																				 	 </v>
		<v n="1.0.3"> start track																				 	 </v>
	</changelog>
</class>
*/
//_______________________________________________________________________________________________________________


//_____________________________________________________________________________________________________________________________________________
//	xsOrg, xsObject and xsField buffers 
//_____________________________________________________________________________________________________________________________________________

private static 	Map<String,Schema.SObjectType> 	gds = Schema.getGlobalDescribe(); // map to hold global describe data
public static xs.xsOrg org = new xs.xsOrg();


public class xsField {
	public string 								name;
	public string								type;
	public string								referenceType;
	public integer								byteLength 					{ get { return this.soResult==null ? null : this.soResult.getByteLength(); }}
	public string								calculatedFormula 			{ get { return this.soResult==null ? null : this.soResult.getCalculatedFormula(); }}
	public Object 								defaultValue 				{ get { return this.soResult==null ? null : this.soResult.getDefaultValue(); }}
	public string 								defaultValueFormula 		{ get { return this.soResult==null ? null : this.soResult.getDefaultValueFormula(); }}
	public integer								digits						{ get { return this.soResult==null ? null : this.soResult.getDigits(); }}
	public string								inlineHelpText				{ get { return this.soResult==null ? null : this.soResult.getInlineHelpText(); }}
	public string								label						{ get { return this.soResult==null ? null : this.soResult.getLabel(); }}
	public integer								length						{ get { return this.soResult==null ? null : this.soResult.getLength(); }}
	public string								localName    				{ get { return this.soResult==null ? null : this.soResult.getLocalName(); }}
	public integer								precision					{ get { return this.soResult==null ? null : this.soResult.getPrecision(); }}
	public string								relationshipName			{ get { return this.soResult==null ? null : this.soResult.getRelationshipName(); }}
	public integer								relationshipOrder			{ get { return this.soResult==null ? null : this.soResult.getRelationshipOrder(); }}
	public integer								scale						{ get { return this.soResult==null ? null : this.soResult.getScale(); }}
	public string								SOAPType    				{ get { return this.soResult==null ? null : (this.soResult.getSOAPType()+'').toLowerCase(); }}
	public boolean								isAccessible				{ get { return this.soResult==null ? null : this.soResult.isAccessible(); }} 
	public boolean								isAutoNumber				{ get { return this.soResult==null ? null : this.soResult.isAutoNumber(); }} 
	public boolean								isCalculated				{ get { return this.soResult==null ? null : this.soResult.isCalculated(); }} 
	public boolean								isCascadeDelete				{ get { return this.soResult==null ? null : this.soResult.isCascadeDelete(); }} 
	public boolean								isCaseSensitive				{ get { return this.soResult==null ? null : this.soResult.isCaseSensitive(); }} 
	public boolean								isCreateable				{ get { return this.soResult==null ? null : this.soResult.isCreateable(); }} 
	public boolean								isCustom					{ get { return this.soResult==null ? null : this.soResult.isCustom(); }} 
	public boolean								isDefaultedOnCreate			{ get { return this.soResult==null ? null : this.soResult.isDefaultedOnCreate(); }} 
	public boolean								isDependentPicklist			{ get { return this.soResult==null ? null : this.soResult.isDependentPicklist(); }} 
	public boolean								isDeprecatedAndHidden		{ get { return this.soResult==null ? null : this.soResult.isDeprecatedAndHidden(); }} 
	public boolean								isExternalID				{ get { return this.soResult==null ? null : this.soResult.isExternalID(); }} 
	public boolean								isFilterable				{ get { return this.soResult==null ? null : this.soResult.isFilterable(); }} 
	public boolean								isGroupable					{ get { return this.soResult==null ? null : this.soResult.isGroupable(); }} 
	public boolean								isHtmlFormatted				{ get { return this.soResult==null ? null : this.soResult.isHtmlFormatted(); }} 
	public boolean								isIdLookup					{ get { return this.soResult==null ? null : this.soResult.isIdLookup(); }} 
	public boolean								isNameField					{ get { return this.soResult==null ? null : this.soResult.isNameField(); }} 
	public boolean								isNamePointing				{ get { return this.soResult==null ? null : this.soResult.isNamePointing(); }} 
	public boolean								isNillable					{ get { return this.soResult==null ? null : this.soResult.isNillable(); }} 
	public boolean								isPermissionable			{ get { return this.soResult==null ? null : this.soResult.isPermissionable(); }} 
	public boolean								isRestrictedDelete			{ get { return this.soResult==null ? null : this.soResult.isRestrictedDelete(); }} 
	public boolean								isRestrictedPicklist		{ get { return this.soResult==null ? null : this.soResult.isRestrictedPicklist(); }} 
	public boolean								isSortable					{ get { return this.soResult==null ? null : this.soResult.isSortable(); }} 
	public boolean								isUnique					{ get { return this.soResult==null ? null : this.soResult.isUnique(); }} 
	public boolean								isUpdateable				{ get { return this.soResult==null ? null : this.soResult.isUpdateable(); }} 
	public boolean								isWriteRequiresMasterRead	{ get { return this.soResult==null ? null : this.soResult.isWriteRequiresMasterRead(); }} 



	public DescribeFieldResult					soResult;
	public Schema.SObjectType					soReferenceTo;
	
	public List<Schema.PicklistEntry>			soPicklistEntries		= null;
	
	public List<String> getPicklistValues(){
		if(this.type != 'picklist') 			return null;
	  	List<String> 							results					= new List<String>();
		if(this.soPicklistEntries==null)		this.soPicklistEntries  = soResult.getPickListValues();
		for(Schema.PicklistEntry pe : this.soPicklistEntries) { 
	  		results.add(pe.getValue());
	   	}
	  	return results;	
	}
}


public class xsObject {
	public string								name;
	public string								label 						{ get { return this.soResult==null ? null : this.soResult.getLabel(); }}
	public string								keyPrefix					{ get { return this.soResult==null ? null : this.soResult.getKeyPrefix(); }} 
	public string								labelPlural					{ get { return this.soResult==null ? null : this.soResult.getLabelPlural(); }} 
	public boolean								isAccessible				{ get { return this.soResult==null ? null : this.soResult.isAccessible(); }} 
	public boolean								isCreateable				{ get { return this.soResult==null ? null : this.soResult.isCreateable(); }} 
	public boolean								isCustom					{ get { return this.soResult==null ? null : this.soResult.isCustom(); }} 
	public boolean								isDeletable					{ get { return this.soResult==null ? null : this.soResult.isDeletable(); }} 
	public boolean								isQueryable					{ get { return this.soResult==null ? null : this.soResult.isQueryable(); }} 
	public boolean								isUpdateable				{ get { return this.soResult==null ? null : this.soResult.isUpdateable(); }} 
	public boolean								isMergeable					{ get { return this.soResult==null ? null : this.soResult.isMergeable(); }} 
	public boolean								isSearchable				{ get { return this.soResult==null ? null : this.soResult.isSearchable(); }} 

	public DescribeSObjectResult 				soResult;
	public Map<String, Schema.SObjectField>		soFields;
	public map<string,xsField>					fields		= new map<string,xsField>();

	public xsField get(string name) {
		//return this.fields.get(name.toLowerCase());
		if( fields.containsKey(name) ) {
			return this.fields.get(name);
		} else {
			for(string fieldName : fields.keyset() ) {
				if(fieldName.toLowerCase() == name.toLowerCase()) {
					return this.fields.get(fieldName);
				}
			}
		}
		return null;
	}

	public boolean fieldExists(string fieldName) {
		return ( this.get(fieldName) != null ? true : false );
	}
	
	public list<string> getFieldNames() {
		return xt.toListSorted(fields.keySet());
	}

	public map<string,string> getFieldLabels() {
		map<string,string> result = new map<string,string>();
		for(string fieldName : fields.keySet() ) {
			result.put(fieldName,fields.get(fieldName).label);
		}
		return result;
	}

}


public class xsOrg {
	public map<string,xsObject> 						objects		= new map<string,xsObject>();

	public void getObjects() { // this method caches ALL objects without field describes
		for(string name : this.getObjectNames()) {
			if(!this.objects.containsKey(name)) { 
				xsObject xso 	= new xsObject();
				xso.name 		= name;
				//xso.soResult 	= Schema.getGlobalDescribe().get(name.toLowerCase()).getDescribe();
				xso.soResult 	= gds.get(name.toLowerCase()).getDescribe();
				name 			= xso.soResult.getName(); // 2014-08-22: why this is done? can't remember anymore...
				this.objects.put(name,xso);
			}
		}
	}	


	public xsObject get(string name) {
		if(name==null) return null;
	 // first: search if object exists at all an correct propper case in name by copying the name from dictionary.
		boolean objectExists = false;
		for(string objectName : this.getObjectNames()) {
			if( objectName.toLowerCase() == name.toLowerCase() ) {
				name = objectName;
				objectExists = true;
			}
		}
		if(!objectExists) return null;
	 // then, query the object for fields
		xsObject result;
		if(!this.objects.containsKey(name) || this.objects.get(name).fields.size()==0 ) { //if we have no chache or if we have something ( by getObjects() ), but didn't cached the fields   //DO NOT://.toLowerCase()
			xsObject xso 	= new xsObject();
			xso.name 		= name;//.toLowerCase();
			// 2014-09-04: the following is a wast of perfomance !!
				// xso.soResult 	= Schema.getGlobalDescribe().get(name.toLowerCase()).getDescribe();
				// xso.soFields 	= Schema.getGlobalDescribe().get(name.toLowerCase()).getDescribe().fields.getMap();
			xso.soResult 	= gds.get(name.toLowerCase()).getDescribe();
			xso.soFields 	= gds.get(name.toLowerCase()).getDescribe().fields.getMap();

			for(string fieldName : xso.soFields.keySet()) {
				xsField xsf 						= new xsField();
				xsf.name							= fieldName;
				xsf.soResult						= xso.soFields.get(fieldName).getDescribe();
				try {
					xsf.name						= xsf.soResult.getName();
				} catch(Exception e) {}
				try {
					xsf.soReferenceTo 				= xsf.soResult.getReferenceTo().get(0); 						// caution: this will store only one type for polymorphic relations (e.g. owner on custom objects)
					//integer referenceCount			= xsf.soResult.getReferenceTo().size();	
					xsf.referenceType				= string.valueof(xsf.soReferenceTo.getDescribe().getName()); 	// TRY case-sensitive result
					if( (xsf.soResult.getReferenceTo().size() > 1) && fieldName=='OwnerId') {  						// 2014-08-22 : http://salesforce.stackexchange.com/questions/47467/owner-custom-fields-and-some-standard-fields-are-not-accessible-in-relations/47487#47487
						xsf.referenceType 			= 'Name';														// 2014-08-22 : needs verification
					}
				} catch(Exception e) {}
				xsf.type							= (xsf.soResult.getType()+'').toLowerCase();
				if( true 
					&& xsf.soResult.getType()+'' 	!= 'ADDRESS' 								// random bugs in Spring14
					&& fieldName 					!= 'lastvieweddate' 						// random bugs in Spring14
					&& fieldName 					!= 'digestfrequency' 						// for orgs with chatter deactivated
					&& fieldName 					!= 'smallphotourl' 							// for orgs with chatter deactivated
					&& fieldName 					!= 'fullphotourl' 							// for orgs with chatter deactivated
					&& fieldName 					!= 'defaultgroupnotificationfrequency' 		// for orgs with chatter deactivated
					&& fieldName 					!= 'aboutme' 								// for orgs with chatter deactivated
				) {
					xso.fields.put(xsf.name,xsf);
				}
			}
			name 			= xso.soResult.getName(); // 2014-08-22: why this is done? can't remember anymore...
			this.objects.put(name,xso);
			result = xso;
		} else {
			result = this.objects.get(name);
		}
		return result;
	}


	public list<string> getObjectNames() {
		list<string> results = new list<string>();
		for(string objectName : xt.toListSorted(gds.keyset()) ) {
			results.add(gds.get(objectName)+'');
		}
		return results;
	}

	public map<string,string> getObjectLabels() {
		map<string,string> result = new map<string,string>();
		for(string objectName : this.getObjectNames() ) {
			DescribeSObjectResult soResult = gds.get(objectName.toLowerCase()).getDescribe();
			result.put(objectName,soResult.getLabel());
		}
		return result;
	}
	
	public map<string,string> getPrefixes() {
		//Schema.SObjectType result;
		map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
		String prefix;
		map<String, String> prefixMap = new map<String, String>();
		for(Schema.SObjectType ot : gd.values()) {
			prefix = ot.getDescribe().getKeyPrefix();
			if(prefix != null) { prefixMap.put(prefix, ot.getDescribe().getName()); }
		}
		return prefixMap;
	}
	
}




//_____________________________________________________________________________________________________________________________________________
//	user and profile functions 
//_____________________________________________________________________________________________________________________________________________

public static Profile getUserProfile() {
	return ( (List<Profile>) xs.query('select * from Profile where Id=\''+UserInfo.getProfileId()+'\' '))[0];
	//return [select Id, PermissionsModifyAllData, PermissionsApiEnabled from Profile where Id = :UserInfo.getProfileId() ][0];
}





//_____________________________________________________________________________________________________________________________________________
//	query functions 
//_____________________________________________________________________________________________________________________________________________

public static String soqlSelectAsterix(String ObjectName) {
    ObjectName = getObjectNamespacePrefixedName(ObjectName); 	// added 2013-10-23 - make it work with and without prefix
    return ' ' + String.join( getFields(ObjectName),', ' ) + ' ';
}

public static String soqlSelectAsterix(String ObjectName, String ReferencePrefix) {
    ObjectName = getObjectNamespacePrefixedName(ObjectName);  	// added 2013-10-23 - make it work with and without prefix
	List<string> elements = new List<String>();
	for(string field : getFields(ObjectName) ) {
		elements.add( ReferencePrefix+'.'+field );
	}
	return ' ' + String.join( elements, ', ' )+' ';
}

public static String soqlSelectAsterix(String ObjectName, String ReferencePrefix, string[] excludeFields ) {
    string[] lowerCaseExcludeFields = new string[]{}; // force to lowercase
	for(String field : excludeFields) lowerCaseExcludeFields.add(field.toLowerCase());
	excludeFields = lowerCaseExcludeFields;

	ObjectName = getObjectNamespacePrefixedName(ObjectName);
	List<string> elements = new List<String>();
	for(string field : getFields(ObjectName) ) {
		if( ! xt.inList( excludeFields, field.toLowerCase() )) { // compare to lowercase
			elements.add( ReferencePrefix+'.'+field );
		}
	}
	return ' ' + String.join( elements, ', ' )+' ';
}

public static string queryCreateSoql(string soql) { // USAGE: select *.not(Name|Employees|ACustomField__c) from Account where ....
	string 		objectBase			= null;
	string 		objectAlias			= '';
	string[] 	objectRefs			= new string[]{};
	string[] 	objectMods			= new string[]{};
	string[]	soqlTokens			= new string[]{};
	soql += ' ';
	xr r;
	r = xr.build('(?i)\\sfrom\\s+(\\w+)\\s+(\\w*)', soql ); // search for    from ENTITY ALIAS
	while(r.find()) {
		objectBase = r.group(1);
		if(r.group(2)!=null) if( ! xt.inList(  new string[]{'where','with','group','having','order','limit','for','offset','update'} ,  r.group(2).toLowerCase()   )) {
			objectAlias = r.group(2);
		}
	}
	r = xr.build('\\s+([\\w\\.]*?)\\.??\\*(.*?)[\\s,]', soql ); // search for   .*
	while(r.find()) {
		String objectRef = r.group(1);
		if(objectRef != '' && objectRef != objectBase ) {
			if(!objectRef.startsWith(objectBase+'.')) objectRef = objectBase + '.' + objectRef;
		}
		if(objectRef == '') {
			objectRef = objectBase;
		}

		if(r.group(2)!='') { xt.log('mods:'+r.group(2)); }
		objectRefs.add( objectRef );
		objectMods.add( r.group(2) );
		soqlTokens.add( r.group(0) );

	}
	integer i = 0;
	for(String 		objectRef : objectRefs) {
//xt.log( objectRef );
		string 		selectSoql 			= '';
		string 		objectType 			= xs.getObjectType(objectRef);
		string 		referencePrefix 	= objectRef;
		string[] 	excludeFields		= new string[]{};
		if(objectAlias!='') {
			if(objectRef!=objectBase) {
				referencePrefix = objectAlias+'.' + objectRef.removeStart(objectBase+'.');
			} else {
				referencePrefix = objectAlias+'' + objectRef.removeStart(objectBase+'');
			}
		}
		r = xr.build('\\.not\\((.*?)\\)', objectMods.get(i) );
		while(r.find()) {
			excludeFields.addAll( xt.explode('|',r.group(1).toLowerCase() ) );
		}
//xt.log( '--- '+objectType + ' - '+referencePrefix + ' - '+excludeFields + ' - ' );
		selectSoql = xs.soqlSelectAsterix( objectType, referencePrefix, excludeFields );
		soql = soql.replace(
				soqlTokens.get(i),
				selectSoql + (soqlTokens.get(i).endsWith(',')?' , ':'')
		);
		i++;
	}
	return soql;
}

public static string soql(string soql) { return queryCreateSoql(soql); }


public static sobject[] query(String soql) {
	soql = queryCreateSoql( soql );
	//try {
		return database.query( soql );
	//} catch(exception e) { return new sobject[]{}; }
}


//_____________________________________________________________________________________________________________________________________________
//	namespace functions 
//_____________________________________________________________________________________________________________________________________________

// will try to figure out the providing nsp of dev-orgs. Works only for user wich access to setup (/0A2)
public static string getOrgNamespacePrefix() {
	string result = '';
	string[] tds = new string[]{}; 
	PageReference p = new PageReference('/0A2');
    String html = '';
    if(!Test.isRunningTest()) { html = p.getContent().toString(); }
    html = html.replace('\r','');html = html.replace('\n','');
    xr r = new xr ('<td class="summaryYes">(.*?)</td>',  html  );
    // there are 0 to 3 matches, BUT only if there are exactly 3 matches, the third one is the namespace! 
    while(r.find()) {
        tds.add(r.group(1));
    }
    if(tds.size()==3) result=tds.get(2);
    return result;    
}


// commented out: can not work !!
// will try to figure out master-session-id from parent frame (non-visualforce context). Works only when elfAppCore is installed
// public static string getMasterSessionId() {
// 	string result = '';
// 	string[] tds = new string[]{}; 
// 	PageReference p = new PageReference('/');
//     String html = p.getContent().toString();
//     html = html.replace('\r','');html = html.replace('\n','');
//     xr r = new xr ('<span class="elfMasterSessionId" style="display: none;">(.*?)</span>',  html  );
//     result = r.pick(1);    
//     return result;    
// }



public static string removeNamespacePrefix(string ObjName) {
	if( ObjName.indexOf('__')>=0 && ObjName.indexOf('__') != ObjName.lastIndexOf('__') ) { // out of "prefix__test__c" get only "test__c"
		ObjName = ObjName.substringAfter('__');
	}
	return ObjName;
}


public static string getObjectNamespacePrefix(String ObjName) {
//xt.log('getPrefix : '+ObjName);
  try {																									// first, try it without prefix
    	return gds.get(  removeNamespacePrefix(ObjName) ).getDescribe().getName().replace(  removeNamespacePrefix(ObjName) ,'').replace('__','');
    } catch(exception e) {																					// later, try it prefixed
    	return gds.get( ObjName ).getDescribe().getName().replace( removeNamespacePrefix(ObjName) ,'').replace('__','');
    }
}
// public static string getObjectNamespacePrefix(String ObjName) {											// 2014-09-02: old version
//     ObjName = removeNamespacePrefix(ObjName); // in case its prefixed already, unprefix it!
//     return gds.get( ObjName ).getDescribe().getName().replace( ObjName ,'').replace('__','');
// }


public static string getObjectKeyPrefix(String ObjName) {
	return gds.get( ObjName ).getDescribe().getKeyPrefix();
}


public static string getObjectNamespacePrefixedName(String ObjName) {
 	try {
		return gds.get( removeNamespacePrefix(ObjName) ).getDescribe().getName();							// first, try it without prefix
	} catch(exception e) {
		return gds.get( ObjName ).getDescribe().getName();													// later, try it prefixed
	}
}
// public static string getObjectNamespacePrefixedName(String ObjName) {									// 2014-09-02: old version
//     ObjName = removeNamespacePrefix(ObjName); // in case its prefixed already, unprefix it!
// 	return gds.get( ObjName ).getDescribe().getName();
// }

//_____________________________________________________________________________________________________________________________________________
//	package functions 
//_____________________________________________________________________________________________________________________________________________

public class InstalledPackage {
	public string 				namespace;
	public string 				version;
	public string				publisher;
	public string				installDate;
}

public static map<string,InstalledPackage> getInstalledPackages() {
	map<string,InstalledPackage> results = new map<string,InstalledPackage>();
	string[] tables = new string[]{}; 
	string[] tds = new string[]{}; 
	PageReference p = new PageReference('/0A3');
    String html = '';
    if(!Test.isRunningTest()) { html = p.getContent().toString(); }
    html = html.replace('\r','');html = html.replace('\n','');
    xr r;
    r = new xr (''
    	+'<table class="list".*?>'
    		+'(.*?)'
    	+'</table>'
    ,html);
    while(r.find()) {
    	tables.add(r.group(1));
    }
	if(tables.size()>0) {
	    r = new xr (''
	    	+'<tr.*?>'
	    		+'.*?'+'<img'+'.*?'
	    		+'.*?'+'</th>'+'.*?'
	    		+'<td.*?class=".*?dataCell.*?">(.*?)</td>'
	    		+'<td.*?class=".*?dataCell.*?">(.*?)</td>'
	    		+'<td.*?class=".*?dataCell.*?">(.*?)</td>'
	    		+'<td.*?class=".*?dataCell.*?">(.*?)</td>'
	    		+'.*?'
	    	+'</tr>'
	    ,tables[0]);
	    while(r.find()) {
	    	InstalledPackage ip = new InstalledPackage();
	    	ip.publisher			= r.group(1).unescapeHtml4();
	    	ip.version				= r.group(2);
	    	ip.namespace			= r.group(3);
	    	ip.installDate			= r.group(4);
	    	results.put(ip.namespace,ip);
	    }
	}
    return results;    
}


//_____________________________________________________________________________________________________________________________________________
//	create objects 
//_____________________________________________________________________________________________________________________________________________


public static SObject newSObject(string objectName) {
	return (SObject) Type.forName(objectName).newInstance();
}

public static Object newObject(string objectName) {
	return Type.forName(objectName).newInstance();
}


//_____________________________________________________________________________________________________________________________________________
//	schema functions 
//_____________________________________________________________________________________________________________________________________________

public static Map<String, Schema.SObjectField> getFieldMap(String ObjectName) { // new version 2013-10-23
    return org.get(ObjectName).soFields;
}

public static List<String> getFields(String ObjectName) { // new version 2013-10-23
	return  xt.toList( org.get(ObjectName).fields.keyset() );
}

// public static string getType(SObject obj) { // DEPRECIATED old version (as of 2014-08-28)
// 	if(obj==null) return '';
// 	return obj.getSObjectType().getDescribe().getName()+'';
// }

// public static string getTypeDetect(Decimal 				o) { return 'Decimal'; }
// public static string getTypeDetect(Double 				o) { return 'Double'; }
// public static string getTypeDetect(Set<object> 			o) { return 'Set'; }
// public static string getTypeDetect(Map<object,object> 	o) { return 'Map'; }
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

public static void getType_StaticTest() {
	list<string>t00 = new list<string>{'test'};				xt.log('List<string> : ' + xs.getType(t00));
	Account 	t01 = new Account(); 						xt.log('Account : ' + xs.getType(t01));
	Boolean 	t02 = true; 								xt.log('Boolean : ' + xs.getType(t02));
	Boolean 	t03 = false; 								xt.log('Boolean : ' + xs.getType(t03));
	String 		t04 = 'sdfsdf'; 							xt.log('String  : ' + xs.getType(t04));
	Id 			t05 = [select id from user limit 1][0].Id; 	xt.log('Id : ' 		+ xs.getType(t05));
	Blob		t06 = Blob.valueOf('testsdf'); 				xt.log('Blob : '	+ xs.getType(t06));
	Datetime	t07 = Datetime.now();						xt.log('Datetime : '+ xs.getType(t07));
	Time		t08 = Time.newInstance(18, 30, 2, 20);		xt.log('Time : '	+ xs.getType(t08));
	Date		t09 = (Date) Date.today();					xt.log('Date : '	+ xs.getType(t09));
	Integer		t10 = 7;									xt.log('Integer : '	+ xs.getType(t10));
	Decimal		t11 = 18.99;								xt.log('Decimal : '	+ xs.getType(t11));
	Double		t12 = 77.99;								xt.log('Double : '	+ xs.getType(t12));
	Long		t13 = 9;									xt.log('Long : '	+ xs.getType(t13));
    
	list<string>		c01 = new list<string>{'test'};			xt.log('List<String> : ' 		+ xs.getType(c01));
	set<string>			c02 = new set<string>{'test345'};		xt.log('Set<String> : ' 		+ xs.getType(c02));
	map<string,string>	c03 = new map<string,string>{'a'=>'b'};	xt.log('Map<String,String> : ' 	+ xs.getType(c03));
}

////////////////////////////////////////////////////////////////////////////////////////////
// get value by fieldReference (path to subitems). On Accounts fieldReference could be Parent.AnnualRevenue
//public static Object getValue(SObject aSObject, String fieldReference) { return null; } // DEPRICIATED !!!!!
public static Object getFieldValue(SObject aSObject, String fieldReference) {
	Object result = null;
	String type   = '';
	List<string> 	FieldLevels = fieldReference.split('\\.');
	SObject 		InnerObject = aSObject;
	String 			FieldName = fieldLevels[FieldLevels.size()-1];
	if(false) { // switch
		} else if(fieldLevels.size()==2) {
			InnerObject = aSobject.getSObject(fieldLevels[0]);
		} else if(fieldLevels.size()==3) {
			InnerObject = aSobject.getSObject(fieldLevels[0]).getSObject(fieldLevels[1]);
	}
	//type   = InnerObject.getSObjectType().getDescribe().fields.getMap().get(FieldName).getDescribe().getType()+'';
	result = InnerObject.get(FieldName);
	return result;
}

////////////////////////////////////////////////////////////////////////////////////////////
// get type by fieldReference (path to subitems). On Accounts fieldReference could be Parent.AnnualRevenue
//public static Object getType(SObject aSObject, String fieldReference) {
//public static String getType(SObject aSObject, String fieldReference) { return null; } // DEPRICIATED !!!!!
public static String getFieldType(SObject aSObject, String fieldReference) {
	//Object result = null;
	String result = null;
	List<string> 	FieldLevels = fieldReference.split('\\.');
	SObject 		InnerObject = aSObject;
	String 			FieldName = fieldLevels[FieldLevels.size()-1];
	if(false) { // switch
		} else if(fieldLevels.size()==2) {
			InnerObject = aSobject.getSObject(fieldLevels[0]);
		} else if(fieldLevels.size()==3) {
			InnerObject = aSobject.getSObject(fieldLevels[0]).getSObject(fieldLevels[1]);
	}
	//try {
		result = xs.getFieldType( (InnerObject.getSObjectType().getDescribe().getName()+'').toLowerCase() , FieldName);
	//} catch(Exception e)  {}
	return result;
}


public static String getFieldType(String ObjectName, String FieldName) {
	string result = 'undefined';
	try {
		result = xs.org.get( ObjectName.toLowerCase() ).get( FieldName.toLowerCase() ).type;
	} catch(Exception e) { }
	return result;
}

// Usage:
// param "Opportunity.Account.Owner" ===> User
// namespaceprefixes are added automatically
public static xsField getField(String reference) { 
	string[] 		refs 			= xt.explode('.',reference);
	xsObject 		curObject			= null;
	integer i = 0;
	for( string ref : refs ) {
		if(i == 0) {
			string prefix = '';
			if(ref.endsWith('__c')) {
				prefix = getObjectNamespacePrefix( ref )!='' ? getObjectNamespacePrefix( ref )+'__' : '';	// 2014-09-02: swapped the order of this lines
			    ref = removeNamespacePrefix(ref);															// 2014-09-02: swapped the order of this lines	
			}
// xt.log('START : '+ref);			
			curObject = org.get( prefix + ref );
// xt.log('STRAR-res : '+curObject.name);			
			if(curObject == null) return null;
		}
		if(i>0 && i<refs.size()-1 ) { 
			if(ref.endsWith('__r')) {  							// try for a custom-reference
				try {
					curObject = org.get(     org.get( curObject.name ).get( ref.removeEnd('__r')+'__c' ).referenceType   );
// xt.log('__r : '+curObject.name);			
				} catch(exception e) { return null;	}
			} else /*if(ref.endsWith('Id'))*/ {	 				// try for a standard-reference
				try {
					curObject = org.get(     org.get( curObject.name ).get(ref+'Id').referenceType   );
// xt.log('Id : '+curObject.name);			
				} catch(exception e) { return null;	}
			}
		}
		if(i == refs.size()-1 ) {
// xt.log('Result : ' + curObject.name + ' ref='+ref);			
			return curObject.get( ref ) ;
		}
		i++;
	}
// xt.log('-----');	
	return null; 												// this should never be reached
}


// Usage:
// param "Opportunity.Account.Owner" ===> User
// namespaceprefixes are added automatically
public static String getObjectType(string objectReference) {
	string[] 		refs 			= xt.explode('.',objectReference);
	xsObject 		curObject			= null;
	integer i = 0;
	for( string ref : refs ) {
	    
		if(i == 0) {
			string prefix = '';
			if(ref.endsWith('__c')) {
			 // to following is a big shit! it must work from inside and outside managed packages. Can be done way better, but excessive testing required !!
			    //string oldPrefix = ref.removeEnd('__c').substringBefore('__')+'__'; 								// 2014-09-02: added 
			    																	// worked before
				//try { 																								// 2014-09-02: added
				prefix = getObjectNamespacePrefix( ref )!='' ? getObjectNamespacePrefix( ref )+'__' : '';		// worked before
				ref = removeNamespacePrefix(ref);
				// } catch(exception e) {																				// 2014-09-02: added
				// 	prefix = oldPrefix;																				// 2014-09-02: added
				// }																									// 2014-09-02: added	
			}
			curObject = org.get( prefix + ref );
			if(curObject == null) return null;
		}
		if(i > 0 ) {
			if(ref.endsWith('__r')) {  							// try for a custom-reference
				try {
					curObject = org.get(     org.get( curObject.name ).get( ref.removeEnd('__r')+'__c' ).referenceType   );
				} catch(exception e) { return null;	}
			} else /*if(ref.endsWith('Id'))*/ {	 				// try for a standard-reference
				try {
					curObject = org.get(     org.get( curObject.name ).get(ref+'Id').referenceType   );
				} catch(exception e) { return null;	}
			}
		}
		if(i == refs.size()-1 ) {
			return curObject.name ;
		}
		i++;
	}
	return null; 												// this should never be reached
}




////////////////////////////////////////////////////////////////////////////////////////////
// checks if a fieldReference exists on an object
public static list<string> getVerifiedFieldList(SObject aSObject, list<string> fiedReferences) {
	list<string> result = new list<string>();
	for(string fieldReference : fiedReferences) {
		if( getFieldExists(aSObject, fieldReference ) ) result.add(fieldReference);
	}
	return result;
}

////////////////////////////////////////////////////////////////////////////////////////////
// checks if a fieldReference exists on an object
public static boolean getFieldExists(SObject aSObject, string fieldReference) {
	object  value  = null;
	List<string> 	refs 	= fieldReference.split('\\.');
	SObject 		obj 	= aSObject;
	integer			level 	= 0;
	integer			levelCount 	= refs.size();
	for(string ref : refs) {
		boolean proceed = false;
		level++;
//xt.log(ref+' ('+level+')');
		try {
			value = obj.get(ref);		// try for a field
			return true;   				// got a field
		} catch(exception e) {
//xt.log('noField:'+ref);
		}								// no field, but could still be a reference
		try {							// try for reference
			if(ref.endsWith('__r')) {  	// try for a custom-reference
				obj = (SObject) newObject(  org.get( getType(obj) ).get( ref.removeEnd('__r')+'__c' ).referenceType );
//xt.log('type:'+ xs.getFieldType(obj,ref) );
				proceed = true;
			} else {					// try for a standard-reference
				obj = (SObject) newObject(  org.get( getType(obj) ).get(ref+'Id').referenceType );
//xt.log('type:'+ xs.getType(obj,ref+'Id') );//xt.log('NEW-type:'+ getType(obj) );
				proceed = true;
			}
		} catch(exception e) { }
//xt.log('ERROR:'+ (ref) );
		if(!proceed) return false;
	}
	return false; 						// nothing matched
}



public static Map<String,String> getChildRelationships(String ObjectName) { //key is "ObjectName.RelationshipName"
	Map<string,string> result = new Map<string,string>();
	List<Schema.ChildRelationship> crs = Schema.getGlobalDescribe().get(ObjectName).getDescribe().getChildRelationships();
	for(Schema.ChildRelationship cr : crs) if(cr.getRelationshipName() != null) {
		String out = cr.getChildSObject().getDescribe().getName()+'.'+cr.getField().getDescribe().getName();
		result.put(cr.getRelationshipName(),out);
//System.debug(cr.getRelationshipName()+' ====> '+ out );
	}
	return result;
}

public static Map<String,String> getChildRelationshipsByObjectNames(String ObjectName) { // key is only "ObjectName"
	Map<string,string> result = new Map<string,string>();
	List<Schema.ChildRelationship> crs = Schema.getGlobalDescribe().get(ObjectName).getDescribe().getChildRelationships();
	for(Schema.ChildRelationship cr : crs) if(cr.getRelationshipName() != null) {
		String out = cr.getChildSObject().getDescribe().getName()+'';
		result.put(out,cr.getRelationshipName());
//System.debug(cr.getRelationshipName()+' ====> '+ out );
	}
	return result;
}

// public static List<String> getPicklistValues(String ObjectName,String FieldName){ 
//   	List<String> 					results				= new List<String>();
// 	List<Schema.PicklistEntry> 		pes 				= org.get(ObjectName).get(FieldName).soResult.getPickListValues();
// 	for(Schema.PicklistEntry pe : pes) { 
//   		results.add(pe.getValue());
//   	}
//   	return results;	
// }

public static List<String> getPicklistValues(String ObjectName,String FieldName){ 
	return org.get(ObjectName).get(FieldName).getPickListValues();
}
	


public static boolean isNumber(String ObjectName, String FieldName) {
    string type = null;
    try { type = org.get(ObjectName).get(FieldName).type; } catch(exception e) { return false; }
    return false
    	|| type == 'currency'
        || type == 'integer'
        || type == 'percent'
        || type == 'double'
	;
}

public static boolean isNumber(SObject o, String fieldReference) {
    string type = null;
    try { type = getFieldType(o,fieldReference); } catch(exception e) { return false; }
    return false
    	|| type == 'currency'
        || type == 'integer'
        || type == 'percent'
        || type == 'double'
	;
}


public static boolean isDateOrTime(String ObjectName, String FieldName) {
    string type = null;
    try { type = org.get(ObjectName).get(FieldName).type; } catch(exception e) { return false; }
    return false
    	|| type == 'time'
        || type == 'date'
        || type == 'datetime'
	;
}



public static boolean isText(String ObjectName, String FieldName) {
    string type = null;
    try { type = org.get(ObjectName).get(FieldName).type; } catch(exception e) { return false; }
    return false
    	|| type == 'string'
        || type == 'textarea'
        || type == 'encryptedstring'
	;
}

public static boolean isText(SObject o, String fieldReference) {
    string type = null;
    try { type = getFieldType(o,fieldReference); } catch(exception e) { return false; }
    return false
    	|| type == 'string'
        || type == 'textarea'
        || type == 'encryptedstring'
	;
}

public static boolean isPicklist(SObject o, String fieldReference) {
    string type = null;
    try { type = getFieldType(o,fieldReference); } catch(exception e) { return false; }
    return false
    	|| type == 'picklist'
	;
}

/* this testcode is designed to run on dev13 */
/* 2014:09-02 : updated fixed bugs to access from outside managed package
/* 2014:08-22 : TEST I see no way to write, because we can not have any relaiable CustomField present in every Org...  
// xt.log(xs.getObjectNamespacePrefix('elfXLog__elfXLog__c'));                    
// xt.log(xs.getField('Opportunity.Account.Owner.Name').type);                    
// xt.log(xs.getField('elfXLog__elfXLog__c.Owner.Name').isCustom);                    
// xt.log(xs.getObjectType('Opportunity.Account'));                    
// xt.log(xs.getObjectType('Opportunity.Account'));                    
// xt.log(xs.getField('elfXLog__elfXLog__c.Name'));                    
// xt.log(xs.getField('elfXLog__elfXLog__c.Owner'));                    
// xt.log( xs.org.get('wordFusion__elfDPImport__c').isCustom );                    
// xt.log( xs.org.get('Name').getFieldNames() );                    
// xt.log( xs.org.get('Lead').get('OwnerId').referenceType );                    
// xt.log(xs.queryCreateSoql('select *, CreatedBy.*, Owner.TestB__r from Account limit 1 '));                    
// xt.log(xs.getObjectType('Account.Owner.LastModifiedBy'));                    
// xt.log(xs.getObjectType('Account.Owner.wordFusion__TestB__r'));                    
// xt.log(xs.getObjectType('elfXLog__elfXLog__c'));               
// xt.log(Schema.getGlobalDescribe().get( 'elfXLog__elfXLog__c' ).getDescribe().getName() );
// xt.log(xs.getObjectNamespacePrefix('wordFusion__elfDPImport__c'));                    
// xt.log(xs.getObjectNamespacePrefix('elfDPImport__c'));                    
// xt.log(xs.getObjectNamespacePrefix('elfXLog__elfXLog__c'));                    
// xt.log(xs.queryCreateSoql('select Owner.* from wordFusion__elfDPImport__c limit 1 '));                    
// xt.log(xs.query('select *, CreatedBy.*, Owner.* from wordFusion__elfDPImport__c limit 1 '));                    
// xt.log(xs.query('select *, CreatedBy.*, Owner.wordFusion__TestB__r.* from Account limit 1 '));                    
// xt.log(xs.query('select *, CreatedBy.*, Owner.* from elfXLog__elfXLog__c limit 1 ')); //, CreatedBy.*, Owner.*                    
*/


public static testMethod void test() {
    String 									s 					= '';
	List<String> 							ls 					= new List<String>();
	Map<String,String> 						ms 					= new Map<String,String>();
	Map<String, Schema.SObjectField> 		mSObjectField		= new Map<String, Schema.SObjectField>();
	Object 									o;
	SObject 								so;
	Boolean 								b;
	Account									a;
	Account									a1;
	Account									a2;
	xsField 								xsf;
	list<SObject>							os;
	xs.InstalledPackage						ip					= new xs.InstalledPackage();
	map<string, xs.InstalledPackage>		mips				= new map<string, xs.InstalledPackage>();
	
	s 					= xs.getObjectKeyPrefix('Account');
	s 					= xs.getObjectNamespacePrefix('Account');
	s 					= xs.getObjectNamespacePrefixedName('Account');
    s 					= xs.soqlSelectAsterix('Account');
    s 					= xs.soqlSelectAsterix('Account','a');
    s 					= xs.getFieldType('Account','Name');
    a2 					= new Account(Name='Test2');
    upsert a2;
    a1 					= new Account(Name='Test1',ParentId=a2.Id);
    upsert a1;
    a 					= [select Id, Name, Owner.LastName, Parent.Owner.LastName from Account where Id=:a1.Id limit 1];
    
    o 					= xs.getFieldValue(a,'Name');
    o 					= xs.getFieldValue(a,'Owner.LastName');
    o 					= xs.getFieldValue(a,'Parent.Owner.LastName');
    o 					= xs.getFieldType(a,'Name');
    o 					= xs.getFieldType(a,'Owner.LastName');
    o 					= xs.getFieldType(a,'Parent.Owner.LastName');
    o 					= xs.getFieldType(a,'987345908 unoirtgj ²³');  
    ms 					= xs.getChildRelationships('Account');
    ms 					= xs.getChildRelationshipsByObjectNames('Account');
    
    b 					= isNumber('Account','Name');
    b 					= isNumber(new Account(),'Name');
    b 					= isText('Account','Name');
    b 					= isText(new Account(),'Name');
    b 					= isDateOrTime('Account','Name');
    b 					= isPicklist(new Account(),'Name');
    
    s 					= xs.org.get('Account').get('Name').type;
    //s 					= xs.org.get('Account').get('Name').type;
    s 					= getFieldType('Account','Name');//xs.org.get('Account').get('Namee').type;
    s 					= getFieldType('Account','Nameeee');//xs.org.get('Account').get('Namee').type;
    mSObjectField 		= xs.getFieldMap('Account');
    s 					= xs.removeNamespacePrefix('prefix__test__c');
    
    ls 					= xs.org.get('Account').getFieldNames();
    s 					= getObjectType('Opportunity.Account.Owner');
    
    xsf 				= xs.getField('Opportunity.Account.Owner.Name');
    ls 					= xs.getField('Account.Type').getPickListValues() ;
    ms 					= xs.org.get('Account').getFieldLabels() ;
    ms 					= xs.org.getObjectLabels() ;
    s					= xs.soql('select * from Account limit 1');
    os					= xs.query('select * from Account limit 1');
    os					= xs.query('select *.not(Name|Employees), Account.Name, Account.CreatedBy.* from Opportunity limit 1');
    s					= getOrgNamespacePrefix();
    mips				= xs.getInstalledPackages();
    
    so					= xs.newSObject('Account');
    o					= xs.newObject('Account');
    s					= xs.getType(so);
    
 

    ls					= getVerifiedFieldList( new Account(Name='testVFL') , new string[]{ 'Name','Id' } );
    
    ls					= getPickListValues('Account','Type');
    
}




}















/*
//DEPRECIATED: consumes schema-limits
public static boolean isText(String ObjectName, String FieldName) {
 Schema.DisplayType dt = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap().get(FieldName).getDescribe().getType();
 return false
		|| dt == Schema.Displaytype.String
     || dt == Schema.Displaytype.TextArea
     || dt == Schema.Displaytype.EncryptedString
	;
}
*/


/*
// DEPRECIATED: consumes schema-limits
public static boolean isDateOrTime(String ObjectName, String FieldName) {
    Schema.DisplayType dt = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap().get(FieldName).getDescribe().getType();
    return false
		|| dt == Schema.Displaytype.Time
        || dt == Schema.Displaytype.Date
        || dt == Schema.Displaytype.Datetime
	;
}
*/




/*
// DEPRECIATED: consumes schema-limits
public static boolean isNumber(String ObjectName, String FieldName) {
    Schema.DisplayType dt = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap().get(FieldName).getDescribe().getType();
    return false
    	|| dt == Schema.Displaytype.Currency
        || dt == Schema.Displaytype.Integer
        || dt == Schema.Displaytype.Percent
        || dt == Schema.Displaytype.Double
	;
}
*/





/*
public static Map<String, Schema.SObjectField> getFieldMap(String ObjectName) { // UNBUFFERD VERSION WILL EAT UP LIMITS
    return Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap();
}

public static List<String> getFields(String ObjectName) {
	List<String> result = new List<String>();
	for(Schema.SObjectField field : getFieldMap(ObjectName).values() ){
	   result.add(field+'');
	}
	return result;
}
*/






/*
public static String getFieldType(String ObjectName, String FieldName) {
    if(ObjectName==null || FieldName==null) return '';
    if( FieldName.countMatches('__') > 1 ) FieldName = Fieldname.substringAfter('__');
    String out = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap().get(FieldName).getDescribe().getType()+'';
    //System.debug('=============================>'+out);
    return Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap().get(FieldName).getDescribe().getType()+'';
}
*/


/*
public static Object getValue2(SObject aSObject, String fieldReference) {
	Object result = null;
	string type = '';
	List<string> fieldLevels = xt.explode('.',fieldReference);
	if(false) { // switch
		} else if(fieldLevels.size()==1) {
			result = aSObject.get(fieldLevels[0]) ;
		} else if(fieldLevels.size()==2) {
			try {
				result = aSobject.getSObject(fieldLevels[0]).get(fieldLevels[1]) ;
			} catch(Exception e) {
				result = null;
			}
		} else if(fieldLevels.size()==3) {
			try {
				result = aSobject.getSObject(fieldLevels[0]).getSObject(fieldLevels[1]).get(fieldLevels[2])  ;
			} catch(Exception e) {
				result = null;
			}
	}
	return result;
}
*/


/*
public static string type(object o) {
	string result = '?';
	if(o==null) result = 'null';
	//return(string.valueof(o));
	//Type t = o.class;
	if(Type.forName('string').equals(o)) 	{ result = 'string'; }
	if(Type.forName('decimal').equals(o)) 	{ result = 'decimal'; }
	if(Type.forName('integer').equals(o)) 	{ result = 'integer'; }
	if(Type.forName('double').equals(o)) 	{ result = 'double'; }
	if(Type.forName('long').equals(o)) 		{ result = 'long'; }
	if(Type.forName('datetime').equals(o)) 	{ result = 'datetime'; }
	if(Type.forName('date').equals(o)) 		{ result = 'date'; }
	if(Type.forName('time').equals(o)) 		{ result = 'time'; }
	//if(Type.forName('decimal').equals(o)) {return 'decimal';}
	return result;
}
*/

/*
private static String t(string Value)	{ return 'string'; }
private static String t(integer Value)	{ return 'integer'; }
private static String t(Double Value) 	{ return 'double'; }
private static String t(Boolean Value) 	{ return 'boolean'; }
private static String t(Long Value)		{ return 'long'; }
private static String t(Date Value)		{ return 'date'; }
private static String t(Datetime Value)	{ return 'datetime'; }
private static String t(Time Value)		{ return 'time'; }
private static String t(Decimal Value)	{ return 'decimal'; }
*/
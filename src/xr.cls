//_______________________________________________________________________________________________________________
public without sharing class xr {
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


<class name="xr" longname="xregex">
	<description>
		force.com wrapper for matcher and pattern
	<description>
	<require>
	</require>
	<changelog>
		<v n="1.0.1"> added License Block																(2014-09-17) </v>
		<v n="1.0.0"> changed header to xml																(2014-03-23) </v>
		<v n="0.9.3"> HEAD		 																					 </v>
		<v n="0.9.2"> HEAD 																							 </v>
		<v n="0.9.1"> renamed to xr 																				 </v>
		<v n="0.9.0"> start track as xregex-class																	 </v>
	</changelog>
</class>
*/
//_______________________________________________________________________________________________________________

	public static xr build(string regex, string haystack) {
		return new xr(regex,haystack);
	}

	public pattern p;
	public matcher m;

	public xr(string regex, string haystack) {
		p = pattern.compile( regex );
		m = p.matcher(haystack);
	}

	public boolean find() {
		return m.find();
	}

	public string group(integer i) {
		try {
			return m.group(i);
		} catch(exception e) {
			return null;
		}
	}

	public integer end(integer i) {
		try {
			return m.end(i);
		} catch(exception e) {
			return null;
		}
	}

	public integer start(integer i) {
		try {
			return m.start(i);
		} catch(exception e) {
			return null;
		}
	}

	public string pick(integer i) {
		//if(m.find()) return m.group(1); else return '';
		if(m.find()) return m.group(i); else return '';
	}




}
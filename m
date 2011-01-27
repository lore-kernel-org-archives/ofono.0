Content-Type: multipart/mixed; boundary="===============8686837470456230962=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 17:53:32 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9C997E3A@irsmsx501.ger.corp.intel.com>
In-Reply-To: <AANLkTi==Pz3ObYKNwSF3NA_xp0Pp6C=5sgchKMfM7O0h@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8686837470456230962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka, Sjur,

> I think we need these in ConnectionContext, or perhaps a separate
> DedicatedContext interface would be better. The structure of QoS TFT
> =

> Also the PcscfAddresses should be part of the Settings  or Settings6
> in ConnectionContext.
> =


I prepared a patched in this way sometimes ago for the Dedicated Bearers ma=
ybe it can help :

--
*** ofono-0.36/doc/connman-api.txt	2010-10-31 17:48:50.000000000 +0100
--- ofono-patched/doc/connman-api.txt	2010-12-09 17:44:32.694063480 +0100
***************
*** 132,141 ****
--- 132,163 ----
  					 [service].Error.NotAttached
  					 [service].Error.AttachInProgress
  =

+ 		array{object,dict} GetSecondarys()
+ =

+ 			Get array of secondary context objects and properties.
+ =

+ 			The method should only be call once per application.
+ 			Further changes shall be monitored via SecondaryAdded
+ 			SecondaryRemoved signals.
+ =

+ =

  Signals		PropertyChanged(string property, variant value)
  =

  			This signal indicates a changed value of the given
  			property.
+ 			=

+ 		SecondaryAdded(object path, dict properties)
+ =

+ 			Signal that gets emitted when a new secondary context has
+ 			been created.  It contains the secondary context object path
+ 			and its properties.
+ =

+ 		SecondaryRemoved(object path)
+ =

+ 			Signal that gets emitted when a secondary context has been
+ 			removed.  The object path of the secondary context is only
+ 			included for reference.  Its properties are no
+ 			longer accessible at this point.
  =

  Properties	boolean Active [readwrite]
  =

***************
*** 239,241 ****
--- 261,350 ----
  		string MessageCenter [readwrite, MMS only]
  =

  			Holds the MMSC setting.
+ 			=

+ 			=

+ 			=

+ 			=

+ Connection Secondary Context hierarchy
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ Service		org.ofono
+ Interface	org.ofono.SecondaryConnectionContext
+ Object path	/modemX/contextX/secondaryY
+ =

+ =

+ Methods 	void Close()
+ 			Deactivate secondary context (dedicated bearer in LTE)
+ 			=

+ 		array{object,dict} GetTFTs()
+ =

+ 			Get array of TFT objects and properties.
+ =

+ 			The method should only be call once per application.
+ 			Further changes shall be monitored via TFTAdded
+ 			TFTRemoved signals.
+ =

+ Signals		TFTAdded(object path, dict properties)
+ =

+ 			Signal that gets emitted when a new context has
+ 			been created.  It contains the context object path
+ 			and its properties.
+ =

+ 		TFTRemoved(object path)
+ =

+ 			Signal that gets emitted when a context has been
+ 			removed.  The object path of the context is only
+ 			included for reference.  Its properties are no
+ 			longer accessible at this point.			=

+ =

+ TFT hierarchy
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ Service		org.ofono
+ Interface	org.ofono.TFT
+ Object path	/modemX/contextX/secondaryY/TFTZ
+ =

+ Methods		dict GetProperties()
+ 			Returns all properties for the context object.
+ =

+ 			Possible Errors: [service].Error.InvalidArguments
+ =

+ 		void SetProperty(string property, variant value)
+ =

+ 			Sets the property to a desired value
+ =

+ 			Possible Errors: [service].Error.InvalidArguments
+ 					 [service].Error.InvalidFormat
+ 					 [service].Error.Failed
+ 					 =

+ 		object GetSecondaryContext()
+ 			=

+ 			Returns the related Secondary(dedicated) context
+ 				=

+ =

+ Signals		PropertyChanged(string property, variant value)
+ =

+ 			This signal indicates a changed value of the given
+ 			property.
+ =

+ Properties  string DestinationAddress [read]
+ =

+ 			Holds the destination Address
+ =

+ 		string SubnetMask [read]
+ 		=

+ 			Holds the SbunetMask
+ =

+ 		integer DestinationPortRangeStart [read]
+ 		=

+ 			Holds the destination port range start
+ 		=

+ 		integer DestinationPortRangeEnd [read]
+ 		=

+ 			Holds the destination port range end
+ 		=

+ 		integer SourcePortRangeStart [read]
+ 		=

+ 			Holds the source port range start
+ 			=

+ 		integer SourcePortRangeEnd [read]
+ 		=

+ 			Holds the source port range end


Regards,
Redouane.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8686837470456230962==--


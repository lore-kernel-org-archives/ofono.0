Content-Type: multipart/mixed; boundary="===============4265211700014891962=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 15:42:40 -0700
Message-ID: <1251844960.1266.53.camel@localhost.localdomain>
In-Reply-To: <200909011636.49020.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4265211700014891962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> So as it happens I had also been brainstorming a GPRS API for the last se=
veral =

> days.  And somewhat spontaneously a GPRS api discussion happened on IRC =

> between myself, Marcel and Ismo.  The following GPRS API proposal is a re=
sult =

> of this discussion.  I'd like all interested to comment.  What needs =

> improvement? What is missing?  What should be removed?
> =

> Please note that Secondary PDP contexts, Traffic Filters and Network Acti=
vated =

> (Incoming) PDP contexts are not covered in this proposal.  These features=
 are =

> not commonly used and none of us have real experience with them yet.  How=
ever, =

> we considered these features and have left room in the APIs for further =

> expansion.
> =

> Data Connection Manager hierarchy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Service		org.ofono
> Interface	org.ofono.DataConnectionManager

I think this should be GPRSManager or something to clearly separate
between GRPS connections and actual data connection,

> Object path	[variable]
> =

> Methods		dict GetProperties()
> =

> 			Returns all global system properties. See the
> 			properties section for available properties.
> =

> 			Possible Errors: [service].Error.InvalidArguments
> =

> 		void SetProperty(string property, variant value)
> =

> 			Sets the property to a desired value
> =

> 			Possible Errors: [service].Error.InvalidArguments
> 					 [service].Error.InvalidFormat
> 					 [service].Error.Failed
> =

> 		void DeactivateAll()
> =

> 			Deactivates all active contexts.
> =

> 		object CreateContext()
> =

> 			Creates a new Primary context.  Returns the object
> 			path of the created context.
> =

> 		object RemoveContext()
> =

> 			Removes a primary context.  All secondary contexts, if
> 			any, associated with the primary context are also
> 			removed.

I assume this is void RemoveContext(object context)

> Signals		PropertyChanged(string property, variant value)
> =

> 			This signal indicates a changed value of the given
> 			property.
> =

> Properties	array{object} PrimaryContexts [readonly]
> =

> 			List of all primary contexts objects.

Calling this just Contexts seems to more reasonable. See comment about
interface name below.

> 		boolean Attached [readonly]
> =

> 			Contains whether the Packet Radio Service is attached.
> 			The attach state might change dynamically based on
> 			availability of network resources.  If this value
> 			changes to false, the user can assume that all
> 			contexts have been deactivated.
> =

> 			If the modem is detached, certain features will not
> 			be available, e.g. receiving SMS over packet radio
> 			or network initiated PDP activation.
> =

> 		boolean RoamingAllowed [readwrite]
> =

> 			Contains whether data roaming is allowed.  In the off
> 			setting, if the packet radio registration state
> 			indicates that the modem is roaming, oFono will
> 			automatically detach and no further connection
> 			establishment will be possible.
> =

> 		boolean Powered [readwrite]
> =

> 			Controls whether packet radio use is allowed. Setting
> 			this value to off detaches the modem from the
> 			Packet Domain network.
> 			=

> 		string Status [readonly]
> =

> 			The current packet radio registration status of a modem.
> =

> 			The possible values are: =

> 				"unregistered"  Not registered to any network
> 				"registered"    Registered to home network
> 				"searching"     Not registered, but searching
> 				"denied"        Registration has been denied
> 				"unknown"       Status is unknown
> 				"roaming"       Registered, but roaming
> =

> 		uint16 LocationAreaCode [readonly, optional]
> =

> 			Contains the current location area code.
> =

> 		uint32 CellId [readonly, optional]
> =

> 			Contains the current network cell id.
> =

> 		string Technology [readonly, optional]
> =

> 			Contains the technology of the current network.
> =

> 			The possible values are: "GSM", "GSMCompact", "UTRAN",
> 						 "GSM+EGPS", "UTRAN+HSDPA",
> 						 "UTRAN+HSUPA",
> 						 "UTRAN+HSDPA+HSUPA",
> 						 "E-UTRAN"
> =

> Primary Data Context hierarchy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Service		org.ofono
> Interface	org.ofono.PrimaryDataContext

I would prefer if we just call this GRPSContext and explain that this is
for the primary context. The confusion between primary context and
secondary context is some GSM specific non-sense.

> Object path	[variable]
> =

> Methods		dict GetProperties()
> 			Returns all properties for the context object.
> =

> 			Possible Errors: [service].Error.InvalidArguments
> =

> 		void SetProperty(string property, variant value)
> =

> 			Sets the property to a desired value
> =

> 			Possible Errors: [service].Error.InvalidArguments
> 					 [service].Error.InvalidFormat
> 					 [service].Error.Failed
> =

> Signals		PropertyChanged(string property, variant value)
> =

> 			This signal indicates a changed value of the given
> 			property.
> =

> Properties	boolean Activated [readwrite]
> =

> 			Holds whether the context is activated.  This value
> 			can be set to activate / deactivate the context.
> =

> 		string AccessPointName [readwrite]
> =

> 			Holds the name of the access point.  This is
> 			abbreviated as APN.  This value cannot be changed when
> 			the context is active.
> =

> 		string Username [readwrite]
> =

> 			Holds the username to be used for authentication
> 			purposes.  This value cannot be changed when the
> 			context is active.
> =

> 		string Password [readwrite]
> =

> 			Holds the password to be used for authentication
> 			purposes.  This value cannot be changed when the
> 			context is active.
> =

> 		string Interface [readonly, optional]
> =

> 			Holds the interface of the network interface created
> 			by this context (e.g. "ppp0")

Our current assumption is that the basic setup of IP address, netmask
and broadcast are done by oFono. Only routing and DNS are up to other
programs like ConnMan for example.

> 		array{string} DomainNameServers [readonly, optional]
> =

> 			Holds the list of domain name servers for this
> 			context.

What about the gateway value. In theory we can just route it to the
interface, but if the device fakes a real Ethernet interface and the
gateway is in a different subnet we need a proper host route first.

Regards

Marcel



--===============4265211700014891962==--


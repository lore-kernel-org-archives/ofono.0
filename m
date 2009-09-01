Content-Type: multipart/mixed; boundary="===============8760439841171246504=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 16:36:48 -0500
Message-ID: <200909011636.49020.denkenz@gmail.com>
In-Reply-To: <a4e57c0e0909010409m1ccd4326scf28151fe8afb859@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8760439841171246504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Everyone,

So as it happens I had also been brainstorming a GPRS API for the last seve=
ral =

days.  And somewhat spontaneously a GPRS api discussion happened on IRC =

between myself, Marcel and Ismo.  The following GPRS API proposal is a resu=
lt =

of this discussion.  I'd like all interested to comment.  What needs =

improvement? What is missing?  What should be removed?

Please note that Secondary PDP contexts, Traffic Filters and Network Activa=
ted =

(Incoming) PDP contexts are not covered in this proposal.  These features a=
re =

not commonly used and none of us have real experience with them yet.  Howev=
er, =

we considered these features and have left room in the APIs for further =

expansion.

Data Connection Manager hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service		org.ofono
Interface	org.ofono.DataConnectionManager
Object path	[variable]

Methods		dict GetProperties()

			Returns all global system properties. See the
			properties section for available properties.

			Possible Errors: [service].Error.InvalidArguments

		void SetProperty(string property, variant value)

			Sets the property to a desired value

			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.InvalidFormat
					 [service].Error.Failed

		void DeactivateAll()

			Deactivates all active contexts.

		object CreateContext()

			Creates a new Primary context.  Returns the object
			path of the created context.

		object RemoveContext()

			Removes a primary context.  All secondary contexts, if
			any, associated with the primary context are also
			removed.

Signals		PropertyChanged(string property, variant value)

			This signal indicates a changed value of the given
			property.

Properties	array{object} PrimaryContexts [readonly]

			List of all primary contexts objects.

		boolean Attached [readonly]

			Contains whether the Packet Radio Service is attached.
			The attach state might change dynamically based on
			availability of network resources.  If this value
			changes to false, the user can assume that all
			contexts have been deactivated.

			If the modem is detached, certain features will not
			be available, e.g. receiving SMS over packet radio
			or network initiated PDP activation.

		boolean RoamingAllowed [readwrite]

			Contains whether data roaming is allowed.  In the off
			setting, if the packet radio registration state
			indicates that the modem is roaming, oFono will
			automatically detach and no further connection
			establishment will be possible.

		boolean Powered [readwrite]

			Controls whether packet radio use is allowed. Setting
			this value to off detaches the modem from the
			Packet Domain network.
			=

		string Status [readonly]

			The current packet radio registration status of a modem.

			The possible values are: =

				"unregistered"  Not registered to any network
				"registered"    Registered to home network
				"searching"     Not registered, but searching
				"denied"        Registration has been denied
				"unknown"       Status is unknown
				"roaming"       Registered, but roaming

		uint16 LocationAreaCode [readonly, optional]

			Contains the current location area code.

		uint32 CellId [readonly, optional]

			Contains the current network cell id.

		string Technology [readonly, optional]

			Contains the technology of the current network.

			The possible values are: "GSM", "GSMCompact", "UTRAN",
						 "GSM+EGPS", "UTRAN+HSDPA",
						 "UTRAN+HSUPA",
						 "UTRAN+HSDPA+HSUPA",
						 "E-UTRAN"

Primary Data Context hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service		org.ofono
Interface	org.ofono.PrimaryDataContext
Object path	[variable]

Methods		dict GetProperties()
			Returns all properties for the context object.

			Possible Errors: [service].Error.InvalidArguments

		void SetProperty(string property, variant value)

			Sets the property to a desired value

			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.InvalidFormat
					 [service].Error.Failed

Signals		PropertyChanged(string property, variant value)

			This signal indicates a changed value of the given
			property.

Properties	boolean Activated [readwrite]

			Holds whether the context is activated.  This value
			can be set to activate / deactivate the context.

		string AccessPointName [readwrite]

			Holds the name of the access point.  This is
			abbreviated as APN.  This value cannot be changed when
			the context is active.

		string Username [readwrite]

			Holds the username to be used for authentication
			purposes.  This value cannot be changed when the
			context is active.

		string Password [readwrite]

			Holds the password to be used for authentication
			purposes.  This value cannot be changed when the
			context is active.

		string Interface [readonly, optional]

			Holds the interface of the network interface created
			by this context (e.g. "ppp0")

		array{string} DomainNameServers [readonly, optional]

			Holds the list of domain name servers for this
			context.


Regards,
-Denis

--===============8760439841171246504==--


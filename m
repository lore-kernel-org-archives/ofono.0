Content-Type: multipart/mixed; boundary="===============4143552365221225860=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RFC: API for Neighbouring Cell Info
Date: Thu, 28 Jan 2010 10:03:46 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BACB181B@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4143552365221225860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I would like to propose an API for exposing neighbouring cell info. =

Since the exact information provided is rather modem specific my thinking i=
s to use the following API as the generic framework and then the actual per=
-cell information attributes that a driver provides can be different from m=
odem to modem with the constraint that _if_ a modem provides a certain attr=
ibute that is specified by this API definition the driver must format it as=
 specified.

Your feedback is highly appreciated, especially from those who plan to use =
this information for location purposes.

Once there is agreement on the API we can discuss whether it makes sense to=
 add some skeleton support in the oFono core or leave it to each individual=
 modem plugin to implement the DBUS service in its entire.

Cheers,
Waldo


Neighbouring Cell Info hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Service		org.ofono
Interface	org.ofono.NeighbouringCellInfo
Object path	[variable prefix]/{modem0,modem1,...}

Methods	dict GetProperties()

			Returns all neighbouring cell info properties. See the
			properties section for available properties.

			Possible Errors: [service].Error.InvalidArguments

		void SetProperty(string name, variant value)

			Changes the value of the specified property. Only
			properties that are listed as read-write are
			changeable. On success a PropertyChanged signal
			will be emitted.

			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.DoesNotExist

Signals	PropertyChanged(string property, variant value)

			This signal indicates a changed value of the given
			property.

Properties	boolean Enabled [readwrite]

			Boolean representing whether the interface provides
			neighbouring cell information.

		array{dict} Info [readonly, only when Enabled]

			List of neighbouring cells with the following information for each cell:

			string Type [readonly]

				Describes the type of Cell.

				The possible values are: "GSM serving cell",
						"GSM neighbour cell",
						"UMTS serving cell",
						"UMTS neighbour cell",
						"UMTS detected cell"

			string MobileCountryCode [readonly]

				Contains the Mobile Country Code (MCC).
	=

			string MobileNetworkCode [readonly]

				Contains the Mobile Network Code (MNC)

			uint16 LocationAreaCode [readonly]

				Contains the location area code of the cell.

			uint32 CellId [readonly]

				Contains the network cell id.

			byte RxLevel [readonly, GSM only]
		=

				Received signal strength as defined by [3GPP TS 45.008 s8.1.4] [0-63]			=


			uint32 TimingAdvance [readonly, GSM serving cell only]

				Timing advance for serving GSM cell [0-???]

			uint16 ScramblingCode [readonly, UMTS only]

				Scrambling code [0-511]

			uint16 DownlinkFreq [readonly, UMTS only]

				Downlink frequency [0-16383]

			int8 RSCP [readonly, UMTS only]

				Received Signal Code Power [3GPP TS 25.133 s9.1.1.3] in dBm [-120...-25]

			int8 ECNO [readonly, UMTS only]

				CPICH Ec/No [3GPP TS 25.133 s9.1.2.3] in dB  [-24...0]
		=09

--===============4143552365221225860==--


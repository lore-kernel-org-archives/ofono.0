Content-Type: multipart/mixed; boundary="===============3435769501515810131=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 5/5 v3] Cell-info: Documentation
Date: Mon, 07 Feb 2011 11:24:58 -0800
Message-ID: <1297106698.1520.444.camel@aeonflux>
In-Reply-To: <1294833919-1510-6-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3435769501515810131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  doc/cell-info.txt |  121 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 121 insertions(+), 0 deletions(-)
>  create mode 100644 doc/cell-info.txt
> =

> diff --git a/doc/cell-info.txt b/doc/cell-info.txt
> new file mode 100644
> index 0000000..64d9db6
> --- /dev/null
> +++ b/doc/cell-info.txt
> @@ -0,0 +1,121 @@
> +Cell Info hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.CellInfo
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods 	aa{sv} GetNeighbors()
> +
> +			Calling this procedure returns properties of serving
> +			and neighboring cells in GSM or WCDMA networks. This
> +			information can be used to determine current location
> +			using triangulation over neighboring cell tower
> +			locations and estimated distances.
> +
> +			The returned array consists of two parts: 1) first
> +			element of the array contains a dictionary of
> +			common information about network and serving cell 2)
> +			rest of the array comprises dictionaries containing
> +			measurement results of neighboring cells. The contents
> +			of the dictionaries follow the specification
> +			OMA-TS-ULP-V2_0-20100816-C for user plane Location and
> +			is described in properties section.

I am having a little bit of a problem calling this GetNeighbors and then
also retrieving the serving cell at the same time.

I am just spinning some idea here, but maybe calling the interface
org.ofono.NeighborCellInfo and the method AquireMeasurment() would be
better.

> +			Possible errors: org.ofono.Error.Failed
> +
> +Properties
> +
> +Serving cell
> +		string Type
> +			Radio access network type of neighbor cell information.
> +			The possible values are:
> +			"geran"	Measurement results are for the GSM EDGE Radio
> +				Access Network.
> +			"utran"	Measurement results are for UMTS Radio Access
> +				Network.
> +
> +		string MobileCountryCode
> +			Mobile Country Code of serving cell. Possible values:
> +			Values: 0...999
> +
> +		string MobileNetworkCode
> +			Mobile Network Code of serving cell.
> +			Values: 0...999
> +
> +		uint16 LocationAreaCode [GERAN]
> +			Location area code of serving cell.
> +			Values: 0...65535
> +
> +		uint16 CellId [GERAN]
> +			Cell Id of serving cell.
> +			Values: 0...65535
> +
> +		byte TimingAdvance [GERAN, optional]
> +			Timing advance.
> +			Values: 0...63
> +
> +		uint32 UniqueCellId [UTRA-FDD]
> +			Serving WCDMA unique cell ID.
> +			Values: 0...268435455
> +
> +		uint16 ScramblingCode [UTRA-FDD]
> +			Primary scrambling code.
> +			Values: 0...511
> +
> +		uint16 UARFCN-DL [UTRA-FDD]
> +			Downlink UTRA Absolute Radio Frequency Channel Number
> +			of serving cell.
> +			Values: 0...16383

Do we wanna keep the UARFCN acronym?

> +		uint16 UARFCN-UL [UTRA-FDD, optional]
> +			Uplink UTRA Absolute Radio Frequency Channel Number.
> +			Values: 0...16383

I am still going forth and back if it is a good idea to make cell[0]
special as the serving cell. There are common fields, but also other
fields that are totally different.

So one question that came to my mind is how this mixes when the serving
cell is UMTS, can the neighbors cells also report GSM? Do we have a mix
of values in the dictionary anyway?

> +Neighbor cell measurement results
> +
> +		uint16 AbsoluteRadioFrequencyChannelNumber [GERAN]
> +			Absolute radio frequency channel number.
> +			Values: 0...1023
> +
> +		byte BaseStationIdentityCode [GERAN]
> +			Base station identity code.
> +			Values: 0...63.
> +
> +		byte RXLEV [GERAN]
> +			Measured power of the channel.
> +			Values: 0...63

I think we can find something better name than RXLEV.

> +		byte ReceivedSignalStrengthIndicator [UTRA-FDD]
> +			RX power level.
> +			Values: 0...127
> +
> +		uint16 UARFCN-DL [UTRA-FDD]
> +			Downlink UARFCN.
> +			Values: 0...16383
> +
> +		uint16 UARFCN-UL [UTRA-FDD, optional]
> +			Uplink UARFCN.
> +			Values: 0...16383
> +
> +		uint16 ScramblingCode [UTRA-FDD]
> +			Primary scrambling code.
> +			Values: 0...511
> +
> +		uint32 UniqueCellId [UTRA-FDD, optional]
> +			Unique cell ID.
> +			Values: 0...268435455
> +
> +		byte CPICH-ECN0 [UTRA-FDD, optional]
> +			 Common pilot channel RX energy per chip over noise
> +			 density in dB.
> +			 Values: 0...63

Any better name than CPICH?

> +		int16 CPICH-RSCP [UTRA-FDD, optional]
> +			Common pilot channel RX carrier power in dBm
> +			Values: -4...127
> +
> +		byte Pathloss [UTRA-FDD, optional]
> +			Measured path loss in dB.
> +			Values: 46...173

Regards

Marcel



--===============3435769501515810131==--


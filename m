Content-Type: multipart/mixed; boundary="===============6251017572276748861=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 5/5] cell-info: Documentation
Date: Tue, 28 Dec 2010 15:27:27 +0200
Message-ID: <1293542847-24248-6-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1293542847-24248-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6251017572276748861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cell-info.txt |  124 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 doc/cell-info.txt

diff --git a/doc/cell-info.txt b/doc/cell-info.txt
new file mode 100644
index 0000000..b288e69
--- /dev/null
+++ b/doc/cell-info.txt
@@ -0,0 +1,124 @@
+Cell Info hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.CellInfo
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods 	a{sv}aa{sv} GetNeighborCellInfo()
+
+			Calling this procedure returns properties of serving
+			and neighbouring cells in GSM or WCDMA networks. This
+			information can be used to determine current location
+			using triangulation over neighbouring cell tower
+			locations and estimated distances.
+
+			The return value consists of two parts: 1) dictionary
+			of common information about network and serving cell 2)
+			array of dictionaries containing measurement results
+			of neighbouring cells. The contents of the dictionaries
+			follow the specification OMA-TS-ULP-V2_0-20100816-C for
+			user plane Location and is described in properties
+			section.
+
+		a{sv} GetProperties
+
+			Calling this procedure returns properties of serving
+			cell in GSM or WCDMA networks. Effectively the data
+			returned is the part 1 of the data returned by
+			GetNeighborCellInfo.
+
+Properties
+
+a{sv]		string Type
+
+		Radio access network type of neighbor cell information.
+
+		The possible values are:
+			"geran"	Measurement results are for the GSM EDGE Radio
+				Access Network.
+			"utran"	Measurement results are for UMTS Radio Access
+				Network.
+
+		uint16 MobileCountryCode
+			Mobile Country Code of serving cell. Possible values:
+			Values: 0...999"
+
+		uint16 MobileNetworkCode
+			Mobile Network Code of serving cell.
+			Values: 0...999"
+
+		uint16 LocationAreaCode [GERAN]
+			Location area code of serving cell.
+			Values: 0...65535
+
+		uint16 CellId [GERAN]
+			Cell Id of serving cell.
+			Values: 0...65535
+
+		byte TimingAdvance [GERAN, optional]
+			Timing advance.
+			Values: 0...63
+
+		uint32 UniqueCellId [UTRA-FDD]
+			Serving WCDMA unique cell ID.
+			Values: 0...268435455
+
+		uint16 ScramblingCode [UTRA-FDD]
+			Primary scrambling code.
+			Values: 0...511
+
+		uint16 UARFCN-DL [UTRA-FDD]
+			Downlink UTRA Absolute Radio Frequency Channel Number
+			of serving cell.
+			Values: 0...16383
+
+		uint16 UARFCN-UL [UTRA-FDD, optional]
+			Uplink UTRA Absolute Radio Frequency Channel Number.
+			Values: 0...16383
+
+
+aa{sv}		uint16 AbsoluteRadioFrequencyChannelNumber [GERAN]
+			Absolute radio frequency channel number.
+			 Values: 0...1023
+
+		byte BaseStationIdentityCode [GERAN]
+			Base station identity code.
+			Values: 0...63.
+
+		byte RXLEV [GERAN]
+			Measured power of the channel.
+			Values: 0...63
+
+		byte ReceivedSignalStrengthIndicator [UTRA-FDD]
+			RX power level.
+			Values: 0...127
+
+		uint16 UARFCN-DL [UTRA-FDD]
+			Downlink UARFCN.
+			Values: 0...16383
+
+		uint16 UARFCN-UL [UTRA-FDD, optional]
+			Uplink UARFCN.
+			Values: 0...16383
+
+		uint16 ScramblingCode [UTRA-FDD]
+			Primary scrambling code.
+			Values: 0...511
+
+		uint32 UniqueCellId [UTRA-FDD, optional]
+			Unique cell ID.
+			Values: 0...268435455
+
+		byte CPICH-ECN0 [UTRA-FDD, optional]
+			 Common pilot channel RX energy per chip over noise
+			 density in dB.
+			 Values: 0...63
+
+		int16 CPICH-RSCP [UTRA-FDD, optional]
+			Common pilot channel RX carrier power in dBm
+			Values: -4...127
+
+		byte Pathloss [UTRA-FDD, optional]
+			Measured path loss in dB.
+			Values: 46...173
-- =

1.7.1


--===============6251017572276748861==--


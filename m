Content-Type: multipart/mixed; boundary="===============8875921615150695727=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 5/5] cell-info: Documentation
Date: Mon, 14 Feb 2011 16:56:52 +0200
Message-ID: <1297695412-22259-6-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1297695412-22259-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8875921615150695727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cell-info.txt |  122 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 doc/cell-info.txt

diff --git a/doc/cell-info.txt b/doc/cell-info.txt
new file mode 100644
index 0000000..b8a4136
--- /dev/null
+++ b/doc/cell-info.txt
@@ -0,0 +1,122 @@
+Cell Info hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.NeighborCellInfo
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods 	aa{sv} AquireMeasurement()
+
+			Calling this procedure returns properties of serving
+			and neighbouring cells in GSM, WCDMA and LTE networks.
+			This information can be used to determine current
+			location using triangulation over neighbouring cell
+			tower locations and estimated distances.
+
+			This method returns an array that consists of two
+			types of cells: 1) first type contains a dictionary of
+			common information about network and serving cell for
+			a certain radio access type 2) following entries
+			contain the measurement results of neighboring cells of
+			the same RAT. The contents of the dictionaries
+			follow the specification OMA-TS-ULP-V2_0-20100816-C
+			for user plane Location and is described in properties
+			section.
+
+			Possible errors: org.ofono.Error.Failed
+
+Properties
+
+Serving cell
+		string Type
+			Radio access network type of neighbor cell information.
+			The possible values are:
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
+Neighbor cell measurement results
+
+		uint16 AbsoluteRadioFrequencyChannelNumber [GERAN]
+			Absolute radio frequency channel number.
+			Values: 0...1023
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


--===============8875921615150695727==--


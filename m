Content-Type: multipart/mixed; boundary="===============0307400476776871490=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [RFC PATCH 5/5 v2] cell-info: Documentation
Date: Wed, 22 Dec 2010 11:35:39 +0200
Message-ID: <1293010539-9524-6-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1293010539-9524-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0307400476776871490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cell-info.txt |  110 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 doc/cell-info.txt

diff --git a/doc/cell-info.txt b/doc/cell-info.txt
new file mode 100644
index 0000000..9144eb7
--- /dev/null
+++ b/doc/cell-info.txt
@@ -0,0 +1,110 @@
+Cell Info hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.CellInfo
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		a{sv}aa{sv} GetProperties()
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
+Properties
+
+a{sv]		string Type
+
+			Radio access type.
+			Values: "GERAN", "UTRA-FDD
+
+		uint32 MCC
+			Mobile Country Code of serving cell. Possible values:
+			Values: 0...999"
+
+		uint32 MNC
+			Mobile Network Code of serving cell.
+			Values: 0...999"
+
+		uint32 LAC [GERAN]
+			Location area code of serving cell.
+			Values: 0...65535
+
+		uint32 CI [GERAN]
+			Cell Id of serving cell.
+			Values: 0...65535
+
+		uint32 TA [GERAN, OPTIONAL]
+			Timing advance.
+			Values: 0...63
+
+		uint32 UCID [UTRA-FDD]
+			Serving WCDMA unique cell ID.
+			Values: 0...268435455
+
+		uint32 SC [UTRA-FDD]
+			Primary scrambling code.
+			Values: 0...511
+
+		uint32 UARFCN-DL [UTRA-FDD]
+			Downlink UARFCN of serving cell.
+			Values: 0...16383
+
+		uint32 UARFCN-UL [UTRA-FDD, OPTIONAL]
+			Uplink UARFCN.
+			Values: 0...16383
+
+
+aa{sv}		uint32 ARFCN [GERAN]
+			Absolute radio frequency channel number.
+			 Values: 0...1023
+
+		uint32 BSIC [GERAN]
+			Base station identity code.
+			Values: 0...63.
+
+		uint32 RXLEV [GERAN]
+			Measured power of the channel.
+			Values: 0...63
+
+		int32 RSSI [UTRA-FDD]
+			RX power level in dBm.
+			Values: -47...-110
+
+		uint32 UARFCN-DL [UTRA-FDD]
+			Downlink UARFCN.
+			Values: 0...16383
+
+		uint32 UARFCN-UL [UTRA-FDD, OPTIONAL]
+			Uplink UARFCN.
+			Values: 0...16383
+
+		uint32 SC [UTRA-FDD]
+			Primary scrambling code.
+			Values: 0...511
+
+		uint32 UCID [UTRA-FDD, OPTIONAL]
+			Unique cell ID.
+			Values: 0...268435455
+
+		uint32 ECN0 [UTRA-FDD, OPTIONAL]
+			 CPICH RX energy per chip over noise density in dB.
+			 Values: 0...63
+
+		int32 RSCP [UTRA-FDD, OPTIONAL]
+			CPICH RX carrier power in dBm
+			Values: -4...127
+
+		uint32 Pathloss [UTRA-FDD, OPTIONAL]
+			Measured path loss in dB.
+			Values: 46...173
-- =

1.7.1


--===============0307400476776871490==--


Content-Type: multipart/mixed; boundary="===============8880007001534507933=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 4/4] doc: document power-event signals for quectel Hardware
 API
Date: Fri, 19 Jul 2019 14:39:57 +0200
Message-ID: <20190719123957.6911-4-martin@geanix.com>
In-Reply-To: <20190719123957.6911-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8880007001534507933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Changes since v2:
 * Use Voltage{High,Low} instead of {High,Low}Power

Changes since v1:
 * new patch split out from PATCHv1 7/7

 doc/quectel-hardware-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
index 6aafbfd8..8795ef40 100644
--- a/doc/quectel-hardware-api.txt
+++ b/doc/quectel-hardware-api.txt
@@ -10,6 +10,25 @@ Methods		array{string,variant} GetProperties
 			Returns hardware properties for the modem object. See
 			the properties section for available properties.
 =

+Signals		PowerDown(string reason)
+
+			This signal is emitted on gracefull shutdowns initiated
+			by the modem.
+
+			Possible reasons:
+				"VoltageLow"	The supply voltage is too low
+				"Normal"	The PWRKEY pin was asserted
+				"VoltageHigh"	The supply voltage is too high
+
+		PowerWarning(string reason)
+
+			This signal is emitted when the modem detects its supply
+			voltage is close to its supported limits.
+
+			Possible reasons:
+				"VoltageLow"	The supply voltage is low
+				"VoltageHigh"	The supply voltage is high
+
 Properties	int32 Voltage [readonly]
 =

 			Integer with the modem supply voltage in mV.
-- =

2.22.0


--===============8880007001534507933==--


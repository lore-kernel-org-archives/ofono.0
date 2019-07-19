Content-Type: multipart/mixed; boundary="===============3799900304762244053=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2 4/4] doc: document power-event signals for quectel Hardware
 API
Date: Fri, 19 Jul 2019 12:19:14 +0200
Message-ID: <20190719101914.122689-4-martin@geanix.com>
In-Reply-To: <20190719101914.122689-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3799900304762244053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Changes since v1:
 * new patch split out from PATCHv1 7/7

 doc/quectel-hardware-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
index 6aafbfd8..411afcd1 100644
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
+				"LowPower"	The supply voltage is too low
+				"Normal"	The PWRKEY pin was asserted
+				"HighPower"	The supply voltage is too high
+
+		PowerWarning(string reason)
+
+			This signal is emitted when the modem detects its supply
+			voltage is close to its supported limits.
+
+			Possible reasons:
+				"LowPower"	The supply voltage is low
+				"HighPower"	The supply voltage is high
+
 Properties	int32 Voltage [readonly]
 =

 			Integer with the modem supply voltage in mV.
-- =

2.22.0


--===============3799900304762244053==--


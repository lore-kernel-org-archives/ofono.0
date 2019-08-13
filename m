Content-Type: multipart/mixed; boundary="===============8204915247180913404=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/2] doc: convert quectel power event reasons to lower case
Date: Tue, 13 Aug 2019 20:08:52 +0200
Message-ID: <20190813180853.2049-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8204915247180913404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/quectel-hardware-api.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
index 139a0dc1..c2433282 100644
--- a/doc/quectel-hardware-api.txt
+++ b/doc/quectel-hardware-api.txt
@@ -16,9 +16,9 @@ Signals		PowerDown(string reason)
 			by the modem.
 =

 			Possible reasons:
-				"VoltageLow"	The supply voltage is too low
-				"Normal"	The PWRKEY pin was asserted
-				"VoltageHigh"	The supply voltage is too high
+				"voltagelow"	The supply voltage is too low
+				"normal"	The PWRKEY pin was asserted
+				"voltagehigh"	The supply voltage is too high
 =

 		PowerWarning(string reason)
 =

@@ -26,8 +26,8 @@ Signals		PowerDown(string reason)
 			voltage is close to its supported limits.
 =

 			Possible reasons:
-				"VoltageLow"	The supply voltage is low
-				"VoltageHigh"	The supply voltage is high
+				"voltagelow"	The supply voltage is low
+				"voltagehigh"	The supply voltage is high
 =

 Properties	int32 Voltage [readonly]
 =

-- =

2.22.0


--===============8204915247180913404==--


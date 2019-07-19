Content-Type: multipart/mixed; boundary="===============1111201115531977863=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 2/4] doc: add documentaion for Quectel hardware API
Date: Fri, 19 Jul 2019 14:39:55 +0200
Message-ID: <20190719123957.6911-2-martin@geanix.com>
In-Reply-To: <20190719123957.6911-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1111201115531977863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Changes since v2:
 * none

Changes since v1:
 * new patch split out from PATCHv1 6/7
 * added documentation of charge status and level

 doc/quectel-hardware-api.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 doc/quectel-hardware-api.txt

diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
new file mode 100644
index 00000000..6aafbfd8
--- /dev/null
+++ b/doc/quectel-hardware-api.txt
@@ -0,0 +1,33 @@
+Hardware hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.quectel.Hardware
+Object path	/{device0,device1,...}
+
+Methods		array{string,variant} GetProperties
+
+			Returns hardware properties for the modem object. See
+			the properties section for available properties.
+
+Properties	int32 Voltage [readonly]
+
+			Integer with the modem supply voltage in mV.
+
+		int32 ChargeStatus [readonly,optional]
+
+			Integer with one of either:
+
+			0: Modem is not charging
+			1: Modem is charging
+			2: Charging is finished
+
+			This property is available on UC15
+
+		int32 ChargeLevel [readonly,optional]
+
+			Integer representing the battery charge level in
+			percent (from 0 to 100).
+
+			This property is available on UC15
+
-- =

2.22.0


--===============1111201115531977863==--


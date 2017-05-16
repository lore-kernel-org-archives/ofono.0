Content-Type: multipart/mixed; boundary="===============8251552910003201684=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [RFC v2 3/3] doc: gemalto: add documentation about interface
 cinterion.HardwareMonitor.
Date: Tue, 16 May 2017 10:38:42 +0200
Message-ID: <1494923922-8874-3-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1494923922-8874-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8251552910003201684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This interface exposes a single method to access temperature and supply
voltage of the modem.
---
 doc/cinterion-hardware-monitor-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 doc/cinterion-hardware-monitor-api.txt

diff --git a/doc/cinterion-hardware-monitor-api.txt b/doc/cinterion-hardwar=
e-monitor-api.txt
new file mode 100644
index 0000000..50adca3
--- /dev/null
+++ b/doc/cinterion-hardware-monitor-api.txt
@@ -0,0 +1,17 @@
+
+HardwareMonitor hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Service		org.ofono.cinterion
+Interface	org.ofono.cinterion.HardwareMonitor
+Object path	/{device0,device1,...}
+
+Methods		array{string,variant} GetStatistics
+
+			Returns an array of dict entries representing the
+			current temperature and supply voltage of the modem.
+
+			Units:
+			Temperature: Celsius
+			Voltage: mV
+
-- =

1.9.1


--===============8251552910003201684==--


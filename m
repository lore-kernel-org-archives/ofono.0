Content-Type: multipart/mixed; boundary="===============2635849617509582180=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCHv2 4/4] operator-settings: Example GPRS context settings
 file
Date: Mon, 03 Jan 2011 09:31:52 +0200
Message-ID: <1294039912-6008-5-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2635849617509582180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 examples/example-operator-settings.xml |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100644 examples/example-operator-settings.xml

diff --git a/examples/example-operator-settings.xml b/examples/example-oper=
ator-settings.xml
new file mode 100644
index 0000000..8927656
--- /dev/null
+++ b/examples/example-operator-settings.xml
@@ -0,0 +1,15 @@
+<?xml version=3D"1.0"?>
+<!--
+   Example GPRS access point settings.
+   <access>-element must contain required attributes type=3D"internet"|"mm=
s",
+     mcc, mnc and name.
+   others: spn (Service Provider Name from SIM), apn (GPRS Access Point Na=
me),
+     protocol=3D"ipv4"|"ipv6" (others may be added), username, password, =

+     proxy (as "address:port", for now mms only), mmsserver (as http-url, =

+     mms only).
+-->
+
+<settings>
+<access type=3D"internet" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Pho=
nesim Internet-GPRS" apn=3D"internet.apn"/>
+<access type=3D"mms" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phonesim=
 MMS-GPRS" apn=3D"mms.apn" protocol=3D"ipv4" username=3D"mmsuser" password=
=3D"mmspass" proxy=3D"10.11.12.13:8080" mmsserver=3D"http://mms.example.com=
:8000"/>
+</settings>
-- =

1.7.1


--===============2635849617509582180==--


Content-Type: multipart/mixed; boundary="===============0205975006988947521=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 4/4] operator-settings: Example GPRS context settings file
Date: Tue, 21 Dec 2010 11:01:19 +0200
Message-ID: <1292922079-24711-5-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1292922079-24711-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0205975006988947521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 examples/example-operator-settings.csv |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 examples/example-operator-settings.csv

diff --git a/examples/example-operator-settings.csv b/examples/example-oper=
ator-settings.csv
new file mode 100644
index 0000000..7493894
--- /dev/null
+++ b/examples/example-operator-settings.csv
@@ -0,0 +1,9 @@
+# Example GPRS access point settings
+# Format: (type=3DINTERNET|MMS protocol=3Dipv4|ipv6)
+# MCC,MNC,SPN,type,UI name, APN, username, password, protocol, proxy IP ad=
dress, proxy port, MMS server URL
+#
+001,01,TEST,INTERNET,Network Tester GPRS,internet,,,,,,
+246,81,oFono,INTERNET,Phonesim Internet-GPRS,internet.apn,,,ipv4,,,
+246,81,oFono,MMS,Phonesim MMS-GPRS,mms.apn,mmsuser,mmspass,ipv4,10.10.10.1=
0,8080,http://192.168.0.111:8002
+888,009,Example,INTERNET,Example Operator Internet,internet
+888,009,Example,MMS,Example Operator MMS,mms,,,ipv4,10.11.12.13,8081,http:=
//mms.example.com:8000
-- =

1.7.1


--===============0205975006988947521==--


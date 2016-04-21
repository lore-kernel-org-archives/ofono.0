Content-Type: multipart/mixed; boundary="===============5907292049717180760=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 1/4] doc: Add allowed-apns api doc
Date: Thu, 21 Apr 2016 09:19:38 +0530
Message-ID: <1461210578-11241-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5907292049717180760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am              |  3 ++-
 doc/allowed-apns-api.txt | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 doc/allowed-apns-api.txt

diff --git a/Makefile.am b/Makefile.am
index 5cd9766..f1a89cc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -646,7 +646,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/location-reporting-api.txt \
 			doc/certification.txt doc/siri-api.txt \
 			doc/telit-modem.txt \
-			doc/networkmonitor-api.txt
+			doc/networkmonitor-api.txt \
+			doc/allowed-apns-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/allowed-apns-api.txt b/doc/allowed-apns-api.txt
new file mode 100644
index 0000000..6bc95d0
--- /dev/null
+++ b/doc/allowed-apns-api.txt
@@ -0,0 +1,17 @@
+Allowed APNs hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Service		org.ofono
+Interface	org.ofono.AllowedAccessPoints
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		array{string} GetAllowedAccessPoints()
+
+			Get the list of allowed access points provided
+			in the SIM card.
+
+			This method returns an array of strings which
+			contains a list of Access Point Names supported
+			by network provider. Returns with an error if
+			SIM reading failed or an empty list if there
+			are no access points listed on the SIM.
-- =

1.9.1


--===============5907292049717180760==--


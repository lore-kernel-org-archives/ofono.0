Content-Type: multipart/mixed; boundary="===============3144495489717831775=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 6/6] location-reporting: add documentation
Date: Tue, 22 Feb 2011 15:35:15 -0300
Message-ID: <1298399715-9617-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1298399715-9617-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3144495489717831775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>

---
 Makefile.am                    |    3 ++-
 doc/location-reporting-api.txt |   39 ++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 41 insertions(+), 1 deletions(-)
 create mode 100644 doc/location-reporting-api.txt

diff --git a/Makefile.am b/Makefile.am
index 9b6edf4..ca558ea 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -420,7 +420,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt doc/message-api.txt
+			doc/calypso-modem.txt doc/message-api.txt \
+			doc/location-reporting-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/location-reporting-api.txt b/doc/location-reporting-api.txt
new file mode 100644
index 0000000..b8ce840
--- /dev/null
+++ b/doc/location-reporting-api.txt
@@ -0,0 +1,39 @@
+Location Reporting Hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.LocationReporting
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all LocationReporting properties. See the
+			properties section for available properties.
+
+		byte Request()
+
+			Asks to turn ON the NMEA stream and supplies the
+			gps device file descriptor. The external cliend should
+			use the file descriptor to receive the NMEA data.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InUse
+					 [service].Error.Failed
+
+		void Release()
+
+			Releases the gps device file descriptor and turns
+			OFF the NMEA stream.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotAvailable
+					 [service].Error.Failed
+
+Properties	boolean Enabled [readonly]
+
+                        Boolean representing the state of the NMEA stream.
+
+		string Type [readonly]
+
+			Holds the type of the device. Currently only NMEA is
+			supported.
-- =

1.7.4.1


--===============3144495489717831775==--


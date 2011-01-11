Content-Type: multipart/mixed; boundary="===============4237758202598306664=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 9/9] gps: add documentation
Date: Tue, 11 Jan 2011 00:23:58 -0300
Message-ID: <1294716238-21218-10-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4237758202598306664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |    2 +-
 doc/gps-api.txt |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 55 insertions(+), 1 deletions(-)
 create mode 100644 doc/gps-api.txt

diff --git a/Makefile.am b/Makefile.am
index 3352f24..0b748ed 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -376,7 +376,7 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt
+			doc/calypso-modem.txt doc/gps-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/gps-api.txt b/doc/gps-api.txt
new file mode 100644
index 0000000..9cf9792
--- /dev/null
+++ b/doc/gps-api.txt
@@ -0,0 +1,54 @@
+Location Reporting hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.LocationReporting
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all Gps properties. See the
+			properties section for available properties.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InProgress
+					 [service].Error.Failed
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean	Powered [readwrite]
+
+			This property will power or disable the GPS feature in
+			the modem.
+
+			Many modem manufacturers provide a GPS unit with their
+			modem hardware. This unit can be turned on or off and
+			frequently takes over one of the tty ports that the
+			modem provides.
+
+		dict Settings [readonly]
+
+			Holds the location information settings
+
+			string Device [readonly]
+
+				Holds the device from which the location
+				information can be obtained (e.g. "/dev/ttyACM2")
+
+			string Type [readonly]
+
+				Holds the type of the device (e.g. "nmea")
+
-- =

1.7.2.3


--===============4237758202598306664==--


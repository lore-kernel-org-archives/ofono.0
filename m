Content-Type: multipart/mixed; boundary="===============9027233369102177055=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v3 7/7] gps: add documentation
Date: Wed, 26 Jan 2011 12:32:54 -0300
Message-ID: <1296055974-9640-8-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1296055974-9640-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9027233369102177055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |    3 +-
 doc/gps-api.txt              |   49 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100644 doc/gps-api.txt
 mode change 100755 =3D> 100644 test/test-location-reporting

diff --git a/Makefile.am b/Makefile.am
index 49bf8f3..2ebf9e6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -399,7 +399,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt doc/message-api.txt
+			doc/calypso-modem.txt doc/message-api.txt \
+			doc/gps-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/gps-api.txt b/doc/gps-api.txt
new file mode 100644
index 0000000..85b0669
--- /dev/null
+++ b/doc/gps-api.txt
@@ -0,0 +1,49 @@
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
+		void RegisterAgent(object path)
+
+			Registers an agent which will be called with the
+			gps file descriptor.
+
+		void UnregisterAgent(object path)
+
+			Unregisters an agent.
+
+Properties	string Type [readonly]
+
+			Holds the type of the device (e.g. "nmea")
+
+LocationReportingAgent Hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.LocationReportingAgent
+Object path	freely definable
+
+Methods		void ReceiveGpsFileDescriptor(int32 fd)
+
+			Supplies the current gps device open file
+			descriptor. The file descriptor should be used by
+			the external client to receive the NMEA data.
+
+			Possible Errors: None
+
+		void Release() [noreply]
+
+			Agent is being released, possibly because of oFono
+			terminating, Location Reporting interface is being
+			torn down or modem off.  No UnregisterAgent call is
+			needed.
diff --git a/test/test-location-reporting b/test/test-location-reporting
old mode 100755
new mode 100644
-- =

1.7.2.3


--===============9027233369102177055==--


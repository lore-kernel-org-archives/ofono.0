Content-Type: multipart/mixed; boundary="===============7679282168038717653=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 8/8] gps: add documentation
Date: Thu, 16 Dec 2010 17:30:23 -0300
Message-ID: <1292531423-22316-9-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7679282168038717653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |    3 ++-
 doc/gps-api.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletions(-)
 create mode 100644 doc/gps-api.txt

diff --git a/Makefile.am b/Makefile.am
index 4b8cb51..a8ad097 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -359,7 +359,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/message-api.txt doc/message-waiting-api.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
-			doc/audio-settings-api.txt doc/text-telephony-api.txt
+			doc/audio-settings-api.txt doc/text-telephony-api.txt \
+			doc/gps-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/gps-api.txt b/doc/gps-api.txt
new file mode 100644
index 0000000..e9238a8
--- /dev/null
+++ b/doc/gps-api.txt
@@ -0,0 +1,41 @@
+GPS hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Gps
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
-- =

1.7.2.3


--===============7679282168038717653==--


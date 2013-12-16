Content-Type: multipart/mixed; boundary="===============0927343973442228714=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 1/8] doc: Add Siri API
Date: Mon, 16 Dec 2013 17:52:37 +0000
Message-ID: <1387216364-7138-2-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0927343973442228714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |  2 +-
 doc/siri-api.txt | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 mode change 100644 =3D> 100755 Makefile.am
 create mode 100644 doc/siri-api.txt

diff --git a/Makefile.am b/Makefile.am
old mode 100644
new mode 100755
index 513ee14..b89352e
--- a/Makefile.am
+++ b/Makefile.am
@@ -566,7 +566,7 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
 			doc/calypso-modem.txt doc/message-api.txt \
 			doc/location-reporting-api.txt \
-			doc/certification.txt
+			doc/certification.txt doc/siri-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/siri-api.txt b/doc/siri-api.txt
new file mode 100644
index 0000000..6c44231
--- /dev/null
+++ b/doc/siri-api.txt
@@ -0,0 +1,43 @@
+Siri hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Siri
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all Siri properties. See the
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
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+
+Properties	boolean	Enabled [readonly]
+
+			This property indicates whether Siri is available on
+			the device.
+
+		string EyesFreeMode [readwrite]
+
+			This property indicates the state of Siri Eyes Free
+			Mode.  The current possible values are: "enabled"
+			and "disabled"
-- =

1.7.11.7


--===============0927343973442228714==--


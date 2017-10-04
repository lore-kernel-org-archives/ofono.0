Content-Type: multipart/mixed; boundary="===============3427924869995888033=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 1/6] doc: add ims atom documentation
Date: Wed, 04 Oct 2017 09:12:27 +0530
Message-ID: <1507088548-25106-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3427924869995888033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |  3 ++-
 doc/ims-api.txt | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100755 doc/ims-api.txt

diff --git a/Makefile.am b/Makefile.am
index 5368b61..3ce6d50 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -680,7 +680,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/networkmonitor-api.txt \
 			doc/allowed-apns-api.txt \
 			doc/lte-api.txt \
-			doc/cinterion-hardware-monitor-api.txt
+			doc/cinterion-hardware-monitor-api.txt \
+			doc/ims-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/ims-api.txt b/doc/ims-api.txt
new file mode 100755
index 0000000..4f9a19b
--- /dev/null
+++ b/doc/ims-api.txt
@@ -0,0 +1,60 @@
+IpMultimediaSystem Hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.IpMultimediaSystem
+Object path	[variable prefix]/{modem0,modem1,...}
+
+
+Methods		dict GetProperties()
+
+			Returns all IpMultimediaSystem configuration properties.
+
+		void SetProperty(string property, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as readwrite are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.Failed
+
+		void Register()
+
+			Attempts to register to IMS. A successful method return
+			indicates that the registration process could be
+			initiated successfully. The actual registration state
+			will be reflected by the 'Registered' property.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+
+		void Unregister()
+
+			Attempts to unregister from IMS. A successful method
+			return indicates that the unregistration process could
+			be initiated successfully. The actual unregistration
+			state will be reflected by the 'Registered' property.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties 	boolean Registered [readonly]
+
+			Contains the current IMS registration state.
+
+		boolean VoiceCapable [readonly, optional]
+
+			Boolean representing whether voice call transfer over
+			RTP (IMS) is available.
+
+		boolean SmsCapable [readonly, optional]
+
+			Boolean representing whether SMS-over-IMS is available.
-- =

1.9.1


--===============3427924869995888033==--


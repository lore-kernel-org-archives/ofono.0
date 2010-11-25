Content-Type: multipart/mixed; boundary="===============3499068969033275447=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/5] text-telephony: add documentation
Date: Thu, 25 Nov 2010 15:41:58 -0200
Message-ID: <1290706920-24740-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1290706920-24740-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3499068969033275447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                |    2 +-
 doc/text-telephony-api.txt |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)
 create mode 100644 doc/text-telephony-api.txt

diff --git a/Makefile.am b/Makefile.am
index 93db7ea..77965d4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -356,7 +356,7 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt \
 			doc/message-api.txt doc/message-waiting-api.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
-			doc/audio-settings-api.txt
+			doc/audio-settings-api.txt doc/text-telephony-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/text-telephony-api.txt b/doc/text-telephony-api.txt
new file mode 100644
index 0000000..3fa7942
--- /dev/null
+++ b/doc/text-telephony-api.txt
@@ -0,0 +1,39 @@
+Text Telephony hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.TextTelephony
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all Text Telephony properties. See the
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
+			This property will enable or disable the text
+			telephony feature in the modem.
+
+			Text telephony (TTY), also known as Cellular Text Modem
+			(CTM), is a feature present in some modems that allow
+			them to be used by hearing impaired people.
-- =

1.7.3.2


--===============3499068969033275447==--


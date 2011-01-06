Content-Type: multipart/mixed; boundary="===============0900648649933200902=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: [PATCH 1/3] doc: Add message state API
Date: Thu, 06 Jan 2011 11:50:53 -0800
Message-ID: <1294343455-29551-2-git-send-email-faiyaz.baxamusa@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0900648649933200902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    2 +-
 doc/cdma-message-api.txt  |    5 +++++
 doc/message-api.txt       |   24 +-----------------------
 doc/message-state-api.txt |   27 +++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 doc/message-state-api.txt

diff --git a/Makefile.am b/Makefile.am
index 09dc9ad..14f53ef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -369,7 +369,7 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt
+			doc/calypso-modem.txt doc/message-state-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/cdma-message-api.txt b/doc/cdma-message-api.txt
index 8e6b9ea..c3d03f8 100644
--- a/doc/cdma-message-api.txt
+++ b/doc/cdma-message-api.txt
@@ -110,3 +110,8 @@ Properties	boolean UseDeliveryAcknowledgement
 			The call back number for the user.  If the number is
 			empty, then the optional field is not included
 			in the encoded PDU.
+
+Message hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Please refer to message-state-api.txt
diff --git a/doc/message-api.txt b/doc/message-api.txt
index f7ab22a..e6c8522 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -90,26 +90,4 @@ Properties	string ServiceCenterAddress
 Message hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-Service		org.ofono
-Interface	org.ofono.Message
-Object path	[variable prefix]/{modem0,modem1,...}/{message_01,...}
-
-Methods		dict GetProperties()
-
-			Returns properties for the message object. See
-			the properties section for available properties.
-
-			Possible Errors: [service].Error.InvalidArguments
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
-Properties	string State
-
-			Contains the state of the message object.  Possible
-			values are:
-				"pending",
-				"sent",
-				"failed"
+Please refer to message-state-api.txt
diff --git a/doc/message-state-api.txt b/doc/message-state-api.txt
new file mode 100644
index 0000000..edd0cbf
--- /dev/null
+++ b/doc/message-state-api.txt
@@ -0,0 +1,27 @@
+Message hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Message
+Object path	[variable prefix]/{modem0,modem1,...}/{message_01,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the message object. See
+			the properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string State
+
+			Contains the state of the message object.  Possible
+			values are:
+				"pending",
+				"sent",
+				"failed"
+				"invalid"
-- =

1.7.0.4


--===============0900648649933200902==--


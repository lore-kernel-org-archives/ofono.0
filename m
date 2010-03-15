Content-Type: multipart/mixed; boundary="===============1257083944442762627=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] doc: Add SmsManager API documentation.
Date: Mon, 15 Mar 2010 17:17:45 -0300
Message-ID: <1268684265-16908-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1257083944442762627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sms-api.txt |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 doc/sms-api.txt

diff --git a/doc/sms-api.txt b/doc/sms-api.txt
new file mode 100644
index 0000000..80de1db
--- /dev/null
+++ b/doc/sms-api.txt
@@ -0,0 +1,47 @@
+SmsManager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SmsManager
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the modem object. See
+			the properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.DoesNotExist
+
+		void SendMessage(string to, string text)
+
+			Send the message in text to the number in to.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		ImmediateMessage(string message, dict info)
+
+			New immediate (class 0) SMS received. Info has Sender,
+			LocalSentTime, and SentTime information.
+
+		IncomingMessage(string message, dict info)
+
+
+			New incoming (class >=3D 1) SMS received. Info has Sender,
+			LocalSentTime, and SentTime information.
+
+Properties	string ServiceCenterAddress
+
+			Contains the number of the SMS service center.
-- =

1.6.3.3


--===============1257083944442762627==--


Content-Type: multipart/mixed; boundary="===============8857036820744124859=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 13/17] sms: test code for message's D-Bus GetProperties
Date: Thu, 05 Aug 2010 17:55:35 -0700
Message-ID: <86580a851fe96e1dbe48e9c8b9995f6733e5ae79.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8857036820744124859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 test/test-sms-msg-get-properties |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100755 test/test-sms-msg-get-properties

diff --git a/test/test-sms-msg-get-properties b/test/test-sms-msg-get-prope=
rties
new file mode 100755
index 0000000..eaac7b8
--- /dev/null
+++ b/test/test-sms-msg-get-properties
@@ -0,0 +1,26 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+if len(sys.argv) !=3D 2:
+    print "Error: missing argument (SMS message D-Bus object name)"
+    sys.exit(1)
+
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                         'org.ofono.Manager')
+
+properties =3D manager.GetProperties()
+
+path =3D properties["Modems"][0]
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+                         'org.ofono.SmsManager')
+
+sms_msg =3D dbus.Interface(bus.get_object('org.ofono', sys.argv[1]),
+                         'org.ofono.SmsMessage')
+properties =3D sms_msg.GetProperties()
+print "To: %s\nState: %s\n" % (properties["To"], properties["State"])
-- =

1.6.6.1


--===============8857036820744124859==--


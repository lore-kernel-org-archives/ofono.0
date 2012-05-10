Content-Type: multipart/mixed; boundary="===============0638997590090839060=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/2] test: Add python get-conversation test
Date: Thu, 10 May 2012 16:32:26 +0200
Message-ID: <1336660347-10739-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1336660347-10739-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0638997590090839060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    3 ++-
 test/get-conversation |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)
 create mode 100755 test/get-conversation

diff --git a/Makefile.am b/Makefile.am
index c3a4486..3ae0749 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -51,7 +51,8 @@ INCLUDES =3D -I$(builddir)/src -I$(srcdir)/src -I$(srcdir=
)/gdbus
 CLEANFILES =3D src/builtin.h
 =

 test_scripts =3D test/monitor-mms test/get-services test/send-message \
-		test/delete-message test/mark-message-read test/get-messages
+		test/delete-message test/mark-message-read test/get-messages \
+		test/get-conversation
 =

 doc_files =3D doc/architecture.txt doc/consumer.txt doc/manager-api.txt \
 				doc/service-api.txt doc/message-api.txt \
diff --git a/test/get-conversation b/test/get-conversation
new file mode 100755
index 0000000..6edaeca
--- /dev/null
+++ b/test/get-conversation
@@ -0,0 +1,34 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+if (len(sys.argv) < 3):
+	print "Usage: %s '<number>' <count>" % (sys.argv[0])
+	print "Sample: get-conversation '555-1234' 0"
+	sys.exit(1)
+
+bus =3D dbus.SessionBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono.mms', '/org/ofono/mms=
'),
+					'org.ofono.mms.Manager')
+
+services =3D manager.GetServices()
+path =3D services[0][0]
+
+service =3D dbus.Interface(bus.get_object('org.ofono.mms', path),
+						'org.ofono.mms.Service')
+
+messages =3D service.GetConversation(sys.argv[1], sys.argv[2])
+
+for entry in messages:
+	path =3D entry[0]
+	properties =3D entry[1]
+
+	print "[ %s ]" % (path)
+
+	for key in properties.keys():
+		val =3D str(properties[key])
+		print "    %s =3D %s" % (key, val)
+
+	print
-- =

1.7.4.1


--===============0638997590090839060==--


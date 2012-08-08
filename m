Content-Type: multipart/mixed; boundary="===============7540221258753699436=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 3/3] test: Add a script to set the delivery-report flag
Date: Wed, 08 Aug 2012 15:21:46 +0200
Message-ID: <1344432106-23105-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344432106-23105-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7540221258753699436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 test/set-dr |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100755 test/set-dr

diff --git a/Makefile.am b/Makefile.am
index 3ae0749..6130ba2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,7 +52,7 @@ CLEANFILES =3D src/builtin.h

 test_scripts =3D test/monitor-mms test/get-services test/send-message \
 		test/delete-message test/mark-message-read test/get-messages \
-		test/get-conversation
+		test/get-conversation test/set-dr

 doc_files =3D doc/architecture.txt doc/consumer.txt doc/manager-api.txt \
 				doc/service-api.txt doc/message-api.txt \
diff --git a/test/set-dr b/test/set-dr
new file mode 100755
index 0000000..2143807
--- /dev/null
+++ b/test/set-dr
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import sys
+import dbus
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
+if len(sys.argv) > 1:
+	allowed =3D dbus.Boolean(int(sys.argv[1]))
+else:
+	allowed =3D dbus.Boolean(1)
+
+print "Setting delivery report use for %s...(UseDeliveryReports=3D%d)" %\
+	(path, allowed)
+
+service.SetProperty("UseDeliveryReports", allowed)
--
1.7.9.5


--===============7540221258753699436==--


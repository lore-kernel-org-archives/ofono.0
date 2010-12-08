Content-Type: multipart/mixed; boundary="===============2463657685400317826=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 4/4] scripts: Added init.rc script
Date: Wed, 08 Dec 2010 09:35:29 +0100
Message-ID: <1291797329-20592-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2463657685400317826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Updates in Makefile.am and the adding of an init file.

Regards,
Jessica Nilsson

---
 Makefile.am    |   10 +++++++
 scripts/ofonod |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100755 scripts/ofonod

diff --git a/Makefile.am b/Makefile.am
index a5c89f2..0e6b761 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -82,6 +82,10 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 =

 udev_files =3D plugins/ofono.rules
 =

+if ISIMODEM25
+init_files =3D scripts/ofonod
+endif
+
 if UDEV
 builtin_modules +=3D udev
 builtin_sources +=3D plugins/udev.c
@@ -562,3 +566,9 @@ include/ofono/%.h: include/%.h
 =

 clean-local:
 	@$(RM) -rf include/ofono
+
+if ISIMODEM25
+init-scripts:
+	$(AM_V_at)$(MKDIR_P) $(sysconfdir)/rc.d/init.d
+	@install -m 755 $(init_files) $(sysconfdir)/rc.d/init.d/ofonod
+endif
diff --git a/scripts/ofonod b/scripts/ofonod
new file mode 100755
index 0000000..6f568e8
--- /dev/null
+++ b/scripts/ofonod
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+# Init file for ofono daemon
+
+### BEGIN INIT INFO
+# Provides: ofonod
+# Required-Start: $local_fs cops msa
+# Required-Stop:
+# Default-Start:  2 3 4 5
+# Default-Stop: 0 1 6
+# chkconfig: 2345 99 01
+# Short-Description: start and stop ofono
+# Description: ofono
+# Modem middleware for accessing the modem
+# through phonet sockets.
+### END INIT INFO
+
+progname=3Dofonod
+execname=3D/usr/sbin/$progname
+lockfile=3D/var/lock/subsys/$progname
+options=3D""
+
+# Sanity check
+[ -x $execname ] || exit 5
+
+# Source function library.
+. /etc/init.d/functions
+
+RETVAL=3D0
+
+start() {
+
+        echo -n "Starting $progname: "
+        /sbin/ifconfig shrm0 up
+        daemon $execname $options
+        RETVAL=3D$?
+        [ $RETVAL -eq 0 ] && touch $lockfile
+        echo
+        return $RETVAL
+}
+
+stop() {
+        echo -n "Stopping $progname: "
+        killproc $progname
+        RETVAL=3D$?
+        echo
+        [ $RETVAL -eq 0 ] && rm -f $lockfile
+        return $RETVAL
+}
+
+case "$1" in
+  start)
+        start
+        ;;
+  stop)
+        stop
+        ;;
+  reload)
+  ;;
+  restart|force-reload)
+        stop
+        start
+        ;;
+  status)
+        status $progname
+        RETVAL=3D$?
+        ;;
+  try-restart)
+        if [ -f $lockfile ]; then
+            stop
+            start
+        fi
+        ;;
+  *)
+        echo $"Usage: $0 {start|stop|restart|try-restart|reload|force-relo=
ad|status}"
+        RETVAL=3D$?
+esac
+
+exit $RETVAL
-- =

1.7.3.2


--===============2463657685400317826==--


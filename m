Content-Type: multipart/mixed; boundary="===============5892914342524182078=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] add manpage for ofonod
Date: Mon, 27 Jul 2009 21:37:57 -0400
Message-ID: <20090727213757.6ae93605@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5892914342524182078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I created this manpage for Debian; feel free to use it.  The license
is the same as oFono's.

---
 doc/Makefile.am |    2 ++
 doc/ofonod.8    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 doc/ofonod.8

diff --git a/doc/Makefile.am b/doc/Makefile.am
index dae164a..85f6023 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -2,3 +2,5 @@
 EXTRA_DIST =3D overview.txt
 =

 MAINTAINERCLEANFILES =3D Makefile.in
+
+man_MANS =3D ofonod.8
diff --git a/doc/ofonod.8 b/doc/ofonod.8
new file mode 100644
index 0000000..474d7fb
--- /dev/null
+++ b/doc/ofonod.8
@@ -0,0 +1,35 @@
+.\"
+.\" ofonod(8)
+.\"
+.\" Copyright (C) 2009  Collabora Ltd.
+.TH ofonod 8 "Jul 2009"
+.SH NAME
+ofonod \- oFono mobile telephony daemon
+.SH SYNOPSIS
+.B "ofonod [options]"
+.SH DESCRIPTION
+.B ofonod
+is a daemon which provides an oFono stack for interfacing mobile telephony=
 devices.
+oFono is controlled through \fID-Bus\fP; for example, one can tell
+.B ofonod
+to send AT commands over /dev/rfcomm0 by calling the \fID-Bus\fP method or=
g.ofono.at.Manager.Create.
+.I "/etc/dbus-1/system.d/ofono.conf"
+is used to manage \fID-Bus\fP permissions for oFono.
+.SH OPTIONS
+.TP
+.B --debug, -d
+Enable debug information output.
+.TP
+.B --nodetach, -n
+Don't run as daemon in background.
+.TP
+.SH SEE ALSO
+.PP
+\&\fIdbus-send\fR\|(1)
+
+.SH FILES
+.BR /etc/dbus-1/system.d/ofono.conf
+.SH AUTHOR
+.br
+This man page was written by Andres Salomon <dilinger@collabora.co.uk>.
+
-- =

1.6.3.3


--===============5892914342524182078==--


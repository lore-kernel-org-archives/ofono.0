Content-Type: multipart/mixed; boundary="===============2594961270007089843=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 10/13] doc: explain debugging options to -d,
 add a pointer in -h to manpage
Date: Wed, 26 May 2010 12:49:24 -0700
Message-ID: <62d8f8ad8f10827a444e36fbefa1d52a34481e62.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2594961270007089843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Modified HACKING and man page to have more formation on what are the
debugging options and how to enable them.
---
 HACKING      |   10 ++++++++++
 doc/ofonod.8 |    5 ++++-
 src/main.c   |    4 +++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/HACKING b/HACKING
index ae420aa..e825185 100644
--- a/HACKING
+++ b/HACKING
@@ -81,3 +81,13 @@ automatically includes this option.
 =

 For production installations or distribution packaging it is important that
 the "--enable-maintainer-mode" option is NOT used.
+
+Note multiple arguments to -d can be specified, colon, comma or space
+separated. The arguments are relative source code filenames for which
+debugging output should be enabled; output shell-style globs are
+accepted (e.g.: 'plugins/*:src/main.c').
+
+Other debugging settings that can be toggled:
+
+ - Environment variable OFONO_AT_DEBUG (set to 1): enable AT commands
+   debugging
diff --git a/doc/ofonod.8 b/doc/ofonod.8
index 474d7fb..7bb908c 100644
--- a/doc/ofonod.8
+++ b/doc/ofonod.8
@@ -18,7 +18,10 @@ is used to manage \fID-Bus\fP permissions for oFono.
 .SH OPTIONS
 .TP
 .B --debug, -d
-Enable debug information output.
+Enable debug information output. Note multiple arguments to -d can be
+specified, colon, comma or space separated. The arguments are relative
+source code filenames for which debugging output should be enabled;
+output shell-style globs are accepted (e.g.: "plugins/*:src/main.c").
 .TP
 .B --nodetach, -n
 Don't run as daemon in background.
diff --git a/src/main.c b/src/main.c
index 8e686ac..c5791be 100644
--- a/src/main.c
+++ b/src/main.c
@@ -98,7 +98,9 @@ static gboolean option_version =3D FALSE;
 =

 static GOptionEntry options[] =3D {
 	{ "debug", 'd', 0, G_OPTION_ARG_STRING, &option_debug,
-				"Specify debug options to enable", "DEBUG" },
+			   "Specify debug options to enable (see the "
+			   "man page for ofonod(8) for more information).",
+			   "DEBUG" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
-- =

1.6.6.1


--===============2594961270007089843==--


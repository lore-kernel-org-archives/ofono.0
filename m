Content-Type: multipart/mixed; boundary="===============3307867348202695145=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 05/23] doc: explain debugging options to -d,
 add a pointer in -h to manpage
Date: Fri, 25 Jun 2010 16:15:27 -0700
Message-ID: <7e92d75b6ac64b851bb397ce36caf7bf7cc2911f.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3307867348202695145==
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
index d8df2f2..b395cfa 100644
--- a/src/main.c
+++ b/src/main.c
@@ -110,7 +110,9 @@ static gboolean parse_debug(const char *key, const char=
 *value,
 static GOptionEntry options[] =3D {
 	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_debug,
-				"Specify debug options to enable", "DEBUG" },
+			   "Specify debug options to enable (see the "
+			   "man page for ofonod(8) for more information).",
+			   "DEBUG" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
-- =

1.6.6.1


--===============3307867348202695145==--


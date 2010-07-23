Content-Type: multipart/mixed; boundary="===============2802888278564759493=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 03/20] manpage: explain debugging options to -d
Date: Fri, 23 Jul 2010 13:59:51 -0700
Message-ID: <653d2f7bd50151fb28b287940f62ac16dfec1830.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2802888278564759493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Modified HACKING and man page to have more formation on what are the
debugging options and how to enable them.
---
 HACKING      |   10 ++++++++++
 doc/ofonod.8 |    5 ++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

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
-- =

1.6.6.1


--===============2802888278564759493==--


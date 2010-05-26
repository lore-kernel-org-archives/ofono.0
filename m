Content-Type: multipart/mixed; boundary="===============8671103325868105877=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 11/13] automake: fix installation of udev rules in VPATH
 builds
Date: Wed, 26 May 2010 12:49:25 -0700
Message-ID: <a759b96fc09af236d1c322199cf42cc0d423fcc4.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8671103325868105877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

When the build directory is different than the source directory, we
need to specify the source prefix to the original file we are
copying.
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ed13346..31c157c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -418,7 +418,7 @@ src/ofono.ver: src/ofono.exp
 	$(AM_V_at)echo "local: *; };" >> $@
 =

 plugins/%.rules:
-	$(AM_V_GEN)cp $(subst 97-,,$@) $@
+	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 =

 $(src_ofonod_OBJECTS) $(unit_objects): $(local_headers)
 =

-- =

1.6.6.1


--===============8671103325868105877==--


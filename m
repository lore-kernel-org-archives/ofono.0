Content-Type: multipart/mixed; boundary="===============7933806120620095697=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [VPATH PATCH 2/2] Fix $(INCLUDE) in Makefile.am
Date: Tue, 30 Aug 2011 15:20:18 +0300
Message-ID: <1314706818-9720-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1314706818-9720-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7933806120620095697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow using directory names as namespaces.
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 832c8ac..92ef72e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -447,7 +447,8 @@ AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS=
@ @USB_CFLAGS@ \
 					-DOFONO_PLUGIN_BUILTIN \
 					-DPLUGINDIR=3D\""$(build_plugindir)"\"
 =

-INCLUDES =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
+INCLUDES =3D -I$(builddir) -I$(srcdir) -I$(builddir)/include \
+			-I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
 			-I$(srcdir)/btio
 =

-- =

1.7.4.1


--===============7933806120620095697==--


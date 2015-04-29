Content-Type: multipart/mixed; boundary="===============1335814992448710983=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH 3/3] ehs6: Add support for Cinterion EHS6 plugin
Date: Wed, 29 Apr 2015 19:39:05 +0100
Message-ID: <1430332745-15275-3-git-send-email-ajlennon@dynamicdevices.co.uk>
In-Reply-To: <1430332745-15275-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1335814992448710983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 22249c4..a7da15c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -393,6 +393,9 @@ builtin_sources +=3D plugins/caif.c
 builtin_modules +=3D tc65
 builtin_sources +=3D plugins/tc65.c
 =

+builtin_modules +=3D ehs6
+builtin_sources +=3D plugins/ehs6.c
+
 builtin_modules +=3D nokia
 builtin_sources +=3D plugins/nokia.c
 =

-- =

1.9.1


--===============1335814992448710983==--


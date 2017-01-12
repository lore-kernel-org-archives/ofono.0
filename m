Content-Type: multipart/mixed; boundary="===============5372478919119736338=="
MIME-Version: 1.0
From: Vincent Cesson <cesson.vincent@gmail.com>
Subject: [RFC 3/3] build: Add Gemalto plugin in Makefile
Date: Thu, 12 Jan 2017 18:06:52 +0100
Message-ID: <1484240812-3327-4-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1484240812-3327-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5372478919119736338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: vcesson <vincent.cesson@smile.fr>

---
 Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index a817565..a87c892 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -452,6 +452,9 @@ builtin_sources +=3D plugins/caif.c
 builtin_modules +=3D cinterion
 builtin_sources +=3D plugins/cinterion.c
 =

+builtin_modules +=3D gemalto
+builtin_sources +=3D plugins/gemalto.c
+
 builtin_modules +=3D nokia
 builtin_sources +=3D plugins/nokia.c
 =

-- =

1.9.1


--===============5372478919119736338==--


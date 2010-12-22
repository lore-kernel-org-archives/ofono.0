Content-Type: multipart/mixed; boundary="===============7139082794032876779=="
MIME-Version: 1.0
From: Oskari Timperi <oskari.timperi@ixonos.com>
Subject: [PATCHv2 2/3] Add TC65 to Makefile.am
Date: Wed, 22 Dec 2010 13:13:01 +0200
Message-ID: <1293016382-4607-3-git-send-email-oskari.timperi@ixonos.com>
In-Reply-To: <1293016382-4607-2-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7139082794032876779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4a919ab..1670de9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -287,6 +287,9 @@ builtin_sources +=3D plugins/ste.c

 builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
+
+builtin_modules +=3D tc65
+builtin_sources +=3D plugins/tc65.c
 endif

 if MAINTAINER_MODE
--
1.6.3.3

-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============7139082794032876779==--


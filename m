Content-Type: multipart/mixed; boundary="===============0386156092625296728=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] test-common: Avoid accessing an unitialised variable.
Date: Mon, 21 Jun 2010 10:41:10 +0200
Message-ID: <1277109671-7452-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0386156092625296728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes a segfault, reported by valrgind as:
[...]
=3D=3D6300=3D=3D Use of uninitialised value of size 4
=3D=3D6300=3D=3D    at 0x8048B4D: test_invalid (test-common.c:81)
---
 unit/test-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unit/test-common.c b/unit/test-common.c
index f33f117..baed178 100644
--- a/unit/test-common.c
+++ b/unit/test-common.c
@@ -78,7 +78,7 @@ static void test_invalid()
 =

 		ret =3D parse_ss_control_string(str, &type, &sc,
 						&sia, &sib, &sic, &sid, &dn);
-		if (strlen(sid))
+		if (ret =3D=3D TRUE && strlen(sid))
 			ret =3D FALSE;
 =

 		g_assert(ret =3D=3D FALSE);
-- =

1.7.1.86.g0e460.dirty


--===============0386156092625296728==--


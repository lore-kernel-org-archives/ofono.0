Content-Type: multipart/mixed; boundary="===============5336691895831345417=="
MIME-Version: 1.0
From: Adrian Bunk <bunk@kernel.org>
Subject: [PATCH] configure.ac: HAVE_EXPLICIT_BZERO is needed for internal ell
Date: Thu, 09 May 2019 12:19:52 +0300
Message-ID: <20190509091952.17075-2-bunk@kernel.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5336691895831345417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index bacb7ac5..cf33d79a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -220,6 +220,8 @@ if (test "${enable_external_ell}" =3D "yes"); then
 		AC_MSG_ERROR(Embedded Linux library >=3D 0.12 is required))
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
+else
+	AC_CHECK_FUNCS(explicit_bzero)
 fi
 AM_CONDITIONAL(EXTERNAL_ELL, test "${enable_external_ell}" =3D "yes")
 =

-- =

2.20.1


--===============5336691895831345417==--


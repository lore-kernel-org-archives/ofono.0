Content-Type: multipart/mixed; boundary="===============2628672143948341864=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] gril: Really use given uid/gid to open ril socket
Date: Wed, 23 Mar 2016 10:58:13 +0100
Message-ID: <1458727093-13826-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2628672143948341864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gril/gril.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/gril/gril.c b/gril/gril.c
index fa1a780..297a772 100644
--- a/gril/gril.c
+++ b/gril/gril.c
@@ -824,14 +824,15 @@ static struct ril_s *create_ril(const char *sock_path=
, unsigned int uid,
 	addr.sun_family =3D AF_UNIX;
 	strncpy(addr.sun_path, sock_path, sizeof(addr.sun_path) - 1);
 =

-	if (uid !=3D 0 && seteuid(uid) < 0)
-		ofono_error("%s: seteuid(%d) failed: %s (%d)",
-				__func__, uid, strerror(errno), errno);
-
+	/* Drop root user last, otherwise we won't be able to change egid */
 	if (gid !=3D 0 && setegid(gid) < 0)
 		ofono_error("%s: setegid(%d) failed: %s (%d)",
 				__func__, gid, strerror(errno), errno);
 =

+	if (uid !=3D 0 && seteuid(uid) < 0)
+		ofono_error("%s: seteuid(%d) failed: %s (%d)",
+				__func__, uid, strerror(errno), errno);
+
 	r =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 =

 	/* Switch back to root as needed */
@@ -1053,7 +1054,7 @@ GRil *g_ril_new_with_ucred(const char *sock_path, enu=
m ofono_ril_vendor vendor,
 	if (ril =3D=3D NULL)
 		return NULL;
 =

-	ril->parent =3D create_ril(sock_path, 0, 0);
+	ril->parent =3D create_ril(sock_path, uid, gid);
 	if (ril->parent =3D=3D NULL) {
 		g_free(ril);
 		return NULL;
-- =

2.5.0


--===============2628672143948341864==--


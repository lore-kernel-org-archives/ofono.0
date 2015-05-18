Content-Type: multipart/mixed; boundary="===============0212483891386159594=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] gprs: Add comment to gprs_reset_contexts
Date: Mon, 18 May 2015 19:07:45 +0200
Message-ID: <1431968865-21620-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0212483891386159594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 9c15abf..f21fe6e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2318,6 +2318,11 @@ static DBusMessage *gprs_reset_contexts(DBusConnecti=
on *conn,
 	if (gprs->pending)
 		return __ofono_error_busy(msg);
 =

+	/*
+	 * We want __ofono_error_busy to take precedence over
+	 * __ofono_error_not_allowed errors, so we check it first.
+	 */
+
 	for (l =3D gprs->contexts; l; l =3D l->next) {
 		struct pri_context *ctx =3D l->data;
 =

-- =

2.1.4


--===============0212483891386159594==--


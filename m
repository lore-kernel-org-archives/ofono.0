Content-Type: multipart/mixed; boundary="===============0308656935015496041=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Do nothing on detached when attaching.
Date: Sun, 22 Sep 2019 23:04:23 +0200
Message-ID: <20190922210423.4553-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0308656935015496041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Its incorrect to fiddle with the driver attach state when
attaching. When attaching the state is transitioning,
and the correct state will not always be assigned in
the end of the attach process, regardless of result.
---
 src/gprs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index c7b181f5..7d854fcf 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2551,6 +2551,15 @@ void ofono_gprs_detached_notify(struct ofono_gprs *g=
prs)
 {
 	DBG("%s", __ofono_atom_get_path(gprs->atom));
 =

+	/*
+	 * In case we are attaching let that finish, it will update to the
+	 * correct status. If we fiddle with driver_attach and the
+	 * attach fails, the code will invert back the state to attached,
+	 * which would leave us in an incorrect state.
+	 */
+	if (gprs->flags & GPRS_FLAG_ATTACHING)
+		return;
+
 	gprs->driver_attached =3D FALSE;
 	gprs_attached_update(gprs);
 =

-- =

2.20.1


--===============0308656935015496041==--


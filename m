Content-Type: multipart/mixed; boundary="===============1030693078684613195=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: update attached on netreg updates when running LTE
Date: Tue, 01 Oct 2019 22:10:51 +0200
Message-ID: <20191001201051.21376-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1030693078684613195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

There was a race condition where a context might be
registered before the netreg status updates to LTE.

The code took for granted the context is activated after
the technology update. With this change, any order is
is accepted.
---
 src/gprs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index a8702958..a1e52572 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1721,12 +1721,18 @@ static void gprs_netreg_update(struct ofono_gprs *g=
prs)
 =

 	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
 =

-	if (on_lte(gprs))
+	if (on_lte(gprs)) {
 		/*
 		 * For LTE we set attached status only on successful
 		 * context activation.
+		 *
+		 * The context could potentially be registered before the netreg
+		 * update is received.
 		 */
-                return;
+		gprs_attached_update(gprs);
+
+		return;
+	}
 =

 	if (gprs->driver_attached =3D=3D attach)
 		return;
-- =

2.20.1

--===============1030693078684613195==--


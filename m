Content-Type: multipart/mixed; boundary="===============4780167878044775422=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH v2] gprs: Only release detachable context on de-attach
Date: Tue, 17 Sep 2019 18:25:48 +0200
Message-ID: <20190917162548.14266-1-richard.rojfors@gmail.com>
In-Reply-To: <20190917111417.27567-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4780167878044775422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Currently there is an issue if the attach state changes and
there are active contexts of which the driver does not
implement the detach_shutdown.
In that case we just release the context (clears CID and
active state), but nothing is signalled on D-Bus or towards
the modem.
Ofono is then out of sync with both the connection manager
and the modem, this manifests itself later on if the modem
changes state of the context, then ofono will not find it
since the CID is cleared, and the connection manager won't
be notified.
---
 src/gprs.c | 55 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index de172979..85a6b29e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1521,6 +1521,27 @@ static gboolean have_active_contexts(struct ofono_gp=
rs *gprs)
 	return FALSE;
 }
 =

+static gboolean have_detachable_active_contexts(struct ofono_gprs *gprs)
+{
+	GSList *l;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx;
+		struct ofono_gprs_context *gc;
+
+		ctx =3D l->data;
+		gc =3D ctx->context_driver;
+
+		if (!gc || !gc->driver->detach_shutdown)
+			continue;
+
+		if (ctx->active =3D=3D TRUE)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static bool have_read_settings(struct ofono_gprs *gprs)
 {
 	GSList *l;
@@ -1535,7 +1556,7 @@ static bool have_read_settings(struct ofono_gprs *gpr=
s)
 	return false;
 }
 =

-static void release_active_contexts(struct ofono_gprs *gprs)
+static void detach_active_contexts(struct ofono_gprs *gprs)
 {
 	GSList *l;
 	struct pri_context *ctx;
@@ -1599,23 +1620,27 @@ static void gprs_attached_update(struct ofono_gprs =
*gprs)
 	 * at driver level. "Attached" =3D TRUE property can't be signalled to
 	 * the applications registered on GPRS properties.
 	 * Active contexts have to be release at driver level.
+	 *
+	 * Skip that for LTE since the condition to be attached on LTE
+	 * is that a context gets activated
 	 */
-	if (attached =3D=3D FALSE) {
-		release_active_contexts(gprs);
-		gprs->bearer =3D -1;
-	} else if (have_active_contexts(gprs) =3D=3D TRUE && !on_lte(gprs)) {
-		/*
-		 * Some times the context activates after a detach event and
-		 * right before an attach. We close it to avoid unexpected open
-		 * contexts.
-		 * Skip that for LTE since the condition to be attached on LTE
-		 * is that a context gets activated
-		 */
-		release_active_contexts(gprs);
-		gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
-		return;
+	if (have_detachable_active_contexts(gprs) && !on_lte(gprs)) {
+		detach_active_contexts(gprs);
+
+		if (attached =3D=3D TRUE) {
+			/*
+			 * Some times the context activates after a detach event
+			 * and right before an attach. We close it to avoid
+			 * unexpected open contexts.
+			 */
+			gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
+			return;
+		}
 	}
 =

+	if (attached =3D=3D FALSE)
+		gprs->bearer =3D -1;
+
 	gprs_set_attached_property(gprs, attached);
 }
 =

-- =

2.20.1


--===============4780167878044775422==--


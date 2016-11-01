Content-Type: multipart/mixed; boundary="===============7981352849625197001=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] gprs: avoid remove context when context operation is in
 progress
Date: Tue, 01 Nov 2016 14:19:11 +0800
Message-ID: <1477981151-28551-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7981352849625197001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

If remove the context before context activation / deactivation is
completed, it may cause crash.
---
 src/gprs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 3a4a819..4aa00f9 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2154,13 +2154,13 @@ static DBusMessage *gprs_remove_context(DBusConnect=
ion *conn,
 	if (ctx =3D=3D NULL)
 		return __ofono_error_not_found(msg);
 =

+	/* This context is already being messed with */
+	if (ctx->pending)
+		return __ofono_error_busy(msg);
+
 	if (ctx->active) {
 		struct ofono_gprs_context *gc =3D ctx->context_driver;
 =

-		/* This context is already being messed with */
-		if (ctx->pending)
-			return __ofono_error_busy(msg);
-
 		gprs->pending =3D dbus_message_ref(msg);
 		gc->driver->deactivate_primary(gc, ctx->context.cid,
 					gprs_deactivate_for_remove, ctx);
-- =

1.9.1


--===============7981352849625197001==--


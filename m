Content-Type: multipart/mixed; boundary="===============6308401883524525651=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] gprs: Check GPRS_FLAG_ATTACHED_UPDATE in
 pri_deactivate_callback
Date: Tue, 01 Nov 2016 18:53:17 +0300
Message-ID: <1478015597-22406-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6308401883524525651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This prevents attached state from getting stuck at 0 like this:

1. Context deactivation is initiated over D-Bus, ctx->pending is set
2. Attached becomes FALSE, context is still marked as active
3. Attached becomes TRUE, gprs_attached_update sets GPRS_FLAG_ATTACHED_UPDA=
TE
4. Deactivation completes, attached is 0, driver_attached is 1

Futher network status updates don't call gprs_attached_update because
driver_attached is still 1, so attached is staying 0 until we lose the
data registration again which may not happen for quite a long time.
---
 src/gprs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 3a4a819..3d71398 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -135,6 +135,7 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+static void gprs_attached_update(struct ofono_gprs *gprs);
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

@@ -946,6 +947,16 @@ static void pri_deactivate_callback(const struct ofono=
_error *error, void *data)
 	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+	/*
+	 * If "Attached" property was about to be signalled as TRUE but there
+	 * were still active contexts, try again to signal "Attached" property
+	 * to registered applications after active contexts have been released.
+	 */
+	if (ctx->gprs && (ctx->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE)) {
+		ctx->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
+		gprs_attached_update(ctx->gprs);
+	}
 }
 =

 static void pri_read_settings_callback(const struct ofono_error *error,
-- =

1.9.1


--===============6308401883524525651==--


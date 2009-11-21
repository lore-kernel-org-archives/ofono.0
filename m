Content-Type: multipart/mixed; boundary="===============7230619771428863887=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/1] emit settings signal before active signal
Date: Sat, 21 Nov 2009 18:56:48 +0800
Message-ID: <1258801008-9862-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7230619771428863887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index b533209..57bb794 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -374,18 +374,19 @@ static void pri_activate_callback(const struct ofono_=
error *error,
 	__ofono_dbus_pending_reply(&gc->pending,
 				dbus_message_new_method_return(gc->pending));
 =

-	value =3D ctx->active;
-	ofono_dbus_signal_property_changed(conn, ctx->path,
-						DATA_CONTEXT_INTERFACE,
-						"Active", DBUS_TYPE_BOOLEAN,
-						&value);
-
 	/* If we don't have the interface, don't bother emitting any settings,
 	 * as nobody can make use of them
 	 */
 	if (interface !=3D NULL)
 		pri_update_context_settings(ctx, interface, static_ip,
 						ip, netmask, gateway, dns);
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+						DATA_CONTEXT_INTERFACE,
+						"Active", DBUS_TYPE_BOOLEAN,
+						&value);
+
 }
 =

 static void pri_deactivate_callback(const struct ofono_error *error, void =
*data)
-- =

1.6.1.3


--===============7230619771428863887==--


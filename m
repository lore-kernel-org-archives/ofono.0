Content-Type: multipart/mixed; boundary="===============7802591449407744486=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] plugins: Fix allowed apn plugin exit
Date: Thu, 26 May 2016 14:39:48 +0530
Message-ID: <1464253788-30332-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7802591449407744486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/allowed-apns.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/plugins/allowed-apns.c b/plugins/allowed-apns.c
index 77ede86..fd68e35 100644
--- a/plugins/allowed-apns.c
+++ b/plugins/allowed-apns.c
@@ -32,7 +32,6 @@
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
-#include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/sim.h>
 #include <ofono/dbus.h>
@@ -43,6 +42,7 @@
 #define ALLOWED_ACCESS_POINTS_INTERFACE "org.ofono.AllowedAccessPoints"
 =

 guint modemwatch_id;
+GSList *context_list;
 =

 struct allowed_apns_ctx {
 	guint simwatch_id;
@@ -54,8 +54,6 @@ struct allowed_apns_ctx {
 	DBusMessage *reply;
 };
 =

-GSList *context_list;
-
 static void context_destroy(gpointer data)
 {
 	struct allowed_apns_ctx *ctx =3D data;
@@ -71,8 +69,6 @@ static void context_destroy(gpointer data)
 	if (ctx->sim_context)
 		ofono_sim_context_free(ctx->sim_context);
 =

-	context_list =3D g_slist_remove(context_list, ctx);
-
 	g_free(ctx);
 }
 =

@@ -191,8 +187,15 @@ static void sim_watch(struct ofono_atom *atom,
 	struct allowed_apns_ctx *ctx =3D data;
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
-		if (ctx->sim_context)
+		if (ctx->simwatch_id) {
+			ofono_sim_remove_state_watch(ctx->sim, ctx->simwatch_id);
+			ctx->simwatch_id =3D 0;
+		}
+
+		if (ctx->sim_context) {
 			ofono_sim_context_free(ctx->sim_context);
+			ctx->sim_context =3D NULL;
+		}
 =

 		return;
 	}
-- =

1.9.1


--===============7802591449407744486==--


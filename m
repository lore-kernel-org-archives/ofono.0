Content-Type: multipart/mixed; boundary="===============8502176351955115235=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 1/2] gprs:Add code to handle AT+CGDCONT
Date: Tue, 15 Feb 2011 14:19:22 +0100
Message-ID: <1297775963-3426-2-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1297775963-3426-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8502176351955115235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h |    2 +
 src/gprs.c     |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 157a6f9..1901329 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -73,6 +73,8 @@ void ofono_gprs_remove(struct ofono_gprs *gprs);
 void ofono_gprs_set_data(struct ofono_gprs *gprs, void *data);
 void *ofono_gprs_get_data(struct ofono_gprs *gprs);
 =

+void ofono_gprs_add_emulator_handler(void *user);
+
 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 				unsigned int min, unsigned int max);
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
diff --git a/src/gprs.c b/src/gprs.c
index 33711dc..b36f94d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -45,6 +45,7 @@
 #include "idmap.h"
 #include "simutil.h"
 #include "util.h"
+#include "gatserver.h"
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -2762,3 +2763,65 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
+static void ofono_gprs_list_contexts(struct ofono_gprs *gprs, gpointer use=
r)
+{
+	GAtServer *server =3D user;
+	GSList *l;
+	char buf[256];
+	int i;
+
+	struct pri_context *ctx;
+
+	i =3D 1;
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		snprintf(buf, 255, "+CGDCONT: %d,\"%s\",\"%s\"",
+				i, gprs_proto_to_string(ctx->context.proto),
+				ctx->context.apn);
+
+		g_at_server_send_info(server, buf, FALSE);
+		i +=3D 1 ;
+	}
+}
+
+/* Process the usual AT+CGDCONT command
+ * TODO Create context
+ * TODO Delete: how to map the cid with the correct context
+ * TODO Req. type support: check the range.
+ */
+static void cgdcont_cb(GAtServerRequestType type, GAtResult *cmd, gpointer=
 user)
+{
+	struct ofono_emulator *em =3D user;
+	GAtServer *server =3D em->server;
+	void *atom_gprs =3D __ofono_atom_get_data(em->gprs_atom);
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:  /* +CGDCONT=3D? */
+		g_at_server_send_info(server,
+				"+CGDCONT: (1-10),\"IP\",,,(0-2),(0,1,2,3,4)", FALSE);
+		g_at_server_send_info(server,
+				"+CGDCONT: (1-2),\"IPv6\",,,(0-2),(0,1,2,3,4)", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:  /* +CGDCONT? */
+		ofono_gprs_list_contexts(atom_gprs, server);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	};
+}
+
+void ofono_gprs_add_emulator_handler(void *user)
+{
+	struct ofono_emulator *em =3D user;
+
+	g_at_server_register(em->server, "+CGDCONT", cgdcont_cb, em, NULL);
+}
-- =

1.7.1


--===============8502176351955115235==--


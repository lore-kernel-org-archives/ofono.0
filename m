Content-Type: multipart/mixed; boundary="===============6409845564345919963=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 5/6] Core support for packet switched bearer reporting
Date: Thu, 25 Nov 2010 17:14:37 +0200
Message-ID: <1290698078-18803-5-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201011251714.19241.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6409845564345919963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 3b0733e..0226985 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -107,6 +107,7 @@ struct context_settings {
 =

 struct pri_context {
 	ofono_bool_t active;
+	int bearer;
 	enum ofono_gprs_context_type type;
 	char name[MAX_CONTEXT_NAME_LENGTH + 1];
 	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
@@ -596,6 +597,13 @@ static void append_context_properties(struct pri_conte=
xt *ctx,
 	value =3D ctx->active;
 	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (ctx->active) {
+		const char *bearer =3D packet_bearer_to_string(ctx->bearer);
+
+		ofono_dbus_dict_append(dict, "Bearer",
+					DBUS_TYPE_STRING, &bearer);
+	}
+
 	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING, &type);
 =

 	ofono_dbus_dict_append(dict, "Protocol", DBUS_TYPE_STRING, &proto);
@@ -1591,6 +1599,7 @@ static struct pri_context *add_context(struct ofono_g=
prs *gprs,
 		return NULL;
 	}
 =

+	context->bearer =3D -1;
 	context->id =3D id;
 =

 	DBG("Registering new context");
@@ -2001,6 +2010,29 @@ void ofono_gprs_add_context(struct ofono_gprs *gprs,
 	__ofono_atom_register(gc->atom, gprs_context_unregister);
 }
 =

+void ofono_gprs_context_bearer_notify(struct ofono_gprs_context *gc, int c=
id,
+					int bearer)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GSList *l;
+	const char *value =3D packet_bearer_to_string(bearer);
+
+	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->context.cid !=3D cid)
+			continue;
+
+		if (ctx->bearer =3D=3D bearer)
+			continue;
+
+		ctx->bearer =3D bearer;
+		ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Bearer", DBUS_TYPE_STRING, &value);
+	}
+}
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int cid)
 {
-- =

1.7.1


--===============6409845564345919963==--


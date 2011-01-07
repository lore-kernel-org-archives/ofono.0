Content-Type: multipart/mixed; boundary="===============4798814034024351674=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/4] Core support for packet switched bearer reporting
Date: Fri, 07 Jan 2011 18:02:05 +0200
Message-ID: <1294416127-22432-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294416127-22432-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4798814034024351674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h |    2 ++
 src/gprs.c     |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 1c1d116..cd62f2f 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -59,6 +59,8 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs, in=
t status, int tech);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
 void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
 void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
+				unsigned int cid, int bearer);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
 void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
diff --git a/src/gprs.c b/src/gprs.c
index bd52676..3d4b1a8 100644
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

+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
+				unsigned int cid, int bearer)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GSList *l;
+	const char *value =3D packet_bearer_to_string(bearer);
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
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


--===============4798814034024351674==--


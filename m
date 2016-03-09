Content-Type: multipart/mixed; boundary="===============6859641381192816248=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 12/19] gprs: allow APN updates from gprs-context driver
Date: Wed, 09 Mar 2016 16:44:53 +0100
Message-ID: <1457538300-7183-13-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6859641381192816248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the context activation callback, check for a changed APN. The default
PDP in a 4G network is usually automatically activated. We might not know
the APN. So allow the driver to read the APN and push it back into the
core context.
---
 src/gprs.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9192e68..d31e91b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -103,6 +103,7 @@ struct ipv6_settings {
 };
 =

 struct context_settings {
+	char *apn;
 	char *interface;
 	struct ipv4_settings *ipv4;
 	struct ipv6_settings *ipv6;
@@ -383,6 +384,9 @@ static void context_settings_free(struct context_settin=
gs *settings)
 		settings->ipv6 =3D NULL;
 	}
 =

+	g_free(settings->apn);
+	settings->apn =3D NULL;
+
 	g_free(settings->interface);
 	settings->interface =3D NULL;
 }
@@ -867,6 +871,9 @@ static DBusMessage *pri_get_properties(DBusConnection *=
conn,
 	return reply;
 }
 =

+static DBusMessage *pri_set_apn(struct pri_context *ctx, DBusConnection *c=
onn,
+				DBusMessage *msg, const char *apn);
+
 static void pri_activate_callback(const struct ofono_error *error, void *d=
ata)
 {
 	struct pri_context *ctx =3D data;
@@ -886,6 +893,11 @@ static void pri_activate_callback(const struct ofono_e=
rror *error, void *data)
 		return;
 	}
 =

+
+	if (gc->settings->apn && strcmp(gc->settings->apn, ctx->context.apn))
+		/* APN changed  during context activation. */
+		pri_set_apn(ctx, conn, NULL, gc->settings->apn);
+
 	ctx->active =3D TRUE;
 	__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
@@ -955,13 +967,13 @@ static DBusMessage *pri_set_apn(struct pri_context *c=
tx, DBusConnection *conn,
 		storage_sync(ctx->gprs->imsi, SETTINGS_STORE, settings);
 	}
 =

-	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+	if (msg)
+		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

 	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"AccessPointName",
 					DBUS_TYPE_STRING, &apn);
-
 	return NULL;
 }
 =

@@ -2688,6 +2700,15 @@ void ofono_gprs_context_set_interface(struct ofono_g=
prs_context *gc,
 	settings->interface =3D g_strdup(interface);
 }
 =

+void ofono_gprs_context_set_apn(struct ofono_gprs_context *gc,
+					const char *apn)
+{
+	struct context_settings *settings =3D gc->settings;
+
+	g_free(settings->apn);
+	settings->apn =3D g_strdup(apn);
+}
+
 void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
 						const char *address,
 						ofono_bool_t static_ip)
-- =

2.5.0


--===============6859641381192816248==--


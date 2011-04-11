Content-Type: multipart/mixed; boundary="===============7498706608511397230=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 16/20] packet: add default context implementation
Date: Mon, 11 Apr 2011 13:20:14 +0300
Message-ID: <1302517218-2147-17-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7498706608511397230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes include context creation and signalling of
dbus property property changes.
---
 src/packet.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/src/packet.c b/src/packet.c
index ed8e1ae..f8a76c6 100644
--- a/src/packet.c
+++ b/src/packet.c
@@ -2950,6 +2950,100 @@ void *ofono_packet_service_get_data(struct ofono_pa=
cket_service *ps)
 	return ps->driver_data;
 }
 =

+void ofono_packet_service_default_context_notify(
+				struct ofono_packet_service *ps,
+				struct ofono_default_context_param *dc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct context *ctx;
+	struct context_settings *settings;
+	GSList *l;
+	dbus_bool_t value;
+
+	/*
+	 * Assumption: context id for default EPS context will have value
+	 * outside the ranges indicated in the test form of the command
+	 * +CGDCONT.
+	 */
+	ctx =3D context_create(ps, "default", OFONO_PACKET_CONTEXT_TYPE_DEFAULT);
+	if (ctx =3D=3D NULL) {
+		ofono_error("Unable to allocate memory for default context");
+		return;
+	}
+
+	ctx->id =3D dc->cid;
+	ctx->active =3D TRUE;
+	ctx->context.proto =3D dc->proto;
+	strcpy(ctx->context.apn, dc->apn);
+
+	for (l =3D ctx->ps->context_drivers; l; l =3D l->next) {
+		struct ofono_packet_context *pc =3D l->data;
+
+		if (pc->inuse =3D=3D TRUE)
+			continue;
+
+		if (pc->driver =3D=3D NULL)
+			continue;
+
+		if (pc->driver->activate_context =3D=3D NULL ||
+				pc->driver->deactivate_context =3D=3D NULL)
+			continue;
+
+		if (pc->type !=3D OFONO_PACKET_CONTEXT_TYPE_ANY &&
+				pc->type !=3D ctx->type)
+			continue;
+
+		ctx->context_driver =3D pc;
+		ctx->context_driver->inuse =3D TRUE;
+
+		if (ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IPV4V6 ||
+				ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IP)
+			pc->settings->ipv4 =3D g_new0(struct ipv4_settings, 1);
+
+		if (ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IPV4V6 ||
+				ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IPV6)
+			pc->settings->ipv6 =3D g_new0(struct ipv6_settings, 1);
+
+		ofono_packet_context_set_type(pc, ctx->type);
+		ofono_packet_context_set_interface(pc, dc->interface);
+
+		if (pc->settings->ipv4) {
+			ofono_packet_context_set_ipv4_address(pc, dc->address,
+									TRUE);
+			ofono_packet_context_set_ipv4_gateway(pc, dc->gateway);
+			ofono_packet_context_set_ipv4_dns_servers(pc, dc->dns);
+		}
+
+		if (pc->settings->ipv6) {
+			ofono_packet_context_set_ipv6_address(pc, dc->address);
+			ofono_packet_context_set_ipv6_gateway(pc, dc->gateway);
+			ofono_packet_context_set_ipv6_dns_servers(pc, dc->dns);
+		}
+
+		break;
+	}
+
+	settings =3D ctx->context_driver->settings;
+
+	/*
+	 * If context dbus registration fails or unregistered, context id is
+	 * put back into the idmap which should not be done for default
+	 * context if the context id doesn't fall within range supplied by
+	 * +CGDCONT. TODO: This needs to be addressed.
+	 */
+	if (!context_dbus_register(ctx)) {
+		ofono_error("Unable to register default context");
+		return;
+	}
+
+	ps->contexts =3D g_slist_append(ps->contexts, ctx);
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+}
+
 int ofono_packet_service_get_technology(struct ofono_packet_service *ps)
 {
 	if (ps->netreg_status !=3D NETWORK_REGISTRATION_STATUS_ROAMING &&
@@ -2957,4 +3051,4 @@ int ofono_packet_service_get_technology(struct ofono_=
packet_service *ps)
 		return -1;
 =

 	return ps->netreg_access_tech;
-}
\ No newline at end of file
+}
-- =

1.7.0.4


--===============7498706608511397230==--


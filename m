Content-Type: multipart/mixed; boundary="===============0000203566579074598=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v0] ofono: Only register network when APN is set
Date: Tue, 28 Feb 2012 10:19:23 +0100
Message-ID: <1330420763-8244-1-git-send-email-wagi@monom.org>
In-Reply-To: <1330363830.3392.59.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0000203566579074598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

We should now show a network without an APN.
---
I have not tested this one. But something like this should do
the trick. Maybe someone with deeper knowledge on the APN
behavior could explain under which circumstances the APN is set, e.g.
see the netreg vs apn setting in this patch. Not sure if this is correct.

cheers,
daniel

 plugins/ofono.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index d87d7b6..c92c3cc 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -105,6 +105,9 @@ enum ofono_api {
  * the plugin about IP configuration through the updating the context's
  * properties.
  *
+ * The network is only registered at the core when the AccessPointName
+ * has been set.
+ *
  * CDMA working flow:
  *
  * When a new modem appears, the plugin always powers it up. This
@@ -172,6 +175,7 @@ struct modem_data {
 	/* ConnectionContext Interface */
 	connman_bool_t active;
 	connman_bool_t set_active;
+	char *apn;
 =

 	/* SimManager Interface */
 	char *imsi;
@@ -1105,6 +1109,10 @@ static int add_cm_context(struct modem_data *modem, =
const char *context_path,
 			dbus_message_iter_get_basic(&value, &active);
 =

 			DBG("%s Active %d", modem->path, active);
+		} else if (g_str_equal(key, "AccessPointName") =3D=3D TRUE) {
+			dbus_message_iter_get_basic(&value, &modem->apn);
+
+			DBG("%s AccessPointName %s", modem->path, modem->apn);
 		}
 =

 		dbus_message_iter_next(dict);
@@ -1180,6 +1188,19 @@ static gboolean context_changed(DBusConnection *conn=
ection,
 			set_connected(modem);
 		else
 			set_disconnected(modem);
+	} else if (g_str_equal(key, "AccessPointName") =3D=3D TRUE) {
+		g_free(modem->apn);
+
+		dbus_message_iter_get_basic(&value, &modem->apn);
+
+		DBG("%s AccessPointName %s", modem->path, modem->apn);
+
+		if (has_interface(modem->interfaces,
+					OFONO_API_NETREG) =3D=3D TRUE &&
+				modem->network !=3D NULL) {
+			DBG("Register network at core");
+			add_network(modem);
+		}
 	}
 =

 	return TRUE;
@@ -1518,6 +1539,9 @@ static void netreg_properties_reply(struct modem_data=
 *modem,
 		return;
 	}
 =

+	if (modem->apn =3D=3D NULL)
+		return;
+
 	add_network(modem);
 =

 	if (modem->active =3D=3D TRUE)
@@ -2187,6 +2211,7 @@ static void remove_modem(gpointer data)
 	g_free(modem->serial);
 	g_free(modem->name);
 	g_free(modem->imsi);
+	g_free(modem->apn);
 	g_free(modem->path);
 =

 	g_free(modem);
-- =

1.7.9.48.g85da4d


--===============0000203566579074598==--


Content-Type: multipart/mixed; boundary="===============0195278582561314277=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [RFC][PATCH] Add: online method to isimodem
Date: Thu, 22 Apr 2010 17:49:58 +0300
Message-ID: <1271947798-16962-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1271947798-16962-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0195278582561314277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/isimodem.c |   38 +++++++---
 gatchat/gatppp.c            |   16 ++++
 gatchat/ppp.h               |    2 +
 gatchat/ppp_lcp.c           |    4 +
 gatchat/ppp_net.c           |   13 +++-
 include/modem.h             |    6 ++
 src/modem.c                 |  183 +++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                 |   11 +++
 8 files changed, 260 insertions(+), 13 deletions(-)

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index e6e0bc1..733ac96 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -64,16 +64,20 @@ struct isi_data {
 	GIsiModem *idx;
 	GIsiClient *client;
 	GPhonetNetlink *link;
+	GPhonetLinkState linkstate;
 	unsigned interval;
-	int reported;
+	int powered;
 	int mtc_state;
-	int iface_up;
+	int online;
 };
 =

-static void report_powered(struct isi_data *isi, ofono_bool_t powered)
+static void report_powered(struct isi_data *isi, ofono_bool_t powered,
+				ofono_bool_t online)
 {
-	if (powered !=3D isi->reported)
-		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
+	if (powered !=3D isi->powered)
+		ofono_modem_set_powered(isi->modem, isi->powered =3D powered);
+	if (online !=3D isi->online)
+		ofono_modem_set_online(isi->modem, isi->online =3D online);
 }
 =

 static void set_power_by_mtc_state(struct isi_data *isi, int state)
@@ -84,16 +88,19 @@ static void set_power_by_mtc_state(struct isi_data *isi=
, int state)
 	case MTC_POWER_OFF:
 	case MTC_CHARGING:
 	case MTC_SELFTEST_FAIL:
-		report_powered(isi, 0);
+		report_powered(isi, 0, 0);
 		break;
 =

 	case MTC_RF_INACTIVE:
+		report_powered(isi, 1, 0);
+		break;
+
 	case MTC_NORMAL:
-		report_powered(isi, 1);
+		report_powered(isi, 1, 1);
 		break;
 =

 	default:
-		report_powered(isi, 1);
+		report_powered(isi, 1, 1);
 	}
 }
 =

@@ -132,7 +139,7 @@ static bool mtc_poll_query_cb(GIsiClient *client, const=
 void *restrict data,
 			MTC_STATE_QUERY_REQ, 0x00, 0x00
 		};
 =

-		if (!isi-> iface_up)
+		if (isi->linkstate !=3D PN_LINK_UP)
 			return true;
 =

 		isi->interval *=3D 2;
@@ -198,7 +205,7 @@ static void reachable_cb(GIsiClient *client, bool alive=
, uint16_t object,
 	if (!alive) {
 		DBG("MTC client: %s", strerror(-g_isi_client_error(client)));
 =

-		if (isi->iface_up)
+		if (isi->linkstate =3D=3D PN_LINK_UP)
 			g_isi_request_make(client, msg, sizeof(msg),
 						isi->interval =3D MTC_TIMEOUT,
 						mtc_poll_query_cb, opaque);
@@ -228,7 +235,7 @@ static void phonet_status_cb(GIsiModem *idx,
 		st =3D=3D PN_LINK_REMOVED ? "removed" :
 		st =3D=3D PN_LINK_DOWN ? "down" : "up");
 =

-	isi->iface_up =3D st =3D=3D PN_LINK_UP;
+	isi->linkstate =3D st;
 =

 	if (st =3D=3D PN_LINK_UP)
 		g_isi_verify(isi->client, reachable_cb, isi);
@@ -278,6 +285,8 @@ static int isi_modem_probe(struct ofono_modem *modem)
 	isi->ifname =3D ifname;
 	isi->link =3D link;
 	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
+	isi->powered =3D -1;
+	isi->online =3D -1;
 =

 	return 0;
 }
@@ -334,12 +343,19 @@ static void isi_modem_post_sim(struct ofono_modem *mo=
dem)
 		DBG("Failed to add context");
 }
 =

+static int isi_modem_online(struct ofono_modem *modem, ofono_bool_t online)
+{
+	/* isi_modem follows modem online/offline state */
+	return -ENOTSUP;
+}
+
 static struct ofono_modem_driver driver =3D {
 	.name =3D "isimodem",
 	.probe =3D isi_modem_probe,
 	.remove =3D isi_modem_remove,
 	.pre_sim =3D isi_modem_pre_sim,
 	.post_sim =3D isi_modem_post_sim,
+	.online =3D isi_modem_online,
 };
 =

 static int isimodem_init(void)
diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index e1e49e6..b7834e3 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -40,6 +40,7 @@
 #include "ppp.h"
 =

 #define DEFAULT_MRU	1500
+#define DEFAULT_MTU	1500
 =

 #define BUFFERSZ	(DEFAULT_MRU * 2)
 =

@@ -58,6 +59,7 @@ struct _GAtPPP {
 	guint8 buffer[BUFFERSZ];
 	int index;
 	gint mru;
+	gint mtu;
 	char username[256];
 	char password[256];
 	guint32 xmit_accm[8];
@@ -407,6 +409,8 @@ void ppp_net_up_notify(GAtPPP *ppp, const char *ip,
 {
 	ppp->net =3D ppp_net_new(ppp);
 =

+	ppp_net_set_mtu(ppp->net, ppp->mtu);
+
 	if (ppp->connect_cb =3D=3D NULL)
 		return;
 =

@@ -435,6 +439,17 @@ void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm)
 	ppp->xmit_accm[0] =3D accm;
 }
 =

+/*
+ * The only time we use other than default MTU is when we are in
+ * the network phase.
+ */
+void ppp_set_mtu(GAtPPP *ppp, const guint8 *data)
+{
+	guint16 mtu =3D get_host_short(data);
+
+	ppp->mtu =3D mtu;
+}
+
 /* Administrative Open */
 void g_at_ppp_open(GAtPPP *ppp)
 {
@@ -576,6 +591,7 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 =

 	/* set options to defaults */
 	ppp->mru =3D DEFAULT_MRU;
+	ppp->mtu =3D DEFAULT_MTU;
 	ppp->recv_accm =3D ~0U;
 	ppp->xmit_accm[0] =3D ~0U;
 	ppp->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index a8a0486..07483a9 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -103,6 +103,7 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp);
 const char *ppp_net_get_interface(struct ppp_net *net);
 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
+void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
 =

 /* PPP functions related to main GAtPPP object */
 void ppp_debug(GAtPPP *ppp, const char *str);
@@ -115,3 +116,4 @@ void ppp_net_up_notify(GAtPPP *ppp, const char *ip,
 void ppp_net_down_notify(GAtPPP *ppp);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
+void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 5cf5656..8639c6c 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -197,6 +197,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 		case ACCM:
 		case PFC:
 		case ACFC:
+		case MRU:
 			break;
 =

 		case MAGIC_NUMBER:
@@ -226,6 +227,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 		case AUTH_PROTO:
 			ppp_set_auth(ppp, ppp_option_iter_get_data(&iter));
 			break;
+		case MRU:
+			ppp_set_mtu(ppp, ppp_option_iter_get_data(&iter));
+			break;
 		case MAGIC_NUMBER:
 		case PFC:
 		case ACFC:
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 325e859..c1f2eb4 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -38,7 +38,6 @@
 #include "gatppp.h"
 #include "ppp.h"
 =

-/* XXX should be maximum IP Packet size */
 #define MAX_PACKET 1500
 =

 struct ppp_net {
@@ -46,8 +45,17 @@ struct ppp_net {
 	char *if_name;
 	GIOChannel *channel;
 	gint watch;
+	gint mtu;
 };
 =

+void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
+{
+	if (net =3D=3D NULL)
+		return;
+
+	net->mtu =3D mtu;
+}
+
 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet)
 {
 	GError *error =3D NULL;
@@ -80,7 +88,7 @@ static gboolean ppp_net_callback(GIOChannel *channel, GIO=
Condition cond,
 =

 	if (cond & G_IO_IN) {
 		/* leave space to add PPP protocol field */
-		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
+		status =3D g_io_channel_read_chars(channel, buf + 2, net->mtu,
 				&bytes_read, &error);
 		if (bytes_read > 0) {
 			ppp->proto =3D htons(PPP_IP_PROTO);
@@ -140,6 +148,7 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp)
 			ppp_net_callback, net);
 	net->ppp =3D ppp;
 =

+	net->mtu =3D MAX_PACKET;
 	return net;
 =

 error:
diff --git a/include/modem.h b/include/modem.h
index d502640..34cac7b 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -50,6 +50,9 @@ void ofono_modem_remove(struct ofono_modem *modem);
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
 =

+void ofono_modem_set_online(struct ofono_modem *modem, ofono_bool_t online=
);
+ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
+
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
 =

 int ofono_modem_set_string(struct ofono_modem *modem,
@@ -85,6 +88,9 @@ struct ofono_modem_driver {
 =

 	/* Populate the atoms that are available with SIM / Unlocked SIM*/
 	void (*post_sim)(struct ofono_modem *modem);
+
+	/* Enable or disable cellular radio */
+	int (*online)(struct ofono_modem *modem, ofono_bool_t online);
 };
 =

 int ofono_modem_driver_register(const struct ofono_modem_driver *);
diff --git a/src/modem.c b/src/modem.c
index 8319702..05b1fed 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -61,6 +61,11 @@ struct ofono_modem {
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
 	guint			timeout;
+	DBusMessage		*pending_online;
+	ofono_bool_t            online;
+	ofono_bool_t            requested_online;
+	ofono_bool_t            online_timeout;
+	struct ofono_watchlist	*online_watches;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
@@ -361,6 +366,9 @@ static DBusMessage *modem_get_properties(DBusConnection=
 *conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

+	ofono_dbus_dict_append(&dict, "Online", DBUS_TYPE_BOOLEAN,
+				&modem->online);
+
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN,
 				&modem->powered);
 =

@@ -478,6 +486,158 @@ static gboolean set_powered_timeout(gpointer user)
 	return FALSE;
 }
 =

+static int set_online(struct ofono_modem *modem, ofono_bool_t online)
+{
+	const struct ofono_modem_driver *driver =3D modem->driver;
+	int err =3D -EINVAL;
+
+	if (modem->requested_online =3D=3D online)
+		return -EALREADY;
+
+	modem->requested_online =3D online;
+
+	if (driver && driver->online)
+		err =3D driver->online(modem, online);
+	else if (powering_down && !online)
+		err =3D 0;
+
+	if (err =3D=3D 0)
+		ofono_modem_set_online(modem, online);
+	else if (err !=3D -EINPROGRESS)
+		modem->requested_online =3D modem->online;
+
+	return err;
+}
+
+static gboolean set_online_timeout(gpointer user)
+{
+	struct ofono_modem *modem =3D user;
+
+	DBG("modem: %p", modem);
+
+	modem->online_timeout =3D 0;
+	modem->requested_online =3D modem->online;
+
+	if (modem->pending)
+		__ofono_dbus_pending_reply(&modem->pending,
+				__ofono_error_timed_out(modem->pending));
+
+	return FALSE;
+}
+
+static DBusMessage *set_property_online(struct ofono_modem *modem,
+					DBusMessage *msg,
+					DBusMessageIter *var)
+{
+	ofono_bool_t online;
+	int err;
+
+	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(var, &online);
+
+	if (modem->pending_online !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	if (modem->online =3D=3D online)
+		return dbus_message_new_method_return(msg);
+
+	modem->pending_online =3D dbus_message_ref(msg);
+
+	err =3D set_online(modem, online);
+	if (err < 0) {
+		if (err !=3D -EINPROGRESS && err !=3D -EALREADY)
+			return __ofono_error_failed(msg);
+
+		modem->online_timeout =3D g_timeout_add_seconds(20,
+						set_online_timeout, modem);
+	}
+
+	return NULL;
+}
+
+void ofono_modem_set_online(struct ofono_modem *modem, ofono_bool_t online)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GSList *l;
+	struct ofono_watchlist_item *watch;
+	ofono_online_watch_func notify;
+
+	if (modem->online_timeout) {
+		g_source_remove(modem->online_timeout);
+		modem->online_timeout =3D 0;
+	}
+
+	if (modem->pending_online) {
+		DBusMessage *reply;
+
+		if (online =3D=3D modem->requested_online)
+			reply =3D dbus_message_new_method_return(modem->pending_online);
+		else
+			reply =3D __ofono_error_failed(modem->pending_online);
+
+		__ofono_dbus_pending_reply(&modem->pending_online, reply);
+	}
+
+	modem->requested_online =3D online;
+
+	if (modem->online =3D=3D online)
+		return;
+
+	modem->online =3D online;
+
+	if (!modem->driver) {
+		ofono_error("Calling ofono_modem_set_online on a"
+				"modem with no driver is not valid, "
+				"please fix the modem driver.");
+		return;
+	}
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE, "Online",
+					DBUS_TYPE_BOOLEAN, &online);
+
+	for (l =3D modem->online_watches->items; l; l =3D l->next) {
+		watch =3D l->data;
+		notify =3D watch->notify;
+		notify(modem, online, watch->notify_data);
+	}
+}
+
+unsigned int __ofono_modem_add_online_watch(struct ofono_modem *modem,
+					ofono_online_watch_func notify,
+					void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *watch;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	watch =3D g_new0(struct ofono_watchlist_item, 1);
+
+	watch->notify =3D notify;
+	watch->destroy =3D destroy;
+	watch->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(modem->online_watches, watch);
+}
+
+gboolean __ofono_modem_remove_online_watch(struct ofono_modem *modem,
+						unsigned int id)
+{
+	return __ofono_watchlist_remove_item(modem->online_watches, id);
+}
+
+
+ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	return modem->online;
+}
+
 static DBusMessage *modem_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -502,6 +662,9 @@ static DBusMessage *modem_set_property(DBusConnection *=
conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

+	if (g_str_equal(name, "Online"))
+		return set_property_online(modem, msg, &var);
+
 	if (g_str_equal(name, "Powered") =3D=3D TRUE) {
 		ofono_bool_t powered;
 		int err;
@@ -1210,6 +1373,7 @@ int ofono_modem_register(struct ofono_modem *modem)
 	modem->driver_type =3D NULL;
 =

 	modem->atom_watches =3D __ofono_watchlist_new(g_free);
+	modem->online_watches =3D __ofono_watchlist_new(g_free);
 =

 	emit_modems();
 =

@@ -1217,6 +1381,9 @@ int ofono_modem_register(struct ofono_modem *modem)
 					OFONO_ATOM_TYPE_SIM,
 					sim_watch, modem, NULL);
 =

+	if (modem->driver->online =3D=3D NULL)
+		ofono_modem_set_online(modem, TRUE);
+
 	return 0;
 }
 =

@@ -1224,12 +1391,18 @@ static void modem_unregister(struct ofono_modem *mo=
dem)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

+	if (modem->online =3D=3D TRUE)
+		set_online(modem, FALSE);
+
 	if (modem->powered =3D=3D TRUE)
 		set_powered(modem, FALSE);
 =

 	__ofono_watchlist_free(modem->atom_watches);
 	modem->atom_watches =3D NULL;
 =

+	__ofono_watchlist_free(modem->online_watches);
+	modem->online_watches =3D NULL;
+
 	modem->sim_watch =3D 0;
 	modem->sim_ready_watch =3D 0;
 =

@@ -1247,6 +1420,16 @@ static void modem_unregister(struct ofono_modem *mod=
em)
 		modem->pending =3D NULL;
 	}
 =

+	if (modem->online_timeout) {
+		g_source_remove(modem->online_timeout);
+		modem->online_timeout =3D 0;
+	}
+
+	if (modem->pending_online) {
+		dbus_message_unref(modem->pending_online);
+		modem->pending_online =3D NULL;
+	}
+
 	if (modem->interface_update) {
 		g_source_remove(modem->interface_update);
 		modem->interface_update =3D 0;
diff --git a/src/ofono.h b/src/ofono.h
index 7b13cce..b122f5e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -159,6 +159,17 @@ gboolean __ofono_modem_remove_atom_watch(struct ofono_=
modem *modem,
 =

 void __ofono_atom_free(struct ofono_atom *atom);
 =

+typedef void (*ofono_online_watch_func)(struct ofono_modem *modem,
+					ofono_bool_t online,
+					void *data);
+
+unsigned int __ofono_modem_add_online_watch(struct ofono_modem *modem,
+					ofono_online_watch_func notify,
+					void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_modem_remove_online_watch(struct ofono_modem *modem,
+						unsigned int id);
+
 #include <ofono/call-barring.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-meter.h>
-- =

1.6.3.3


--===============0195278582561314277==--


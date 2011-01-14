Content-Type: multipart/mixed; boundary="===============0745947793033273410=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [offline-atoms PATCH 2/2] Make sms atom offline-safe
Date: Fri, 14 Jan 2011 16:40:53 +0200
Message-ID: <1295016053-31994-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1295016053-31994-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0745947793033273410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow use of SMS atom both in online and offline (post_sim) states.

SMS atom now watches network registration atom and state.  Thmessages
are queued but not sent if not registered to a network.  Errors
occurring when a short message is being sent while transition from
online to offline or when network coverage is dropped are now handled
gracefully.
---
 src/sms.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 9bb5c93..4d1a929 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -80,6 +80,10 @@ struct ofono_sms {
 	guint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
+	ofono_bool_t registered;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int status_watch;
 	struct ofono_sim *sim;
 	GKeyFile *settings;
 	char *imsi;
@@ -747,6 +751,11 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	DBG("tx_finished");
 =

 	if (ok =3D=3D FALSE) {
+		/* Retry again when back in online mode */
+		/* Note this does not increment retry count */
+		if (sms->registered =3D=3D FALSE)
+			return;
+
 		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY))
 			goto next_q;
 =

@@ -810,6 +819,9 @@ next_q:
 =

 	tx_queue_entry_destroy(entry);
 =

+	if (sms->registered =3D=3D FALSE)
+		return;
+
 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
@@ -833,6 +845,9 @@ static gboolean tx_next(gpointer user_data)
 	if (entry =3D=3D NULL)
 		return FALSE;
 =

+	if (sms->registered =3D=3D FALSE)
+		return FALSE;
+
 	if (g_queue_get_length(sms->txq) > 1
 			|| (entry->num_pdus - entry->cur_pdu) > 1)
 		send_mms =3D 1;
@@ -843,6 +858,55 @@ static gboolean tx_next(gpointer user_data)
 	return FALSE;
 }
 =

+static void netreg_status_watch(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_sms *sms =3D data;
+
+	switch (status) {
+	case NETWORK_REGISTRATION_STATUS_REGISTERED:
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+		sms->registered =3D TRUE;
+		break;
+	default:
+		sms->registered =3D FALSE;
+		break;
+	}
+
+	if (sms->registered =3D=3D FALSE)
+		return;
+
+	if (sms->tx_source > 0)
+		return;
+
+	if (g_queue_get_length(sms->txq))
+		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
+}
+
+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_sms *sms =3D data;
+	int status;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sms->registered =3D FALSE;
+		sms->status_watch =3D 0;
+		sms->netreg =3D NULL;
+		return;
+	}
+
+	sms->netreg =3D __ofono_atom_get_data(atom);
+	sms->status_watch =3D __ofono_netreg_add_status_watch(sms->netreg,
+					netreg_status_watch, sms, NULL);
+
+	status =3D ofono_netreg_get_status(sms->netreg);
+	netreg_status_watch(status, 0, 0, 0, NULL, NULL, sms);
+}
+
+
 /**
  * Generate a UUID from an SMS PDU List
  *
@@ -1630,6 +1694,19 @@ static void sms_unregister(struct ofono_atom *atom)
 		sms->mw =3D NULL;
 	}
 =

+	if (sms->status_watch) {
+		__ofono_netreg_remove_status_watch(sms->netreg,
+							sms->status_watch);
+		sms->status_watch =3D 0;
+	}
+
+	if (sms->netreg_watch) {
+		__ofono_modem_remove_atom_watch(modem, sms->netreg_watch);
+		sms->netreg_watch =3D 0;
+	}
+
+	sms->netreg =3D NULL;
+
 	if (sms->messages) {
 		GHashTableIter iter;
 		struct message *m;
@@ -1813,7 +1890,7 @@ void ofono_sms_register(struct ofono_sms *sms)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	const char *path =3D __ofono_atom_get_path(sms->atom);
-	struct ofono_atom *mw_atom;
+	struct ofono_atom *atom;
 	struct ofono_atom *sim_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
@@ -1832,11 +1909,19 @@ void ofono_sms_register(struct ofono_sms *sms)
 					OFONO_ATOM_TYPE_MESSAGE_WAITING,
 					mw_watch, sms, NULL);
 =

-	mw_atom =3D __ofono_modem_find_atom(modem,
-					OFONO_ATOM_TYPE_MESSAGE_WAITING);
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_MESSAGE_WAITING);
+
+	if (atom && __ofono_atom_get_registered(atom))
+		mw_watch(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, sms);
+
+	sms->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, sms, NULL);
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
 =

-	if (mw_atom && __ofono_atom_get_registered(mw_atom))
-		mw_watch(mw_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, sms);
+	if (atom && __ofono_atom_get_registered(atom))
+		netreg_watch(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, sms);
 =

 	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
 =

@@ -1924,7 +2009,7 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 =

 	g_queue_push_tail(sms->txq, entry);
 =

-	if (g_queue_get_length(sms->txq) =3D=3D 1)
+	if (sms->registered && g_queue_get_length(sms->txq) =3D=3D 1)
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 =

 	if (uuid)
-- =

1.7.1


--===============0745947793033273410==--


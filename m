Content-Type: multipart/mixed; boundary="===============6974007127776926799=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/14] Add __ofono_sms_submit for other atoms to submit SMs.
Date: Wed, 07 Jul 2010 00:39:02 +0200
Message-ID: <1278455949-2823-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6974007127776926799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    7 ++++++-
 src/sms.c   |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index e2271e6..94e2715 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -168,12 +168,17 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/cbs.h>
 #include <ofono/devinfo.h>
 #include <ofono/phonebook.h>
-#include <ofono/sms.h>
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 =

+#include <ofono/sms.h>
+
+struct sms;
+void __ofono_sms_submit(struct ofono_sms *sms, const struct sms *msg,
+			ofono_sms_submit_cb_t cb, void *data);
+
 #include <ofono/sim.h>
 #include <ofono/stk.h>
 =

diff --git a/src/sms.c b/src/sms.c
index c848007..54c46a5 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -87,6 +87,8 @@ struct tx_queue_entry {
 	DBusMessage *msg;
 	gboolean status_report;
 	struct sms_address receiver;
+	ofono_sms_submit_cb_t cb;
+	void *data;
 };
 =

 static const char *sms_bearer_to_string(int bearer)
@@ -413,6 +415,9 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	DBG("tx_finished");
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		if (entry->cb)
+			goto callback;
+
 		entry->retry +=3D 1;
 =

 		if (entry->retry !=3D TXQ_MAX_RETRIES) {
@@ -459,6 +464,9 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 		return;
 	}
 =

+	if (entry->cb)
+		goto callback;
+
 	entry =3D g_queue_pop_head(sms->txq);
 	__ofono_dbus_pending_reply(&entry->msg,
 				dbus_message_new_method_return(entry->msg));
@@ -473,6 +481,19 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 		DBG("Scheduling next");
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 	}
+
+	return;
+
+callback:
+	entry =3D g_queue_pop_head(sms->txq);
+
+	entry->cb(error, mr, entry->data);
+
+	g_free(entry->pdus);
+	g_free(entry);
+
+	if (g_queue_peek_head(sms->txq))
+		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 }
 =

 static gboolean tx_next(gpointer user_data)
@@ -1285,3 +1306,21 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
 {
 	return sms->driver_data;
 }
+
+void __ofono_sms_submit(struct ofono_sms *sms, const struct sms *msg,
+			ofono_sms_submit_cb_t cb, void *data)
+{
+	GSList msg_list =3D {
+		.data =3D (void *) msg,
+		.next =3D NULL,
+	};
+	struct tx_queue_entry *entry =3D create_tx_queue_entry(&msg_list);
+
+	entry->cb =3D cb;
+	entry->data =3D data;
+
+	g_queue_push_tail(sms->txq, entry);
+
+	if (g_queue_get_length(sms->txq) =3D=3D 1)
+		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
+}
-- =

1.7.1.86.g0e460.dirty


--===============6974007127776926799==--


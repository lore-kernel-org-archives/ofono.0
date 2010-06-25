Content-Type: multipart/mixed; boundary="===============7640507510487516838=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Fri, 25 Jun 2010 16:15:33 -0700
Message-ID: <fe704ca9ffff079649a522ab344d0318a9e4b879.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7640507510487516838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Add a name field that will be used to contain a permanent name for
each SMS message in-transit, to be used for persistent storage and for
D-Bus object naming.

The persist name will be used to denote if persistence has to be
implemented in this in-transit SMS or not.

Introduce also a destructor function to encapsulate all the release
steps for this data type, as more are to be added later.
---
 src/sms.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 66a0be3..d4d08fa 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -76,6 +76,7 @@ struct pending_pdu {
 	int pdu_len;
 };
 =

+
 struct tx_queue_entry {
 	struct pending_pdu *pdus;
 	unsigned char num_pdus;
@@ -291,6 +292,25 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+
+/*
+ * Destroy/release the contents of a 'struct tx_queue_entry'
+ *
+ * This *only* releases resources allocated *inside* @entry. The
+ * caller still has to explicitly free @entry (if needed) itself.
+ */
+static void tx_queue_entry_destroy(struct tx_queue_entry *entry)
+{
+	g_free(entry->pdus);
+}
+
+static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
+{
+	struct tx_queue_entry *entry =3D _entry;
+	tx_queue_entry_destroy(entry);
+	g_free(entry);
+}
+
 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
 {
 	struct ofono_sms *sms =3D data;
@@ -320,7 +340,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED);
 =

-		g_free(entry->pdus);
+		tx_queue_entry_destroy(entry);
 		g_free(entry);
 =

 		if (g_queue_peek_head(sms->txq)) {
@@ -353,7 +373,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMITTED);
 =

-	g_free(entry->pdus);
+	tx_queue_entry_destroy(entry);
 	g_free(entry);
 =

 	if (g_queue_peek_head(sms->txq)) {
@@ -987,7 +1007,7 @@ static void sms_remove(struct ofono_atom *atom)
 	}
 =

 	if (sms->txq) {
-		g_queue_foreach(sms->txq, (GFunc)g_free, NULL);
+		g_queue_foreach(sms->txq, tx_queue_entry_destroy_free, NULL);
 		g_queue_free(sms->txq);
 		sms->txq =3D NULL;
 	}
-- =

1.6.6.1


--===============7640507510487516838==--


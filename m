Content-Type: multipart/mixed; boundary="===============6700343722043396579=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 12/20] struct tx_queue_entry: add a destructor
Date: Fri, 23 Jul 2010 14:00:00 -0700
Message-ID: <796fef7f2a9f6c407513467dc76247ad7886fced.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6700343722043396579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Introduce a destructor function to encapsulate all the release steps
for this data type, as more are to be added later.
---
 src/sms.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 85353ff..5f5df04 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -405,6 +405,23 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+
+/*
+ * Destroy/release the contents of a 'struct tx_queue_entry'
+ *
+ * This releases resources allocated *inside* @entry and @entry
+ * itself.
+ */
+static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
+{
+	struct tx_queue_entry *entry =3D _entry;
+
+	if (entry->destroy)
+		entry->destroy(entry->data);
+	g_free(entry->pdus);
+	g_free(entry);
+}
+
 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
 {
 	struct ofono_sms *sms =3D data;
@@ -465,11 +482,7 @@ next_q:
 						time(NULL), hs);
 	}
 =

-	if (entry->destroy)
-		entry->destroy(entry->data);
-
-	g_free(entry->pdus);
-	g_free(entry);
+	tx_queue_entry_destroy_free(entry, NULL);
 =

 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
@@ -1129,7 +1142,7 @@ static void sms_remove(struct ofono_atom *atom)
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


--===============6700343722043396579==--


Content-Type: multipart/mixed; boundary="===============3639123747799675900=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 06/19] struct tx_queue_entry: add a destructor
Date: Tue, 03 Aug 2010 16:50:55 -0700
Message-ID: <e7476f495c1d715a21a4deac6aedb5126ca702d4.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3639123747799675900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Introduce a destructor function to encapsulate all the release steps
for this data type, as more are to be added later.
---
 src/sms.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 8d9a55e..fa489d1 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -405,6 +405,26 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+/*
+ * Destroy/release the contents of a 'struct tx_queue_entry'
+ *
+ * This releases resources allocated *inside* @entry and @entry
+ * itself.
+ */
+static void tx_queue_entry_destroy(struct tx_queue_entry *entry)
+{
+	if (entry->destroy)
+		entry->destroy(entry->data);
+
+	g_free(entry->pdus);
+	g_free(entry);
+}
+
+static void tx_queue_entry_destroy_foreach(gpointer _entry, gpointer unuse=
d)
+{
+	tx_queue_entry_destroy(_entry);
+}
+
 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
 {
 	struct ofono_sms *sms =3D data;
@@ -465,11 +485,7 @@ next_q:
 						time(NULL), hs);
 	}
 =

-	if (entry->destroy)
-		entry->destroy(entry->data);
-
-	g_free(entry->pdus);
-	g_free(entry);
+	tx_queue_entry_destroy(entry);
 =

 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
@@ -1101,7 +1117,7 @@ static void sms_remove(struct ofono_atom *atom)
 	}
 =

 	if (sms->txq) {
-		g_queue_foreach(sms->txq, (GFunc)g_free, NULL);
+		g_queue_foreach(sms->txq, tx_queue_entry_destroy_foreach, NULL);
 		g_queue_free(sms->txq);
 		sms->txq =3D NULL;
 	}
-- =

1.6.6.1


--===============3639123747799675900==--


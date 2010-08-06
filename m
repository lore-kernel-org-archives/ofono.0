Content-Type: multipart/mixed; boundary="===============8734506736644716308=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 01/17] sms: replace sequential SMS message ID with hash
Date: Thu, 05 Aug 2010 17:55:23 -0700
Message-ID: <5b8532b215e94ae8e26a6655024ef3068e0468c2.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8734506736644716308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

The SMS messages's ID number (used for history, D-Bus naming and
storage in external database) is updated to use a hash (based on PDUs
and submission time) to further avoid ID collision concerns.
---
 src/sms.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 01596ef..f5c3162 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -29,6 +29,7 @@
 =

 #include <glib.h>
 #include <gdbus.h>
+#include <sys/time.h>
 =

 #include "ofono.h"
 =

@@ -539,6 +540,52 @@ static void set_ref_and_to(GSList *msg_list, guint16 r=
ef, int offset,
 	}
 }
 =

+/**
+ * Generate a UUID from an SMS PDU List
+ *
+ * @param pdu Pointer to array of PDUs data to generate the ID from
+ * @param pdus Number of entries in the \e pdu array
+ * @return 0 in error (no memory or serious code inconsistency in the
+ *     input data structures), otherwise the SMS UUID.
+ *
+ * @internal
+ *
+ * Note we use memcpy() instead of dropping the uuid param straight to
+ * g_checksum_get_digest(). This is because g_checksum_get_digest()
+ * seems to randomly not copy the digest data if the buffer is smaller
+ * than what the digest should have.
+ *
+ * The current time is added to avoid the UUID being the same when the
+ * same message is sent to the same destination repeatedly. Note we
+ * need a high resolution time (not just seconds), otherwise resending
+ * in the same second (not that rare) could yield the same UUID.
+ */
+static unsigned int sms_uuid_from_pdus(const struct pending_pdu *pdu,
+					size_t pdus)
+{
+	unsigned int uuid =3D 0;
+	GChecksum *checksum;
+	gsize uuid_size =3D g_checksum_type_get_length(G_CHECKSUM_SHA256);
+	guint8 data[uuid_size];
+	unsigned cnt;
+	struct timeval now;
+
+	checksum =3D g_checksum_new(G_CHECKSUM_SHA256);
+	if (checksum =3D=3D NULL)
+		goto error_new;
+
+	for (cnt =3D 0; cnt < pdus; cnt++)
+		g_checksum_update(checksum, pdu[cnt].pdu, pdu[cnt].pdu_len);
+
+	gettimeofday(&now, NULL);
+	g_checksum_update(checksum, (void *) &now, sizeof(now));
+	g_checksum_get_digest(checksum, data, &uuid_size);
+	memcpy(&uuid, data, MIN(sizeof(uuid), sizeof(data)));
+	g_checksum_free(checksum);
+error_new:
+	return uuid;
+}
+
 static struct tx_queue_entry *tx_queue_entry_new(GSList *msg_list)
 {
 	struct tx_queue_entry *entry =3D g_new0(struct tx_queue_entry, 1);
@@ -558,6 +605,8 @@ static struct tx_queue_entry *tx_queue_entry_new(GSList=
 *msg_list)
 				pdu->pdu_len, pdu->tpdu_len);
 	}
 =

+	entry->msg_id =3D sms_uuid_from_pdus(entry->pdus, entry->num_pdus);
+
 	return entry;
 }
 =

@@ -1336,7 +1385,6 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sms =
*sms, GSList *list,
 				sizeof(entry->receiver));
 	}
 =

-	entry->msg_id =3D sms->next_msg_id++;
 	entry->flags =3D flags;
 	entry->cb =3D cb;
 	entry->data =3D data;
-- =

1.6.6.1


--===============8734506736644716308==--


Content-Type: multipart/mixed; boundary="===============4574994590922746139=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 11/20] SMS: rename create_tx_queue_entry() to
 tx_queue_entry_new()
Date: Fri, 23 Jul 2010 13:59:59 -0700
Message-ID: <3b9588df5ecf0a6b8f0fe30fbf0411393131facd.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4574994590922746139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This is for symmetry with tx_queue_entry_free()
---
 src/sms.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index b53f880..85353ff 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -522,7 +522,7 @@ static void set_ref_and_to(GSList *msg_list, guint16 re=
f, int offset,
 	}
 }
 =

-static struct tx_queue_entry *create_tx_queue_entry(GSList *msg_list)
+static struct tx_queue_entry *tx_queue_entry_new(GSList *msg_list)
 {
 	struct tx_queue_entry *entry =3D g_new0(struct tx_queue_entry, 1);
 	int i =3D 0;
@@ -574,7 +574,7 @@ static void send_message_destroy(void *data)
  *
  * An alphabet is chosen for the text and it (might be) segmented in
  * fragments by sms_text_prepare() into @msg_list. A queue list @entry
- * is created by create_tx_queue_entry() and g_queue_push_tail()
+ * is created by tx_queue_entry_new() and g_queue_push_tail()
  * appends that entry to the SMS transmit queue. Then the tx_next()
  * function is scheduled to run to process the queue.
  */
@@ -1338,7 +1338,7 @@ struct tx_queue_entry * __ofono_sms_txq_submit(struct=
 ofono_sms *sms, GSList *li
 					ofono_sms_txq_submit_cb_t cb,
 					void *data, ofono_destroy_func destroy)
 {
-	struct tx_queue_entry *entry =3D create_tx_queue_entry(list);
+	struct tx_queue_entry *entry =3D tx_queue_entry_new(list);
 =

 	if (flags & OFONO_SMS_SUBMIT_FLAG_REQUEST_SR) {
 		struct sms *head =3D list->data;
-- =

1.6.6.1


--===============4574994590922746139==--


Content-Type: multipart/mixed; boundary="===============8430684860671248696=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 15/17] sms: document variable usage in sms_msg_send()
Date: Thu, 05 Aug 2010 17:55:37 -0700
Message-ID: <bcf747d99941a9272363acfed1b8f3cd23c5e2b8.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8430684860671248696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/sms.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index e648fd0..2b21e0c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -851,6 +851,9 @@ enum sms_msg_send_flags {
  * is created by tx_queue_entry_new() and g_queue_push_tail()
  * appends that entry to the SMS transmit queue. Then the tx_next()
  * function is scheduled to run to process the queue.
+ *
+ * @sms is the main SMS driver struct, @entry and @msg_list represent
+ * the current message being processed.
  */
 static
 struct tx_queue_entry *sms_msg_send(
-- =

1.6.6.1


--===============8430684860671248696==--


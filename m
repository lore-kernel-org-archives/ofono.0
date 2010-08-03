Content-Type: multipart/mixed; boundary="===============2312678896470887508=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 17/19] sms: document variable usage in sms_msg_send()
Date: Tue, 03 Aug 2010 16:51:06 -0700
Message-ID: <b6e7e92ed6a6a3504ad3a8f1400379f09fd83d90.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2312678896470887508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/sms.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 0aa058b..0c5b4c5 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -795,6 +795,9 @@ static void sms_msg_dbus_destroy(void *_dbus_path)
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


--===============2312678896470887508==--


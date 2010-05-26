Content-Type: multipart/mixed; boundary="===============2750509852300002614=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 02/13] sms_send_message: add a short roadmap
Date: Wed, 26 May 2010 12:49:16 -0700
Message-ID: <992d70300e42d2d7d98ff0e4e9fd2c8d3c415932.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2750509852300002614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/sms.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 3a1cff0..594481e 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -398,6 +398,19 @@ static struct tx_queue_entry *create_tx_queue_entry(GS=
List *msg_list)
 	return entry;
 }
 =

+/*
+ * Pre-process a SMS text message and deliver it [D-BUS' SendMessage()]
+ *
+ * @conn: D-BUS connection
+ * @msg: message data (telephone number and text)
+ * @data: SMS object to use for transmision
+ *
+ * An alphabet is chosen for the text and it (might be) segmented in
+ * fragments by sms_text_prepare() into @msg_list. A queue list @entry
+ * is created by create_tx_queue_entry() and g_queue_push_tail()
+ * appends that entry to the SMS transmit queue. Then the tx_next()
+ * function is scheduled to run to process the queue.
+ */
 static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *ms=
g,
 					void *data)
 {
-- =

1.6.6.1


--===============2750509852300002614==--


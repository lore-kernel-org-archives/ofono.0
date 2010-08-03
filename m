Content-Type: multipart/mixed; boundary="===============3815173416210115086=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 12/19] sms: introduce sms_msg_cancel and its D-Bus wrapper
Date: Tue, 03 Aug 2010 16:51:01 -0700
Message-ID: <be81902d38e5c521f5c5db928da2c479f0ec320f.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3815173416210115086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This introduces the ability to cancel a pending SMS message,
accessible via an internal API and over a D-Bus wrapper.

Sending a note to the network to cancel an in-transit message is not
yet implemented.

Note the test case code requires follow up commits that propagate the
message's state changes over D-Bus.
---
 src/sms.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index fbaa271..a595f7d 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -525,6 +525,20 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 }
 =

 =

+
+static void sms_msg_cancel(struct tx_queue_entry *);
+/*
+ * Note that the D-Bus specific cleanups are taken care by the
+ * sms_msg_dbus_destroy() callback passed in dbus_sms_msg_send().
+ */
+static DBusMessage *dbus_sms_msg_cancel(
+	DBusConnection * conn, DBusMessage *msg, void *data)
+{
+	struct tx_queue_entry *sms_msg =3D data;
+	sms_msg_cancel(sms_msg);
+	return dbus_message_new_method_return(msg);
+}
+
 /*
  * D-Bus SMS Message interface
  *
@@ -534,6 +548,8 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
 =

 static
 GDBusMethodTable sms_msg_methods[] =3D {
+	{ "Cancel",		"",	"",
+	  dbus_sms_msg_cancel, 0 },
 	{ }
 };
 =

@@ -579,6 +595,11 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	gboolean ok =3D error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR;
 =

 	DBG("tx_finished");
+	/*
+	 * Queue is empty? Messages might have been cancelled.
+	 */
+	if (entry =3D=3D NULL)
+		return;
 =

 	if (ok =3D=3D FALSE) {
 		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY)) {
@@ -789,6 +810,40 @@ struct tx_queue_entry *sms_msg_send(
 	return sms_msg;
 }
 =

+/**
+ * Cancel a pending SMS message
+ *
+ * @sms_msg: message to cancel
+ *
+ * This function cancels a message that is pending or being
+ * actively transmitted. Note that after this function returns, the
+ * @sms_msg handle is no longer valid.
+ *
+ * \internal
+ *
+ * There is no need to cancel the calling of tx_next() by
+ * g_timeout_add() scheduled in sms_msg_send(). The rationale behind
+ * this is that the tx_next() function is scheduled to go over the
+ * list of messages in the @sms object, so it might have been
+ * scheduled for other messages also rather than just for this one
+ * @sms_msg. By the time it gets to run, it might see the list empty
+ * or see other messages, but @sms_msg won't be there.
+ */
+static void sms_msg_cancel(struct tx_queue_entry *sms_msg)
+{
+	struct ofono_sms *sms =3D sms_msg->sms_mgr;
+	DBG("%s (%p)\n", __func__, sms_msg);
+
+	if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_QUEUED)
+		g_queue_remove(sms->txq, sms_msg);
+	else if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_WSR)
+		g_queue_remove(sms->tx_wsrq, sms_msg);
+
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELING);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELLED);
+	tx_queue_entry_destroy(sms_msg);
+}
+
 /*
  * Send a PropertyChange signal when the state changes
  *
-- =

1.6.6.1


--===============3815173416210115086==--


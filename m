Content-Type: multipart/mixed; boundary="===============1785451071219985362=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 17/23] SMS: introduce sms_msg_cancel and its D-Bus wrapper
Date: Fri, 25 Jun 2010 16:15:39 -0700
Message-ID: <d764e25cd41d993feb909f486308ea1e2be88ce4.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1785451071219985362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This introduces the ability to cancel a pending SMS message,
accessible via an internal API and over a D-Bus wrapper.

Sending a note to the network to cancel an in-transit message is not
yet implemented.
---
 src/sms.c     |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   15 +++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 97c7429..faaacbe 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -426,6 +426,24 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 }
 =

 =

+static DBusMessage *dbus_sms_msg_cancel(
+	DBusConnection * conn, DBusMessage *msg, void *data)
+{
+	gboolean do_network_cancel =3D FALSE;
+	struct tx_queue_entry *sms_msg =3D data;
+	if (!dbus_message_get_args(msg, NULL,
+				   DBUS_TYPE_BOOLEAN, &do_network_cancel))
+		return __ofono_error_invalid_args(msg);
+	sms_msg_cancel(sms_msg,
+		       do_network_cancel ? SMS_MSG_CANCEL_IN_NETWORK : 0);
+	sms_msg->msg =3D dbus_message_ref(msg);
+	__ofono_dbus_pending_reply(
+		&sms_msg->msg,
+		dbus_message_new_method_return(sms_msg->msg));
+	return NULL;
+}
+
+
 /*
  * D-Bus SMS Message interface
  *
@@ -435,6 +453,8 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
 =

 static
 GDBusMethodTable sms_msg_methods[] =3D {
+	{ "Cancel",		DBUS_TYPE_BOOLEAN_AS_STRING,	"",
+	  dbus_sms_msg_cancel, G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -734,6 +754,43 @@ struct tx_queue_entry *sms_msg_send(
 }
 =

 =

+/**
+ * Cancel a pending SMS message
+ *
+ * @sms_msg: message to cancel
+ * @flags: modifies for the action
+ *
+ * This function cancels a message that is pending or being
+ * actively transmitted.
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
+void sms_msg_cancel(struct tx_queue_entry *sms_msg,
+		    enum sms_msg_cancel_flags flags)
+{
+	struct ofono_sms *sms =3D sms_msg->sms_mgr;
+	DBG("%s (%p)\n", __func__, sms_msg);
+	if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_QUEUED)
+		g_queue_remove(sms->txq, sms_msg);
+	else if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_WFA)
+		g_queue_remove(sms->tx_wfaq, sms_msg);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELING);
+	if (flags & SMS_MSG_CANCEL_IN_NETWORK)
+		ofono_warn("%s(): SMS_MSG_CANCEL_IN_NETWORK support "
+			   "not yet implemented\n", __func__);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELLED);
+	tx_queue_entry_destroy(sms_msg);
+}
+
+
 /*
  * D-Bus: Send a SMS text message
  *
diff --git a/src/smsutil.h b/src/smsutil.h
index 40df71f..ad1e560 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -559,6 +559,21 @@ gboolean cbs_topic_in_range(unsigned int topic, GSList=
 *ranges);
 =

 char *ussd_decode(int dcs, int len, const unsigned char *data);
 =

+/*
+ * SMS Message API
+ */
+
+enum sms_msg_cancel_flags {
+	/**
+	 * The cancelled message will be reported to the network so it
+	 * tries to cancel it if in transit.
+	 */
+	SMS_MSG_CANCEL_IN_NETWORK =3D 0x1,
+};
+
+struct tx_queue_entry;
+void sms_msg_cancel(struct tx_queue_entry *sms_msg, enum sms_msg_cancel_fl=
ags);
+
 enum {
 	/* Note this has to be a multiple of sizeof(guint32);
 	 * Compilation will assert-fail if this is not met. */
-- =

1.6.6.1


--===============1785451071219985362==--


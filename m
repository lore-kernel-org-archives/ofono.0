Content-Type: multipart/mixed; boundary="===============2869298843008941694=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 14/23] SMS: export outgoing messages over D-Bus
 (skeleton)
Date: Mon, 28 Jun 2010 16:28:32 -0700
Message-ID: <1277767712.3006.28.camel@localhost.localdomain>
In-Reply-To: <35d2fe59c28a8e703a5204cbfcc1e981cf5479d0.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2869298843008941694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-06-25 at 16:15 -0700, Inaky Perez-Gonzalez wrote: =

> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> This creates two frunctions, sms_msg_[un]register() which will
> add/remove a D-Bus object for each SMS message when in transit.
> =

> Future changes make sms_msg_register() need information that is not
> available at the time create_tx_queue_entry() is called, thus why
> registration happens later.

Found a few rough corners here when integrating the final parts of
status reports into the SMS state-machine. A re-submit will have this
incremental patch merged:

diff --git a/src/sms.c b/src/sms.c
index 1b35fa9..27a3d64 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -532,8 +532,15 @@ GDBusSignalTable sms_msg_signals[] =3D {
 };
 =


+/**
+ *
+ * @returns 0 if ok, 0 on error
+ *
+ * On success, sms_msg->dbus_path is non-NULL; this is needed as the
+ * cleanup path on error are not easy to break up.
+ */
 static
-void sms_msg_register(struct tx_queue_entry *sms_msg)
+int sms_msg_register(struct tx_queue_entry *sms_msg)
 {
 	g_assert(sms_msg->name !=3D NULL);
 	sms_msg->dbus_path =3D g_strdup(sms_msg->name);
@@ -544,20 +551,26 @@ void sms_msg_register(struct tx_queue_entry *sms_msg)
 		ofono_error("%s: Could not create %s interface",
 			    sms_msg->dbus_path, SMS_MSG_INTERFACE);
 		g_free(sms_msg->dbus_path);
+		sms_msg->dbus_path =3D NULL;
+		return 1;
+	} else {
+		ofono_debug("%s: %d: sms %p @ %s: MSG registered",
+			    __FILE__, __LINE__, sms_msg, sms_msg->dbus_path);
+		return 0;
 	}
-	ofono_debug("%s: %d: sms %p: MSG registered @ %s",
-		    __FILE__, __LINE__, sms_msg, sms_msg->dbus_path);
 }
 =


 static
 void sms_msg_unregister(struct tx_queue_entry *sms_msg)
 {
+	if (sms_msg->dbus_path =3D=3D NULL)
+		return;
+	ofono_debug("%s: %d: sms %p @ %s: MSG unregistered",
+		    __FILE__, __LINE__, sms_msg, sms_msg->dbus_path);
 	g_dbus_unregister_interface(ofono_dbus_get_connection(),
 				    sms_msg->dbus_path, SMS_MSG_INTERFACE);
 	g_free(sms_msg->dbus_path);
-	ofono_debug("%s: %d: sms %p: MSG unregistered",
-		    __FILE__, __LINE__, sms_msg);
 }
 =


@@ -801,7 +814,10 @@ struct tx_queue_entry *sms_msg_send(
 	entry->name =3D g_strdup_printf(SMS_MSG_NAME_FMT, sms_path,
 				      msg_id_str, entry->num_pdus);
 	ofono_debug("sms/entry %p name %s\n", entry, entry->name);
-	sms_msg_register(entry);
+	if (sms_msg_register(entry)) {
+		tx_queue_entry_destroy_free(entry, NULL);
+		return NULL;
+	}
 =

 	g_queue_push_tail(sms->txq, entry);
 	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_QUEUED);


--===============2869298843008941694==--


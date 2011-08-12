Content-Type: multipart/mixed; boundary="===============3926847372481213372=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] Add CDMA voice call answering support
Date: Fri, 12 Aug 2011 17:19:09 +0800
Message-ID: <1313140749-28926-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3926847372481213372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-voicecall.h |    3 +++
 src/cdma-voicecall.c     |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
index 9e741da..6f77462 100644
--- a/include/cdma-voicecall.h
+++ b/include/cdma-voicecall.h
@@ -55,6 +55,9 @@ struct ofono_cdma_voicecall_driver {
 	/* Hangs up active, dialing, alerting or incoming calls */
 	void (*hangup)(struct ofono_cdma_voicecall *vc,
 			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	void (*answer)(struct ofono_cdma_voicecall *vc,
+			ofono_cdma_voicecall_cb_t cb, void *data);
 };
 =

 void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index 183433d..b7323c8 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -286,6 +286,27 @@ static DBusMessage *voicecall_manager_hangup(DBusConne=
ction *conn,
 	return NULL;
 }
 =

+static DBusMessage *voicecall_manager_answer(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_voicecall *vc =3D data;
+
+	if (vc->pending)
+		return __ofono_error_busy(msg);
+
+	if (vc->driver->answer =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (vc->status !=3D CDMA_CALL_STATUS_INCOMING)
+		return __ofono_error_failed(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	vc->driver->answer(vc, generic_callback, vc);
+
+	return NULL;
+}
+
 static GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",
 					voicecall_manager_get_properties },
@@ -293,6 +314,8 @@ static GDBusMethodTable manager_methods[] =3D {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Hangup",           "",    "",         voicecall_manager_hangup,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Answer",           "",    "",         voicecall_manager_answer,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.5


--===============3926847372481213372==--


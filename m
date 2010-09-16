Content-Type: multipart/mixed; boundary="===============4930738816619884233=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isimodem-ussd PATCH 5/5] isimodem/ussd: fix mobile-terminated cases
Date: Thu, 16 Sep 2010 20:32:49 +0300
Message-ID: <1284658369-1988-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284658369-1988-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4930738816619884233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

ACK notifys. Handle mobile-terminated requests gracefully.
---
 drivers/isimodem/ussd.c |  130 +++++++++++++++++++++++++++----------------=
---
 1 files changed, 76 insertions(+), 54 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 2f4091c..94fe4d7 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -1,7 +1,7 @@
 /*
  * This file is part of oFono - Open Source Telephony
  *
- * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
  *
  * Contact: Aki Niemi <aki.niemi@nokia.com>
  *
@@ -50,41 +50,84 @@
 =

 struct ussd_data {
 	GIsiClient *client;
+	int mt_session;
 };
 =

-static inline int isi_type_to_status(uint8_t type)
+static void ussd_notify_ack(struct ussd_data *ud)
 {
+	const unsigned char msg[] =3D {
+		SS_GSM_USSD_SEND_REQ,
+		SS_GSM_USSD_NOTIFY,
+		0x00		/* subblock count */
+	};
+
+	g_isi_send(ud->client, msg, sizeof(msg), SS_TIMEOUT, NULL, NULL, NULL);
+}
+
+static void ussd_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_ussd *ussd =3D opaque;
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	int dcs;
+	int type;
+	size_t ussdlen;
+	int status;
+
+	if (!msg || len < 4 || msg[0] !=3D SS_GSM_USSD_RECEIVE_IND)
+		return;
+
+	dcs =3D msg[1];
+	type =3D msg[2];
+	ussdlen =3D msg[3];
+
+	if (len < 4 + ussdlen)
+		ussdlen =3D len - 4;
+
 	switch (type) {
+	case 0:
+		/* Nothing - this is response to NOTIFY_ACK REQ */
+		return;
+
 	case SS_GSM_USSD_MT_REPLY:
-		return OFONO_USSD_STATUS_LOCAL_CLIENT_RESPONDED;
+		/* This never happens, but.. */
+		status =3D OFONO_USSD_STATUS_LOCAL_CLIENT_RESPONDED;
+		break;
+
 	case SS_GSM_USSD_COMMAND:
-		return OFONO_USSD_STATUS_ACTION_REQUIRED;
+		if (ud->mt_session)
+			/* Ignore, we get SS_GSM_USSD_REQUEST, too */
+			return;
+		status =3D OFONO_USSD_STATUS_ACTION_REQUIRED;
+		break;
+
 	case SS_GSM_USSD_NOTIFY:
-		return OFONO_USSD_STATUS_NOTIFY;
+		status =3D OFONO_USSD_STATUS_NOTIFY;
+		ussd_notify_ack(ud);
+		break;
+
 	case SS_GSM_USSD_END:
-		return OFONO_USSD_STATUS_TERMINATED;
+		status =3D OFONO_USSD_STATUS_TERMINATED;
+		ud->mt_session =3D 0;
+		break;
+
 	case SS_GSM_USSD_REQUEST:
+		ud->mt_session =3D 1;
+		status =3D OFONO_USSD_STATUS_ACTION_REQUIRED;
+		break;
+
 	default:
-		return OFONO_USSD_STATUS_NOT_SUPPORTED;
+		status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
 	}
-}
-
-static void ussd_parse(struct ofono_ussd *ussd, const void *restrict data,
-			size_t len)
-{
-	const unsigned char *msg =3D data;
-	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
 =

-	if (!msg || len < 4)
-		ofono_ussd_notify(ussd, status, 0, NULL, 0);
+	DBG("type: %u %s, dcs: 0x%02x, len: %u",
+		type, ss_ussd_type_name(type), dcs, ussdlen);
 =

-	status =3D isi_type_to_status(msg[2]);
-
-	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
-		ofono_ussd_notify(ussd, status, msg[1], msg + 4, msg[3]);
+	ofono_ussd_notify(ussd, status, dcs, msg + 4, ussdlen);
 }
 =

-
 static gboolean ussd_send_resp_cb(GIsiClient *client,
 					const void *restrict data, size_t len,
 					uint16_t object, void *opaque)
@@ -104,12 +147,11 @@ static gboolean ussd_send_resp_cb(GIsiClient *client,
 	if (msg[0] =3D=3D SS_SERVICE_FAILED_RESP)
 		goto error;
 =

-	if (len < 4 || msg[0] !=3D SS_GSM_USSD_SEND_RESP)
+	if (msg[0] !=3D SS_GSM_USSD_SEND_RESP)
 		return FALSE;
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 =

-	ussd_parse(cbd->user, data, len);
 	return TRUE;
 =

 error:
@@ -118,13 +160,17 @@ error:
 =

 }
 =

-static GIsiRequest *ussd_send(GIsiClient *client,
-				int dcs, uint8_t const *str, size_t len,
-				void *data, GDestroyNotify notify)
+static void isi_request(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_cb_t cb, void *data)
 {
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
 	const uint8_t msg[] =3D {
 		SS_GSM_USSD_SEND_REQ,
-		SS_GSM_USSD_COMMAND,
+		ud->mt_session
+		? SS_GSM_USSD_MT_REPLY
+		: SS_GSM_USSD_COMMAND,
 		0x01,		/* subblock count */
 		SS_GSM_USSD_STRING,
 		4 + len + 3,	/* subblock length */
@@ -132,27 +178,16 @@ static GIsiRequest *ussd_send(GIsiClient *client,
 		len,		/* string length */
 		/* USSD string goes here */
 	};
-
 	const struct iovec iov[2] =3D {
 		{ (uint8_t *)msg, sizeof(msg) },
-		{ (uint8_t *)str, len }
+		{ (uint8_t *)pdu, len }
 	};
 =

-	return g_isi_vsend(client, iov, 2, SS_TIMEOUT,
-				ussd_send_resp_cb, data, notify);
-}
-
-static void isi_request(struct ofono_ussd *ussd, int dcs,
-			const unsigned char *pdu, int len,
-			ofono_ussd_cb_t cb, void *data)
-{
-	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
-	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
-
 	if (!cbd)
 		goto error;
 =

-	if (ussd_send(ud->client, dcs, pdu, len, cbd, g_free))
+	if (g_isi_vsend(ud->client, iov, 2, SS_TIMEOUT,
+			ussd_send_resp_cb, cbd, g_free))
 		return;
 =

 error:
@@ -184,19 +219,6 @@ error:
 	g_free(cbd);
 }
 =

-static void ussd_ind_cb(GIsiClient *client,
-			const void *restrict data, size_t len,
-			uint16_t object, void *opaque)
-{
-	const unsigned char *msg =3D data;
-	struct ofono_ussd *ussd =3D opaque;
-
-	if (!msg || len < 4 || msg[0] !=3D SS_GSM_USSD_RECEIVE_IND)
-		return;
-
-	ussd_parse(ussd, data, len);
-}
-
 static gboolean isi_ussd_register(gpointer user)
 {
 	struct ofono_ussd *ussd =3D user;
-- =

1.7.0.4


--===============4930738816619884233==--


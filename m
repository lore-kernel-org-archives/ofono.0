Content-Type: multipart/mixed; boundary="===============1955821481596061125=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 17/18] isimodem: CBS for wgmodem2.5
Date: Tue, 15 Feb 2011 13:31:11 +0100
Message-ID: <d01065fc1a0d34feedf665921f2fe4270850af4d.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1955821481596061125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

set and clear topics support added
---
 drivers/isimodem/cbs.c   |  425 +++++++++++++++++++++++++++++++++++++++++-=
----
 drivers/isimodem/debug.c |    4 +
 drivers/isimodem/sms.h   |    7 +-
 3 files changed, 394 insertions(+), 42 deletions(-)

diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index b969c1f..93219e2 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -47,12 +48,15 @@
 =

 struct cbs_data {
 	GIsiClient *client;
+	uint8_t subscription_nr;
 };
 =

 struct cbs_info {
 	uint8_t pdu[88];
 };
 =

+GIsiClient *pn_sms_client;
+
 static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d)
 {
 	uint8_t cause;
@@ -89,18 +93,299 @@ static gboolean check_response_status(const GIsiMessag=
e *msg, uint8_t msgid)
 	return FALSE;
 }
 =

+static void reset_buf(char *buf, char *buf_2, int buf_len)
+{
+	memset(buf, '\0', buf_len);
+	memset(buf_2, '\0', buf_len);
+}
+
+static int get_topics_len(const char *topics)
+{
+	int i =3D 0;
+	int k =3D 0;
+	int length =3D 0;
+	char buf[6];
+	char buf_2[6];
+
+	reset_buf(buf, buf_2, 6);
+
+	while (*topics !=3D '\0') {
+		if (*topics =3D=3D ',') {
+			reset_buf(buf, buf_2, 6);
+			k =3D 0;
+			length++;
+		} else if (*topics !=3D ',' && *topics !=3D '-') {
+			buf[k] =3D *topics;
+			k++;
+		} else if (*topics =3D=3D '-') {
+			topics++;
+			i++;
+			k =3D 0;
+
+			while (*topics !=3D ',' && *topics !=3D '\0') {
+				buf_2[k] =3D *topics;
+				topics++;
+				i++;
+				k++;
+			}
+
+			length =3D length + atoi(buf_2) - atoi(buf) + 1;
+			k =3D 0;
+		}
+
+		topics++;
+		i++;
+	}
+
+	topics =3D topics - i;
+	return length;
+}
+
+static void parse_topics(const char *topics, gint16 *topics_parsed)
+{
+	int j =3D 0;
+	int k =3D 0;
+	char buf[6];
+	char buf_2[6];
+
+	reset_buf(buf, buf_2, 6);
+
+	while (*topics !=3D '\0') {
+		if (*topics !=3D ',' && *topics !=3D '-') {
+			buf[j] =3D *topics;
+			j++;
+		} else if (*topics =3D=3D '-') {
+			topics++;
+			j =3D 0;
+
+			while (*topics !=3D ',' && *topics !=3D '\0') {
+				buf_2[j] =3D *topics;
+				topics++;
+				j++;
+			}
+
+			for (j =3D 0; j <=3D (atoi(buf_2) - atoi(buf)); j++) {
+				topics_parsed[k] =3D atoi(buf) + j;
+				topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
+				k++;
+			}
+
+			j =3D 0;
+		} else if (*topics =3D=3D ',') {
+			topics_parsed[k] =3D atoi(buf);
+			topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
+			reset_buf(buf, buf_2, 6);
+			j =3D 0;
+			k++;
+		}
+
+		topics++;
+	}
+}
+
+static void set_topics_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbd->user);
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+	uint8_t result;
+	DBG("");
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		return;
+	}
+
+	if (g_isi_msg_data_len(msg) < 2 || g_isi_msg_id(msg) !=3D
+			SMS_CB_ROUTING_RESP)
+		goto error;
+
+	g_isi_msg_data_get_byte(msg, 1, &result);
+
+	if (result !=3D SMS_OK)
+		goto error;
+
+	g_isi_msg_data_get_byte(msg, 0, &cd->subscription_nr);
+
+	DBG("got subscription nr: %d", cd->subscription_nr);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 static void isi_set_topics(struct ofono_cbs *cbs, const char *topics,
 				ofono_cbs_set_cb_t cb, void *data)
 {
-	DBG("Not implemented (topics=3D%s), all topics accepted", topics);
-	CALLBACK_WITH_SUCCESS(cb, data);
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cbs, cb, data);
+	int topics_len =3D get_topics_len(topics);
+	gint16 topics_out[topics_len];
+	GIsiModem *modem;
+
+	uint8_t msg[] =3D {
+		SMS_CB_ROUTING_REQ,
+		SMS_ROUTING_SET,
+		cd->subscription_nr,
+		0x00,			/*Subscription type*/
+		0x00,			/*Fillers*/
+		0x00,
+		0x01,			/*Number of subblocks*/
+		0x00,
+		0x26,			/*Subblock*/
+		0x00,
+		topics_len * 2 + 6,	/*Subblock length*/
+		0x00,
+		topics_len,		/*Number of topics*/
+	};
+	struct iovec iov[2] =3D {
+		{ msg, sizeof(msg) },
+		{ topics_out, sizeof(topics_out) },
+	};
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	if (cd =3D=3D NULL)
+		goto error;
+
+	modem =3D g_isi_client_modem(cd->client);
+
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) >=3D 0) {
+		parse_topics(topics, topics_out);
+
+		if (g_isi_client_vsend_with_timeout(cd->client, iov, 2,
+				CBS_TIMEOUT, set_topics_resp_cb, cbd, g_free))
+			return;
+
+		CALLBACK_WITH_FAILURE(cb, data);
+	} else {
+		/*
+		 * TODO: This should probably be put first in
+		 *       the function to avoid unecessary initialization
+		 *       and allocation.  Fix when the version handling
+		 *       issue has been solved.
+		 */
+		DBG("Not implemented (topics=3D%s), all topics accepted", topics);
+		CALLBACK_WITH_SUCCESS(cb, data);
+	}
+
+error:
+	g_free(cbd);
+}
+
+static void clear_topics_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbd->user);
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (!check_response_status(msg, SMS_CB_ROUTING_RESP))
+		goto error;
+
+	cd->subscription_nr =3D 0;
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void isi_clear_topics(struct ofono_cbs *cbs,
 				ofono_cbs_set_cb_t cb, void *data)
 {
-	DBG("Not implemented");
-	CALLBACK_WITH_SUCCESS(cb, data);
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cbs, cb, data);
+	GIsiModem *modem;
+
+	uint8_t msg[] =3D {
+		SMS_CB_ROUTING_REQ,
+		SMS_ROUTING_RELEASE,
+		cd->subscription_nr,	/* Subscription number */
+		0x00,			/* Subscription type */
+		0x00,			/* Fillers */
+		0x00,
+		0x00			/*No subblocks*/
+	};
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	if (cd =3D=3D NULL)
+		goto error;
+
+	modem =3D g_isi_client_modem(cd->client);
+
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) >=3D 0) {
+		if (g_isi_client_send_with_timeout(cd->client, msg, sizeof(msg),
+					CBS_TIMEOUT, clear_topics_resp_cb,
+					cbd, g_free))
+			return;
+
+		CALLBACK_WITH_FAILURE(cb, data);
+	} else {
+		/*
+		 * TODO: This should probably be put first in
+		 *       the function to avoid unecessary initialization
+		 *       and allocation.  Fix when the version handling
+		 *       issue has been solved.
+		 */
+		DBG("Not implemented");
+		CALLBACK_WITH_SUCCESS(cb, data);
+	}
+error:
+	g_free(cbd);
+}
+
+static void routing_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_cbs *cbs =3D data;
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct cbs_info info;
+	size_t len =3D sizeof(struct cbs_info);
+	GIsiSubBlockIter iter;
+	size_t subblock_len;
+	uint8_t sbcount;
+	uint8_t *pdu_data;
+
+	DBG("");
+
+	if (cd =3D=3D NULL || !check_response_status(msg, SMS_CB_ROUTING_IND))
+		return;
+
+	g_isi_msg_data_get_byte(msg, 1, &sbcount);
+
+	for (g_isi_sb_iter_init_full(&iter, msg, 2, TRUE, sbcount);
+		g_isi_sb_iter_is_valid(&iter);
+		g_isi_sb_iter_next(&iter)) {
+
+		if (g_isi_sb_iter_get_id(&iter) !=3D SMS_GSM_CB_MESSAGE)
+			continue;
+
+		subblock_len =3D g_isi_sb_iter_get_len(&iter) - 4;
+
+		if (subblock_len > len &&
+			g_isi_sb_iter_get_data(&iter, (void **)&pdu_data, 4)) {
+			unsigned int i;
+
+			for (i =3D 0; i < len; i++) {
+				if (i < 6) /*account for filler in pos 6*/
+					info.pdu[i] =3D pdu_data[i];
+				else
+					info.pdu[i] =3D pdu_data[i+1];
+			}
+
+			DBG("CBS Message received");
+			ofono_cbs_notify(cbs, info.pdu, len);
+			return;
+		} else {
+			DBG("Error reading CBS message");
+			return;
+		}
+	}
 }
 =

 static void routing_ntf_cb(const GIsiMessage *msg, void *data)
@@ -131,40 +416,71 @@ static void routing_ntf_cb(const GIsiMessage *msg, vo=
id *data)
 static void routing_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_cbs *cbs =3D data;
+
+	ofono_cbs_register(cbs);
+}
+
+static void reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_cbs *cbs =3D data;
 	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	uint8_t *new_msg;
+	GIsiModem *modem;
 =

-	if (cd =3D=3D NULL || !check_response_status(msg, SMS_GSM_CB_ROUTING_RESP=
))
+	if (cd =3D=3D NULL)
 		return;
 =

-	g_isi_client_ntf_subscribe(cd->client, SMS_GSM_CB_ROUTING_NTF,
-					routing_ntf_cb, cbs);
+	ISI_VERSION_DBG(msg);
+
+	modem =3D g_isi_client_modem(cd->client);
+
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) >=3D 0) {
+		uint8_t t_msg[] =3D {
+			SMS_CB_ROUTING_REQ,
+			SMS_ROUTING_QUERY_ALL,
+			0x00,	/* New subscription*/
+			0x00,	/* Subscription type */
+			0x00,	/* Fillers */
+			0x00,
+			0x00	/* No subblocks*/
+		};
+		new_msg =3D g_try_malloc0(sizeof(t_msg));
+		memmove(new_msg, t_msg, sizeof(t_msg));
+	} else {
+		uint8_t t_msg[] =3D {
+			SMS_GSM_CB_ROUTING_REQ,
+			SMS_ROUTING_SET,
+			SMS_GSM_ROUTING_MODE_ALL,
+			SMS_CB_NOT_ALLOWED_IDS_LIST,
+			0x00,  /* Subject count */
+			0x00,  /* Language count */
+			0x00,  /* CB range */
+			0x00,  /* Subject list MSBS */
+			0x00,  /* Subject list LSBS */
+			0x00   /* Languages */
+		};
+		new_msg =3D g_try_malloc0(sizeof(t_msg));
+		memmove(new_msg, t_msg, sizeof(t_msg));
+	}
 =

-	ofono_cbs_register(cbs);
+	g_isi_client_send(cd->client, new_msg, sizeof(msg),
+				routing_resp_cb, cbs, NULL);
+
+	g_free(new_msg);
 }
 =

 static int isi_cbs_probe(struct ofono_cbs *cbs, unsigned int vendor,
 				void *user)
 {
 	GIsiModem *modem =3D user;
-	struct cbs_data *cd;
-
-	const uint8_t msg[] =3D {
-		SMS_GSM_CB_ROUTING_REQ,
-		SMS_ROUTING_SET,
-		SMS_GSM_ROUTING_MODE_ALL,
-		SMS_CB_NOT_ALLOWED_IDS_LIST,
-		0x00,  /* Subject count */
-		0x00,  /* Language count */
-		0x00,  /* CB range */
-		0x00,  /* Subject list MSBS */
-		0x00,  /* Subject list LSBS */
-		0x00   /* Languages */
-	};
+	struct cbs_data *cd =3D g_try_new0(struct cbs_data, 1);
 =

-	cd =3D g_try_new0(struct cbs_data, 1);
 	if (cd =3D=3D NULL)
 		return -ENOMEM;
 =

+	cd->subscription_nr =3D 0;
+
 	cd->client =3D g_isi_client_create(modem, PN_SMS);
 	if (cd->client =3D=3D NULL) {
 		g_free(cd);
@@ -173,34 +489,60 @@ static int isi_cbs_probe(struct ofono_cbs *cbs, unsig=
ned int vendor,
 =

 	ofono_cbs_set_data(cbs, cd);
 =

-	if (g_isi_client_send(cd->client, msg, sizeof(msg),
-				routing_resp_cb, cbs, NULL))
-		return 0;
+	g_isi_client_ind_subscribe(cd->client, SMS_CB_ROUTING_IND,
+			routing_ind_cb, cbs);
+
+	g_isi_client_ntf_subscribe(cd->client, SMS_GSM_CB_ROUTING_NTF,
+			routing_ntf_cb, cbs);
 =

-	return -errno;
+	g_isi_client_verify(cd->client, reachable_cb, cbs, NULL);
+
+	return 0;
 }
 =

 static void isi_cbs_remove(struct ofono_cbs *cbs)
 {
 	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
-	const uint8_t msg[] =3D {
-		SMS_GSM_CB_ROUTING_REQ,
-		SMS_ROUTING_RELEASE,
-		SMS_GSM_ROUTING_MODE_ALL,
-		SMS_CB_NOT_ALLOWED_IDS_LIST,
-		0x00,  /* Subject count */
-		0x00,  /* Language count */
-		0x00,  /* CB range */
-		0x00,  /* Subject list MSBS */
-		0x00,  /* Subject list LSBS */
-		0x00   /* Languages */
-	};
-
-	ofono_cbs_set_data(cbs, NULL);
+	uint8_t *msg;
+	GIsiModem *modem;
 =

 	if (cd =3D=3D NULL)
 		return;
 =

+	modem =3D g_isi_client_modem(cd->client);
+
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) >=3D 0) {
+		uint8_t t_msg[] =3D {
+			SMS_CB_ROUTING_REQ,
+			SMS_ROUTING_RELEASE,
+			cd->subscription_nr,	/* Subscription number */
+			0x00,			/* Subscription type */
+			0x00,			/* Fillers */
+			0x00,
+			0x00			/* No subblocks*/
+		};
+		msg =3D g_try_malloc0(sizeof(t_msg));
+		memmove(msg, t_msg, sizeof(t_msg));
+	} else {
+		uint8_t t_msg[] =3D {
+			SMS_GSM_CB_ROUTING_REQ,
+			SMS_ROUTING_RELEASE,
+			SMS_GSM_ROUTING_MODE_ALL,
+			SMS_CB_NOT_ALLOWED_IDS_LIST,
+			0x00,  /* Subject count */
+			0x00,  /* Language count */
+			0x00,  /* CB range */
+			0x00,  /* Subject list MSBS */
+			0x00,  /* Subject list LSBS */
+			0x00   /* Languages */
+		};
+		msg =3D g_try_malloc0(sizeof(t_msg));
+		memmove(msg, t_msg, sizeof(t_msg));
+	}
+	ofono_cbs_set_data(cbs, NULL);
+
+
 	/*
 	 * Send a promiscuous routing release, so as not to hog
 	 * resources unnecessarily after being removed.
@@ -209,6 +551,7 @@ static void isi_cbs_remove(struct ofono_cbs *cbs)
 =

 	g_isi_client_destroy(cd->client);
 	g_free(cd);
+	g_free(msg);
 }
 =

 static struct ofono_cbs_driver driver =3D {
diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 1fd2226..ec3f3b3 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -449,6 +449,9 @@ const char *sms_message_id_name(enum sms_message_id val=
ue)
 		_(SMS_SETTINGS_UPDATE_RESP);
 		_(SMS_SETTINGS_READ_REQ);
 		_(SMS_SETTINGS_READ_RESP);
+		_(SMS_CB_ROUTING_REQ);
+		_(SMS_CB_ROUTING_RESP);
+		_(SMS_CB_ROUTING_IND);
 		_(SMS_RECEIVED_MSG_REPORT_REQ);
 		_(SMS_RECEIVED_MSG_REPORT_RESP);
 		_(SMS_RECEIVE_MESSAGE_REQ);
@@ -473,6 +476,7 @@ const char *sms_subblock_name(enum sms_subblock value)
 		_(SMS_GSM_TPDU);
 		_(SMS_GSM_TPDU_25);
 		_(SMS_GSM_ROUTE_INFO);
+		_(SMS_GSM_CBS_SUBSCRIPTION);
 		_(SMS_GSM_PARAMETERS);
 		_(SMS_COMMON_DATA);
 		_(SMS_ADDRESS);
diff --git a/drivers/isimodem/sms.h b/drivers/isimodem/sms.h
index a51adf2..03db354 100644
--- a/drivers/isimodem/sms.h
+++ b/drivers/isimodem/sms.h
@@ -130,6 +130,9 @@ enum sms_message_id {
 	SMS_SETTINGS_UPDATE_RESP =3D 0x31,
 	SMS_SETTINGS_READ_REQ =3D  0x32,
 	SMS_SETTINGS_READ_RESP =3D 0x33,
+	SMS_CB_ROUTING_REQ =3D 0x34,
+	SMS_CB_ROUTING_RESP =3D 0x35,
+	SMS_CB_ROUTING_IND =3D 0x36,
 	SMS_RECEIVED_MSG_REPORT_REQ =3D 0x3B,
 	SMS_RECEIVED_MSG_REPORT_RESP =3D 0x3C,
 	SMS_RECEIVE_MESSAGE_REQ =3D 0x41,
@@ -150,6 +153,7 @@ enum sms_subblock {
 	SMS_GSM_TPDU =3D 0x11,
 	SMS_GSM_TPDU_25 =3D 0x001C,
 	SMS_GSM_ROUTE_INFO =3D 0x0023,
+	SMS_GSM_CBS_SUBSCRIPTION =3D 0x002D,
 	SMS_GSM_PARAMETERS =3D 0x0031,
 	SMS_COMMON_DATA =3D 0x80,
 	SMS_ADDRESS =3D 0x82,
@@ -160,7 +164,8 @@ enum sms_routing_command {
 	SMS_ROUTING_SET =3D 0x01,
 	SMS_ROUTING_SUSPEND =3D 0x02,
 	SMS_ROUTING_RESUME =3D 0x03,
-	SMS_ROUTING_UPDATE =3D 0x04
+	SMS_ROUTING_UPDATE =3D 0x04,
+	SMS_ROUTING_QUERY_ALL =3D 0x06
 };
 =

 enum sms_route_preference {
-- =

1.7.3.5


--===============1955821481596061125==--


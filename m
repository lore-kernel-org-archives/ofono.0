Content-Type: multipart/mixed; boundary="===============3114765604978399144=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 07/18] isimodem: add wgmodem2.5 to devinfo
Date: Tue, 15 Feb 2011 13:31:01 +0100
Message-ID: <b1a7da8d4f03ebca0ee0fd98db11ba4fb8e229e1.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3114765604978399144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/debug.c   |    1 +
 drivers/isimodem/devinfo.c |  161 ++++++++++++++++++++++++++++++++++++----=
----
 drivers/isimodem/info.h    |    3 +
 3 files changed, 136 insertions(+), 29 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index c14acc2..10d0201 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -481,6 +481,7 @@ const char *info_message_id_name(enum info_message_id v=
alue)
 const char *info_subblock_name(enum info_subblock value)
 {
 	switch (value) {
+		_(INFO_SB_MODEMSW_VERSION);
 		_(INFO_SB_PRODUCT_INFO_NAME);
 		_(INFO_SB_PRODUCT_INFO_MANUFACTURER);
 		_(INFO_SB_SN_IMEI_PLAIN);
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index 3bf05f4..ebe4273 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -46,6 +47,8 @@
 =

 struct devinfo_data {
 	GIsiClient *client;
+	GIsiClient *primary;
+	GIsiClient *secondary;
 };
 =

 static void info_resp_cb(const GIsiMessage *msg, void *data)
@@ -82,7 +85,8 @@ static void info_resp_cb(const GIsiMessage *msg, void *da=
ta)
 		if (id !=3D INFO_SB_PRODUCT_INFO_MANUFACTURER &&
 				id !=3D INFO_SB_PRODUCT_INFO_NAME &&
 				id !=3D INFO_SB_MCUSW_VERSION &&
-				id !=3D INFO_SB_SN_IMEI_PLAIN)
+				id !=3D INFO_SB_SN_IMEI_PLAIN &&
+				id !=3D INFO_SB_MODEMSW_VERSION)
 			continue;
 =

 		if (g_isi_sb_iter_get_len(&iter) < 5)
@@ -111,17 +115,22 @@ static void isi_query_manufacturer(struct ofono_devin=
fo *info,
 	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(dev, cb, data);
 =

+	if (cbd =3D=3D NULL || dev =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_resource(dev->client) =3D=3D PN_MODEM_INFO) {
+		goto error;
+	} else {
+
 	const uint8_t msg[] =3D {
 		INFO_PRODUCT_INFO_READ_REQ,
 		INFO_PRODUCT_MANUFACTURER
 	};
 	size_t len =3D sizeof(msg);
 =

-	if (cbd =3D=3D NULL || dev =3D=3D NULL)
-		goto error;
-
 	if (g_isi_client_send(dev->client, msg, len, info_resp_cb, cbd, g_free))
 		return;
+	}
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, "", data);
@@ -135,17 +144,22 @@ static void isi_query_model(struct ofono_devinfo *inf=
o,
 	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(dev, cb, data);
 =

+	if (cbd =3D=3D NULL || dev =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_resource(dev->client) =3D=3D PN_MODEM_INFO) {
+		goto error;
+	} else {
+
 	const uint8_t msg[] =3D {
 		INFO_PRODUCT_INFO_READ_REQ,
 		INFO_PRODUCT_NAME
 	};
 	size_t len =3D sizeof(msg);
 =

-	if (cbd =3D=3D NULL || dev =3D=3D NULL)
-		goto error;
-
 	if (g_isi_client_send(dev->client, msg, len, info_resp_cb, cbd, g_free))
 		return;
+	}
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, "", data);
@@ -159,24 +173,51 @@ static void isi_query_revision(struct ofono_devinfo *=
info,
 	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(dev, cb, data);
 =

-	const uint8_t msg[] =3D {
-		INFO_VERSION_READ_REQ,
-		0x00, INFO_MCUSW,
-		0x00, 0x00, 0x00, 0x00
-	};
-	size_t len =3D sizeof(msg);
+	unsigned char *msg =3D NULL;
+	unsigned char msg_size =3D 0;
+	size_t len;
 =

 	if (cbd =3D=3D NULL || dev =3D=3D NULL)
 		goto error;
 =

+	if (g_isi_client_resource(dev->client) =3D=3D PN_MODEM_INFO) {
+		goto error;
+	} else {
+		msg_size =3D 7;
+		msg =3D g_try_malloc0(msg_size);
+		msg[0] =3D INFO_VERSION_READ_REQ;
+		msg[1] =3D 0x00;
+		msg[2] =3D INFO_MCUSW;
+		msg[3] =3D 0x00;
+		msg[4] =3D 0x00;
+		msg[5] =3D 0x00;
+		msg[6] =3D 0x00;
+	}
+
+	len =3D sizeof(msg);
+
 	if (g_isi_client_send(dev->client, msg, len, info_resp_cb, cbd, g_free))
-		return;
+		goto out;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, "", data);
+out:
+	g_free(msg);
 	g_free(cbd);
 }
 =

+static gboolean send_serial_number_read_req(GIsiClient *client, void *cbd,
+					GDestroyNotify destroy)
+{
+	const uint8_t msg[] =3D {
+		INFO_SERIAL_NUMBER_READ_REQ,
+		INFO_SN_IMEI_PLAIN
+	};
+
+	return g_isi_client_send(client, msg, sizeof(msg),
+					info_resp_cb, cbd, g_free);
+
+}
 static void isi_query_serial(struct ofono_devinfo *info,
 				ofono_devinfo_query_cb_t cb,
 				void *data)
@@ -184,33 +225,84 @@ static void isi_query_serial(struct ofono_devinfo *in=
fo,
 	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(dev, cb, data);
 =

-	const uint8_t msg[] =3D {
-		INFO_SERIAL_NUMBER_READ_REQ,
-		INFO_SN_IMEI_PLAIN
-	};
-	size_t len =3D sizeof(msg);
+		if (cbd =3D=3D NULL || dev =3D=3D NULL)
+			goto error;
 =

-	if (cbd =3D=3D NULL || dev =3D=3D NULL)
-		goto error;
+/* FIXME Move to u8500 */
+	if (g_isi_client_resource(dev->client) =3D=3D PN_MODEM_INFO) {
+		char imei[16]; /* IMEI 15 digits + 1 null*/
+		char numbers[] =3D "1234567890";
+		FILE *fp =3D fopen("/etc/imei", "r");
+		DBG("");
 =

-	if (g_isi_client_send(dev->client, msg, len, info_resp_cb, cbd, g_free))
+		if (fp =3D=3D NULL) {
+			DBG("failed to open /etc/imei file");
+			goto error;
+		}
+
+		if (fgets(imei, 16, fp)) {
+			DBG(" IMEI =3D %s", imei);
+			if (15 =3D=3D strspn(imei, numbers))
+				CALLBACK_WITH_SUCCESS(cb, imei, data);
+			else {
+				CALLBACK_WITH_FAILURE(cb, "", data);
+				fclose(fp);
+				goto error;
+			}
+		}
+
+		fclose(fp);
+		g_free(cbd);
 		return;
+	} else {
+		if (send_serial_number_read_req(dev->client, cbd, g_free))
+			return;
+
+	}
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, "", data);
 	g_free(cbd);
 }
 =

-static void reachable_cb(const GIsiMessage *msg, void *data)
+static void primary_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_devinfo *info =3D data;
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	ISI_VERSION_DBG(msg);
+
+	if (dev =3D=3D NULL || dev->client !=3D NULL)
+		return;
+
+	dev->client =3D dev->primary;
+
+	ofono_devinfo_register(info);
+	g_isi_client_destroy(dev->secondary);
+
+}
+
+static void secondary_reachable_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_devinfo *info =3D data;
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
 =

 	if (g_isi_msg_error(msg) < 0)
 		return;
 =

 	ISI_VERSION_DBG(msg);
 =

+	if (dev =3D=3D NULL || dev->client !=3D NULL)
+		return;
+
+	dev->client =3D dev->secondary;
+
 	ofono_devinfo_register(info);
+	g_isi_client_destroy(dev->primary);
+
 }
 =

 static int isi_devinfo_probe(struct ofono_devinfo *info, unsigned int vend=
or,
@@ -222,19 +314,30 @@ static int isi_devinfo_probe(struct ofono_devinfo *in=
fo, unsigned int vendor,
 	if (data =3D=3D NULL)
 		return -ENOMEM;
 =

-	data->client =3D g_isi_client_create(idx, PN_PHONE_INFO);
-	if (data->client =3D=3D NULL) {
-		g_free(data);
-		return -ENOMEM;
-	}
+	data->primary =3D g_isi_client_create(idx, PN_MODEM_INFO);
+	if (data->primary =3D=3D NULL)
+		goto nomem;
 =

+	data->secondary =3D g_isi_client_create(idx, PN_PHONE_INFO);
+	if (data->secondary =3D=3D NULL)
+		goto nomem;
 =

 	ofono_devinfo_set_data(info, data);
 =

 	g_isi_client_set_timeout(data->client, INFO_TIMEOUT);
-	g_isi_client_verify(data->client, reachable_cb, info, NULL);
+	g_isi_client_verify(data->primary, primary_reachable_cb, info, NULL);
+	g_isi_client_verify(data->secondary, secondary_reachable_cb, info,
+				NULL);
 =

 	return 0;
+
+nomem:
+	g_isi_client_destroy(data->primary);
+	g_isi_client_destroy(data->secondary);
+
+	g_free(data);
+	return -ENOMEM;
+
 }
 =

 static void isi_devinfo_remove(struct ofono_devinfo *info)
diff --git a/drivers/isimodem/info.h b/drivers/isimodem/info.h
index bdf1596..60425bf 100644
--- a/drivers/isimodem/info.h
+++ b/drivers/isimodem/info.h
@@ -27,6 +27,8 @@ extern "C" {
 #endif
 =

 #define PN_PHONE_INFO				0x1B
+#define PN_MODEM_INFO				0xC5
+
 #define PN_EPOC_INFO				98
 #define INFO_TIMEOUT				5
 =

@@ -50,6 +52,7 @@ enum info_message_id {
 };
 =

 enum info_subblock {
+	INFO_SB_MODEMSW_VERSION =3D		0x00,
 	INFO_SB_PRODUCT_INFO_NAME =3D		0x01,
 	INFO_SB_PRODUCT_INFO_MANUFACTURER =3D	0x07,
 	INFO_SB_SN_IMEI_PLAIN =3D			0x41,
-- =

1.7.3.5


--===============3114765604978399144==--


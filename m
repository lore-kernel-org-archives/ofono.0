Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E95464E
	for <ofono@lists.linux.dev>; Wed, 23 Jul 2025 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250692; cv=none; b=kG0gGOLz/u1rpumww/PSLztwJTwUiwE5wySBxu9Ygf1rcZaiEREXUNOIl8CYY6cE2lMdMhc9lxAcU2AR4sIo5LHxQwELU+D4AZzbmo+JaNaqaxdQ5is5/TeHLiLOXfXmwb6jg4zb56tKo4SRKq0pVZu39zkDxHxH5CNwJwEbx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250692; c=relaxed/simple;
	bh=e7OHOp3l89tqjejPek9Bnnz/n9+lnbhX2B/xw1PbW80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbTcyZShIDUl0p8MdBJ5R5Es80DInBRkT4+2A9+DPVTQynMAZQm4nCq3KexIiAeXKBwIUDnoVmcKuDcxgqfkMri1NACJlkxEFp2ssmU6bX8AKm5DY6AU1r6C6QYPaSCDvVR9EmlSOYlJSn5WhZu3sRURg4Q2Oz8VFgIV89VJubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGi6A9aZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGi6A9aZ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so11913144a12.3
        for <ofono@lists.linux.dev>; Tue, 22 Jul 2025 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753250689; x=1753855489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmBfZVbTepR0NAfVCgJxQO8gCQzORgPovMxaL9qniIY=;
        b=HGi6A9aZhZaE/61hh/h1S2Yakhp8HQ/oCr4W5c0LdlcfBbhFHmEJoS6uAr/VDSbyYm
         Ezm778YcISK4gHbAn8JZ3VC4uNNXXl5aHqYpaTTt5lPbzNZiewpOTCzsYOgzuQl4Rndx
         9atZdviBF3Zceb4KyXWhb8i+sPAx6vjvzzbT/rmTc1TpHqt20EvY+CEmhU9tY3wSJgJO
         RWYBr8PUDnrBuk2E35UWYaquBDyF9HXwwpI7gK1pvv9ovzxH/MDWH+Jx2FJJb9Lwp7yr
         KiBUrsAGKv9UfTLf92CGcgQF4jtwoHa6Dhn1DjGXgjEEj/p9y6XKLxBZ1uwGbrsFU2j+
         /S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250689; x=1753855489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmBfZVbTepR0NAfVCgJxQO8gCQzORgPovMxaL9qniIY=;
        b=tGgJxFZx276783Uc+356ZE0ZCEQXPn+0SbdBIujmRI3scavKZIoG+ofj5W/Tbj2EkM
         WoX2zWTT+X1yaGvR6i72v1aTM10BgGEYbqxZ5dVRRlndm7so0omWtnPQyhqzPLG/EK3k
         KNPXs1W8xx0mHksT+tEP1gn6AN/t0rkaAa8EMtiB+SjAxsNO+X5qx5ekvpTWpYkHiU5/
         z0+0smhqmR4UlZDkZ1Q9g+ZAdOvsnM4gUGJxsIwSFF1ZC9WEza9YwpOshA1wxAfW7ya6
         yolMK9yccc7Y9cNBRndkA8byuE4Vt2a3NEGfhmNKmHzMX+XWUrGcKr/ZYx9zVVogPr2A
         InTg==
X-Gm-Message-State: AOJu0YwNrfiBnSupKTtSNxoYw65vZCPs+k7H3gYPSpdN4fvR03lHfDrV
	clQzXyjaVqxPBg+6U3Vtvqv7O8iAcJTngKiFJ699owWaxz+H6oE2a4T1enGVOQ==
X-Gm-Gg: ASbGncsPhoRdbvumhCOFQjeHqlPPR3/TM8LP/K9B/xbuJFha2cBK73o5XvTjTpIiHn9
	s9Xa3IVmet761BwEQ1TvYUtVya1waL976svCwSmLh+w3ZeIxshb2+JEPVVqiaimRrHWKNXWRTrs
	+iSa27ndR+HH3dcBkYL8QVH1QQP9LADB6DdIJ/sF3JI/oi0mJJVBuNG9hLIMkpeO/3tcR0IGVKK
	xpVgd4C9dnzfFD8RwqpUo7nBYUj6JN+QgbMguGngAHZiF6v0CgpMUV7mY7qFndAceidq4Bj4NDX
	JTHbKNzMQ8MJjChFAiULaERYzuxNN9s9a9VUh26JGQSLqHjd8ZepuZnBqEgW7IjtDXAq6bpW2Fn
	WxMzYLzA1of0rgW/nVghpJvzv4FBo7Wa+bHAzGzMfHHS4
X-Google-Smtp-Source: AGHT+IFWkFhyiuEQEzpf0S3BtR0YWeQ/HlkNRjGcJV6/Q4i4wNccf5rkSRJcDP9jieWYl420epIodA==
X-Received: by 2002:a05:6402:278e:b0:60c:4220:5d89 with SMTP id 4fb4d7f45d1cf-6149b59c3demr1327257a12.23.1753250689015;
        Tue, 22 Jul 2025 23:04:49 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f0a267sm7621808a12.11.2025.07.22.23.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:04:48 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: sms: Implement message ack
Date: Wed, 23 Jul 2025 09:04:37 +0300
Message-Id: <20250723060437.560910-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "transfer route" message may come with ack_required being set to require
ack, obey that.
---
 drivers/qmimodem/sms.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/wms.h |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 43fa9e39..39a4bb3f 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -571,6 +571,47 @@ static void get_msg_protocol(struct ofono_sms *sms)
 				get_msg_protocol_cb, sms, NULL);
 }
 
+static void send_ack_cb(struct qmi_result *result, void *user_data)
+{
+	uint16_t err;
+
+	DBG("");
+
+	if (!qmi_result_set_error(result, &err))
+		return;
+
+	DBG("Err: protocol %d - %s",
+			err, qmi_result_get_error(result));
+}
+
+static void send_ack(struct sms_data *data,
+				const struct qmi_wms_result_message *message)
+{
+	struct __attribute__((__packed__)) {
+		uint32_t transaction_id;
+		uint8_t mode;
+		uint8_t success;
+	} ack;
+	struct qmi_param *param;
+
+	ack.transaction_id = message->transaction_id;
+	ack.success = 1;
+
+	if (message->msg_format == 0)
+		ack.mode = QMI_WMS_MESSAGE_MODE_CDMA;
+	else
+		ack.mode = QMI_WMS_MESSAGE_MODE_GSMWCDMA;
+
+	param = qmi_param_new();
+	qmi_param_append(param, 0x01, sizeof(ack), &ack);
+
+	if (qmi_service_send(data->wms, QMI_WMS_SEND_ACK, param,
+				send_ack_cb, NULL, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+}
+
 static void event_notify(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sms *sms = user_data;
@@ -615,6 +656,9 @@ static void event_notify(struct qmi_result *result, void *user_data)
 			DBG("msg format %d PDU length %d",
 				message->msg_format, plen);
 
+			if (message->ack_required == QMI_WMS_ACK_REQUIRED)
+				send_ack(data, message);
+
 			ofono_sms_deliver_notify(sms, message->msg_data,
 							plen, plen);
 		}
diff --git a/drivers/qmimodem/wms.h b/drivers/qmimodem/wms.h
index 9d7165b5..f8d4f3f5 100644
--- a/drivers/qmimodem/wms.h
+++ b/drivers/qmimodem/wms.h
@@ -20,6 +20,7 @@
 #define QMI_WMS_GET_SMSC_ADDR		52	/* Get SMSC address */
 #define QMI_WMS_SET_SMSC_ADDR		53	/* Set SMSC address */
 #define QMI_WMS_GET_MSG_LIST_MAX	54	/* Get maximum size of SMS storage */
+#define QMI_WMS_SEND_ACK		55	/* Send Ack */
 
 #define QMI_WMS_GET_DOMAIN_PREF		64	/* Get domain preference */
 #define QMI_WMS_SET_DOMAIN_PREF		65	/* Set domain preference */
@@ -32,6 +33,8 @@ struct qmi_wms_result_new_msg_notify {
 	uint32_t storage_index;
 } __attribute__((__packed__));
 
+#define QMI_WMS_ACK_REQUIRED			0x00
+
 #define QMI_WMS_RESULT_MESSAGE			0x11
 struct qmi_wms_result_message {
 	uint8_t ack_required;				/* bool */
-- 
2.25.1


Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F825464E
	for <ofono@lists.linux.dev>; Wed, 23 Jul 2025 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250639; cv=none; b=KBY+1+EgjOzlwIkVlMAemLfIkQ9Epg2t/HnVbQnQSwkGFee793oZnxGFnIDhm/PE3uk0l337NR6Wd56yMQDkwFOMgt0Cq9UHpsX6S/ThVW25SQu1Tjh/yOdEHoGh486kT+OdrbmcgKkv+tEJZHl4f5v4G415T2hUMUUuEIi82EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250639; c=relaxed/simple;
	bh=9rQjFr+zaN7AnwN23MxMHr7xSz4KEnruf5bNGPVFYMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mJsDBpFxqNjWI4Cm9MO8ZbBGnCGbyU+ofQd6NK+ggo7BEPR4TJrAWK5wuEQeViU9ZlMpld74oe4NjVFEYC7hSAAGCSkHKE5/OsodHZroBMpHd1jC7ypxXj1ILwdxErn3U9OyHG+KmCkDc2WMiKEx8xdAqkTJW2LyfrkPd88ivcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pyw9HY43; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyw9HY43"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so12112095a12.3
        for <ofono@lists.linux.dev>; Tue, 22 Jul 2025 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753250635; x=1753855435; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzDscwq7F3NHOa1dIvX1KWiRa9kD88dSYYiBteBzrjE=;
        b=Pyw9HY43qeSUtOq38T5tnuWirspH+FPu0WBVmNrP4VhS5cKpDUwtIRdNFl9jVoHNmg
         wnX5rqojcWS9LDzLGVTDzUd49RpfYRTauLq2gZWQ8PYSSCAJTqXRfK0QxFRBxVRR3cKf
         1iyj6HTnZDsByhZgya+Yo2djfD/y7epNZwkAxIViSEncRFBHWTLQcU8wNhFeHcOx4Y7S
         w4Ee5QfLAsZElT/+HW/IBsFz1IhshNcewlnyaqEXDQuzjem4GwlSKAE4z/wZe6l6fXkW
         /9bKuRcCsRHE/tgtyloa3oIlIJWzDwKvLbecsJI+BuU+mU2l46TlwZ6puXrtw+wtwwf/
         C+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250635; x=1753855435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzDscwq7F3NHOa1dIvX1KWiRa9kD88dSYYiBteBzrjE=;
        b=w2mGE8+euU+bHztCYSAvM+2P7VJ9LLFPM3iQOMEwo3csS/ZQUQH7o6K19jJF5AAzdx
         Ox5YVrbeKb5jcmSZFUBxn8lFO9aXucnm25lHvzGPMyMR3byJUcrQ6Q5ezNBFm9ePZv5Q
         cnn9zdm42N4JKXDOxUNiqTpzymvRm08lnKYqItYtLN2Lx4x158fdcJwS3MHgnQvkFFoP
         eFJiwWNqoRzpQrN/pPaHJztGHn13kFUQcuu8X0b2QRN/HBGJFUpQf8AMRPLNcxaPB3hL
         TGLD+y5U6/ko7a/FJYfQGlDSqZ2rC0N7I5HjzhhxAXNLqhPjVv+s/2YsfqPaYSM1x+6P
         nWWQ==
X-Gm-Message-State: AOJu0YyCtMAXEkynwQelJzu/LJXJiVLzRk+vwjLlqKi2ZY7N2y3zDUmp
	iRYN+RteO+YVok2GufxuA6HCRnvoGEiy2RV3Ed2mHdTaj+9X0sWmVXevrohpCQ==
X-Gm-Gg: ASbGncuBUAtQUqHkb0BaUIboMHdXFfAalmUfQ7HJ5aIXgHALj2lUA0mqlN9TkIGT+zO
	+YmvrInvzbVOG0mJO7anHq472zHETLFUSwFrPRXO+ww7F/uaAQWoaEi7bTEk5Gt1Q6HB7MTM/yJ
	OfB9UteIhD42Dlc4efXC5QuKsdBJrNZ4H623SxZE5Vej8ZjqDVNTL+mEEuGpHopUJ4eUg0xtChc
	Izk5qWsxltPTj8ILdNBUmMCZkGNHiTJYWUIBnbJFvk79d+9/6G+EgqhWlm3n8bZNfZ62n1/TGJV
	a5/UhQkzvSskanJq8qxyJx38dDT/syD28hl4ZmTK7KxxkeKgznByt70JoYRRpkNe7Mg2O3QpSll
	zqZDWqxaf/WpmafJ1zzm5474HYrFal4o2kf4xCGkD+ORI
X-Google-Smtp-Source: AGHT+IG3YuB9PqKPYZOJwwEO/JlrzuRz5YBLBgWvlcs9oxJyONb5TYp8kOdE1N0KndmuIRlAEuKndg==
X-Received: by 2002:a05:6402:2712:b0:613:45b7:6f77 with SMTP id 4fb4d7f45d1cf-6149b451e3dmr1303314a12.15.1753250634926;
        Tue, 22 Jul 2025 23:03:54 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36f96sm8086594a12.23.2025.07.22.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:03:54 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: sms: Change SMS storage type to UIM
Date: Wed, 23 Jul 2025 09:03:32 +0300
Message-Id: <20250723060332.560825-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory, a SIM card can be moved to another device before a particular
message in NV is read and then moved back. That might lead to that message
being received twice.

Also, some modems (like MDM6600 found in Motorola Droid4), cannot store
incoming class 4 messages in NV, only in UIM.

Fix that by using UIM as message storage type instead of NV for class 4
messages.
---
 drivers/qmimodem/sms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 75863480..43fa9e39 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -349,7 +349,7 @@ static void delete_msg(struct ofono_sms *sms, uint8_t tag)
 	param = qmi_param_new();
 
 	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_STORE,
-				QMI_WMS_STORAGE_TYPE_NV);
+				QMI_WMS_STORAGE_TYPE_UIM);
 
 	if (tag == QMI_WMS_MT_UNDEFINE) {
 		DBG("delete read msg type %d ndx %d", data->rd_msg_id.type,
@@ -516,7 +516,7 @@ static void get_msg_list(struct ofono_sms *sms)
 
 	/* query NOT_READ msg list */
 	qmi_param_append_uint8(param, QMI_WMS_PARAM_STORAGE_TYPE,
-				QMI_WMS_STORAGE_TYPE_NV);
+				QMI_WMS_STORAGE_TYPE_UIM);
 	qmi_param_append_uint8(param, QMI_WMS_PARAM_TAG_TYPE,
 				QMI_WMS_MT_NOT_READ);
 	qmi_param_append_uint8(param, QMI_WMS_PARAM_MESSAGE_MODE,
@@ -689,7 +689,7 @@ static void get_routes_cb(struct qmi_result *result, void *user_data)
 	new_list->count = L_CPU_TO_LE16(1);
 	new_list->route[0].msg_type = QMI_WMS_MSG_TYPE_P2P;
 	new_list->route[0].msg_class = QMI_WMS_MSG_CLASS_NONE;
-	new_list->route[0].storage_type = QMI_WMS_STORAGE_TYPE_NV;
+	new_list->route[0].storage_type = QMI_WMS_STORAGE_TYPE_UIM;
 	new_list->route[0].action = QMI_WMS_ACTION_STORE_AND_NOTIFY;
 
 	param = qmi_param_new();
-- 
2.25.1


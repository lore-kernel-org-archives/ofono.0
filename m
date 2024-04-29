Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E58288A
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406253; cv=none; b=KXgNIQi2zhMn2tGJAQYd9XY4PWOGqHRih+YTMcNEZk6Q6nzFAoOPoLaBXYoIqIAVB//6cdNor8cCeTs7uLZStofNGBg4V3myV3sEffHJvsozfwysJJVKH3PSGu8p2aCaSXOugTxAGJOGUqcZIsuHsPy8x8C/vqiC7irsVlMjozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406253; c=relaxed/simple;
	bh=4vYB4VjYrMWtB1o2PAUL++oj805s5KvpSpUqEDdGydo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmWR4GlzSeKBSsVVjaf02au9SngwihokrkIuzHc7gj032lI53ntBqNfBTIKDJZqLhW3W9EgAD6aV4635TuzgYXIhixnV/w3j/opgIhggRBbIF+fuFy5zM+zd/BMVRK/PguoITPMKKR4J76khy89d0oEwTxbvRR0vkaPvHdZ+wwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMKAt96q; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMKAt96q"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c5ed7fdbb1so2751975b6e.0
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406250; x=1715011050; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckPB0cVcXgeh3i2Xby9h8HcVJoPWvsuXrLEm7SCkQPE=;
        b=OMKAt96qwzEXqAVzlb/W+CytYdd8rvbJnHGYmitWD531Jx9WBsK5QC0BTnxZQWDekH
         0r4Zo30SmW5AGd/5QmpQCsDmeCMlRSncw5D8BLKCOgUDV2oPlt5aRccTbUwtViDkWuQF
         fgzP8wokoHkqjG8mpjc7MmKtUMI+JPgY5P+dmHZXG84WUH65dcx2ZE5Own7EZtnP17uj
         WgqMyrOeX8CIvMIdMqTj4WilJUsHBI17VCr7RTw8oHjQ0kGksaz/TM8ZxixPi0Q9C86I
         U9uSDoDM4N1crZp0jUvN1P9ODGQR9VmFtZH5E49uuFmAKDAq82iP00vjjSjj6/33bRcH
         lB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406250; x=1715011050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckPB0cVcXgeh3i2Xby9h8HcVJoPWvsuXrLEm7SCkQPE=;
        b=QqMnKzBnghXBICNfdYMY8MKOJF2CuMaV3nPVJ/jml14Toy4bMXnNa7VZh5IiHVgL2F
         LQ2EUZ1ZAJWeowVrzhKe2n0Jr6+7xjWOHPjVxKxScLJrbmsMFeqbaBtVFs5uv//jnl0g
         TWfQyilFdH0PGpdx7wgbngd8fdsQRoRC1H1bZD87QPnXVWY0Y+C4e3bIGOoksakTKh1u
         pjk7AtOjkRmM2kQ2nZMY8hJ8MBU9dylVo3gP8LYcQ7rZrLAG37crb31cdLqJc+bWjJP2
         3SpmuKvMf+4QzJ/6vDbPzZF7ss5v8q7gLkYgLLZKQHG7h1tyOUbh4LC8rkdyM05a53a1
         fIMw==
X-Gm-Message-State: AOJu0YzA18JOjg4PYgDKG8IGWVcnawH7Jd8acPbqhw43cFxkav5p/MQy
	i94rryliX7kJKkErQU58hNdJaU2TgZ2Wi1LNdh38nqFXnG09k+/YTRXzvA==
X-Google-Smtp-Source: AGHT+IFMbyBZkpVToQAmlNxvSUTXNI05pfRKKRiZ8IYJHKlIbkb5dkYt1zBuePTAsOsiTJXib72r4g==
X-Received: by 2002:a05:6808:2194:b0:3c6:ef2e:98f4 with SMTP id be20-20020a056808219400b003c6ef2e98f4mr31423oib.15.1714406250408;
        Mon, 29 Apr 2024 08:57:30 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bf29-20020a056808191d00b003c7443c0efasm3117820oib.1.2024.04.29.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:30 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] qmi: lte: Support additional attributes
Date: Mon, 29 Apr 2024 10:56:55 -0500
Message-ID: <20240429155726.51479-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429155726.51479-1-denkenz@gmail.com>
References: <20240429155726.51479-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for setting APN Type (IPV4, IPV6 or Dual), Username and
Password attributes of the profile used for the default bearer.
---
 drivers/qmimodem/lte.c | 21 +++++++++++++++++----
 drivers/qmimodem/wds.c | 14 ++++++++++++++
 drivers/qmimodem/wds.h |  1 +
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 7633572b39ef..70efaf04c8f5 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -66,6 +66,10 @@ static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data)
 {
+	static const uint8_t PARAM_PDP_TYPE = 0x11;
+	static const uint8_t PARAM_USERNAME = 0x1B;
+	static const uint8_t PARAM_PASSWORD = 0x1C;
+	static const uint8_t PARAM_AUTHENTICATION_PREFERENCE = 0x1D;
 	struct lte_data *ldd = ofono_lte_get_data(lte);
 	struct cb_data *cbd = cb_data_new(cb, data);
 	struct qmi_param* param;
@@ -76,19 +80,28 @@ static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *lte,
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
 		.index = ldd->default_profile,
 	};
+	uint8_t auth = qmi_wds_auth_from_ofono(info->auth_method);
 
 	DBG("");
 
 	param = qmi_param_new();
 
-	/* Profile selector */
 	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
-
-	/* WDS APN Name */
+	qmi_param_append_uint8(param, PARAM_PDP_TYPE,
+				qmi_wds_pdp_type_from_ofono(info->proto));
 	qmi_param_append(param, QMI_WDS_PARAM_APN,
 				strlen(info->apn), info->apn);
 
-	/* Modify profile */
+	qmi_param_append_uint8(param, PARAM_AUTHENTICATION_PREFERENCE, auth);
+
+	if (auth && info->username[0])
+		qmi_param_append(param, PARAM_USERNAME,
+					strlen(info->username), info->username);
+
+	if (auth && info->password[0])
+		qmi_param_append(param, PARAM_PASSWORD,
+					strlen(info->password), info->password);
+
 	if (qmi_service_send(ldd->wds, QMI_WDS_MODIFY_PROFILE, param,
 					modify_profile_cb, cbd, l_free) > 0)
 		return;
diff --git a/drivers/qmimodem/wds.c b/drivers/qmimodem/wds.c
index 748ad867c2cc..d126f4712921 100644
--- a/drivers/qmimodem/wds.c
+++ b/drivers/qmimodem/wds.c
@@ -23,3 +23,17 @@ int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method)
 
 	return -ENOENT;
 }
+
+int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto)
+{
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IP:
+		return QMI_WDS_PDP_TYPE_IPV4;
+	case OFONO_GPRS_PROTO_IPV6:
+		return QMI_WDS_PDP_TYPE_IPV6;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return QMI_WDS_PDP_TYPE_IPV4V6;
+	}
+
+	return -ENOENT;
+}
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index c8aeefe430bb..d896fd8cc535 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -110,3 +110,4 @@ enum qmi_wds_command {
 };
 
 int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method);
+int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto);
-- 
2.44.0


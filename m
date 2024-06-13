Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1751494BC
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314912; cv=none; b=eaxSK6chRVuD1J2NYmm2JovwkC2w9lSbCyWfb3TydM2Ww4yb8LI7G5ztSQnr4+jHU7bMXqEap2fa12mRMkrQ/YfluEO4DbtBK3gwhwjVsS9UQY5gVAbt/YHe6q8GOyPoWYCq8Lx1CjRRuJ7ALFNZnuTRdyaFfKauh4X1xwAYROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314912; c=relaxed/simple;
	bh=z/wDdgwLXzFtlQ88C22rUmkqY+9SnBVNsbbyJMQsOOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPDxC8bR/tWbhZZZ3fUSWtFZlWO3biCJ0IAm6WC2GwNyCEvl2xLI5Nia1szz8h6T9JT8mv4jxGhSxBP5byHTnsO0H+3P6jI6TWFUgjHbNXB6dvs6NM1Sl2AimSxfPkOA5hxb0eelAh7mu/p8yQz6i9iH4nR6x1GVesyiFBTHgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by36gxUe; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by36gxUe"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f971cb3c9cso808818a34.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314910; x=1718919710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIQ2/9ja8jDLNYCwjMa3M8cJJG3T9L6Kv6Drj4uEAxQ=;
        b=by36gxUeGqXuWDiuqF7sJ3nsK+Qsttk3mbwdvrgrsLNKDJScXWTuUIJTDs1Cae+Wd+
         n4UM9Bsfp06UVtoqQSFG0a7Q87Mebj3fEdho9PN9PHsaXcXDFMIdE3T7K9yTXzI+TYoE
         WVMV3QJdNUACnW7KvMxEzFP6vBe/KbN1CsiRi/9yPAM90n6UucF32t3x6eWvoXke5Ja7
         r95SGR9cJclH3JfeS6nI9byg1FCuhATAomiamr5TvPs9rxb7DQyRJOHPoO2uIFQ5TrFQ
         255iV8jlRn5PHSNyrfaNbFP4cdamwEt0VgYJBiKEPANWN9mLnJEg77nrzZatAbNcSCNe
         OPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314910; x=1718919710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIQ2/9ja8jDLNYCwjMa3M8cJJG3T9L6Kv6Drj4uEAxQ=;
        b=d7WM7tIWiZoW73pO72eWWmIWPm1vHIPk9xBelSIg52Y/sQCFO9bnG1RAQbq/yooeL0
         Hi6QOmtb2LAHSo+ZCdKi8HkrhXip7VOVoxopXMbI6Ag89PY//XFPr3y2N7+JI3+B9jhn
         qRzSwfKQfBc+VYzwQh8c+tGuSWuKtgE/QmhW87WGXVkPYCgwIHrskwyXwt6FdPHQWoQE
         UnhDEc2mVpwJRNpw8jbb0AvnRCvQgTQKugJBA7QVNwnkbpuuhl2iQZCmS5o5F35NdO63
         dRDLWX7wC88L5gD037ULY3M7ueHOhkFH7RwnEzqIW8HUiKHw8h2GK+4cw7Kq3ouMuTQT
         qPLA==
X-Gm-Message-State: AOJu0Yy1aj/dcvt+1DkTOn84nm1jBThyNcOzIIOfCouALQpf7Tnrd+US
	5Ab7E+i8jYHkJOsFCHSeh/sm5h/+/vsHfXxezBO68eV/cGSWbBwaeEahZg==
X-Google-Smtp-Source: AGHT+IHF2S1s5/j4lpaAp5LCRiPcnpZqwzUPvhECeVjM7Xk18nZL6iL/s9IPD7TgpKbUMNlYmPkMlw==
X-Received: by 2002:a05:6871:3a24:b0:258:4978:7584 with SMTP id 586e51a60fabf-25849788d54mr16979fac.58.1718314909483;
        Thu, 13 Jun 2024 14:41:49 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 19/23] qmi: lte: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:28 -0500
Message-ID: <20240613214134.1056517-19-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/lte.c | 47 ++++++++++--------------------------------
 plugins/gobi.c         |  4 +++-
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 5466eac7c204..d2d1048b5515 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -162,10 +162,10 @@ error:
 	ofono_lte_remove(lte);
 }
 
-static void create_wds_cb(struct qmi_service *service, void *user_data)
+static int qmimodem_lte_probe(struct ofono_lte *lte,
+					unsigned int vendor, void *data)
 {
-	struct ofono_lte *lte = user_data;
-	struct lte_data *ldd = ofono_lte_get_data(lte);
+	struct qmi_service *wds = data;
 	struct qmi_param *param;
 	struct {
 		uint8_t type;
@@ -174,49 +174,25 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
 		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
 	};
+	struct lte_data *ldd;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request WDS service");
-		ofono_lte_remove(lte);
-		return;
-	}
-
-	ldd->wds = service;
-
-	/* Query the default profile */
 	param = qmi_param_new();
-
-	/* Profile type */
 	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
-	/* Get default profile */
-	if (qmi_service_send(ldd->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
-				param, get_default_profile_cb, lte, NULL) > 0)
-		return;
-
-	qmi_param_free(param);
-
-	ofono_error("Failed to query default profile");
-	ofono_lte_register(lte);
-}
-
-static int qmimodem_lte_probe(struct ofono_lte *lte,
-					unsigned int vendor, void *data)
-{
-	struct qmi_device *device = data;
-	struct lte_data *ldd;
-
-	DBG("qmimodem lte probe");
+	if (!qmi_service_send(wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+				param, get_default_profile_cb, lte, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(wds);
+		return -EIO;
+	}
 
 	ldd = l_new(struct lte_data, 1);
+	ldd->wds = wds;
 
 	ofono_lte_set_data(lte, ldd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_WDS,
-					create_wds_cb, lte, NULL);
-
 	return 0;
 }
 
@@ -229,7 +205,6 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 	ofono_lte_set_data(lte, NULL);
 
 	qmi_service_free(ldd->wds);
-
 	l_free(ldd);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 8e16e63cd6e2..6d48f0d1bc5b 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -800,7 +800,9 @@ static void gobi_post_sim(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	ofono_lte_create(modem, 0, "qmimodem", data->device);
+	if (data->features & GOBI_WDS)
+		ofono_lte_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wds));
 
 	if (data->features & GOBI_NAS)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
-- 
2.45.0


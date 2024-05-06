Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86515B545
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028002; cv=none; b=ID0m5ouJBnpBEs1ym+EMYgLRtLogiwec6ryj6LU8++PmJgYQx6zN6lAH6rhSoC9SJgDU3LUxSbyelKpgEq3muD1lP1BYArzN+KOLz1VqLgAm5zZIv4qLU552ueUwf+UcBoMU8RA3GOq9fU/0kUN17qiV54+h2XPX9aMQ7DGdstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028002; c=relaxed/simple;
	bh=eorzlpp88bYIN8lNEORiwkTjtn+qAQ/4gWi26O2huaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6PTM02Y11zCMIwsNeH9KdIdgruUZBve2zNqhh9GewzYHxZfCUX9Y9Yguxl8sdLudHzSF4RRd7BWDeQh2Yvf/89wUmwTWK9DILbRff7aVUc/4oYZReGDd4VuJoZMbaeKXnk4GRwm/WpVJgeMmXF7EgvOQhozxdXpG0esDxxyVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHJYOzhq; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHJYOzhq"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f0378cd80bso1330193a34.3
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715028000; x=1715632800; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrdHPzhES3q+09uw4lDBYE0WuGrSt8P5mtr9rFvlwJ8=;
        b=DHJYOzhqKylYWoaAX++DlYUVMTJQgzdNQZzQRIT+09EdhPhsvlwbG2Umq5kza0spRg
         xJe3L1yDiuCgP74MOlSR1O2dxsOpb7taEfPvQJ2Q20bWINKkeN2uVTDziWLGKdgVTnZ/
         vmRKB1I3EGzqCBP33dot4jkQG1qbRtewNN6p8zqciv+eJhWSUQVL5+1C0F1X6fYurrnA
         8OlO6O1TInIusLBY+jbCFlHOWFuWSULCWxu8bak/ayoT1YzfS5pj6ieYlyQ/4NwtMjwX
         YnzsrJR+WGMM9UMs38z/mYhTBQojvnvH8abRebml0vjqMf0fcbT7+WRQQCwn603mPA72
         h0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028000; x=1715632800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrdHPzhES3q+09uw4lDBYE0WuGrSt8P5mtr9rFvlwJ8=;
        b=jmzxmk2EBuwQd1NkkIVpwoSvA4LQ5/E06HbzvSwSCXVlR6A7CHSTtzKi8yupF1K76U
         WIoNkzMaUVs6QdKHXrrjoHTicOEXLkQMmWllgpyxJ+gRDAojjwpTK+9H0F1Ow3Z8dndJ
         ezmoiBgGOmmiqUEzmGNAkVxl02OHF+9HImbzOpuR6UjzMu7STjN3PW4AB9XpM4QKjhfO
         0lKAubQ5QlNvm6rkdyTzSNAlXTPgW4NYrUOUIN5VV2jyE0AQ2Y1XFALvPQQD24nqNGX7
         vGUPIkOtbqXD4oZoBal+z89osrPOfo1AVp6ge5b3zxJ2McxjNKhekjV+o7CiHvTmViy9
         h4Pw==
X-Gm-Message-State: AOJu0YzncPFukV/Kr6yV636CVU19ToyjjF936V+s32/lOgIqJZTDAq4u
	szXmgK0KoXK688WSjogRsDOOqPElO9tK4DqwZyLyOh4B3jesXILibjfzHw==
X-Google-Smtp-Source: AGHT+IGgupCU3VL/2I6iAi6I83VrfaZtNX4BLya+u4T2z9Sx4zQamsN/VeWF8gs71zzSIKcf09ThFg==
X-Received: by 2002:a05:6870:818b:b0:23f:eea9:ae35 with SMTP id k11-20020a056870818b00b0023feea9ae35mr2200516oae.41.1715028000068;
        Mon, 06 May 2024 13:40:00 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 8/8] qmi: gprs-context: Obtain initial bearer IP support
Date: Mon,  6 May 2024 15:39:30 -0500
Message-ID: <20240506203952.55806-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506203952.55806-1-denkenz@gmail.com>
References: <20240506203952.55806-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.read_settings is used by the core to setup the network interface for
the initial bearer.  This initial bearer is typically an internet
context, but can be something else, depending on the carrier.  The
initial bearer might also be configured by the network itself, and can
be IPv4, IPv6 or dual stack.  Have the gprs-context driver query the
initial attach parameters to obtain this information, and only then
invoke the WDS Start Network command.

Supporting Dual Stack contexts requires multiple WDS handles to be
allocated, with each handle issuing a Start Network request with a
different IP family preference.  This is currently not supported by the
underlying QMUX/QRTR transport.  For now, choose invoke Start Network
with IPv4 family preference for IPV4 and Dual Stack contexts, and IPv6
famiily preference for IPv6 contexts.
---
 drivers/qmimodem/gprs-context.c | 64 ++++++++++++++++++++++++++++-----
 drivers/qmimodem/wds.h          |  6 ++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 8a40f91d7871..f133eb8682c2 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -282,6 +282,55 @@ error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 
+static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
+{
+	static const uint8_t RESULT_IP_SUPPORT_TYPE = 0x11;
+	struct cb_data *cbd = user_data;
+	ofono_gprs_context_cb_t cb = cbd->cb;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
+	uint8_t iptype;
+	struct qmi_param *param;
+	uint8_t ip_family;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error))
+		goto error;
+
+	if (!qmi_result_get_uint8(result, RESULT_IP_SUPPORT_TYPE, &iptype))
+		goto error;
+
+	switch (iptype) {
+	case QMI_WDS_IP_SUPPORT_IPV4:
+		ip_family = QMI_WDS_IP_FAMILY_IPV4;
+		break;
+	case QMI_WDS_IP_SUPPORT_IPV6:
+		ip_family = QMI_WDS_IP_FAMILY_IPV6;
+		break;
+	case QMI_WDS_IP_SUPPORT_IPV4V6:
+		ip_family = QMI_WDS_IP_FAMILY_IPV4;
+		break;
+	default:
+		goto error;
+	}
+
+	param = qmi_param_new_uint8(QMI_WDS_PARAM_IP_FAMILY, ip_family);
+
+	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, param,
+					start_net_cb, cbd, cb_data_unref) > 0) {
+		cb_data_ref(cbd);
+		return;
+	}
+
+	qmi_param_free(param);
+
+error:
+	data->active_context = 0;
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 /*
  * This function gets called for "automatic" contexts, those which are
  * not activated via activate_primary.  For these, we will still need
@@ -299,18 +348,15 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 
 	DBG("cid %u", cid);
 
-	data->active_context = cid;
-
-	cbd->user = gc;
-
-	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, NULL,
-					start_net_cb, cbd, cb_data_unref) > 0)
+	if (qmi_service_send(data->wds, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
+				NULL, get_lte_attach_param_cb, cbd,
+				cb_data_unref) > 0) {
+		data->active_context = cid;
+		cbd->user = gc;
 		return;
-
-	data->active_context = 0;
+	}
 
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
 	l_free(cbd);
 }
 
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 026402e7a3f6..a308767177a3 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -46,6 +46,12 @@ enum qmi_wds_pdp_type {
 	QMI_WDS_PDP_TYPE_IPV4V6		= 0x03,
 };
 
+enum qmi_wds_ip_support {
+	QMI_WDS_IP_SUPPORT_IPV4		= 0x00,
+	QMI_WDS_IP_SUPPORT_IPV6		= 0x01,
+	QMI_WDS_IP_SUPPORT_IPV4V6	= 0x02,
+};
+
 enum qmi_wds_ip_family {
 	QMI_WDS_IP_FAMILY_UNKNOWN = 0,
 	QMI_WDS_IP_FAMILY_IPV4 = 4,
-- 
2.45.0


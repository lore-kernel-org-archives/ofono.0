Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D13156F43
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565455; cv=none; b=ULeaRV3HAuwoLZ8SpSi+GfuPf8VfQPlcg3jqqJqeV13NbQap3bDtzV/kLcThrgq839p+v6LZaTCz/buLX9VnMqMYClv7+spSiWbsl3ranNkHbFypFLzhCoMwkoIGzk1I1myLivdxdedQzspz9SIVoA+bNCCrSFgR4gaieC4RVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565455; c=relaxed/simple;
	bh=MuAW1WprFYauDCz4XMr9Kc3S07e6qhYMoW7Cy3L/pD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1YqqOzYRgHZ3l1n2QGDFMtej6vwoeHmQXNoxXZ2bFkSei/OzZ41r59KcE99f9triqZk/VauX4abyJn855agc+JzI2yTze89+wVwwQSLjaFFMfQOfIk4DHFG0laa4EZbI9/bRo3BQSGPYEmww+aALBhRKaJsyyRscniOaMrwp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii0hmNiu; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii0hmNiu"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375858224adso21990835ab.0
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565453; x=1721170253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7ZNcA2G06tng7crsSBn2P2yEzjO2BBEK4gyu2rEWUE=;
        b=Ii0hmNiuswcXN3a5d7QRKNUSBz9d1jCxnBXYxinXYC/puHxDCSUQR8PizpK+tJt6PK
         DEz+uyzM1Unevz6/z6GHNWDdRHsla0e5OKtinSxfektmHjLY7a7LzNd5Cv6gseDMKvoj
         5emUnWurg275tBu3hm233ecNISuJhgJPDJSsSZWMUI+dOYShQbX8R5o1VJlkz/YCDvMv
         6kX2nK+yrwUc2k/SewPHqq+ObX1p80BpyzAU2OvMMqCJ46l3jAB25WS1dh9FKfJZ7XNy
         ZbGUkfxw+/4NaycYTStcOqQ+kHeHsmhvHltWD4g0GuNxvmJIvP2qZr4o2aD8I+G4HFzJ
         7dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565453; x=1721170253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7ZNcA2G06tng7crsSBn2P2yEzjO2BBEK4gyu2rEWUE=;
        b=aEuul9oKbNOw6ZSu8McoVb+6Un0OM5NCEUKKIUTsM/wHos9EDRiYUFkanS7cCEi8q0
         jgsTsxupj1K5Wyk5ggpRRXg7q1RnRjNc8E0yaJvtbQNrHDXZWmdl0UVYd9YNEHW6X3kK
         WWawbSLghdTalzBAgGb5wVe4CPOIxJR/Nxc1UnpZpPt9YeMBoSQfCMJUr2MfG5zAMsJu
         a23O6DQK3NWEbpEWnQQGqgahYh7FB9IZ0nwBW+Xlv3I4jJRtqarLIdnAyKg+UDlx5gdZ
         XNrSCDxx5OPHyFb58J4DNUxRPPsb0hmZQtqXdBAW1/VWkAZXgyWNDNVH3CPTMPzSM5zm
         9g6A==
X-Gm-Message-State: AOJu0YzT0bkp6ODARc8zAxGPoQ31jZKtlZHmZHv5GZPkh1QM+scDd0c6
	O4e04T+poUXx4rxXEQ5uQsf8xBtvAi9W4cpea/Zs4b7+HIAnT93HI1vfNA==
X-Google-Smtp-Source: AGHT+IE0nrdga+iJ2KqvRYbhrsT561ktkHRTK4kwjbtczZ5/UJAU6aCfpByqu1hqch9NhgivK4HcAA==
X-Received: by 2002:a92:c54f:0:b0:375:c240:e7a6 with SMTP id e9e14a558f8ab-38a5a0798b7mr40247165ab.24.1720565453092;
        Tue, 09 Jul 2024 15:50:53 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/11] qmi: gprs-context: Set up WDS service for IPv6
Date: Tue,  9 Jul 2024 17:50:27 -0500
Message-ID: <20240709225047.1427626-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709225047.1427626-1-denkenz@gmail.com>
References: <20240709225047.1427626-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track and take ownership of the passed in WDS service meant for IPv6
connectivity.  The WDS service should be bound to a particular
endpoint / mux_id and register to the same indication types as the
other WDS service being utilized.

Additionally, WDS services are created with IPv4 as the default family
preference.  To support dual-stack bearers, the WDS service managing
IPv6 requires 'Set IP Family Preference' command to be issued with the
IPv6 family preference set.
---
 drivers/qmimodem/gprs-context.c | 51 ++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 203a320a42af..131358aa112b 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -22,6 +22,7 @@
 
 struct gprs_context_data {
 	struct qmi_service *wds;
+	struct qmi_service *ipv6;
 	unsigned int active_context;
 	uint32_t pkt_handle;
 	uint8_t mux_id;
@@ -454,6 +455,37 @@ static void qmi_gprs_context_detach_shutdown(struct ofono_gprs_context *gc,
 	qmi_deactivate_primary(gc, cid, NULL, NULL);
 }
 
+static void set_ip_family_preference_cb(struct qmi_result *result,
+							void *user_data)
+{
+	struct ofono_gprs_context *gc = user_data;
+	uint16_t error;
+
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
+
+	DBG("%u", error);
+
+	if (error)
+		ofono_gprs_context_remove(gc);
+}
+
+static int set_ip_family_preference(struct ofono_gprs_context *gc,
+						struct qmi_service *wds,
+						uint8_t family)
+{
+	static const uint8_t PARAM_IP_FAMILY_PREFERENCE = 0x1;
+	struct qmi_param *param =
+			qmi_param_new_uint8(PARAM_IP_FAMILY_PREFERENCE, family);
+
+	if (qmi_service_send(wds, QMI_WDS_SET_IP_FAMILY, param,
+				set_ip_family_preference_cb, gc, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
 static void bind_mux_data_port_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_gprs_context *gc = user_data;
@@ -547,22 +579,38 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 	_auto_(qmi_service_free) struct qmi_service *ipv6 =
 					va_arg(args, struct qmi_service *);
 	struct gprs_context_data *data;
+	int r;
 
 	DBG("");
 
 	if (mux_id != -1) {
-		int r = qmi_gprs_context_bind_mux(gc, ipv4, mux_id);
+		r = qmi_gprs_context_bind_mux(gc, ipv4, mux_id);
+		if (r < 0)
+			return r;
 
+		r = qmi_gprs_context_bind_mux(gc, ipv6, mux_id);
 		if (r < 0)
 			return r;
 	}
 
+	/*
+	 * Default family preference for new WDS services is IPv4.  For the
+	 * service used for IPv6 contexts, issue a SET_IP_FAMILY_PREFERENCE
+	 * command
+	 */
+	r = set_ip_family_preference(gc, ipv6, QMI_WDS_IP_FAMILY_IPV6);
+	if (r < 0)
+		return r;
+
 	data = l_new(struct gprs_context_data, 1);
 	data->wds = l_steal_ptr(ipv4);
+	data->ipv6 = l_steal_ptr(ipv6);
 	data->mux_id = mux_id;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
 					pkt_status_notify, gc, NULL);
+	qmi_service_register(data->ipv6, QMI_WDS_PACKET_SERVICE_STATUS,
+					pkt_status_notify, gc, NULL);
 
 	ofono_gprs_context_set_data(gc, data);
 
@@ -578,6 +626,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 	ofono_gprs_context_set_data(gc, NULL);
 
 	qmi_service_free(data->wds);
+	qmi_service_free(data->ipv6);
 	l_free(data);
 }
 
-- 
2.45.2


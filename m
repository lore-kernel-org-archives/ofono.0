Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09847168AF6
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605710; cv=none; b=Cg/q5HFaOGgXYCJ/h2bLbmwd0IgasuanmdmYznvtnJOJMiP4zD8dl69bpRviz5+dpWehyYdtlyJXYmJ1oP9NkfHr3rGBq42XMvWw31Ij/EhJ21rx6eL5uty7QYZWYntfL/tqiVNLGYtx60dxO0NTNqrv5ljwJO0uFzGF0kaY5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605710; c=relaxed/simple;
	bh=P3z5ElUn7xNmU6UohQAVMUt7DdCV5olvYS3dfYN6334=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjpMHGZg6T4SuohRLd3SOKDnrj2Hc7U6BQSdKSAbmuBJ13mM8vYimavhTO0oqbYLNvDS4tByp1a7kjV+183Jauc/11gEGuLHGmyl9DPhL7NuZ3NR5bMPQ0d/QkadXOt5mcIkPXjA/3t6LHW1FLfbWoyTocOCYT0csjhTdWsWo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVtH/ssH; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVtH/ssH"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee2fda66easo1983076a34.3
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605708; x=1715210508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZjTlxNRGudk/6QpIkbXwD+L/r4fvBdLywaY209hNh8=;
        b=NVtH/ssH4teeI03p3kcCDMJJ9tF6WSTUC++TAEYsAGZsiya5P2czycFQa9OWVRYD7/
         Wx/keUomrjkikfth6MC8ezwFe3Ux7DujsKyIfgn73oPM2FDu4BqA1i/RkR9dkjEgyc6X
         3fyR8ousghf+3waLQ5+jCwES6birKSaoHqk2AkreqsBoe1IcB7DRtKf5moufWKL0nHT8
         Nqom35p11KI/jqUoPEyyK8kOJMGc2ZPNVGaYdnpRn3b4g+PinGL9vDA7uLH7MEiFLlxU
         4xO74lgmAzeRi/Aplth3XuFSMefiq5psq3kKHTsXQ32WImU8l1+lzgOPo5aSrr8xNqDs
         Sq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605708; x=1715210508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZjTlxNRGudk/6QpIkbXwD+L/r4fvBdLywaY209hNh8=;
        b=CePlADJ/2jJ79yGPuV2ufRP/DFs+xqaC1rrbvd9LAWcJx5O6vIT0R70UH1XABShDdC
         s9Sr08rPi5pB2MFdD93oUAAyPcQtOrHf96mPU9eP8ejZaXIs54Ve5ajbFqrngOG+y9Xk
         cVLpEh9YIfCHfgcp875/nWRya0/2vJoBOxEvpXrbo9GldLUuVGK+JHm5yqXyT8Yqt3NC
         /K5McMH1R5msNNzAGvJKmAdAzAX9ZeuQSTYhboxKZ1x7M51wDB+0VDReqectpmAS5CAr
         S0WSn5F4pN0Y88m/OE5GM8hhmsBM+wtma5MfWGuf0bV0s6ZGJWQzjvmyE7eFzm01ZtyD
         CQPQ==
X-Gm-Message-State: AOJu0YwN30Keiils1HpK4pN4yfN3BEXKOVTM7ERBshmS7qCx21oiFpGU
	v5yWOMaFhCbEM1cREJZON+Myg/ZdRBUex4IKu7rtaK3fInsx1CVIO6syaQ==
X-Google-Smtp-Source: AGHT+IEZWt+hEThiQ4xZbOYeORHYVoRvoiUQ/Usq1xiiYrooWxgjRvMdKUiy2ctWUzy3Ji3w6PzHxg==
X-Received: by 2002:a05:6830:6c0a:b0:6ee:575b:8dd5 with SMTP id ds10-20020a0568306c0a00b006ee575b8dd5mr481721otb.20.1714605707982;
        Wed, 01 May 2024 16:21:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830278b00b006ee4e216d02sm1128040otu.14.2024.05.01.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:21:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/6] qmi: gprs: register and listen to event reports
Date: Wed,  1 May 2024 18:21:30 -0500
Message-ID: <20240501232144.14025-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501232144.14025-1-denkenz@gmail.com>
References: <20240501232144.14025-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mostly useful to obtain inter and intra RAT changes, data bearer
changes, data transfer statistics, etc.
---
 drivers/qmimodem/gprs.c | 88 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index dbd461731d94..ebbef4475120 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -184,6 +184,13 @@ static void ss_info_notify(struct qmi_result *result, void *user_data)
 		ofono_gprs_status_notify(gprs, status);
 }
 
+static void event_report_notify(struct qmi_result *result, void *user_data)
+{
+	DBG("");
+
+	qmi_result_print_tlvs(result);
+}
+
 static void attach_detach_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
@@ -275,6 +282,74 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
+static void set_event_report_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("set_event_report_cb: %hd", error);
+		goto error;
+	}
+
+	/*
+	 * First get the SS info - the modem may already be connected,
+	 * and the state-change notification may never arrive
+	 */
+	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
+					ss_info_notify, gprs, NULL);
+
+	ofono_gprs_register(gprs);
+	return;
+error:
+	ofono_gprs_remove(gprs);
+}
+
+static int set_event_report_request(struct ofono_gprs *gprs)
+{
+	static const uint8_t PARAM_CHANNEL_RATE = 0x10;
+	static const uint8_t PARAM_TRANSFER_STATISTICS = 0x11;
+	static const uint8_t PARAM_DATA_BEARER_TECHNOLOGY = 0x12;
+	static const uint8_t PARAM_DORMANCY_STATUS = 0x13;
+	static const uint8_t PARAM_CURRENT_DATA_BEARER_TECHNOLOGY = 0x15;
+	static const uint8_t PARAM_PREFERRED_DATA_SYSTEM = 0x18;
+	static const uint8_t PARAM_DATA_SYSTEM_STATUS = 0x1A;
+	static const uint8_t PARAM_LIMITED_DATA_SYSTEM_STATUS = 0x1C;
+	static const uint8_t PARAM_PDN_FILTER_REMOVALS = 0x1D;
+	static const uint8_t PARAM_DATA_BEARER_TECHNOLOGY_EXTENDED = 0x1E;
+
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct {
+		uint8_t interval;
+		uint32_t indicators;
+	} __attribute((packed)) ts = {
+		.interval = 5,
+		.indicators = ~0, /* register for everything */
+	};
+	struct qmi_param *param = qmi_param_new();
+
+	qmi_param_append_uint8(param, PARAM_CHANNEL_RATE, 1);
+	qmi_param_append(param, PARAM_TRANSFER_STATISTICS, sizeof(ts), &ts);
+	qmi_param_append_uint8(param, PARAM_DATA_BEARER_TECHNOLOGY, 1);
+	qmi_param_append_uint8(param, PARAM_DORMANCY_STATUS, 1);
+	qmi_param_append_uint8(param, PARAM_CURRENT_DATA_BEARER_TECHNOLOGY, 1);
+	qmi_param_append_uint8(param, PARAM_PREFERRED_DATA_SYSTEM, 1);
+	qmi_param_append_uint8(param, PARAM_DATA_SYSTEM_STATUS, 1);
+	qmi_param_append_uint8(param, PARAM_LIMITED_DATA_SYSTEM_STATUS, 1);
+	qmi_param_append_uint8(param, PARAM_PDN_FILTER_REMOVALS, 1);
+	qmi_param_append_uint8(param, PARAM_DATA_BEARER_TECHNOLOGY_EXTENDED, 1);
+
+	if (qmi_service_send(data->wds, QMI_WDS_EVENT_REPORT,
+				param, set_event_report_cb, gprs, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
 static void get_default_profile_number_cb(struct qmi_result *result,
 								void *user_data)
 {
@@ -300,15 +375,8 @@ static void get_default_profile_number_cb(struct qmi_result *result,
 	data->default_profile = index;
 	ofono_gprs_set_cid_range(gprs, index, index);
 
-	/*
-	 * First get the SS info - the modem may already be connected,
-	 * and the state-change notification may never arrive
-	 */
-	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
-					ss_info_notify, gprs, NULL);
-
-	ofono_gprs_register(gprs);
-	return;
+	if (set_event_report_request(gprs) >= 0)
+		return;
 error:
 	ofono_gprs_remove(gprs);
 }
@@ -353,6 +421,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 	}
 
 	data->wds = service;
+	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
+				event_report_notify, gprs, NULL);
 
 	if (get_default_profile_number_request(gprs) >= 0)
 		return;
-- 
2.44.0


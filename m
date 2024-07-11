Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A54381AD
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716425; cv=none; b=iJlAiraSC/PYKPx3UwwPG/0z3tpP9laZGqz7y8iDmT48q+ZHBEb/ep8H5xjH1U6PZwPo7ylYjlY3moc9VRP0EgvthHNyCQDG5Wknn+hNzlknK1w3cd13GnRR7Af/WD8tr6kGwFAdf/3MlDkxfzx86Ufk5PgMRAj/PycgG9HXyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716425; c=relaxed/simple;
	bh=kDr1xsnUxUtjM3I9IlmL9vxIjJLhnalxNLEmIJVSIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSGevZxsa/Q6yBQtcb9WFbT6CHjiGAlZGhKsndO8zbe6cooNMFBo+j6mVHE91d2D7rSS4ZgjDiCsILRPKS5CUwQrc8JQdO7EUaBZN5AvmgTVYGBu5got7LlqZIojgROSMZrfxDsStwKFswV5FyyKB+vGlgxMnjoU3vs2UxjTRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKioo9F+; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKioo9F+"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8076f64774eso18604939f.0
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716423; x=1721321223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulFCqB4rLETVs0UZnS7S1sOnvERefdoHgf1++l0WEJM=;
        b=kKioo9F+H9vVD5RhqeTvjS5w8J6kjZfcy6cXBuDJPBDcf9W3S3g84NH4SRFNPSnE3h
         Oi66Y3GHieampD0FkQdw12GVlEnixtC+6jL649e5Zi7bWYK2j75tVhh21XUvalzANlne
         T1R2EkTNr995ZARhj2Kt3j96U9K5RLpKrI4AvGMMA9bk3z6JTcFsr8CbGX/rvkmoAzNZ
         gzDNBfAtBIfGJpcQhoFR42jvCNoUd6NOOvZcqOa3SO7GPriNOAz7fGylbdcg7BjNKFl2
         B+iFjeuuWl23sQzqdQ3syyKLh3+cluqwwbrqVtlOJGBQUP3bvQ4+BLyoErKHMvNymWQp
         8YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716423; x=1721321223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulFCqB4rLETVs0UZnS7S1sOnvERefdoHgf1++l0WEJM=;
        b=Lyi1/Bh+N24nL6kV9Lwf2Di9/Z2D+s/jtpSeqT+/Ug4krXaQD/FS1MQxbquTPb2Jpn
         kLXvqDJrVaw/IdOT/FN44Ma5xCSH0z6x4yBLPJQpV5wVez7ergTsOqhj/jJxQd+cufUX
         +vFreWGfDLxBU02xvKc+O2ueNuOSkGXzo/20hN3JF/J9RAJNAFO+QGxfFxYCSa0u7HAX
         JzmFV4tZH3Y/UCqOjTMr2EPgThqB6Z8YlP76f1GAdE/KS7+UKxNwi/bNs7kyGJ4Q0Qrn
         cgkWipTgzCwybQtcmudfVJXWkhnAVb9y/uI6AOHHntARufHa81Nz1W+MsyyR+PlX/0o5
         BR5A==
X-Gm-Message-State: AOJu0YzL9mhhrXN8gYsmfaFC9xojKIglY4SmGXlTf5zLlPHUmi4b4PXf
	NvuVD0g5IgIpE6udTXCdKcZ4K3j/fkdr2O8qk/wn5rMEwCs4w9yL62gf9g==
X-Google-Smtp-Source: AGHT+IEvoyF4rdY+XJI4qxOYSb+LEx8ornErRxTTVA30fP1XS99+akgmxOG6NT0b2wFuC3Jl5iverw==
X-Received: by 2002:a05:6602:2568:b0:803:1d26:d359 with SMTP id ca18e2360f4ac-8031d26d794mr946381539f.12.1720716423109;
        Thu, 11 Jul 2024 09:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/11] qmi: gprs-context: Set up WDS service for IPv6
Date: Thu, 11 Jul 2024 11:46:28 -0500
Message-ID: <20240711164654.1688558-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
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
index 203a320a42af..456f46ead6d5 100644
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
+	static const uint8_t PARAM_IP_FAMILY_PREFERENCE = 0x01;
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


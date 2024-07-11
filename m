Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BB16D4DF
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716585; cv=none; b=fX5kAzbkK4tmQ1cTuMmP8Nax/zx7fYrefkixdxAXh61GjJRWZp5PpuETSdd1Ywm77N9SZv0YhNNswrJ6LMVcRj4zon/o98dWidh0+Cpn3MIHZHAdGUU8ZH0LOBTw5/KFTG4/dluhqeRZImVcrXIaky5MAP7w2LxQyRSzni51LCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716585; c=relaxed/simple;
	bh=kDr1xsnUxUtjM3I9IlmL9vxIjJLhnalxNLEmIJVSIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evLQ5BNksQkNud1IuW19TtkW8ExadHYlus/IBhyONCaDBYklQLSHN4/k/vnDSin28vCCldGVrxbGVr/MforQXRssewRTPjYiWsyPaCodi8R9+ltBgDdwksQdBCEOgCmbekYTQRIkODUsmIEexsOz6r02EC3uaA+ntCV6J5HS+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9Kn3EAI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Kn3EAI"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70388567d24so626197a34.0
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716583; x=1721321383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulFCqB4rLETVs0UZnS7S1sOnvERefdoHgf1++l0WEJM=;
        b=B9Kn3EAIrlBR/Jm9f/ji/GE5O2K9VydI8Zy3K18VgJnvPGteEarV/D9u87GLodwGm2
         PWhqzladh2QbzRCGpa32vQAr/9YKnrjyF9NE6tIURcA8jdLAlFzY/e8vGsRNlCyG5lap
         rzgcfDMol0GB+Y0JwNVVDSzDMezRORj7jIQ3oxc/0oG25j/Ge9rRJfspQPlcAzajlRwt
         47Cl6AQNHNzVYYiVImI6UFmYq5N5jLV1L6i+6iEnwehsIK75BFRgpiCB2a3CXrGsbfuG
         48thXlXxAiZn8Ab9YKKujsqPKRZfVqdjgCzLIBIqR4O53TcuK9U965C/yyx6deDl4TRO
         6J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716583; x=1721321383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulFCqB4rLETVs0UZnS7S1sOnvERefdoHgf1++l0WEJM=;
        b=PbfR+0jvI0cWpP19JRAkzPUWtCAzcLkkUAECyi9aS5c58ytT9BDM+dqK3clH3aiF7V
         UHhpYmtg8nEu/RuS6dCGgfd/VZIREUgkbYDAKm/RFtDU2peGqVQuSK+b4PBvJFpTqHfJ
         4wTnYYiXadUQrnxKZf+mgrN2WDmJjuz9rcI0ZBcql6Rb4HsDBj1pkhJQQ0DB7fRsJZ4Y
         Dll15mwpjB/XEFL2o9bi5L+XP0mMv8/JmkrLALiOdN5yGCw1ZGjaziFAg4AU679QU5UI
         BkShIpsRS5dHzM36tDwOCSB8wleTpZ68uUT1PeQzqkFItQgwF6b9NFKFp+J/kGg+upIy
         qI1g==
X-Gm-Message-State: AOJu0YxuJHwb2q7Tp7XLqWsrXfLy7qCetFHpI7RgBPAwOzD4rRIiUHGu
	ECVKLwRJP5G59OIYOIN4OZW0tGwUM6exwkS9rc+iRsyQBOuPt2078GfCiA==
X-Google-Smtp-Source: AGHT+IEoOtmHk4spjTpbCvqHnhbvC8AZz9pD+DNXCs2qTO0eTymnOrGT4n6nCzTgAkVluuszTxZUPw==
X-Received: by 2002:a05:6830:1e99:b0:703:6847:3ab8 with SMTP id 46e09a7af769-70375a45ca7mr9959994a34.25.1720716583374;
        Thu, 11 Jul 2024 09:49:43 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/11] qmi: gprs-context: Set up WDS service for IPv6
Date: Thu, 11 Jul 2024 11:49:30 -0500
Message-ID: <20240711164936.1688973-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164936.1688973-1-denkenz@gmail.com>
References: <20240711164936.1688973-1-denkenz@gmail.com>
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


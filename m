Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5E16D4DF
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716588; cv=none; b=tff2Hdh0fWXKQjP6d3lH4h2OsVh5JL2ZG3wYuuyMlEhBSzlO+hpb7kHCWa8iuBml5EJv6FLvgVyb3TSnmR/vFZtrLcUwGhcU5EvAXA9oR6Bmphg6uf99f1QJDPrACf0QqsnQUNh92qfQ/mTuFMtA5iREAKcQBPYP7zMIM7JUODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716588; c=relaxed/simple;
	bh=df43SoDfw6AYWnDD9dDCrCpJ77gJAH8rr/24mcl08A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi4ZDxTCiGX1BY4FujjyDgKxIy5Mj5CcMdUdtwIjqRAl1SiWEjvwUhPWXae6BFDaHRZ21ogiAFIxTWEBjcLMgJCwNMhF349enhYWPlBhkSwVXPyqI6flW8pm9Q4cusfUB70djqQj/kA0fZs/ohh5C2XZNP/cYjpPvh/Jf8XuJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLqWUA09; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLqWUA09"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d6301e7279so663887b6e.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716586; x=1721321386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7y5oDOtmsbXllu5bhw8YrwObtC5/6CUGeA3EBR4tHM=;
        b=CLqWUA09YPi+aQ9RKp2YKxhIGjQIUVYaDC9W7+uZ8RjVXVnD0iohrldsUEDfVUG4XN
         8/ol+eXQyIDoFKBC35TL+N9BxjO4eWylhdGp/CTQDXzBolOmJq3fixsFmTGe2+0ZZAfo
         gw6Imq/GYModN0i3EvQgGb7bZHjcEAIyGGsSBrKE3B60gaV/UJRCkOmHrQILiSHgi+4X
         eXmoYDPJ9f1i2QzHzlscSE4iHIQmsfpIsAE33GBBlOywZSqT9dTTRogQrmPKBB4PjRn8
         rxtIUMZ/r4m1AFe6gOhWL+zsr8IsCLTDcpm0XMNcqLRh4gC8KgO37Tu+ZZjM5U7vmqKt
         X3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716586; x=1721321386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7y5oDOtmsbXllu5bhw8YrwObtC5/6CUGeA3EBR4tHM=;
        b=DTUXBrV/XY7+0MtZnc5DaV86H5vgiLl72VQlAhq3cqoZI6Ld/7XF3c/xCD2U598uay
         HfuwtbFcupKAWh5U32MP0TZVwzvMRB1aKy9/ga93SkIGmMf3haelAd+Ar8b5Faykf1DD
         mWeuvKxdlt34ZOnVWaANLP6pQHWGhVz0BGHLOKsuQSUdlgHBusNHRVxa7iZdV77oCTO7
         mz0TwvXSCF3Ri/Dj8qTdoBFgLvLFBOSuGRv4PdO62vHssfPenZppPHUO8g1s35KtCvdF
         tjgAfHT/TQSVwRoNl5+LzL9JNxcEkdJjIIqGKgkXChjFCv/KbBzs0X4sPD8SfiPhF9n3
         LjyQ==
X-Gm-Message-State: AOJu0YxVq0vMQKEYQBio5nwrkATLd8Hv7i2JcQSI8TuBWK1cfGfSCQNm
	fKM866KO2DrBAzG6FBQAvgOd3VF+jYhy4rH7DSOB0dYjLg2uLAJjDuarpQ==
X-Google-Smtp-Source: AGHT+IEo2K7/3tp9ZoVq1FZbr8FP2XwNEmJpumSYBFocaXOhN5TZtukwjhcgRG/67+ZTpa/AFT2OUQ==
X-Received: by 2002:a05:6808:10c5:b0:3d5:6728:74ae with SMTP id 5614622812f47-3d93c0cb369mr10672264b6e.56.1720716585557;
        Thu, 11 Jul 2024 09:49:45 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/11] qmi: gprs-context: Dual-Stack context activation support
Date: Thu, 11 Jul 2024 11:49:33 -0500
Message-ID: <20240711164936.1688973-11-denkenz@gmail.com>
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

Support dual-stack contexts by utilizing two WDS services, one for each
family type.  For IPv4 only contexts, the WDS service 'ipv4' is used.
For IPv6 only contexts, the WDS service 'ipv6' is used.  For dual stack
contexts, both WDS services are used simultaneously.

When a default bearer (using read_settings) or primary context is
activated (using activate_primary), the Start Network command is issued
on one or both of the WDS services.  Once the Start Network command
succeeds, the returned packet handle is stored in 'packet_handle_ipv4'
or 'packet_handle_ipv6', depending on the selected IP family.
Subsequently Get Current Settings command is issued and settings are
read from the QMI response and applied to the context.  Success is
signaled to the core if at least one Start Network command succeeded.
Otherwise, an error is signaled.
---
 drivers/qmimodem/gprs-context.c | 364 ++++++++++++++++++++------------
 1 file changed, 228 insertions(+), 136 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 6061de0a483d..89d68d154ed8 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -26,6 +26,8 @@ struct gprs_context_data {
 	unsigned int active_context;
 	uint32_t packet_handle_ipv4;
 	uint32_t packet_handle_ipv6;
+	uint32_t start_network_ipv4_id;
+	uint32_t start_network_ipv6_id;
 	uint8_t mux_id;
 };
 
@@ -67,23 +69,49 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 
 	switch (status->status) {
 	case QMI_WDS_CONNECTION_STATUS_DISCONNECTED:
-		if (data->packet_handle_ipv4) {
+		if (ip_family == QMI_WDS_IP_FAMILY_IPV4 &&
+				data->packet_handle_ipv4) {
 			data->packet_handle_ipv4 = 0;
 			check_all_deactivated(gc);
 		}
 
+		if (ip_family == QMI_WDS_IP_FAMILY_IPV6 &&
+				data->packet_handle_ipv6) {
+			data->packet_handle_ipv6 = 0;
+			check_all_deactivated(gc);
+		}
+
 		break;
 	}
 }
 
-static void get_settings_ipv6(struct ofono_gprs_context *gc,
-					struct qmi_result *result)
+static void check_all_activated(struct gprs_context_data *data,
+					ofono_gprs_context_cb_t cb,
+					void *user_data)
+{
+	if (data->start_network_ipv4_id || data->start_network_ipv6_id)
+		return;
+
+	if (!data->packet_handle_ipv4 && !data->packet_handle_ipv6) {
+		data->active_context = 0;
+		CALLBACK_WITH_FAILURE(cb, user_data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, user_data);
+}
+
+static void get_settings_ipv6_cb(struct qmi_result *result, void *user_data)
 {
 	static const uint8_t RESULT_IP_ADDRESS = 0x25;
 	static const uint8_t RESULT_GATEWAY = 0x26;
 	static const uint8_t RESULT_PRIMARY_DNS = 0x27;
 	static const uint8_t RESULT_SECONDARY_DNS = 0x28;
 	static const uint8_t RESULT_MTU = 0x29;
+	struct cb_data *cbd = user_data;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
 	const char *dns[3] = { NULL, NULL, NULL };
 	char dns1str[INET6_ADDRSTRLEN];
 	char dns2str[INET6_ADDRSTRLEN];
@@ -92,6 +120,13 @@ static void get_settings_ipv6(struct ofono_gprs_context *gc,
 	uint16_t len;
 	uint32_t mtu;
 
+	data->start_network_ipv6_id = 0;
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("error: %u", error);
+		goto done;
+	}
+
 	tlv = qmi_result_get(result, RESULT_IP_ADDRESS, &len);
 	if (tlv && len == sizeof(struct in6_addr) + 1) {
 		const struct in6_addr *ip = tlv;
@@ -131,22 +166,35 @@ static void get_settings_ipv6(struct ofono_gprs_context *gc,
 
 	if (qmi_result_get_uint32(result, RESULT_MTU, &mtu))
 		DBG("MTU: %u", mtu);
+
+done:
+	check_all_activated(data, cbd->cb, cbd->data);
 }
 
-static void get_settings_ipv4(struct ofono_gprs_context *gc,
-					struct qmi_result *result)
+static void get_settings_ipv4_cb(struct qmi_result *result, void *user_data)
 {
 	static const uint8_t RESULT_PRIMARY_DNS = 0x15;
 	static const uint8_t RESULT_SECONDARY_DNS = 0x16;
 	static const uint8_t RESULT_IP_ADDRESS = 0x1e;
 	static const uint8_t RESULT_GATEWAY = 0x20;
 	static const uint8_t RESULT_GATEWAY_NETMASK = 0x21;
+	struct cb_data *cbd = user_data;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
 	uint32_t ip_addr;
 	struct in_addr addr;
 	char* straddr;
 	const char *dns[3] = { NULL, NULL, NULL };
 	char dns_buf[2][INET_ADDRSTRLEN];
 
+	data->start_network_ipv4_id = 0;
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("error: %u", error);
+		goto done;
+	}
+
 	if (qmi_result_get_uint32(result, RESULT_IP_ADDRESS, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		straddr = inet_ntoa(addr);
@@ -182,65 +230,20 @@ static void get_settings_ipv4(struct ofono_gprs_context *gc,
 
 	if (dns[0])
 		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
-}
-
-static void get_settings_cb(struct qmi_result *result, void *user_data)
-{
-	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
-	struct cb_data *cbd = user_data;
-	ofono_gprs_context_cb_t cb = cbd->cb;
-	struct ofono_gprs_context *gc = cbd->user;
-	uint8_t ip_family;
-
-	DBG("");
-
-	if (qmi_result_set_error(result, NULL))
-		goto done;
-
-	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family)) {
-		ofono_error("No IP family in results");
-		goto done;
-	}
-
-	switch (ip_family) {
-	case QMI_WDS_IP_FAMILY_IPV4:
-		get_settings_ipv4(gc, result);
-		break;
-	case QMI_WDS_IP_FAMILY_IPV6:
-		get_settings_ipv6(gc, result);
-		break;
-	default:
-		break;
-	}
 
 done:
-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	check_all_activated(data, cbd->cb, cbd->data);
 }
 
-static void start_net_cb(struct qmi_result *result, void *user_data)
+static uint32_t send_get_current_settings(struct qmi_service *wds,
+						qmi_service_result_func_t func,
+						void *user_data,
+						qmi_destroy_func_t destroy)
 {
-	static const uint8_t RESULT_PACKET_HANDLE = 0x01;
 	static const uint8_t PARAM_REQUESTED_SETTINGS = 0x10;
-	struct cb_data *cbd = user_data;
-	ofono_gprs_context_cb_t cb = cbd->cb;
-	struct ofono_gprs_context *gc = cbd->user;
-	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
-	uint32_t handle;
 	uint32_t requested_settings = 0;
 	struct qmi_param *param;
-
-	DBG("");
-
-	if (qmi_result_set_error(result, NULL))
-		goto error;
-
-	if (!qmi_result_get_uint32(result, RESULT_PACKET_HANDLE, &handle))
-		goto error;
-
-	DBG("packet handle %d", handle);
-
-	data->packet_handle_ipv4 = handle;
-
+	uint32_t id;
 	/*
 	 * Explicitly request certain information to be provided.  The requested
 	 * settings is a bit field, with each bit representing whether the
@@ -254,18 +257,149 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 	L_BITS_SET(&requested_settings, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 17);
 	param = qmi_param_new_uint32(PARAM_REQUESTED_SETTINGS,
 						requested_settings);
+	id = qmi_service_send(wds, QMI_WDS_GET_CURRENT_SETTINGS, param,
+				func, user_data, destroy);
+
+	if (!id)
+		qmi_param_free(param);
+
+	return id;
+}
+
+static void start_network_common_cb(int family, struct qmi_result *result,
+					struct cb_data *cbd,
+					struct qmi_service *wds,
+					qmi_service_result_func_t func,
+					uint32_t *packet_handle,
+					uint32_t *family_start_id)
+{
+	static const uint8_t RESULT_PACKET_HANDLE = 0x01;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
+
+	*family_start_id = 0;
 
-	if (qmi_service_send(data->ipv4, QMI_WDS_GET_CURRENT_SETTINGS, param,
-				get_settings_cb, cbd, cb_data_unref) > 0) {
-		cb_data_ref(cbd);
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
+
+	DBG("family: %d, error: %u", family, error);
+
+	if (error)
+		goto error;
+
+	if (!qmi_result_get_uint32(result, RESULT_PACKET_HANDLE, packet_handle))
+		goto error;
+
+	*family_start_id =
+		send_get_current_settings(wds, func,
+						cb_data_ref(cbd), cb_data_unref);
+	if (*family_start_id)
 		return;
+
+	*packet_handle = 0;
+	cb_data_unref(cbd);
+error:
+	check_all_activated(data, cbd->cb, cbd->data);
+}
+
+static void start_network_ipv4_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+
+	start_network_common_cb(4, result, user_data,
+				data->ipv4, get_settings_ipv4_cb,
+				&data->packet_handle_ipv4,
+				&data->start_network_ipv4_id);
+}
+
+static void start_network_ipv6_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+
+	start_network_common_cb(6, result, user_data,
+				data->ipv6, get_settings_ipv6_cb,
+				&data->packet_handle_ipv6,
+				&data->start_network_ipv6_id);
+}
+
+static struct qmi_param *param_from_context(uint8_t ip_family,
+				const struct ofono_gprs_primary_context *ctx)
+{
+	struct qmi_param *param = qmi_param_new();
+	uint8_t auth;
+
+	qmi_param_append_uint8(param, QMI_WDS_PARAM_IP_FAMILY, ip_family);
+
+	if (!ctx)
+		goto done;
+
+	qmi_param_append(param, QMI_WDS_PARAM_APN,
+					strlen(ctx->apn), ctx->apn);
+
+	auth = qmi_wds_auth_from_ofono(ctx->auth_method);
+	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
+					auth);
+
+	if (auth && ctx->username[0] != '\0')
+		qmi_param_append(param, QMI_WDS_PARAM_USERNAME,
+					strlen(ctx->username), ctx->username);
+
+	if (auth && ctx->password[0] != '\0')
+		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
+					strlen(ctx->password), ctx->password);
+done:
+	return param;
+}
+
+static int start_network(uint8_t iptype, struct gprs_context_data *data,
+				const struct ofono_gprs_primary_context *ctx,
+				struct cb_data *cbd)
+{
+	struct qmi_param *param;
+
+	if (!L_IN_SET(iptype, QMI_WDS_IP_SUPPORT_IPV4, QMI_WDS_IP_SUPPORT_IPV6,
+				QMI_WDS_IP_SUPPORT_IPV4V6))
+		return -EINVAL;
+
+	if (iptype == QMI_WDS_IP_SUPPORT_IPV4 ||
+			iptype == QMI_WDS_IP_SUPPORT_IPV4V6) {
+		param = param_from_context(QMI_WDS_IP_FAMILY_IPV4, ctx);
+
+		data->start_network_ipv4_id =
+			qmi_service_send(data->ipv4, QMI_WDS_START_NETWORK,
+					param, start_network_ipv4_cb,
+					cb_data_ref(cbd), cb_data_unref);
+
+		if (!data->start_network_ipv4_id) {
+			cb_data_unref(cbd);
+			qmi_param_free(param);
+		}
 	}
 
-	qmi_param_free(param);
+	if (iptype == QMI_WDS_IP_SUPPORT_IPV6 ||
+			iptype == QMI_WDS_IP_SUPPORT_IPV4V6) {
+		param = param_from_context(QMI_WDS_IP_FAMILY_IPV6, ctx);
 
-error:
-	data->active_context = 0;
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+		data->start_network_ipv6_id =
+			qmi_service_send(data->ipv6, QMI_WDS_START_NETWORK,
+					param, start_network_ipv6_cb,
+					cb_data_ref(cbd), cb_data_unref);
+
+		if (!data->start_network_ipv6_id) {
+			cb_data_unref(cbd);
+			qmi_param_free(param);
+		}
+	}
+
+	if (data->start_network_ipv4_id || data->start_network_ipv6_id)
+		return 0;
+
+	return -EIO;
 }
 
 static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
@@ -277,40 +411,20 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
 	uint16_t error;
 	uint8_t iptype;
-	struct qmi_param *param;
-	uint8_t ip_family;
 
-	DBG("");
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
 
-	if (qmi_result_set_error(result, &error))
-		goto error;
+	DBG("error: %u", error);
 
-	if (!qmi_result_get_uint8(result, RESULT_IP_SUPPORT_TYPE, &iptype))
+	if (error)
 		goto error;
 
-	switch (iptype) {
-	case QMI_WDS_IP_SUPPORT_IPV4:
-		ip_family = QMI_WDS_IP_FAMILY_IPV4;
-		break;
-	case QMI_WDS_IP_SUPPORT_IPV6:
-		ip_family = QMI_WDS_IP_FAMILY_IPV6;
-		break;
-	case QMI_WDS_IP_SUPPORT_IPV4V6:
-		ip_family = QMI_WDS_IP_FAMILY_IPV4;
-		break;
-	default:
+	if (!qmi_result_get_uint8(result, RESULT_IP_SUPPORT_TYPE, &iptype))
 		goto error;
-	}
-
-	param = qmi_param_new_uint8(QMI_WDS_PARAM_IP_FAMILY, ip_family);
 
-	if (qmi_service_send(data->ipv4, QMI_WDS_START_NETWORK, param,
-					start_net_cb, cbd, cb_data_unref) > 0) {
-		cb_data_ref(cbd);
+	if (!start_network(iptype, data, NULL, cbd))
 		return;
-	}
-
-	qmi_param_free(param);
 
 error:
 	data->active_context = 0;
@@ -320,7 +434,7 @@ error:
 /*
  * This function gets called for "automatic" contexts, those which are
  * not activated via activate_primary.  For these, we will still need
- * to call start_net in order to get the packet handle for the context.
+ * to call start_network in order to get the packet handle for the context.
  * The process for automatic contexts is essentially identical to that
  * for others.
  */
@@ -334,14 +448,15 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 
 	DBG("cid %u", cid);
 
+	data->active_context = cid;
+	cbd->user = gc;
+
 	if (qmi_service_send(data->ipv4, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
 				NULL, get_lte_attach_param_cb, cbd,
-				cb_data_unref) > 0) {
-		data->active_context = cid;
-		cbd->user = gc;
+				cb_data_unref) > 0)
 		return;
-	}
 
+	data->active_context = 0;
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 	l_free(cbd);
 }
@@ -351,60 +466,37 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 				ofono_gprs_context_cb_t cb, void *user_data)
 {
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
-	struct cb_data *cbd = cb_data_new(cb, user_data);
-	struct qmi_param *param;
-	uint8_t ip_family;
-	uint8_t auth;
+	enum ofono_gprs_proto proto = ctx->proto;
+	struct cb_data *cbd;
+	int ip_type;
+	int r;
 
 	DBG("cid %u", ctx->cid);
 
-	cbd->user = gc;
-
-	data->active_context = ctx->cid;
-
-	switch (ctx->proto) {
-	case OFONO_GPRS_PROTO_IP:
-		ip_family = QMI_WDS_IP_FAMILY_IPV4;
-		break;
-	case OFONO_GPRS_PROTO_IPV6:
-		ip_family = QMI_WDS_IP_FAMILY_IPV6;
-		break;
-	default:
+	if (!L_IN_SET(proto, OFONO_GPRS_PROTO_IP, OFONO_GPRS_PROTO_IPV6,
+					OFONO_GPRS_PROTO_IPV4V6))
 		goto error;
-	}
 
-	param = qmi_param_new();
-
-	qmi_param_append(param, QMI_WDS_PARAM_APN,
-					strlen(ctx->apn), ctx->apn);
-
-	qmi_param_append_uint8(param, QMI_WDS_PARAM_IP_FAMILY, ip_family);
-
-	auth = qmi_wds_auth_from_ofono(ctx->auth_method);
+	ip_type = qmi_wds_pdp_type_from_ofono(ctx->proto);
+	if (ip_type < 0)
+		goto error;
 
-	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
-					auth);
+	if (qmi_wds_auth_from_ofono(ctx->auth_method) < 0)
+		goto error;
 
-	if (auth && ctx->username[0] != '\0')
-		qmi_param_append(param, QMI_WDS_PARAM_USERNAME,
-					strlen(ctx->username), ctx->username);
+	data->active_context = ctx->cid;
+	cbd = cb_data_new(cb, user_data);
+	cbd->user = gc;
 
-	if (auth && ctx->password[0] != '\0')
-		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
-					strlen(ctx->password), ctx->password);
+	r = start_network(ip_type, data, ctx, cbd);
+	cb_data_unref(cbd);
 
-	if (qmi_service_send(data->ipv4, QMI_WDS_START_NETWORK, param,
-					start_net_cb, cbd, cb_data_unref) > 0)
+	if (!r)
 		return;
 
-	qmi_param_free(param);
-
-error:
 	data->active_context = 0;
-
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	l_free(cbd);
+error:
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 
 static uint32_t send_stop_net(struct qmi_service *wds, uint32_t packet_handle,
-- 
2.45.2


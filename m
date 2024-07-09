Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B814D439
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565457; cv=none; b=iE/wREZwtDiHV56DmSt1grPv+14MJIz5hT2trsOGob+up9Xr6EdNRXI5g+LBnL3LuGMoJMosgGcURwx0dVH5Prb8mNAJwMVa2xSneV1NhOiEKPqwlFIu3RTJOHeWNrxQC7+9en2/lg0xBeZqKj34RvcSk3jSG6qCbUdzP4JLZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565457; c=relaxed/simple;
	bh=K5VIJjRcsyDyp8z7p9dkucsEe/Yt0allgMJ+oCLRrAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDchZXNRvRAwSiO3DVRO4aovl4ZlM7tnpedysMUBTBDwzeWz1/ILy7lblKaPY3Kg7GDUUGvbWr6VYQxIEuJl2YefH558asyHPEQBa7PdKIf0DHReLkUwlcHvDxKnahKpfPk5WXw/iNG5cUsZ9zOcE6+ym5wVIlQNgQWsIzcYiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+G8qT7L; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+G8qT7L"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-389ccd2f0abso8032965ab.2
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565455; x=1721170255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRHXUrwuSLVSLb+HJJDmp1GdLHzvQfwHZ0Kpu9OPzC8=;
        b=F+G8qT7LxZvC2WOLP/+8rUDrwHIwjsrp5bnpsSu1cJZGbCeUDeTngmXAS/DxSEgb4d
         +xSbPwe0FZjd5ltZJJm11WqSCgio0/e9YackazkjpU+pGHvOWiLj1g6aYZgNwcfThhJO
         BHJHYkJOEhx64XarcbYfOA9dqSLk/rjw5ziuim2wze8twqcRk5zWE16FAKG2/uw5Ffn7
         oEssp3tWw842tUQKZK7FdQe3clu9JbTxlUIs3lbZasUvpT9zZjlnBkfLqF/rCrpqTdnJ
         LHUEFkPfKp3t2U7xNX6YZ7WwTLSZE6EGozZEUfnICLOK/m9A9m88Xo3KcKKo18EzeF4R
         Yvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565455; x=1721170255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRHXUrwuSLVSLb+HJJDmp1GdLHzvQfwHZ0Kpu9OPzC8=;
        b=B86NiXg6uTCfcTeVp3QutTrfmjsirtm1MNh4o0HoT+sAuyhF34Rm71EDEdrckyVXgO
         FXOsZIax2A9P5IvR/hV7SzGZgoge2sltvPymMvL7bpdhfEMntpCA1LDb4/gRizPjmJUY
         qKU37DlAihJcFqUnx6UO130/B4Nw7Rn0kxoTcI77IvHse4A7K83Wv4xv7u/+vZRpZouw
         7lr0hq3eLapOGn04ycztmK5MrtJCijqiNgfC9l/PXPNY5G1Y2T+TglAnaRn215sEZfya
         zHmaHwTHUjcUh9E8f50P2BxuA/nBLPqXLVEnAFwVqqHjh6onSNd1duYPC5QuVDoX4mgc
         /Log==
X-Gm-Message-State: AOJu0YwrpUhz+RiGBUjfm58H/MnZmo33r22l37hYV32sLZRciDo+uH5v
	9H/oY0ICqgndJBK9kQyuT5UYh5knFHa1fnzSlsgxXPblVQHDcIMLkKgJUQ==
X-Google-Smtp-Source: AGHT+IHZ6zsXFYugpFG0FLXl63iBvFxz1VYuQ/tiwK/P/CISiWFX9lehlr3nQoIFslYwBn4cdJ+w3g==
X-Received: by 2002:a92:cdab:0:b0:380:fd76:3d9e with SMTP id e9e14a558f8ab-38a5a45d088mr49547305ab.22.1720565454995;
        Tue, 09 Jul 2024 15:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/11] qmi: gprs-context: Dual-Stack context activation support
Date: Tue,  9 Jul 2024 17:50:30 -0500
Message-ID: <20240709225047.1427626-11-denkenz@gmail.com>
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
index f05f10a277fd..fa6c5fa1c85e 100644
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


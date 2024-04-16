Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E112F5BE
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280494; cv=none; b=AJc544F7vTPdItZ6/Q9/XcPjhKDOAuTciF+LJWYL2J4Ov2xismRAYl8wLyDu2nft8Dt7UkN9W/b9aVnEHlR1b7Os/kYfU4351N2BlCkhyn/6DbuH/NNVXmUhaFi8YfTAN2DJalorRGV/WXvK6wW/r8XfPILKttaJgR0xWnzxJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280494; c=relaxed/simple;
	bh=/spuNrbXsLrvDYP/0kcBWeqaGEFTZsDsKgrLZO4UpVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3zTrFFWJvmAvs/jPLy066h9SZCmF20bcj4/kBmb8ByN5A/S7/s+GUhTTOvmfgwGjZVznvFoxJHAr6cOedsfyWrzA4TeQ+R++YnLEiprcAkpyJpnqjLJsigzgFnnz4IQLr0yVa11AnDEtlDqikqYeOYf2+Lisdu32YRm2ea0SB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpnsJWLL; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpnsJWLL"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c70d8bb618so1132803b6e.2
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280492; x=1713885292; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzKfzYYVa5pORzkJU4nfCQCEZJgpac7TLoOVQUTBdSc=;
        b=bpnsJWLLNyWdslyZyqIydNinMjAv6rgGh9ZIozFoXGUSExhypgOePpPsrCTyF8lV7m
         IvMySS/PP+Jqmo6K8+yMG29Z35tWoNfRqUMTC2Eduhr+dCiM6C+bTBdzhxymuO+a6yao
         kN1YFHB+1CaZIvp29cn7ncLGJF0vzd6vVD39c784O8E8oNY3IJXTAU2HiOhjzIwGb/Zy
         PrCdydLSxUtNGIyEF2UZH/nf+UfZiAkhFbxXcqezEh5l0F22bVGAQnHWVEOmWQIIZLep
         GqmhgLvQwpS+va0ehPjklbxd2zqmJqNFgswKWztSrfBG/8Q7FLFSLXI9iME94pgL55DR
         FQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280492; x=1713885292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzKfzYYVa5pORzkJU4nfCQCEZJgpac7TLoOVQUTBdSc=;
        b=t8zaHFH4jl0CmVLKPa/eUEH4r8aB6swXKF9gzTEVb7gem0fW7FXdmZgUoxm8u7vPht
         hOeaf91aAqiGaOPSabbRAt1U3PeVLPc8ZBNSkIu1iwlpg81Q6osKFx+k8Q+99icC2jqo
         aDf6o/k9iLfAE4vx5TWxCJTCM55QIhzCtCOUxfB7NFg3cjwiRyfmgAeBpQ/mWjeqggZz
         RZCUwPaGyuDtjBpLyGS8qqhSjasWWnxIPpgFcaMpiUWbmxV8aC0uq+vPdFxVtfCsWdBN
         7LAbiwHVcMRnJe4qeuToeReSm3zIuwhVIgtIpPeaFutO/6n6xxiSZxEcn68ksznpai6v
         2tqw==
X-Gm-Message-State: AOJu0Ywe0QyPeKrOZjFlFTiQI7CCHkjVNfr6f6VdrQWkaue9VXIWL7Mh
	788sxKCvL14u2cHGuofhJzpqtJ/UYZemfo0Q00W3BUy7tD5Yl7UQk0HdYA==
X-Google-Smtp-Source: AGHT+IFjerzEFV4b6MqaMpflExHvOECzQ4S1jcYvcMS7WnOqKQ72VGZ06SgaTQKJqcxCe5cE+2Liaw==
X-Received: by 2002:a05:6808:1596:b0:3c7:291b:3f44 with SMTP id t22-20020a056808159600b003c7291b3f44mr1467870oiw.12.1713280492004;
        Tue, 16 Apr 2024 08:14:52 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/7] qmi: gprs-context: Move singleton defines to call site
Date: Tue, 16 Apr 2024 10:14:30 -0500
Message-ID: <20240416151448.3359644-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416151448.3359644-1-denkenz@gmail.com>
References: <20240416151448.3359644-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These defines are used only a single time, either as an enumeration for
a parameter or result.  Move them to be closer to the actual call site
and do not use a QMI_WDS prefix.
---
 drivers/qmimodem/gprs-context.c | 40 ++++++++++++++++++++-------------
 drivers/qmimodem/wds.h          | 17 --------------
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 1d7449e68ccc..ef49e1bcf421 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -44,6 +44,8 @@ struct gprs_context_data {
 
 static void pkt_status_notify(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_CONN_STATUS = 0x01;
+	static const uint8_t RESULT_IP_FAMILY = 0x12;
 	struct ofono_gprs_context *gc = user_data;
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
 	const struct qmi_wds_notify_conn_status *status;
@@ -52,13 +54,13 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 
 	DBG("");
 
-	status = qmi_result_get(result, QMI_WDS_NOTIFY_CONN_STATUS, &len);
+	status = qmi_result_get(result, RESULT_CONN_STATUS, &len);
 	if (!status)
 		return;
 
 	DBG("conn status %d", status->status);
 
-	if (qmi_result_get_uint8(result, QMI_WDS_NOTIFY_IP_FAMILY, &ip_family))
+	if (qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
 		DBG("ip family %d", ip_family);
 
 	switch (status->status) {
@@ -75,6 +77,14 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 
 static void get_settings_cb(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_PDP_TYPE = 0x11;	/* uint8 */
+	static const uint8_t RESULT_APN = 0x14;		/* string */
+	static const uint8_t RESULT_PRIMARY_DNS = 0x15;
+	static const uint8_t RESULT_SECONDARY_DNS = 0x16;
+	static const uint8_t RESULT_IP_ADDRESS = 0x1e;
+	static const uint8_t RESULT_GATEWAY = 0x20;
+	static const uint8_t RESULT_GATEWAY_NETMASK = 0x21;
+	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
@@ -91,49 +101,46 @@ static void get_settings_cb(struct qmi_result *result, void *user_data)
 	if (qmi_result_set_error(result, NULL))
 		goto done;
 
-	apn = qmi_result_get_string(result, QMI_WDS_RESULT_APN);
+	apn = qmi_result_get_string(result, RESULT_APN);
 	if (apn) {
 		DBG("APN: %s", apn);
 		l_free(apn);
 	}
 
-	if (qmi_result_get_uint8(result, QMI_WDS_RESULT_PDP_TYPE, &pdp_type))
+	if (qmi_result_get_uint8(result, RESULT_PDP_TYPE, &pdp_type))
 		DBG("PDP type %d", pdp_type);
 
-	if (qmi_result_get_uint8(result, QMI_WDS_RESULT_IP_FAMILY, &ip_family))
+	if (qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
 		DBG("IP family %d", ip_family);
 
-	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_IP_ADDRESS, &ip_addr)) {
+	if (qmi_result_get_uint32(result, RESULT_IP_ADDRESS, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		straddr = inet_ntoa(addr);
 		DBG("IP addr: %s", straddr);
 		ofono_gprs_context_set_ipv4_address(gc, straddr, 1);
 	}
 
-	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_GATEWAY, &ip_addr)) {
+	if (qmi_result_get_uint32(result, RESULT_GATEWAY, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		straddr = inet_ntoa(addr);
 		DBG("Gateway: %s", straddr);
 		ofono_gprs_context_set_ipv4_gateway(gc, straddr);
 	}
 
-	if (qmi_result_get_uint32(result,
-				QMI_WDS_RESULT_GATEWAY_NETMASK, &ip_addr)) {
+	if (qmi_result_get_uint32(result, RESULT_GATEWAY_NETMASK, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		straddr = inet_ntoa(addr);
 		DBG("Gateway netmask: %s", straddr);
 		ofono_gprs_context_set_ipv4_netmask(gc, straddr);
 	}
 
-	if (qmi_result_get_uint32(result,
-				QMI_WDS_RESULT_PRIMARY_DNS, &ip_addr)) {
+	if (qmi_result_get_uint32(result, RESULT_PRIMARY_DNS, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		dns[0] = inet_ntop(AF_INET, &addr, dns_buf[0], sizeof(dns_buf[0]));
 		DBG("Primary DNS: %s", dns[0]);
 	}
 
-	if (qmi_result_get_uint32(result,
-				QMI_WDS_RESULT_SECONDARY_DNS, &ip_addr)) {
+	if (qmi_result_get_uint32(result, RESULT_SECONDARY_DNS, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		dns[1] = inet_ntop(AF_INET, &addr, dns_buf[1], sizeof(dns_buf[1]));
 		DBG("Secondary DNS: %s", dns[1]);
@@ -148,6 +155,7 @@ done:
 
 static void start_net_cb(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_PACKET_HANDLE = 0x01;
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
@@ -159,7 +167,7 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 	if (qmi_result_set_error(result, NULL))
 		goto error;
 
-	if (!qmi_result_get_uint32(result, QMI_WDS_RESULT_PKT_HANDLE, &handle))
+	if (!qmi_result_get_uint32(result, RESULT_PACKET_HANDLE, &handle))
 		goto error;
 
 	DBG("packet handle %d", handle);
@@ -314,6 +322,7 @@ static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 				unsigned int cid,
 				ofono_gprs_context_cb_t cb, void *user_data)
 {
+	static const uint8_t PARAM_PACKET_HANDLE = 0x01;
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd = cb_data_new(cb, user_data);
 	struct qmi_param *param;
@@ -322,8 +331,7 @@ static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 
 	cbd->user = gc;
 
-	param = qmi_param_new_uint32(QMI_WDS_PARAM_PKT_HANDLE,
-						data->pkt_handle);
+	param = qmi_param_new_uint32(PARAM_PACKET_HANDLE, data->pkt_handle);
 
 	if (qmi_service_send(data->wds, QMI_WDS_STOP_NETWORK, param,
 					stop_net_cb, cbd, l_free) > 0)
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 6213f75231db..398f77c74672 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -30,34 +30,17 @@
 #define QMI_WDS_AUTHENTICATION_PAP		0x1
 #define QMI_WDS_AUTHENTICATION_CHAP		0x2
 
-#define QMI_WDS_RESULT_PKT_HANDLE		0x01	/* uint32 */
-
-/* Stop WDS network interface */
-#define QMI_WDS_PARAM_PKT_HANDLE		0x01	/* uint32 */
-
 /* Packet data connection status indication */
-#define QMI_WDS_NOTIFY_CONN_STATUS		0x01
 struct qmi_wds_notify_conn_status {
 	uint8_t status;
 	uint8_t reconf;
 } __attribute__((__packed__));
-#define QMI_WDS_NOTIFY_IP_FAMILY		0x12	/* uint8 */
 
 #define QMI_WDS_CONN_STATUS_DISCONNECTED	0x01
 #define QMI_WDS_CONN_STATUS_CONNECTED		0x02
 #define QMI_WDS_CONN_STATUS_SUSPENDED		0x03
 #define QMI_WDS_CONN_STATUS_AUTHENTICATING	0x04
 
-/* Get the runtime data session settings */
-#define QMI_WDS_RESULT_PDP_TYPE			0x11	/* uint8 */
-#define QMI_WDS_RESULT_APN			0x14	/* string */
-#define QMI_WDS_RESULT_PRIMARY_DNS		0x15	/* uint32 IPv4 */
-#define QMI_WDS_RESULT_SECONDARY_DNS		0x16	/* uint32 IPv4 */
-#define QMI_WDS_RESULT_IP_ADDRESS		0x1e	/* uint32 IPv4 */
-#define QMI_WDS_RESULT_GATEWAY			0x20	/* uint32 IPv4 */
-#define QMI_WDS_RESULT_GATEWAY_NETMASK		0x21	/* uint32 IPv4 */
-#define QMI_WDS_RESULT_IP_FAMILY		0x2b	/* uint8 */
-
 #define QMI_WDS_PDP_TYPE_IPV4			0x00
 #define QMI_WDS_PDP_TYPE_PPP			0x01
 #define QMI_WDS_PDP_TYPE_IPV6			0x02
-- 
2.44.0


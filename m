Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096B16D4D2
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716587; cv=none; b=A/+cU68wBe8EGDFzwDWlgXgvXSJdi2+Cl9AmH1/8zYcd45jfnG0MRcdrwIno6qFT0VEDY0I+whOp0JczTLQlnbgxVK7+eqmTPljrieXo9Q/PJxIcihF3LcSbeO2u5PmfEdVxU2SbAdKFOMWAoQuR8ehbGgkLzUzK1qo7K+4XkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716587; c=relaxed/simple;
	bh=8cfODcoWXNYMcLJsfnko6IIDlPtXTjFSOie4w2z76kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUB9+tot7zXYPEx0e74qs0U80DJkzlYZLp77/dfozy+eZiVS7UUh0gK8GYys2aPEqOPF+UbSNsks2QyO1/CwaZDPd7qh/raPHYExTr/5HqaryV/jzxAZ5yvkbEZdrVZPDpWzAh9HottemF/m4vHmQruXmhmXfNrtOmQ9+U8UXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QipnrTe2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QipnrTe2"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70445bb3811so588663a34.1
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716585; x=1721321385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IdoR3kSiJsDqnQFMOJF3gYwYZqDTB3crIPGt/XI2os=;
        b=QipnrTe2mZ9tgn6f5c5mVXJPz5wAIMrNEBuS70KBjHFYnXFMG/K0Cm+HjEhPHkdFhU
         nHsqKIdHRC2QbAJnv881bSD7ljOjqE5dYBkNL4QKPM5oRzmGxTBS02kFuScN6rF/ZHNg
         ISV0o4ZGuoOd3f9z9ImDf+iqPkQKxTYF+ijDR4MWgK+yQjJ508qyroyaVcj1HfCjmFOq
         LeyvFvAH2u4iE1vHrnOX2Abn1Q390KfVf2KTAhGBhTNDdaZshfbhSsViUH9pMFWq+kZN
         YRC19Sk2AkEqGT1Yh0/8UTxmXfX2vQBwDNPqQ/IgOd9Jt/LEQ/PQDSgZQlploj/vxhLb
         02dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716585; x=1721321385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IdoR3kSiJsDqnQFMOJF3gYwYZqDTB3crIPGt/XI2os=;
        b=Y/SXdatH771/XXBBKKFCpIe4YxvaDudnEyRWvV44hVPRSdJbQgAX7oELKiH997oH7o
         JS9bcUtuDUlnP0Qx53wmcndiE9loSx2I/rP0g1VYJ8dk1tSaFrunk5ZZmkeRg3l4qcYY
         2idPwkrV6WJFusK47SSfz9Gcibo9yBeDsp+tvmiMFcgC8tjeFYVMN4lAjQcxPxvFYrDh
         UFQnVfD5LU9SnIuIC67h0Ds1sfwvdDhoX+91bYLlc7xEfhb/Sjp7XOnXw2YLPkwPxzy3
         dSCxj2DoYZ7qWfkWiA0PyJCK2cDzkFheMFBxiGMXYevOQj+9ISguxcnr9isHLcK0nStx
         qBHA==
X-Gm-Message-State: AOJu0YwbGnYH2sV0xx5YUfhGsN1ms0oL3/8aZbBaiuf2z2JMIwjGhSij
	thz8fJqvQ8CTtQZ0WcFJHO2Sfm+AOUIozzkvgJoZP9g1ja8zAN98tSLg5A==
X-Google-Smtp-Source: AGHT+IHgNMcrhKNx8tiUbhT3i9w43bmlXOsOUBwWyIoOCvpIZaCilMAsqnajevNtaqyDRO+PhRe6yw==
X-Received: by 2002:a05:6830:1553:b0:703:5dc9:7295 with SMTP id 46e09a7af769-70375a1245dmr9907783a34.17.1720716584758;
        Thu, 11 Jul 2024 09:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:44 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/11] qmi: gprs-context: refactor deactivate_primary
Date: Thu, 11 Jul 2024 11:49:32 -0500
Message-ID: <20240711164936.1688973-10-denkenz@gmail.com>
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

When multiple WDS clients are used (Dual stack contexts), the
deactivate_primary path needs to send Stop Network command on any client
with an ongoing packet connection.  The following strategy is now used:
	1. If no packet connections are ongoing on either IPv4 or IPV6
	   WDS client, callback with an error
	2. If IPv6 WDS client is used, attempt to stop that first,
	   otherwise, proceed to step 4.
	3. If IPv6 WDS client is the only client used, report the
	   success / failure of this operation.  Otherwise, proceed to
	   step 4.
	4. Try to send a Stop Network request to the IPv4 WDS client. If
	   this step fails, callback with an error.
---
 drivers/qmimodem/gprs-context.c | 84 ++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index f4846f0299e7..6061de0a483d 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -425,57 +425,97 @@ static uint32_t send_stop_net(struct qmi_service *wds, uint32_t packet_handle,
 	return id;
 }
 
-static void stop_net_cb(struct qmi_result *result, void *user_data)
+static void stop_net_ipv4_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
 
-	DBG("");
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
 
-	if (qmi_result_set_error(result, NULL)) {
-		if (cb)
-			CALLBACK_WITH_FAILURE(cb, cbd->data);
-		return;
-	}
+	DBG("error: %u", error);
 
 	data->packet_handle_ipv4 = 0;
+	data->active_context = 0;
 
-	if (cb)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	if (error)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
 	else
-		ofono_gprs_context_deactivated(gc, data->active_context);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
 
-	data->active_context = 0;
+static void stop_net_ipv6_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_gprs_context_cb_t cb = cbd->cb;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
+
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
+
+	DBG("error: %u", error);
+
+	data->packet_handle_ipv6 = 0;
+
+	if (data->packet_handle_ipv4) {
+		if (send_stop_net(data->ipv4, data->packet_handle_ipv4,
+					stop_net_ipv4_cb,
+					cb_data_ref(cbd), cb_data_unref))
+			return;
+
+		cb_data_unref(cbd);
+		data->active_context = 0;
+		data->packet_handle_ipv4 = 0;
+		goto error;
+	} else
+		data->active_context = 0;
+
+	if (!error) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		return;
+	}
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 
 static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 				unsigned int cid,
 				ofono_gprs_context_cb_t cb, void *user_data)
 {
-	static const uint8_t PARAM_PACKET_HANDLE = 0x01;
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
-	struct cb_data *cbd = cb_data_new(cb, user_data);
-	struct qmi_param *param;
+	struct cb_data *cbd;
+	uint32_t id;
 
 	DBG("cid %u", cid);
 
+	if (!data->packet_handle_ipv4 && !data->packet_handle_ipv6)
+		goto error;
+
+	cbd = cb_data_new(cb, user_data);
 	cbd->user = gc;
 
-	param = qmi_param_new_uint32(PARAM_PACKET_HANDLE,
-						data->packet_handle_ipv4);
+	if (data->packet_handle_ipv6)
+		id = send_stop_net(data->ipv6, data->packet_handle_ipv6,
+					stop_net_ipv6_cb, cbd, cb_data_unref);
+	else
+		id = send_stop_net(data->ipv4, data->packet_handle_ipv4,
+					stop_net_ipv4_cb, cbd, cb_data_unref);
 
-	if (qmi_service_send(data->ipv4, QMI_WDS_STOP_NETWORK, param,
-					stop_net_cb, cbd, l_free) > 0)
+	if (id)
 		return;
 
-	qmi_param_free(param);
-
-	if (cb)
-		CALLBACK_WITH_FAILURE(cb, user_data);
+	data->packet_handle_ipv6 = 0;
+	data->packet_handle_ipv4 = 0;
+	data->active_context = 0;
 
 	l_free(cbd);
+error:
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 
 static void stop_net_detach_ipv4_cb(struct qmi_result *result, void *user_data)
-- 
2.45.2


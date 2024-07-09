Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719C155316
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565456; cv=none; b=Y1aMjzzqW3fT+eOzaLzGTPRc2g9s2IUuper6LcKbSzYLI6PXXC4A/8dTiswZtT/RqvVZncyac7VepaLy2ZDDsQ1XFdlGh0b2s1/quw0Qs0eIBKIYreYkmrP6OYraMvNEM2z0KLlvmDDxz2ZrAXiUKQg/v47vuuZJ3TFFVyGaqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565456; c=relaxed/simple;
	bh=M1CZJ0aXZNjebQFQsNPbO1erLdOs4SmRG3aTUst4auk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuWVbk2DGAvuDLwG8Im+Kfh+ynaVtsMsUuVlzSDGfeaGRtt69NP5AHdeR0Zpx7kToneirKOXUv/k1s8n5M6PS9EMe/UPrcoOZR3E5WbNxficx+VMgTEtJBYO8rBWZlDEJlia75ytyadtYQJ8q6KMryj0cQrZWzT0G2dzR1unYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfZbV/d1; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfZbV/d1"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-380bfd7cdbfso27739105ab.1
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565454; x=1721170254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVv7hzeLCRW8dJ44zfujNBcMlJ4v82ih1I28IPMtpko=;
        b=BfZbV/d19Fq7mwyLAo2vywq1oOP4hBszBDkakkCuR0/8jcozeI8zzoQQpum6IILOdY
         YdX/PdRPTW7fXD+hr/K9uHAfYjmbfW8eBxw0CsyyLfFqt09cq6YK917sLvULOoUY+fKs
         icJvoTvLRb2akwuyOYrjv+UbZR94BE5IEddfN/c/G+ytY1kK5H2ev/w2iNhmBZceh4TR
         fQRfm7sKvKJUyeHMjEYq+18Io8Z16uF2INISeAW2T86YVBNd8BX5O0gf4tNWXDR9Ig4P
         KPpA5cSbFQkTYGBNuDqSDmyevtcdDoyiCTFSw5DXlSiGpbqQyu6JliHO7lswH0ddZTkd
         3Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565454; x=1721170254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVv7hzeLCRW8dJ44zfujNBcMlJ4v82ih1I28IPMtpko=;
        b=Gsp4HOTqDj/LGhZaOpSGVYuVcExzKhX0wseFJ/e3dX0dBJJbPDuumNMzdCN45zbvWB
         Uhlz5ZN4Sg+7yarPBVMR7noYtKPknmapDOCtIsa7iauBSxLFQURRzoltjp8hfSOTJ1Ph
         p3wmlWe/qdLOA3L1GQLmt2UH8E9JXhuON/8eVJAhZFNq9hsmlMZbm0XZJVApWYpWXhQJ
         y9Si+1gsJ61eFbAjElInOp4UvwLXnWBlQTzUIruyWSci01qR5VnRhLZzTbPYurYoIR35
         ZRMtGW4e0nsBVQWKcsikrKNRdXdIkTrCzpE3C9isKvYF/RWuu39LIktGIVV03GRm4LkL
         q1tA==
X-Gm-Message-State: AOJu0YwGmEPoG1GGJJjd/alqwv7I4yI/pD18N5XGNxtczjBY4op8f6xd
	1W3PqXufW5+WueEinDHEF2cng9cCaRfNoVJDuzli34QUqimGa9sqHM/y9Q==
X-Google-Smtp-Source: AGHT+IFOVrr0VKlfzifh6XxhKS5QDc5lfkbUHQLCoufNcj+7SA5CWYbDEIj3qS4TKaS1rQiSZJU/ng==
X-Received: by 2002:a05:6e02:1805:b0:375:e1fc:aea2 with SMTP id e9e14a558f8ab-38a596cad07mr43303065ab.31.1720565454388;
        Tue, 09 Jul 2024 15:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/11] qmi: gprs-context: refactor deactivate_primary
Date: Tue,  9 Jul 2024 17:50:29 -0500
Message-ID: <20240709225047.1427626-10-denkenz@gmail.com>
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
index bdbf50efd721..f05f10a277fd 100644
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


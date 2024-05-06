Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546015B57D
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032692; cv=none; b=DWjciQYjgstnvN0N/VIKjSdk5ss26nqxRIDfdog93xWGHl0zPcX7z8MgoJQTYYE/2hsxhcu6jwg/uxVpwxxIPRUJj+qmujC3zEtxrllxleDfg3xBqQTqwe7CJ4dfgJM1nCmgy2763yzSGBfW1DGl3p40sqsqhFyCh1urtlAssuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032692; c=relaxed/simple;
	bh=g7s3V2XQJQbcMGIdYGMCQvcUmNQ2E1E3wHx5PDT4Hx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfaPMHq84et+lG6Jtqd/dFDY5gDJyxjmtLB9J/fBLMwt7xsB+utyGV9zAg/MyDX9gc1XMVhrDU0TDyTHA7/DNP2WJ+aMW23aMynbyecRczKT0gmJT70yBE1qO8p1Gc9YfQcNK3VEk/t5OV77oWNxVKeCitRn5//Zv1aJWq/OrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKBOa71O; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKBOa71O"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ac8c73cf88so1646529eaf.2
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032690; x=1715637490; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0hIRCPoPC2tCs8yrpNf8IHi+7O88VAjVuHbsMAdko8=;
        b=gKBOa71ONL16erPUHtinPkuEsapdIXNUGp6VQN3rxoyr6Pfg+KWHHfGqA+oY84jKCS
         FvSzn6h01vC8mGD59/RTF0MFaBzcbp8gDEGvQ7PyvjJxKwPvEvmLc7kdspk3azdC1ySE
         uyReh5L4N0Srq/4Xlp2SlWzFDSVJ7fEWhQWrFhfO4Jd+5uXhGlz3/CqkDDEl7vFiPiCM
         puX82sW+insZ8ZP/V96jio8xGPnZQYJwbeZg7DSHKgGfn6rQ1tntqDvZK0kw39A0+bXe
         jnZRWBJN/2VkH98Sr0R4YibGyK6O+iqkMQH9jvtN3zFJUvxOcdhOLXqFO4RLzhzJQwoa
         f1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032690; x=1715637490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0hIRCPoPC2tCs8yrpNf8IHi+7O88VAjVuHbsMAdko8=;
        b=CXZvmhaiLWD+O+fHj/cJYABXb84u92fkHkcaE2imgKgULOhZaT3CN5r+diZ1NgtaeM
         XE2udWTokuIXTpMvEErHL/YakdTtsk4gIq0d6ajDn8R2yydtqUSM5j2XrjC/icF+ekwP
         CYBtgT4l+hNeGnDhJmOYjVEL4Gxm819sB3uB/pXpJReeY4Ii8rug8inVRnR92DWSstDU
         jCt7gwZyHndLsE2BS8wShzfqrEnd7a3gny36dWEN4DY69ztXiIUw0q3N4r1Pbefz2efk
         65TUzIw0UCV9UUZ+3Pt8et2pYq/uEhworXzZ66Pl0DsMll94mBEoqH5rWoZjHctdOdXm
         7Qvg==
X-Gm-Message-State: AOJu0YzDDiOMbhBXrIpdhCarfr3hsEHWhhDimOP6Se3rkrCUnuDOCWu0
	1uaOc6qXyJd8n5ZST64xN2UsZBj+xojNqbTEM82T7wz1OmMlrll95cTWBw==
X-Google-Smtp-Source: AGHT+IFrMEk/zCTfHqL92stTfwsbY1gQlBclzKULjuCqpgRbyEg8smkneWa3hPtyA4Zpu7ctqb34Yw==
X-Received: by 2002:a4a:b047:0:b0:5b2:f7c:a717 with SMTP id g7-20020a4ab047000000b005b20f7ca717mr4209789oon.9.1715032690081;
        Mon, 06 May 2024 14:58:10 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:09 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 6/8] qmi: gprs-context: Split out IPv4 setting processing
Date: Mon,  6 May 2024 16:58:00 -0500
Message-ID: <20240506215804.57124-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506215804.57124-1-denkenz@gmail.com>
References: <20240506215804.57124-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to support IPv6 bearers by moving IPv4 bearer context processing
into its own function.  get_settings_ipv4() will be called if the
reported IP Family TLV reports ipv4.
---
 drivers/qmimodem/gprs-context.c | 69 ++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 9ac57c893725..99d42e7b5e1f 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -78,44 +78,20 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 	}
 }
 
-static void get_settings_cb(struct qmi_result *result, void *user_data)
+static void get_settings_ipv4(struct ofono_gprs_context *gc,
+					struct qmi_result *result)
 {
-	static const uint8_t RESULT_PDP_TYPE = 0x11;	/* uint8 */
-	static const uint8_t RESULT_APN = 0x14;		/* string */
 	static const uint8_t RESULT_PRIMARY_DNS = 0x15;
 	static const uint8_t RESULT_SECONDARY_DNS = 0x16;
 	static const uint8_t RESULT_IP_ADDRESS = 0x1e;
 	static const uint8_t RESULT_GATEWAY = 0x20;
 	static const uint8_t RESULT_GATEWAY_NETMASK = 0x21;
-	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
-	struct cb_data *cbd = user_data;
-	ofono_gprs_context_cb_t cb = cbd->cb;
-	struct ofono_gprs_context *gc = cbd->user;
-	uint8_t pdp_type, ip_family;
 	uint32_t ip_addr;
 	struct in_addr addr;
 	char* straddr;
-	char* apn;
 	const char *dns[3] = { NULL, NULL, NULL };
 	char dns_buf[2][INET_ADDRSTRLEN];
 
-	DBG("");
-
-	if (qmi_result_set_error(result, NULL))
-		goto done;
-
-	apn = qmi_result_get_string(result, RESULT_APN);
-	if (apn) {
-		DBG("APN: %s", apn);
-		l_free(apn);
-	}
-
-	if (qmi_result_get_uint8(result, RESULT_PDP_TYPE, &pdp_type))
-		DBG("PDP type %d", pdp_type);
-
-	if (qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
-		DBG("IP family %d", ip_family);
-
 	if (qmi_result_get_uint32(result, RESULT_IP_ADDRESS, &ip_addr)) {
 		addr.s_addr = htonl(ip_addr);
 		straddr = inet_ntoa(addr);
@@ -151,6 +127,47 @@ static void get_settings_cb(struct qmi_result *result, void *user_data)
 
 	if (dns[0])
 		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+}
+
+static void get_settings_cb(struct qmi_result *result, void *user_data)
+{
+	static const uint8_t RESULT_PDP_TYPE = 0x11;	/* uint8 */
+	static const uint8_t RESULT_APN = 0x14;		/* string */
+	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
+	struct cb_data *cbd = user_data;
+	ofono_gprs_context_cb_t cb = cbd->cb;
+	struct ofono_gprs_context *gc = cbd->user;
+	uint8_t pdp_type, ip_family;
+	char* apn;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto done;
+
+	apn = qmi_result_get_string(result, RESULT_APN);
+	if (apn) {
+		DBG("APN: %s", apn);
+		l_free(apn);
+	}
+
+	if (qmi_result_get_uint8(result, RESULT_PDP_TYPE, &pdp_type))
+		DBG("PDP type %d", pdp_type);
+
+	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family)) {
+		ofono_error("No IP family in results");
+		goto done;
+	}
+
+	switch (ip_family) {
+	case QMI_WDS_IP_FAMILY_IPV4:
+		get_settings_ipv4(gc, result);
+		break;
+	case QMI_WDS_IP_FAMILY_IPV6:
+		break;
+	default:
+		break;
+	}
 
 done:
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-- 
2.45.0


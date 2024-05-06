Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331F1591E8
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028001; cv=none; b=D3aYQWJdEYAF4Q2aQ8zcGShKYLrak/ZE9aoFZdX6+uHYVGOFA0Da+GBEW3ePDluYZXEKJs/JAwQwzPLwo22IcPWY9f9idy5alGC6IMny/uNpSZ6hwHbDXeVVZTbtCKTu8mgBcZeU4w6zYo22YyKSbRvSHMiCe8puSnufh8HVhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028001; c=relaxed/simple;
	bh=g7s3V2XQJQbcMGIdYGMCQvcUmNQ2E1E3wHx5PDT4Hx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHH2ffhONHkh3QWvpWbTci0UBsebCok/f4C4mv/e7Vg/Gto0J8eyKcqBUgaD7cp+vD8Vu07A+DzRk4PWOocbQdD5oNA6pJ5ungLtlM70fL7xP0WQimXVTswEJTkwJKa2TQ3jsaqkZwoTs4P8L+morAgk2VGrBMaUX8p5yKwFsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI9g7edh; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI9g7edh"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ed3587b93bso1545885a34.1
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027998; x=1715632798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0hIRCPoPC2tCs8yrpNf8IHi+7O88VAjVuHbsMAdko8=;
        b=EI9g7edhb+kZypXAIFE/Fs4SC9kZvEVuPXOAEYXUKISAKC6F1gmrdD8KdOaL8FY0KL
         P9jyjb+Bm9Lo0td9NRygwPOHPvqOmdaXOJbc9fclQUlJzXnto3CXS6/ndZ6KIpSKW8Eu
         mRHH7qMW6P6JOhfmulhUreTWZUGnewT9xCQJi1qHSwTum1nYWzDhlkqI96GgnO20Uqnp
         0owUdk/15/mocINKepoNDJ2x+7me2xsx8TQRV9onasjpK+/AWv0kUx5jAubNyIrF73xr
         e+4vjWsQoW7/sARJIKKH5gaQXKMePI0RCPu1baYMgVEZh74R2vTW0NqIHRdUdjluq4qJ
         vBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027998; x=1715632798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0hIRCPoPC2tCs8yrpNf8IHi+7O88VAjVuHbsMAdko8=;
        b=Wq2UUsNnD3+dt88h5EDc8Pdwq2zuhfQ81tqDVow6Dc83F/m8T5SZ6IEgHxfvjmpget
         /dWRwQig9kwkOeGS+k+GaI/2StwoZch6+i/8VBuggH0+49AU38hJOg+prb0TptF35nfH
         CMC85IRvW07XuthUMcsew6HtCHCrECzkhwSo/QnTU9vLAOLDCaBrePNWryw7ZePZlqdm
         trPAlEze3LOxl1kH4TUhIzrQ2BKWjQe0HLdIqlmUWAxC3/SHII/RHrzBZqvAaQzO15xR
         Q76ze7vawc0eV3U7TbBo4+Dd3YwU/iTu1c57dsDNtUZLBuUpJsvFuAoUG7X9S+yllBTn
         p76g==
X-Gm-Message-State: AOJu0YyPs3sqjnyhuUMDjbkeGCPH9053lilu56jJPhO2Dyr35IaLCv/P
	Ttibvt5QObcl0rIPhJlFn/isSkHgKTx/oKyA3RRiqMjqptA6i7ZuBSO1HQ==
X-Google-Smtp-Source: AGHT+IGzDhvu/B3qXeofFkBBCurjXapHpvJf1bHr5Ey147bbsl116fZmMP2XkjVDmKFBAL+bOGT45A==
X-Received: by 2002:a05:6870:210e:b0:23c:1f34:730 with SMTP id f14-20020a056870210e00b0023c1f340730mr12975197oae.49.1715027998557;
        Mon, 06 May 2024 13:39:58 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/8] qmi: gprs-context: Split out IPv4 setting processing
Date: Mon,  6 May 2024 15:39:28 -0500
Message-ID: <20240506203952.55806-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506203952.55806-1-denkenz@gmail.com>
References: <20240506203952.55806-1-denkenz@gmail.com>
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


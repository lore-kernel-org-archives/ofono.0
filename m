Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B084047
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716584; cv=none; b=sM1Dn/ye5x3q4X2oWIlbrQl4eWCEfVq19BsNK1ZpqZX1z9AFhREPv1uk3r0HV/aPqKKbE8QKerDpxg+5QkA/H9fFjYbZ0eH14d4+XNQ1cqa+W7cZ/APUfwSH9kYpgUHXTuudVCf0kxBQy2Gj4q7X9xT89JnIHqGY4oXyc3N2PbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716584; c=relaxed/simple;
	bh=0UKrj6psPpqKrHfsfXGzVkrlHHzbsnYn0x2SxeReDmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCChShkAD2BDiSMzdn6Vnu3flBcDmR4gFm7ej1y3wF9Bk266DnDy0VXzlx31ltc5XwXUEmvfmtj0BTM5isdAhRSZC/ABNqLybhHgx2wSqQNBqeXzIoiPQAgbjNxrOdEyc9LATChW3VgCRZK2fW41bmH3tpSvfSBd2X5n8Lq7b/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay1v3Yu0; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay1v3Yu0"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25e43dda1edso665682fac.0
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716582; x=1721321382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs8F02vWqEf3iOs19nUa1+NSb0ZJzw+ofar/3zu1nbw=;
        b=Ay1v3Yu0WkP8WP+mHz5TeOcgKnl9BNnl8/nf4PBB2ksfpGNVK124PTlWaPDCbeVPRX
         +kQiEoY5qOSucoqZ70Jf741ZzlBs1uakou+hUNmlNHTXTb4iRtCj9ej694QZE1EMV2RO
         z9RAPZsCfUA+GK956pX/Pbhca+8jBV6jte69GaZvlcrJWYjlBcsbrTu5KVH1exL80z5F
         M30eWKx+gy4FQc3Qmbd3pQaMgwVD5euE3SXOTOHE3bq7GSjm19nrvUBVfX2X3w5sTJ8C
         ItpsBFmHhET1+iO9NAYfXQWVxdVMOytRbWGcBOqj7gGlthTrj9lgTgzi2NB68UnKO9Wa
         Izpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716582; x=1721321382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs8F02vWqEf3iOs19nUa1+NSb0ZJzw+ofar/3zu1nbw=;
        b=kwcTK3BM9rQbkaN5Yp+XXXdnpsp88NmG5CyBf0mtvyvhnejH3dYwMSd/IyfVzfeOrE
         ZiIU61tN2eGZvf3hq2uzIKBmEyU+qajDOzLwwCUxLS863VzyrZjcp6H4sF0TsY7/R7xn
         oh40ViUOHOuFSTTizTOkbYYGz6N56wJ/EZx2HsR/Jo4QgFFMCtMV3B7JIQx+aX94WbJ4
         Q2JDZifyDZmRPoMHXJ1+O76vx0JtGPcZH6nKEslTvWZ9aNrfLMhm2Oirb43ahOHD4lVY
         4p3To0JtU1SOXBMIl0xjaN4lNzelkaqYFLFQTVEHIj4radrWIfoXvXO3ZaWDxvBkPMzf
         jqgw==
X-Gm-Message-State: AOJu0Yy77ACkx3t11RKGVi5chGlhF6rg9F6SZiHd1XdgRB5bVNGuTrvb
	AhkIWWmYDT6gPDCPYgws8qFyWrbKmQgHDf0BQii2Frrf4jgVjAWl/gSI5A==
X-Google-Smtp-Source: AGHT+IFbrrLUcae+jjyUBCN7ZNeSV+KLzJ/i7ki6KOBHTsMlkQt00aYrke+6Gcq2GLXHA8U79Alo0Q==
X-Received: by 2002:a05:6870:8a21:b0:25b:5032:25c4 with SMTP id 586e51a60fabf-25eaec92ce9mr7440827fac.54.1720716581929;
        Thu, 11 Jul 2024 09:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/11] qmi: gprs-context: Remove parsing of unused TLVs
Date: Thu, 11 Jul 2024 11:49:28 -0500
Message-ID: <20240711164936.1688973-6-denkenz@gmail.com>
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

The information from these TLVs is currently unused and only printed to
debug output.  Same can be accomplished using an external sniffer.
Remove this code until the information in these TLVs is needed for
something.
---
 drivers/qmimodem/gprs-context.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 5582a8052c0b..f29f10720710 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -173,29 +173,17 @@ static void get_settings_ipv4(struct ofono_gprs_context *gc,
 
 static void get_settings_cb(struct qmi_result *result, void *user_data)
 {
-	static const uint8_t RESULT_PDP_TYPE = 0x11;	/* uint8 */
-	static const uint8_t RESULT_APN = 0x14;		/* string */
 	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
-	uint8_t pdp_type, ip_family;
-	char *apn;
+	uint8_t ip_family;
 
 	DBG("");
 
 	if (qmi_result_set_error(result, NULL))
 		goto done;
 
-	apn = qmi_result_get_string(result, RESULT_APN);
-	if (apn) {
-		DBG("APN: %s", apn);
-		l_free(apn);
-	}
-
-	if (qmi_result_get_uint8(result, RESULT_PDP_TYPE, &pdp_type))
-		DBG("PDP type %d", pdp_type);
-
 	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family)) {
 		ofono_error("No IP family in results");
 		goto done;
-- 
2.45.2


Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9A168AE2
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605712; cv=none; b=FIB8nxqkBDwHYbUfvIeqfHkBz4WFfWm7U3HUJwG8EJBJMndOxXnf7M4CZsh2ko0RpxasOu0QF48Qol78EsU9FRsXoe/dBP1Ga9kuBo6LtkGTS4ipNw4XGG0w86StTXv06UcGur70gn3byJDX9GgCptqaIkqdBP/keJroW+zE+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605712; c=relaxed/simple;
	bh=412RREiT9dop9hW/4m7vvdyjRg13n44dAeIFfT7+kjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg/nfVXKGcf0ixSnstL2+hfJ+mOIYoVWnMtiA1xgRdhJH43WJwcVPbhllOaSVIH/1qzMIZMASUZEoybCwSavKVFPsJ/bf9gbyKhI45RgGB626EdTBzKprvIY9MY/AccDMu9IrwgMpPKfryxmtsjSiYKn4pAdAjnf+TJeCg4zVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjZ6bbJl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjZ6bbJl"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ef9dee5bddso283070a34.1
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605710; x=1715210510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49gxTyc0oJbq/wVVFaN0KMeI6YcWMiWBngOx+dk9IM4=;
        b=jjZ6bbJlNlLHXyC98Per60jGcAkZNlL+V9w/2gb4xoVD4EZXj8rw/xgFOYtIqGaUng
         8B074oc90dBLkFVOzG8l70YzWbpW5B3JuMr4ZXz8Eqj7Cy5c82kFWKfgFT+SM64uizDb
         h0tYCI57Trv+pO9YoLosCoKiu/AtrBpwCLI/wN/7GgHjWAY5ie5cXPoM1/K4xllGHC/6
         qFZQa6YQ7XSshfXmH9ZvvjFQ840N4GC1o9OhJeVLQvxaPyy3YbK4ddCRCnDCWMTQoxZW
         jmmJdsdRywJUp4LrtbJA1A7ivnuDm2gV0Hj2cSVkEhnFosR3IxclbVmbVD+wdPWgFD8H
         IGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605710; x=1715210510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49gxTyc0oJbq/wVVFaN0KMeI6YcWMiWBngOx+dk9IM4=;
        b=iitb+pZMrMnZqsTa0U9XANiyjq38nzAxuvUUUamLHsZGcOk02cN4k0cuieJlSKiLRO
         QwS+L9FTTpUobmtPZvt4IO7VxgLdU5JKAfDX8ifAArn+angePcbQzHYRh7HdwPonZmnR
         CZdaEFixCGOJpb+CE1DJczjQm/OgQYMmA/nxbNPE1E12wTEVl/7QVa0KHfdyWAnDy1OT
         yeRqB6I9pNYZQQCxQtcJBzgeTj9fX+4QBOwgi3O1MSfVVK+RNsdRYRO0MTKzH6BXM120
         t32f299nsW3XAviMjqnhjEdKf7JdvglcR3loXh/0pMzB/D+pCJA9s9ku879JkXjDH1v9
         Wjxw==
X-Gm-Message-State: AOJu0YyYYAQ+gVqgxfOf25HsKyZct+fcGeVv8OXD/aCKr3VVBQyH+7wp
	XZHDdygkFZOOWXH/6fI7HgjGvZTkeCs1Sd2+QhcpmNzdAbA2zBqiLM8ynA==
X-Google-Smtp-Source: AGHT+IFQEqReMhP1rOEOf5I4dnN1GrJ5b2SK9mAA+kxgmb1rcFhE1mrTkLpLsZbBPM5DFCTGviVf6A==
X-Received: by 2002:a05:6830:1b63:b0:6ee:f04:41b6 with SMTP id d3-20020a0568301b6300b006ee0f0441b6mr4218828ote.19.1714605710088;
        Wed, 01 May 2024 16:21:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830278b00b006ee4e216d02sm1128040otu.14.2024.05.01.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:21:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 6/6] qmi: gprs: Obtain LTE attach parameters after indication
Date: Wed,  1 May 2024 18:21:33 -0500
Message-ID: <20240501232144.14025-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501232144.14025-1-denkenz@gmail.com>
References: <20240501232144.14025-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems this TLV/Indication combination is needed in order for the
GET_LTE_ATTACH_PARAMETERS command to succeed:
ofonod[3257238]: Failed to query LTE attach params: 74
ofonod[3257238]: LTE bearer established but APN not set
---
 drivers/qmimodem/gprs.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 6bb5879199e6..ebb235545e21 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -151,19 +151,6 @@ static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 
-	if (status == NETWORK_REGISTRATION_STATUS_REGISTERED) {
-		if (tech == ACCESS_TECHNOLOGY_EUTRAN) {
-			/* On LTE we are effectively always attached; and
-			 * the default bearer is established as soon as the
-			 * network is joined.  We just need to query the
-			 * parameters in effect on the default bearer and
-			 * let the ofono core know about the activated
-			 * context.
-			 */
-			get_lte_attach_params(gprs);
-		}
-	}
-
 	/* DC is optional so only notify on successful extraction */
 	if (extract_dc_info(result, &bearer_tech))
 		ofono_gprs_bearer_notify(gprs, bearer_tech);
@@ -186,8 +173,31 @@ static void ss_info_notify(struct qmi_result *result, void *user_data)
 
 static void event_report_notify(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_DATA_SYSTEM_STATUS = 0x24;
+	struct ofono_gprs *gprs = user_data;
+	const void *tlv;
+	uint16_t len;
+
 	DBG("");
 
+	/*
+	 * On LTE we are effectively always attached; and the default bearer is
+	 * established as soon as the network is joined.  We just need to query
+	 * the parameters in effect on the default bearer and let the ofono core
+	 * know about the activated context.
+	 */
+	tlv = qmi_result_get(result, RESULT_DATA_SYSTEM_STATUS, &len);
+	if (tlv) {
+		int r = qmi_wds_parse_data_system_status(tlv, len);
+		static const uint32_t lte_5g = QMI_WDS_RAT_3GPP_LTE |
+						QMI_WDS_RAT_3GPP_5GNR;
+
+		if (r >= 0 && (r & lte_5g))
+			get_lte_attach_params(gprs);
+
+		return;
+	}
+
 	qmi_result_print_tlvs(result);
 }
 
-- 
2.44.0


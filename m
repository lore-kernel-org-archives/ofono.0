Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5401168AE2
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605709; cv=none; b=Z2zi4IkOYKiMHbvl/oRIqF/VIfoIPKQpoRmV9s+au57zmQSuiG0WLBnfxnu1v/U4kqUBq+yEzhGuzeitMpXggvJmsO9nWu3+P1KpOY3bgvo42Bo5DFIKIg0JJUuMzAtzomsI0T/U5NS0AEJAexVx10ZqZ6iH0I0vbMZEoouS2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605709; c=relaxed/simple;
	bh=3s7eg/2w/9QwkI7eZ4wLM+/CycYV6qWhRpz/taZIxbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFP+3AGv+4mOLx/etF1GQnk7aOL2T1JMcs3gyFU7/k1x5FCc3VMFFSuaVwQIpkAJDUuYHPLjHsYXPtBC6rTvHKfebILQCuumMTvYpuBF0D9nA7MmaFAQUMgRpPZy+Unv7CryadCYcS0kwnQFnSubtngIdjUi93RKTF+OzzX2hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0kCbKZA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0kCbKZA"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ee35146ac5so1991118a34.0
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605707; x=1715210507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhSTyREFXvRkGlEPxmtGbcAOQ39xmpQcQUpoaHOFwEg=;
        b=R0kCbKZA4faXxaujFi7/cTReTmUEbIzh+L0u1uogJnTINuA0tF2jyt4c+HYETJx5+7
         Q2vYphWnLKK/3ZAyCLPX2E951ApwvqNQuFOnAbSv0l3AVsoIZsz2y8t4iIIsIi2XOPNq
         Ry4mpXHFl3r8tAwjVHoiy5g8DqWgEW07391lEVdh8jCfvotSfR2tedKBCk1lsek0H71F
         x+gEPGPZlwN938dLZGSryb3KwwgwLS1o4iVe5JKy2eKP/BfZvhnIcDrTKj0/47nMQ2Rs
         hNil2x8DkRe1p8NntqhS0FHMI33to4mdyml0DF0xTA4phcZBbVaMf/nfB+23oWv9DRvd
         Zxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605707; x=1715210507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhSTyREFXvRkGlEPxmtGbcAOQ39xmpQcQUpoaHOFwEg=;
        b=wtECvqiNQQ0139alt4FnX7sjVE17Ky1qWoW0KLpVnlek2CNsepme7/yPAwlffBhBRw
         AVHxCdnzz2XWPM9Ev6+8n+k47aWii/5Rk41S4bPbWvvUZo2CeYCPTf2usG9YHcPM3Stt
         KTqyZKtb3LoEL/cYoPCK7uo1OXoHfGn3cdYa9AZ5hOp/3h/hgW/pc6mw0D+/RKfFBA72
         7OOGr+vgVtdJqFl7y42MQEdtbN1X8z1MGjK152DX8gI+VuB1yDmOgB+8NsdsyrMJFWp7
         8Fl6tUo/4iSFCaSuY3iLGo/YYa2Bfv9awyWuGejnXrT6lYLAVYeCx4Hdsvgk64GhjveV
         7IKw==
X-Gm-Message-State: AOJu0Yybt05jKqFvtXQFfQrNyfOXohBhY1fg2W1K7KWTg9yzmB19yn+d
	qZ1bW7ZRfLdce05if7WsyJrvyZt4iWpiExrQYhADgJz9Nf5hb9Ny/PLPfA==
X-Google-Smtp-Source: AGHT+IHUO67EXcBIP5lAcqk4/TS48MtfZhiCiDV2RrY3PPVdn+IZuir1DvozXrY5gpEOWc9l8Insaw==
X-Received: by 2002:a05:6830:1bc9:b0:6ed:e67b:8699 with SMTP id v9-20020a0568301bc900b006ede67b8699mr414105ota.18.1714605706714;
        Wed, 01 May 2024 16:21:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830278b00b006ee4e216d02sm1128040otu.14.2024.05.01.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:21:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/6] qmi: gprs: register to NAS indications earlier
Date: Wed,  1 May 2024 18:21:28 -0500
Message-ID: <20240501232144.14025-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can register to NAS indications much earlier, as soon as the NAS
service handle is created.  Since the handle is now a 'lightweight'
handle, all service registrations are automatically unregistered when
the handle is destroyed.  There's no need to track the registered
indication id and to remove it separately.
---
 drivers/qmimodem/gprs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 738271905848..bca1897ea02f 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -39,7 +39,6 @@ struct gprs_data {
 	struct qmi_service *nas;
 	struct qmi_service *wds;
 	unsigned int default_profile;
-	uint16_t serving_system_indication_id;
 };
 
 static bool extract_ss_info(struct qmi_result *result, int *status, int *tech)
@@ -306,10 +305,6 @@ static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 	 */
 	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
 					ss_info_notify, gprs, NULL);
-	data->serving_system_indication_id =
-		qmi_service_register(data->nas,
-					QMI_NAS_SERVING_SYSTEM_INDICATION,
-					ss_info_notify, gprs, NULL);
 
 	ofono_gprs_register(gprs);
 	return;
@@ -369,6 +364,8 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 	}
 
 	data->nas = service;
+	qmi_service_register(data->nas, QMI_NAS_SERVING_SYSTEM_INDICATION,
+					ss_info_notify, gprs, NULL);
 
 	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
 						create_wds_cb, gprs, NULL);
@@ -403,13 +400,6 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 	ofono_gprs_set_data(gprs, NULL);
 
 	qmi_service_free(data->wds);
-
-	if (data->serving_system_indication_id) {
-		qmi_service_unregister(data->nas,
-					data->serving_system_indication_id);
-		data->serving_system_indication_id = 0;
-	}
-
 	qmi_service_free(data->nas);
 
 	l_free(data);
-- 
2.44.0


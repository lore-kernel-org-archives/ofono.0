Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E51DBB0C
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202999; cv=none; b=bkT5zjQcgXooXF3lRRgJRC3gVUs5RgmdelFq6sojZ9rtiGiBu9d+HzL//CMe6Pul2dwkFTYI0zsBY7q9O9lMk3O+17OVkATwmmdefPaVytl2jXlhzxIM+JyOH8d4EX3DacMyw2JBUo40BrkdIUoiMBlKD469B07OyjmDFsfkG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202999; c=relaxed/simple;
	bh=jHJtBN7tkMY4JC//mjCTgudJ0dOjinrjj4fP8n7TlJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2xkEJeR6m3lTk5F9TgXzP4L7IcsA+9d1L2Gi5qbCm9hnkk9U8fYSKI0jCdaJlfOaKylEqhcp4kQ9PIOk9oktiaCkH9HVw339PgpkHrbSapsluY8efip6OlRqaZ02sHsYW9q55Pq2TJscfOuQULj8aGB+z4uo9EYfnLse6UUVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjZA2duF; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjZA2duF"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-295d27f9fc9so824560fac.0
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202997; x=1732807797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ep1rTPQ/w023Pu6vGt8sVkI4wCxQQ4L5eMNM+GvPrY=;
        b=CjZA2duFHma2vCDn/pHA60PGbBX/hkHbnO9AYsVhJaowbr6a1cyDI5j34tYha0zg/J
         n4pSteSuqGFbu4mvfKOxqUPPgW3puqLlJw4GLuX/wh1Kk2hFlUGqlS3Gs+8BMFd5b6Gj
         0+/hIQRcCSjmn8QJu95j8MId40Lngbv813RWuVhhh4NJAVHih0HnbBNWLkBY+kjJ2D/P
         yk8EzEQJVfHNTNCLtIM4XiAZ08pWrYM2pXJ4WAQ6uzJrgutGwtwe/x0MrokAt00FLmdb
         2/t9kSGBGKG+0D8MkdgngFLLh5FuqTBDXO2SdXrSw2/wsQBeDwkrbEEohihNytByVuPi
         TvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202997; x=1732807797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ep1rTPQ/w023Pu6vGt8sVkI4wCxQQ4L5eMNM+GvPrY=;
        b=Z12FYmzkdhnq0PTqedRVrr5iyyOYieAe/WbJ3J/8zhR3P7yb7ChB9H5Q/ysYHcLsEY
         L/ubLyjbyrh8gSVeoiiExbAzaOHFFizh82ebuFjGbZpBfYqEKwwnKuhVAiGWy8SnS+Tb
         1y4PKtnG5J/WPR2L9BySvuRJtA1jFpd0pt4cj3J89Tx9MqGy3mQ8eMkIpRUd8wjTBuOS
         UUxnWdgLXWV5A/sE2SPMY+UnWSxE3UkZWBx7xqK/oCfmr+egPBBF5yaK0zL0IWMzjIlG
         o7x6u2Lv0YD2jKy2E7NBhzmutIoxAAwoVxtoDP8ymbMFbdRJ6CGxBIrpTYoRSHaH6M44
         vbKA==
X-Gm-Message-State: AOJu0YzKoKmh3uKBH1WxJiU0IWUjk1FSm7CNTaLwj42cfGEojPqptvkV
	vNkQX5BBqrz1ptiD4PDtzfp0TA/RupQoW2FjhKyjP8EHhKLdqbAkBk2kgw==
X-Gm-Gg: ASbGnctEdc1o2nzUjG32oc9ooM3yK3Pu2GwDxtAD/lB32L/HZaFX6Fnr4b4qOl2SOa4
	AFUj4W6f3BTUIkvxd0U+FsFdKA2RJksyTkVzkxzJ5/ZcuS0t5q80HfzBE6BnCNBrkxXUAwVp06F
	Rt6LflfQCYyEZRVQ+9Sp14q+d5j3lnke8BjnYq46C2GuSvj8Cw6VQPOXRxZZy/JJ5NYck1ZN6lT
	G5a6wZ/2w1a0WAwtaRlpGCikwfLp4bsU7SFTIW5fuzrpAatB5j2pE2zdE+C6KOoI+26WJpbse5D
	c243iArK/QcOKADDLiLrK8cY
X-Google-Smtp-Source: AGHT+IE7i5iIZeMPlcPj1WNn3wXnn+u9v2l1YHWoABkDTqhUZC3z5wtVmy0yEAyaiJ6rIXvP0JZNDA==
X-Received: by 2002:a05:6870:2b09:b0:296:88d2:6428 with SMTP id 586e51a60fabf-296d9b972c2mr7788649fac.16.1732202996978;
        Thu, 21 Nov 2024 07:29:56 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:56 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/10] gobi: Support RAW_IP configuration
Date: Thu, 21 Nov 2024 09:29:35 -0600
Message-ID: <20241121152949.56962-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152949.56962-1-denkenz@gmail.com>
References: <20241121152949.56962-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most newer QMI modem firmware only support RAW_IP based configurations.
This is a more efficient data path since 802.3 headers do not need to be
emulated.  Support this data format by configuring the 'raw_ip' setting
on QMI_WWAN accordingly.
---
 plugins/gobi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index cb53ec582385..111ddd3464fe 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -65,6 +65,7 @@
 
 enum wda_data_format {
 	WDA_DATA_FORMAT_UNKNOWN = 0,
+	WDA_DATA_FORMAT_RAW_IP,
 	WDA_DATA_FORMAT_802_3,	/* Last, most compatible legacy fallback */
 };
 
@@ -133,7 +134,10 @@ static bool wda_get_data_format(struct gobi_data *data,
 		return true;
 	}
 
-	return false;
+	/* For everything except 802.3, use RAW_IP */
+	out_format->ll_protocol = QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP;
+
+	return true;
 }
 
 static int wda_data_format_to_mtu(enum wda_data_format format, uint32_t *out_mtu)
@@ -142,6 +146,7 @@ static int wda_data_format_to_mtu(enum wda_data_format format, uint32_t *out_mtu
 
 	switch (format) {
 	case WDA_DATA_FORMAT_802_3:
+	case WDA_DATA_FORMAT_RAW_IP:
 		mtu = DEFAULT_MTU;
 		break;
 	default:
@@ -500,6 +505,15 @@ static void enable_set_mtu_cb(int error, uint16_t type,
 	if (error)
 		goto error;
 
+	if (data->data_format == WDA_DATA_FORMAT_RAW_IP) {
+		DBG("Setting QMI WWAN to raw_ip");
+
+		if (qmi_wwan_set_raw_ip(data->main_net_name, 'Y') < 0) {
+			ofono_warn("Unable to set raw_ip");
+			goto error;
+		}
+	}
+
 	DBG("Requesting services");
 
 	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
-- 
2.47.0


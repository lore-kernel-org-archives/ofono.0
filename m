Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED81DD877
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203002; cv=none; b=YxMQqEhD3nva4HP2PIV/wN+YychY7+Lrc83CUA7G9KDuYs3ZUtXYYILc4MKSGvrdFUAXZD+WPrQwMjnIH1ZUwRgQMUAW6cCamD8qeVgnIzanE8j5aDTIy4QlFQYUscCqRCv1nymdiB46HEk9dPNh/igG0X9LyCHHHjRjLprhUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203002; c=relaxed/simple;
	bh=s4UdHlpFD1B8aAjSAqtdehl4ctIJUuMcNGL0wizdxH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XINhr5Jm1cAZWrEcwNnZDMld33f65dNurA9fsuR6eYERbPCIA/p18Sx62jR5M0vvWvwisZvsgwid2OVh+AmBNrwR4acnK0xlh+FwE+dgRSCfozt8rRZ4OlDLfbWv6eC0cLv5BHeKtESPx0kjnhPHCyhsMuZEHfonPIry0SEn4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5ElRX6k; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5ElRX6k"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ee9dbf1b47so1054956eaf.1
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203000; x=1732807800; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhssKegXs0dkBlkAs2LAwYuMWY72qVTAcjM7gFFYhEI=;
        b=Z5ElRX6kndW3M6CNqSb3XsWMv1fz+dVs1mAgdjKEbThulxLRS7ZchF8GxfiktsiFAX
         XneVixD1bHs2MVM3FWBoUJ+IQ2nZ6yjpgfrImfffqDf8+I0zQGDj7uTRl3AifmHq5oCn
         WiSrwHOd1Y1ek7w4CdO/JlVQGFXco2twzGR+xA4vHvrZ0DgJbo/HrHHPdOM9DD/Olowh
         lzzghZbup3GtqjJN1o+GfWpVoT2/e6jDkXjjwSyyjVkbrGUFypi6ZpOtNw2fvOUIx/s7
         H28uqntJdEFHdkQTgU4FtoTfxR8Zyt4q/ZtELDnh8Boqazi2vKSbRXTmYUZAYirGGOIw
         XjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203000; x=1732807800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhssKegXs0dkBlkAs2LAwYuMWY72qVTAcjM7gFFYhEI=;
        b=xSkBbu906l+67UvYlacRU5xDQJ8JNIytxdvgPbd2qvXQvX1OmNupzlA/RQUvHCPmOj
         4hCADV1AUfff9momQhlHq7TDxdDC8371HdeF77X9s7toDBIF4nZQ6AIAnbT/3uCnjqdK
         YRA28TViPF2CnvgXhgys/NVFDR6cBvGtAE4C57MYn4lCd0wCYnLH/edMONfv1UJeGxVK
         YmNzgWlX9MkZwZ8MMImHkV+8ifzo3jkiJ1ZuDjMBO/hc/fNLPXZjajWoehHRm1UmHywN
         ry6eFh2TLfhZHGp0w0CQ5X0QtAcahbZcVLjZXpA9ljXsbc3vsTG5G93wwbbs8HshDvFA
         vrcQ==
X-Gm-Message-State: AOJu0Yw7uerNspzjhKj598SRBnXwnfXFiltFZPDjgRd2Yds9Uf8ebInq
	HG+iAI+6B39wuXCwslMaiHvN+JPFvHrz/xNh5xWV77/BwSp0YcClSrjx5Q==
X-Gm-Gg: ASbGnctu0eoYnNDnwTenJ9h6gi5z06xxSyiyAE5GyIrPX4fP7197jopmev/dlUnYwms
	PvvkUDGxQBMRQ6v1AyG/YT2hGJiJwdZ56Lk9ehxABfu9AluoVQSD6UnzWBoA82F9XjycizfNMe6
	GxvOCWPKSZd9EbBi6fzsSqYUxckkrbS/Z4J81fP95yxucfqIkx3aFLkcigbhRTxFxygt9ZYjHRC
	GvdgOT+4EDR91OmkEGyphT7VDJMp821T3yO1SQvwhm/q3umTQZkExi2Smn6CzKtYBPB4cf3q+IT
	GVBQxp6Geh57YzMhFg/aMxAL
X-Google-Smtp-Source: AGHT+IHrWkCGFcN1TM6B9SLxta+uyW7ZSPCp8fCq/pbTtA7L0nXy1dVUbnfaIOnqqa4MGEc1Y4TvYw==
X-Received: by 2002:a05:6870:7d19:b0:297:c05:1b56 with SMTP id 586e51a60fabf-2970c06ccb6mr1125072fac.13.1732202999914;
        Thu, 21 Nov 2024 07:29:59 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:59 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/10] qmimodem: gprs-context: Fix non-default bearer activation
Date: Thu, 21 Nov 2024 09:29:38 -0600
Message-ID: <20241121152949.56962-10-denkenz@gmail.com>
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

start_network() expects a QMI IP_SUPPORT enumeration, which is obtained
from WDS Get LTE Attach Parameters response.  However,
activate_primary() was converting the context type to a QMI PDP Type
enumeration, which was subtly different.  This broke non-default context
activation for dual-stack contexts.

Fixes: 3ee784aa9d9c ("qmi: gprs-context: Dual-Stack context activation support")
---
 drivers/qmimodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index a8ac3cb18c80..484cc7d8ddb9 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -478,7 +478,7 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 					OFONO_GPRS_PROTO_IPV4V6))
 		goto error;
 
-	ip_type = qmi_wds_pdp_type_from_ofono(ctx->proto);
+	ip_type = qmi_wds_ip_support_from_ofono(ctx->proto);
 	if (ip_type < 0)
 		goto error;
 
-- 
2.47.0


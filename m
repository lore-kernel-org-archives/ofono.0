Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6A2BD0D
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716424; cv=none; b=qlrVDbscJ3XeSMyv5K0DSPsota+wnSVjzY3Eebq8bVB1emuEcxGoqsFNKl9WUaHSPc3m5AYpxjGI4vJ+Du0Tkjwf7OIpCNIWKDxybS9Rt54CANCdSZx2ecUF2LOGgpIps63AW49YenkScSxv4SHWMMlcKTmT6ZGO+spxUU8xCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716424; c=relaxed/simple;
	bh=vO4r9cGq68fYR+sL1wt5HYkj6S6KPSzAJWZb1HayTkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3lKQ9GksoO/ETWyyrVHoitJmxcm/CGFbjcK9i8+q2O50o5BmyiSSq71RlujBm7wsI9RWGzC91OV1M/miSNOOqe5GgY2El2RlgEtbRFzuZo7lcm0D5TTYpaNGMzIr9sFAyhajG2Rk6Kgx0hs1B3a5GsL4hXCfOZAgKcEMfb8+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH29+CvE; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH29+CvE"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-80767b21543so40085339f.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716422; x=1721321222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhDPhgBnW28NGD1DexG3TdcWj7WvUa/k14wm4z0A/Pg=;
        b=kH29+CvEkVCpVrinVyGUrrambnUrpD3Ja2a9Rkl2Mq/5gUfm2HQ1pVC13Ow6SISx8p
         XyC57E6ROJ4ALJpdNPfvWQQnDQhZ/gTgV0zO44ru2WEsiTbWVo4qG9IAAWqrzfXm2TKc
         JOb1srHy3MM1FSNapYmKS8UeiO1vT6GiaaQdhm2SvQUh/DxC2quu8mMmlEd3OPaSxSjY
         X1aGfdUwp7sAEDLGghMuXznCkmtWvNJKrHqlbl648joZ1Y6L/ueUIt7wj3iz2WsdZWF3
         gzTKx1eDn+X/E/wlyU9B2QJCxNKgYWKs+Yu7yo8Q9jlk3OWk2Gi4mSIfMxM0mYazYLkJ
         XQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716422; x=1721321222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhDPhgBnW28NGD1DexG3TdcWj7WvUa/k14wm4z0A/Pg=;
        b=HxtcK96loNjCeYhiV+depQARqYkaeoTCnr/LYupQIuavBqYpsFE3zOcTTK5Rf/8ll1
         xlex6QB/gJI6kL+4Up1sLXqyKx0i6hIr9wEisZJWvV8vKk6fhglEXANVyle1b7nufQcN
         Q6lj65PalzfqDAAyFHfmwO5yJuzUViSIbtrfnfwymjFeg2pOJQ8HuSz0Q7tlnypD+oCR
         RgDPYWdYhOmAha08KttlRmLOAe0ZTTG192GXjK4UaXjCDaHytx/xFwRw7UBYwfjAjfhg
         PWuGF3vio0kdqZa/XyU9qH93uTq94uET0vyes5FVrZTZddeuOSGtArW+MifPncBOpfCU
         OagA==
X-Gm-Message-State: AOJu0Ywgx+viexcaOVYfe2fBRqLRVjtb7dhQxQW4u3bYrBwfWHw4seJG
	dleuVRHNEvNCBlbQc+IONYk0vlK0j0tsWShEMcukLU71B/sqE54JvyTrsA==
X-Google-Smtp-Source: AGHT+IGttArU07PPCM8TamzpgadW+zwQLg49n0n3bJq6QDsybMFKm1VefnZz4PbNx1Ss7I7t3Cr+Vg==
X-Received: by 2002:a05:6602:428b:b0:7f6:2570:509 with SMTP id ca18e2360f4ac-800009b5236mr964090239f.6.1720716422510;
        Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/11] qmi: gprs-context: Treat IP family TLV as mandatory
Date: Thu, 11 Jul 2024 11:46:27 -0500
Message-ID: <20240711164654.1688558-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, while here, coalesce two debugging statements into one.
---
 drivers/qmimodem/gprs-context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index f29f10720710..203a320a42af 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -46,10 +46,10 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 	if (!status)
 		return;
 
-	DBG("conn status %d", status->status);
+	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
+		return;
 
-	if (qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
-		DBG("ip family %d", ip_family);
+	DBG("conn status %d ip family %d", status->status, ip_family);
 
 	switch (status->status) {
 	case QMI_WDS_CONNECTION_STATUS_DISCONNECTED:
-- 
2.45.2


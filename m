Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F0155316
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565454; cv=none; b=aZM1Tjd3LCVCvP7Se331IyrCN4CKSOR6vG1i5rqAmHD/slq2/ub5Pmn7Bn9UdTzrV2bxmxZi1xN9Ofjt95I+Dqqc+phPdKX4Eh0O6ewk5fkQu7pCxPpsDWk8e26phRM4CMJIXd1xOYIHQFaW5Y4kdzWkO0AW0lqlGgnE4m4jOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565454; c=relaxed/simple;
	bh=vO4r9cGq68fYR+sL1wt5HYkj6S6KPSzAJWZb1HayTkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI4IRoBwTjrDTn9Y/UeRXrCaQnBi4EfowNiabcx2prnr9diedtsTlnIo+B40b1HsQEqtsVklt+/dsHwI9WQbkw4TD3G4iD3LjXR6iKVSr3CLUexjF8/OY4OlMGicWX8I23QPE0gDU+cn9qrO0H97BGUBrcxP274LsIK7ZiaRJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpgOaplI; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpgOaplI"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-376208fbe7bso22537185ab.3
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565452; x=1721170252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhDPhgBnW28NGD1DexG3TdcWj7WvUa/k14wm4z0A/Pg=;
        b=ZpgOaplIAOuP+ykEp6LRh4aGb7Ktou0Ae5SW+SbFOHulMZJajEC7YoM0xl7UDXXza4
         6F3kP5ejdpkFgyu8UwGO5TrJvz66G/cF/hHXwI2qK1mhUccCj8kQyCvxo7cB8KWdK/4b
         Tv74eXeMSRhPA/xqJU5cL8jGf3K/M0we5w1/nGbhhLaJb9o4vPHGPZX/NENu+I929cpC
         lBjC2TzVyaXJzbPE1+mm6BbL4DVB7RbbbDOtgMz2tcmPpmXgC56cm/JHPGn7SbxSmQg3
         7C8vRYDLz9WZl6hZVlGTfrnV8vJnP5TN/U0N1+Md3jajq15AUvi0mx7ir4kOYNNg3uhi
         TDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565452; x=1721170252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhDPhgBnW28NGD1DexG3TdcWj7WvUa/k14wm4z0A/Pg=;
        b=k4pso+EyqBveWFPtptQGXJBM6at/znKdeaPq8RpnHTOW8KK4eA7Ww6rbDq1Q3IFz2P
         JkuObMKZOcjtLADjRt+7MN/j+Wv6ytVWJ3CjCMHyBiAgGV+vnllE2yOzhJuFvLpLGCsz
         7Gi04qIcdVGZ97kWTi4/04TgZcHzfGhwEzLgUgcvZaBdFsBAb87tE/vTmncjyc+bK+N3
         UlpsTFMU99cWCA9vellY7UJRg9eULESj2WlqvKTZCheECct4FRsenHpjSPIpP4XC8BXy
         mzjfxfa9AOLJNDT3Zuph8WZT0wEWgHeuyqH+8gxM8tFCz6KOZekCQ4F8ZI0HlZhTCTlj
         vyOQ==
X-Gm-Message-State: AOJu0Ywezxl5wZRUfA0uOdcHzuTpeRuhgno36dk43R0VGGkGn2CWXBQ4
	hAqyQCWDQY0jy9OcgEufAHDOmbAD2INldw9n0LAQsMdbdF2nX+gURuUYzw==
X-Google-Smtp-Source: AGHT+IG6b0NNJsHHQi0Ci8mGrOGqksWYIdFdSn0w2rnur4nwGZB/evKX/Lh25zwk1VXg24z5TNk5lg==
X-Received: by 2002:a05:6e02:1c49:b0:374:b07f:6dbf with SMTP id e9e14a558f8ab-38a570f889bmr42611535ab.1.1720565452529;
        Tue, 09 Jul 2024 15:50:52 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/11] qmi: gprs-context: Treat IP family TLV as mandatory
Date: Tue,  9 Jul 2024 17:50:26 -0500
Message-ID: <20240709225047.1427626-7-denkenz@gmail.com>
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


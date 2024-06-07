Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FF19D8B5
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800471; cv=none; b=qpDdZ5rZR2HIpHBsurSEbD5vUTGGOeF+w/x1ZZaylrVgUyK/FsPDpEqGT0mkZe8wM2Lc5TM9hggb/Ceuq8XrXc8M58KxrPhaO3cFq2Qm0OFSi7XKqhXyciyydbrtOpP9QweyK0dzTMD7SnDO/WiQJXApueKQblLFV3XRWx2XhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800471; c=relaxed/simple;
	bh=1/80gbTjlXgIk8OT+kBLx/h+8UXTiTYj8iudPBpGZpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOwXS6IC2OoN/yMFc9BQdhost4i8GRtsqn22LMf0pq650xgwC79HRtraUcN6OVBIbwJit5FVm0sUAdYxH2Ewf4rlcThVEHwoYvkAWyUhJMDMpXUYXNXHmoKL4YFd5+ZHnyK4pnBUbax1VAFkWgj/+vqsg7nS9ZW5gxdVl/P5X1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFXrKFhC; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFXrKFhC"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ba6c41e1a7so1583810eaf.2
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800469; x=1718405269; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXBWSp+cdx6ohzTPdD8kho+bMxW8OHv04nQZYgxczAs=;
        b=bFXrKFhCsB77cHqUVXMiDoxcOHiWhR+DVCnqwoYvXUCRcBNEJMxTbwpOwElCicov7p
         UYR2MaUSYRdV5EQvzYkMXRUpcLp28arovLBgf980xUbvLrEg17yAtb8YuLF5qbjxMFsj
         rPEFWHkwe44s3wMGAY4YOasSMei1On4yqfUcdgcvhfuHFdmad775Nseqmkuv6XEEfXBx
         ktPTivHtS8C/zEWa642qFdtKDMPRBTbo7Y/OCmO8nDO1A+bcMiqeTCj4BULFLZqrn1en
         E2aDCX/zR1TRf9R92NUNSF8Ho8cEDMWW+k1S64g2lS4SOSq85VRRm/0Qr5oc1tASSWet
         ic6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800469; x=1718405269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXBWSp+cdx6ohzTPdD8kho+bMxW8OHv04nQZYgxczAs=;
        b=LZWn4KZnR7qe1haamuxQzgYMZVCTrudHx7kSH+LARJbYsUYu+U7bcfbHUBy491e6/j
         T4mZ68rDAIpTaFEsl3a9AABcqiXDBUEdAUBi+Ap4YnA/Ft1p2+Bm85hAC/RF4IMeotXB
         J+M0ZrBrN0NvUmVMhi5bMDyIpc++Ru1AMuqhoEmjgHQKTF+zZsT0Jdhdr7IIryCcO2Lp
         8+lIxfOWO08rsYrSgj5OO9Ejba44qUuL6DakP3eoccxjGqgjKp5UrbHtOQFkx7MXdRbI
         4vOUqjrdyCn6Vj3nLrX1U0nzYXSUXkIjOOIJHqJahqCO6Q7AQocPmKfmuD4RPXfaDsBK
         PnkQ==
X-Gm-Message-State: AOJu0YyKUeh9qBLG1TRN+wYGZlJsTgT9z260pIHRn7gzeIkvRFIGmE0m
	VNO5Lip1pEKL4a1yJbRW6hQfVaBVbzW+v1MLxneQThwIhbNJhkAF1EOF+g==
X-Google-Smtp-Source: AGHT+IG2PgTfrA9fDxG5AFCjye4D/eNR++O8uKblDSkUEPhiI9NvdQPoqeIpBux/N7YL1fkTjZZbkg==
X-Received: by 2002:a05:6820:1c85:b0:5ba:ccd2:2bb0 with SMTP id 006d021491bc7-5baccd22edamr2174161eaf.1.1717800469206;
        Fri, 07 Jun 2024 15:47:49 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/23] gobi: Remove phonebook and stk atom creation
Date: Fri,  7 Jun 2024 17:47:01 -0500
Message-ID: <20240607224746.903769-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These atoms do not exist in the current qmimodem driver.  Remove them
until they're added back in.
---
 plugins/gobi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 7c105eef992a..147f572a799a 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -748,14 +748,6 @@ static void gobi_post_sim(struct ofono_modem *modem)
 
 	ofono_lte_create(modem, 0, "qmimodem", data->device);
 
-	if (data->features & GOBI_CAT)
-		ofono_stk_create(modem, 0, "qmimodem", data->device);
-	else if (data->features & GOBI_CAT_OLD)
-		ofono_stk_create(modem, 1, "qmimodem", data->device);
-
-	if (data->features & GOBI_PBM)
-		ofono_phonebook_create(modem, 0, "qmimodem", data->device);
-
 	if (data->features & GOBI_NAS)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
 
-- 
2.45.0


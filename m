Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924B1A00F1
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257601; cv=none; b=soO9OkjEOo/N78oQS5HKhdMKbc4RS3BPCGdr394ga4RBwpUw/EUPfRBZO0duYtXHu1RVdT74j4pBSj2BLrRLl6ee2RluVQUIx+S6+Ap3YpgyTUaGQ4yS9+Gu5qkbgQQAuaVobO00JRZWeuuSLzYHxJ629HA4pDGfBw1v8QV3DUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257601; c=relaxed/simple;
	bh=dbqjMrjUQTfCTyD3Ho8KYPphw9aERUYXc7ogkqsrMf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoPzNvRegCZA+tKeO7w34i41QNYt55LOLuBIAEC1xECxzp3k4BK+et2mrKSpkq2aSrbTC+C4FPxuIiw4087eEyClaeD6PjfN/EcTKWzgxO+/vh6jbbwXpzQrLnh1BZJltXdOwjo2FCleEeZykTBp93PqOtL653LnepYIxYOTlZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu3V1viY; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu3V1viY"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bad217c51aso2527129eaf.1
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257599; x=1719862399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INYROVZP49t7Kd5s53aJh9lmOKM9To7nJkG2blZxgp8=;
        b=cu3V1viYwIn1AwspvhwYCKbcXcRyaLael+eTdhaOrWuFxVegYOAvAuF5qPUB8PKvEG
         loEYI40Y7PGTHY0rDxo/BMNSo5KBY7VEziSeFr4uguIGOWLkjer5GWHlcPMhlHvPeqo3
         1ILxlyNKsGmU0jHpOth4pint7KMRfqizGJKZQ2gfDsB6tgcjgweTki7uAeawMpgaseZ7
         SePjqJBJ7fw0xKuEkYeguuaMTESnEDaUMcBlJzn6AD7WJtM5DF2Xvj/k5/h8N+GJL9YM
         orDithCan23q9JNyxk2RdnnHJB9du7ryDC2jQZ7addRA6SohGRJfrHc5WI6H6Re1+bYh
         gk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257599; x=1719862399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INYROVZP49t7Kd5s53aJh9lmOKM9To7nJkG2blZxgp8=;
        b=aQjhQPCam5k/lOVHUHVCf6YU6MvRMdFDfLXBQd96WpQE283HnrsB3yKJE35hZxG4UT
         vgj8din56eQjZdkt3yCxGq4AxI5mlWD7+zB7RAhIRVy8eC1WJkBb+P3GO+6mVDSJR4YW
         jKakja6mWWulctVNCQjTUXthw2FxfdkO4hkdbLKr+2PhDB2Mt1LHK/cjiC2ypEaCGy6f
         xOnsJPxcLKS1jUHK0bnUgK+2NT2NFOEQQykMCkZ/1WxPvIhdBcF3h+q1htQlQWOdRNNN
         f1LHSd66c7j5bg4MisQxe1ayx3ymgHySXRWbWthgrDhGZ0G/cv1640NtxooNDTPeuPy4
         Ubfg==
X-Gm-Message-State: AOJu0YyzY7fve4nwJfGhA073JIETgKN+2AR9yQkpbDc+rDD47blhfWyL
	tgX6uOZoFkjxKb/etUxzMmderJmSvfH7s34S2qlS8ao5M8vx1wtfYqLCqA==
X-Google-Smtp-Source: AGHT+IFZtJg9XLPx8mZ/G20pUAziajCa5i9QZw9Dsd8gAwgkJOy2hNcflUwpMkpIos+3j9aTgAW7Cw==
X-Received: by 2002:a4a:91d3:0:b0:5c1:b998:a859 with SMTP id 006d021491bc7-5c1eec0a767mr5602210eaf.2.1719257598995;
        Mon, 24 Jun 2024 12:33:18 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:18 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/13] qmi: Remove control_major and control_minor
Date: Mon, 24 Jun 2024 14:32:45 -0500
Message-ID: <20240624193315.1164943-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These attributes are no longer used, remove them.
---
 drivers/qmimodem/qmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5f29c4384803..238039d4add7 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -100,8 +100,6 @@ struct qmi_device {
 
 struct qmi_qmux_device {
 	struct qmi_device super;
-	uint16_t control_major;
-	uint16_t control_minor;
 	char *version_str;
 	struct debug_data debug;
 	struct {
@@ -1235,8 +1233,6 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 					type, major, minor);
 
 		if (type == QMI_SERVICE_CONTROL) {
-			qmux->control_major = major;
-			qmux->control_minor = minor;
 			control_version = SERVICE_VERSION(major, minor);
 			continue;
 		}
-- 
2.45.0


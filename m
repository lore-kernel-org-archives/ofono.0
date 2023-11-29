Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBE14017
	for <ofono@lists.linux.dev>; Wed, 29 Nov 2023 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqKkDJxh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so35254525e9.0
        for <ofono@lists.linux.dev>; Wed, 29 Nov 2023 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251056; x=1701855856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xTIo49CK+/5j7rRRFNRLblv+gJ0s+7F2iuxB7BAagg=;
        b=EqKkDJxhXFZ2KH1xEcZ+XHV3TlKXR+CIbT0Vb46E5Ex/QZiU+/fxj+0J0Yi9/1TWqv
         B+fnqJRWDnvp/vTNQuPD3Ad4v+GZ9eTRD2szBZ0CEk7sC1XN2Crv2uP4LXcOlLc1gatD
         uAmuHSjjV/aKBBpzFgqIXPl4u0l1igwWWDQBtZrHSx3FAheR4MbyCQx3KigfHUqj0ZXZ
         DzkwHiYVMOrz8Pq5CvUXUWVJM1XWo5/h1h2oJQt6adVaSjyqHPtVVhMHdE3APst0VVE2
         QreBDanC18dwWSSRAkTm7AN+4xHegddz3Stbx6I0/Fb0ZlyJIcsGy/yxUJMTJp9oELeX
         TGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251056; x=1701855856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xTIo49CK+/5j7rRRFNRLblv+gJ0s+7F2iuxB7BAagg=;
        b=iVDlWZRa8miHDN3bai4JX4kJFp697lr2/NWyaSBweWy+QCc0RJP4uzYORJ46tsw3yT
         YuWG/VxlChhNO9hxNGIXKhklQeBIam3O3O0C3nE2QrNoLzTmbjtmgUCT/2RF4firMTDG
         uvSe/DHocysfE8JtSmmrg/N/tLorPyQg+OevJLSfqOTptwY+mHe1YbQiLSTDH691/qWb
         AClMnJoN92PX+KhnxIpYc0VH/e3e3vUIZI0Hnddu2jJJ83DOtdLP0uviNVJdWQ7Pw5uA
         rcNE4IHeHANsI2birR4Z8ZDt8Et+IJyhNcaXbUU9XwX1Evc3WwYTGhGc7y0ZJ5DJmgb9
         DvWw==
X-Gm-Message-State: AOJu0Yy9UeRF8YMyy/uBz5SmMb7alq34iiru6nG6Plk3PqWUWI29M54w
	bJHjHc1quoTfx/yoVlrPEnI4x4qK6kC14g==
X-Google-Smtp-Source: AGHT+IEbWBwowl1bcumxq1fljsG49xzkhoph/5rft4iWZyzFGuJqpENMl1timnB019cQhWTEeTJWZg==
X-Received: by 2002:a5d:4111:0:b0:333:b8a:ac2e with SMTP id l17-20020a5d4111000000b003330b8aac2emr3476286wrp.68.1701251056396;
        Wed, 29 Nov 2023 01:44:16 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id cm18-20020a5d5f52000000b00333174445fesm1396217wrb.5.2023.11.29.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:44:16 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] isimodem: radio-settings: fix typo
Date: Wed, 29 Nov 2023 11:43:47 +0200
Message-ID: <20231129094403.401316-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 469ae3ba ("radio-settings: Port drivers to use
OFONO_ATOM_DRIVER_BUILTIN")
---
 drivers/isimodem/radio-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-settings.c
index 4e51b980..0875d715 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -371,4 +371,4 @@ static const struct ofono_radio_settings_driver driver = {
 	.set_fast_dormancy	= isi_set_fast_dormancy,
 };
 
-OFONO_ATOM_DRIVER_BUILTIN(radio_settings, isidriver, &driver)
+OFONO_ATOM_DRIVER_BUILTIN(radio_settings, isimodem, &driver)
-- 
2.43.0


Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91403184106
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426006; cv=none; b=s149sSoiQI294sZVF0Cpz8YOCO+UnFQa2tCbI4pJ59b/ThDD3wOng9xowQvC8ksHYGoGpR8UvMPzdd55k3nypIDdTN4IbSKn8MTYlHm17LRtK0pJooM9E+GGVPYI3hBOMEb2H5oyn/ETMX886/WifE+QqZ/0pQKm3U9yMAwQlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426006; c=relaxed/simple;
	bh=Erikr3nz8GxGrS3NQMz6P6CP8AFwKrKJyIwYc2h6B58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQbNYb7yWU1tHY7Oj2q1Ho3xD3o+WTmoRvQEZ365uhl2A4vjjDgO/ZZMMHgMqew8S/JiTneV7SJ2yWAgL1bOBL23Th1Car97WT3UU/ircgA5A47hB7WTxO6zYuEXl/uCiyfSV9Vlh8aTg6iwCr5telVUxrUFR1cNsrw5EVLNMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmClZhGj; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmClZhGj"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c61486d3fcso2991634b6e.2
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426003; x=1715030803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4/bWe1d17BckVLq7Q1kVVsjJofupXGVNIsLwQzN6d8=;
        b=YmClZhGjmCrQF8/dDCzij49hquFIN2hkTjknVKknK4rb7n2+Y7iFAY44Di4oWaREsj
         Iy4QCkL2ftrkbkD+zHD/6Njs3Af4nt92ZbduOOrPJgkpquy2IbvnxUwbMS4I3KklKGtA
         pAqwv4QCRsP54RMaylGBd4jD+1xxvi56GgpNPyHF4WbmkAEInev5StrXb1UIJyvhArjq
         fa4PxCGqTq65rleTwcj3JU3ylPYaFdLKht/crQCaYvoumcXdAl+6D3ttgi87Zwxe9T96
         P8ze2Nv/GJo5De/tdWc+ZN69X5PRKKEUpFlhGNskPECSPunCDjbaU35UWVPjG/70n5tW
         nSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426003; x=1715030803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4/bWe1d17BckVLq7Q1kVVsjJofupXGVNIsLwQzN6d8=;
        b=LgaMO92+9umEG/pjeOGDw6KFrShwS0kpfhmZdmLX7+iHe/JY5hTsknqq3aTU40OLnr
         lLpQui1d5daCpQTDdyhoVZ5MVlsnReECLpS+YUzV/QK04aBJhVy9r7AP1WNTbceO+eT1
         wzmCBmAW3QB70z/Y5ZdtcuBawQT0Of8pnncZ8IN0ZZ03u258MQsnvF1QmfXYkCIpPy9F
         g5JEzW6VOTkUK3zrJGvEfLqydKGUb0qlvryRXkJO5vzTl6ZolbhnePsg5EU53LpYBGHb
         MCwiPNv8df+xXElfrQqth2F5KArEenPcf/I6G+MDN2U6LlZtHo9TBllXK/KsBe6zdTV8
         NbgQ==
X-Gm-Message-State: AOJu0Yx8y0XYfOzmUOWtZt2ASOOZvUtMy5Wu/FGUPmJCPRE1IZp32boU
	Xx/wzNIWrEen3jRGUHV2YpkT8VWPUjBUyKmrlvevmdkgl23zSwkRwjQmMw==
X-Google-Smtp-Source: AGHT+IEV0KtSLKK04NpNWKM28bg43cT3lmPTDadt9P98L5Th0w+q4bX1kdayiiRZPBkH7v8jPjhySw==
X-Received: by 2002:a05:6808:140d:b0:3c8:2af3:6e58 with SMTP id w13-20020a056808140d00b003c82af36e58mr13514548oiv.58.1714426003379;
        Mon, 29 Apr 2024 14:26:43 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e19-20020a056808111300b003c6f5b8a5dasm3466183oih.6.2024.04.29.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:26:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev,
	adam@piggz.co.uk
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] qmi: voicecall: Reflow the logic to avoid nesting
Date: Mon, 29 Apr 2024 16:26:15 -0500
Message-ID: <20240429212640.11474-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/voicecall.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 0df65226307d..bb4c4c2ce204 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -692,20 +692,18 @@ static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
 
 	DBG("");
 
-	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
-			*vd->next_dtmf == 0) {
-		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
-			CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
-		else
-			CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
-
-		l_free(vd->full_dtmf);
-		vd->full_dtmf = NULL;
-	} else {
-		send_one_dtmf(vc,
-				*(vd->next_dtmf++),
-				send_one_dtmf_cb, vd);
+	if (error->type == OFONO_ERROR_TYPE_NO_ERROR && *vd->next_dtmf) {
+		send_one_dtmf(vc, *(vd->next_dtmf++), send_one_dtmf_cb, vd);
+		return;
 	}
+
+	if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
+		CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
+	else
+		CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
+
+	l_free(vd->full_dtmf);
+	vd->full_dtmf = NULL;
 }
 
 static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
-- 
2.44.0


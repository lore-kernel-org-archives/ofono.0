Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2621CEE91
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412415; cv=none; b=hmWLerzZMcuBn0JjFM2SeXXTjUoYWCgcWo9hmmvpoepzGmD8z5/GHRUMg6XNePF8J/qPbk5bPacDHt24GPYx/wwrfHwo0gBjGvrv9pCg+R6p8yDRl1V8hh2sJFAxPUR/OEqKrxnZIqS+TaMoP2GEYUP7g6gCa8kK1cqj/O6MfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412415; c=relaxed/simple;
	bh=8iwI4CYNvmkG6/t1MmpsVOWSzwmdQkGiJhJkcI37gj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqtzxbpgSuiOoixD8SD+u1qtA7+93qMqbss/uPIj2GYBEBzALtcWCss+C8vXNXp8DrFXc5FMfpCCZYuhJwHybCf0G99ejugR0MRSdVs9X54fRGdz+fjPjUpyNKP9GKR/MgHROw6RU9bXPrC/nbAPxbv/KHsSch2AZX22zzVg8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp/uOIGm; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp/uOIGm"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71811c7eb8dso866343a34.0
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412408; x=1731017208; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wni+vWfXstmxk9EPEv18jU1QK8QaTG115FjggOXVjE=;
        b=jp/uOIGmvOKsHzwL7c62amhOaBV9eAgDQExP52Pwr0LU0Zw1UtmRM21jzCnCFOJUMU
         GY0+BYZgdDY/kSxFAHYxA9Cgq/bnuCvFAyvnCpNCILt3v03PbZ+8jWzHFVvxviMRXY27
         6rWu3oUiB1xjvK+P8kMQIkHKK/ri0YISssRubOswN6hVuuK23n7LzStdt1bjtl6TBm2Q
         prWb/ulnlc1lNTJLAwIAQ5HabfLUcUb7r5ZAL4mNcJt+owqqYiv2b/mbrPBryZurzAnf
         In0iFp4ceAf+b1HXlHhAYFxZRvyXg2fAKaJaMM1Gj4GYrpndzxZDTGRuEBG0c/F6cNPl
         dLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412408; x=1731017208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wni+vWfXstmxk9EPEv18jU1QK8QaTG115FjggOXVjE=;
        b=OztHRcJZKCAM33C8zZuG+lB1DqudlUrRqcVL6z/aR5OnVEMrNk0MmjNJeJHD+x1W0O
         qdap5iv8O7CnvfYCz4BvFx4XE7DBQj4YxdthsWmI8hYbB96ncYNpjW9o1FKusEcxdTcY
         BZxFUVHlABRSxmtZmkosJcY1Mysv7ItYxWxPIEuDVckm8ncDCkCj5JFzNBqctp4qisf6
         0vuSYmxC06rGE1dJJYqIdbuwlI9TsGX56R2sYQZtKDa0N8ofaMXNFcPj6xv1k5gRSA8k
         wq2zS5EAMfBcfi6FCUu3zWHe3F4XeFzmPJ/BUTOVMPVzuWicoabseXP4Ovy8EIq9pP6m
         orNQ==
X-Gm-Message-State: AOJu0Ywr4pw4NixoGxHS2f5cjPOAiwc+h1y5qScMDhl9tQ5uYNutfcb0
	aSXaxL0zgc4hfNISlXe/PSaBazT2QkIAC90QD8A8wU5GCpgibzBZfpin6Q==
X-Google-Smtp-Source: AGHT+IF175eA1l9QaW74/u9o1slhdwcagLKm8/X5Ra3KZl/Ds193yY8SVEliYCyU91F4GRDBe5We7Q==
X-Received: by 2002:a05:6830:25d6:b0:717:f707:cb92 with SMTP id 46e09a7af769-719ca25e885mr1465358a34.28.1730412408414;
        Thu, 31 Oct 2024 15:06:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/13] qmi: wda: Convert #defines to an enum
Date: Thu, 31 Oct 2024 17:06:20 -0500
Message-ID: <20241031220638.1582166-13-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/wda.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/wda.h b/drivers/qmimodem/wda.h
index 25bc01eb7565..fd1e1f63ab1e 100644
--- a/drivers/qmimodem/wda.h
+++ b/drivers/qmimodem/wda.h
@@ -10,6 +10,9 @@
 
 /* Get and set data format interface */
 #define QMI_WDA_LL_PROTOCOL	0x11	/* uint32_t */
-#define QMI_WDA_DATA_LINK_PROTOCOL_UNKNOWN	0
-#define QMI_WDA_DATA_LINK_PROTOCOL_802_3	1
-#define QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP	2
+
+enum qmi_wda_data_link_protocol {
+	QMI_WDA_DATA_LINK_PROTOCOL_UNKNOWN =			0x00,
+	QMI_WDA_DATA_LINK_PROTOCOL_802_3 =			0x01,
+	QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP =			0x02,
+};
-- 
2.45.2


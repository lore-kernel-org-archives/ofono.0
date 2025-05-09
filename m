Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286425FA06
	for <ofono@lists.linux.dev>; Fri,  9 May 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820899; cv=none; b=LQhjeLfL2o4S00xVEZamkuoofwe//NxxWw8PyM37m1ftxcWczCgl2jzu8UEClK0JUKas087L4yurBliKMNFqJobGj3ErzGO8IE07TgsGTdrD/xXdDoKWUehM/X1u564KXSXzkEw64csZRzMT8GlBOLqqrKgmLL5a+NL6M6k8ojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820899; c=relaxed/simple;
	bh=xalRSeuRaCbNmRhSVm9Yx/s5lki1GO/rsRHPb3d/Sn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WppqF5s1ph6PjcVWHjuMxQ/W9cSpVx3A5TKMjxzwxhf1HJbzps25Ie+/5bTFrZCloge+gU31ns+zI4KX0mU4Wes/7DTofOlQZXM/mcBRcA5/oC9mJluOcDOI6JgPsBUmwn3815N+rBzwkG+NBuIq/BA1FopIdgFW/SSTiCnYzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCqQhON1; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCqQhON1"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so908700fac.3
        for <ofono@lists.linux.dev>; Fri, 09 May 2025 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820896; x=1747425696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5VtHLD3nKruLf7b729F/5/fxpxFi//3sKynrH/Fn5w=;
        b=mCqQhON1LF1srwBNDnIbcyPQPxn8OrZhBJhT9tTjlFlD0m3aNyf8aRYAg11mVJRuX5
         algZ5TyCFvUQzB63g5JmCscJaaf1Gq2t3AcJ2GfU07QUEfXzo81DEMzSSod5AuEOTGVh
         oDOf4aqOQ3Bmpdkz3joCt+l5z7/UMAC41PRkQkZqy1nGzedDctkfqaNZN6Wk5DzaYCw2
         eOJ4RgaGXfxJ1RB77nAOaW2tKEEBMH3Y9tyoId2C6nhpt8XgHPKy/Oh8pDL34lHhSHln
         RSWqkeBVCfIwE/3I1lE684lC1kbalFaog8Inzf+0FcbmiSi1n4Dld86mkwEqxDCE3ILw
         AzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820896; x=1747425696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5VtHLD3nKruLf7b729F/5/fxpxFi//3sKynrH/Fn5w=;
        b=JNUpq6/zTf+oT8GQx14/nGBF/qazkvlx2BITzLrSDjuyzfEmgiR/U0Zdalg9L6Us9R
         9UeVDWI7oh2K74Vja5b6gjAwoNRWgg8+qB/NJgcb9RYiaIvBTsU2GIG1I9XyDR5rK9l0
         ijsAR32/NrMN03rpCoMFvsjYF9bjxwGInJFpVH3SWdMuvm7kGSF0v7+4EKEO1Rja0Eea
         h1WwjDOxRGQzOVidBRQx3t6kxaMvaZBUsSSn4ciEjV9TY9fTkjKIS/snC478E16tY0Fx
         QlvA0XmtPENdkZ00p8uL4qE1al/b8wOCJRJd0FnIfqfrOgXW6gdZYEES+XOCyBHn9uJe
         D5Ag==
X-Gm-Message-State: AOJu0YxoJb4G0Jne4+rb9Rr4q99eHiRNDCdTvXl06CvjYC6d+2l6kEez
	vlOgFvorq+TmYlWWh74EX2M4AqWd/uY/9KFQD4GVPoh2hgqggeHB/UKeug==
X-Gm-Gg: ASbGncvrEK2XxxUGEeU+KmPlpqswUjT86y59siOpVnoR5LDdJazarwqsQ/kisUzxyx3
	LbY3I6yDjPr7EGLQfRq8t38y2/WNvvIolRgrTJK85qmwjTxjewiUJp0hj88XTYYJ/xv8FRm6ufM
	EfK9GWGXPKg22d/Mg7XKIxkoWbnGtNIS5JaCJsI+mMePso5FjfqsrUdTSMm70FjUY+oZAjQYV0v
	juMm0HWT/aKltWEKzACflnVDuFIWxPFdDBjq9HU5Wcl+56qUITIfoF+SuRsWiqJqOs7RhRL2Bq2
	nIJBwkqDRwUY6IvwOEi9e9/lDqJgPJvjsuMtpZwWcc80lMRqrYtGpzx+fY4wAy5hm8tvm8tx0W1
	NITZ3PkYQJFzwYrgqLY72NpYb2g==
X-Google-Smtp-Source: AGHT+IE7DSSouNlVogj8ylmxLCbm8CT/LUmTJU9rlaz08N042oUyzs/mIaB5MHBVWeUTUpiBtOyBJQ==
X-Received: by 2002:a05:6870:47a4:b0:2d5:c61f:c2db with SMTP id 586e51a60fabf-2dba4550d96mr3074539fac.34.1746820896585;
        Fri, 09 May 2025 13:01:36 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264b2e5asm667326a34.19.2025.05.09.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:01:36 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/5] mbim: Do not require the DescriptorsFile property
Date: Fri,  9 May 2025 15:01:11 -0500
Message-ID: <20250509200131.42020-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509200131.42020-1-denkenz@gmail.com>
References: <20250509200131.42020-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PCIe MBIM devices (for example, based on MHI) do not provide a
descriptors file, unlike USB MBIM devices.
---
 plugins/mbim.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/plugins/mbim.c b/plugins/mbim.c
index e1d33f477515..fa4a25d58eee 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -80,22 +80,19 @@ static int mbim_probe(struct ofono_modem *modem)
 {
 	const char *descriptors;
 	struct mbim_data *data;
-	int err;
 
 	DBG("%p", modem);
 
-	descriptors = ofono_modem_get_string(modem, "DescriptorFile");
-
-	if (!descriptors)
-		return -EINVAL;
-
 	data = l_new(struct mbim_data, 1);
 	data->max_outstanding = 1;
+	data->max_segment = 512;
+
+	descriptors = ofono_modem_get_string(modem, "DescriptorFile");
+	if (descriptors) {
+		int err = mbim_parse_descriptors(data, descriptors);
 
-	err = mbim_parse_descriptors(data, descriptors);
-	if (err < 0) {
-		DBG("Warning, unable to load descriptors, setting defaults");
-		data->max_segment = 512;
+		if (err < 0)
+			ofono_warn("Unable to load descriptors");
 	}
 
 	DBG("MaxSegment: %d, MaxOutstanding: %d",
-- 
2.48.1


Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59666839FD
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406254; cv=none; b=Cvv2l2zd2OX56ukc7zPM5yiguN9M9B3hSqq+KWNPPbuylBrjYONk/XkIdEFA+IkvZD0GEgFE2E2iXNBKNI32Iq4CWJBG7+2e/gI90XSrZ4hLtlxdKZGKEq7dmaVLz6ese11GnAxuraNIvWKLwnJFR7q8AeOevLit90SD38eUKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406254; c=relaxed/simple;
	bh=x+romm09j+Aiw2ODWBUeqapMIpgf6YERu/oOJ3UDV40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmP543gwIVcR3YTbO6FeTXTZ9wB5P+HAifr6ThvD4xJ87zz/V/9hlIM5ZCHzJqsSqayFMWvEFdBPgpM6WJogWVORlH5MLeQkeY1iYlp8NuNTKEz4JVP8HJ5gFeSEK8X24HNQI4aKvKXdhejmX4q0v5jLKV1gou2jQMQjepx/BCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqDriyw+; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqDriyw+"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c709e5e4f9so2970583b6e.3
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406252; x=1715011052; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK1nmFk27qgTx0lKAKUM3BEt8SUtlL2Rlpy0VRvBtIg=;
        b=nqDriyw+fu9YfpA6gBs9o9k4TZSwpl5WefDTwYJoE+025R28dftJoD2e7qNJ4tLdS5
         pyHynXBSIdLvtg8AjXgjb15wKwN4TvzGLgH4EW+GxtwVyHT0T1REO8Z/MJx3g8U1f4iR
         myizBwk0KKwiFHOPM/YVI/ZTviIrLoorYuXQS3ZlXVVtKpFqzGU0KaSaEgjaIqeSBQZB
         BuqGPTo6cpCANXawpFcLlzkhONshq6NOXJorbuxkl7AQ9+Yg7ul+FEI9wfTzeKz/VvVw
         86bTSoUTOq46lzDdaqF7YmNNe8FVNYTHcXTA5gaxE7vVemVrjU0r0Hh7R74zGnmhKV8A
         J3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406252; x=1715011052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK1nmFk27qgTx0lKAKUM3BEt8SUtlL2Rlpy0VRvBtIg=;
        b=A3h+hy4lKUFlZaoQUyUKtMsZDDIYvviHgOlv0PxqqFwi0M4773tE7FGnEfek5wGwlb
         bfJTlbMNA/6bpK8huYqaSzZrQvUi+s8B0xB83M83JaBWlsxhtEkpQT+NS1+stzcvQXVc
         Y/sWOx8g1l1DfexhazlKrdOcJYbeG06op2hdnvTtyua+AxY6UYMsL5tfqAxdwX2TovJT
         uOvl0TdfrtrgdqJmatxwFgJ4cPUlB6fM4COPcr7UM565oHZhaJ59H/1HeBvC88eU6rc+
         jCPqXVL1WY00zlmShywuRLLAk7OlPb9fiWby1hNPjWfjbWkVOKmEPtGmz2s/gYUz3qSW
         27Nw==
X-Gm-Message-State: AOJu0YyovF7GyjM6Vc/31FlC/ja6nMPTytoyjAXHuuHaJ7Za9FvRbsCU
	NNk8NqVjtr+A2bm2YHyuFFkc3ihI3Jh+Dfr6zfqeCHAE7j7SfLQ5ljnt0A==
X-Google-Smtp-Source: AGHT+IHCfBlNKr/hZTajRHaly0e61YMhH5Uvjvc5kTajzZmGMgjAtcNnBaw7C2aA06bU4Fthzp9zrw==
X-Received: by 2002:a54:4088:0:b0:3c7:3b1d:bb59 with SMTP id i8-20020a544088000000b003c73b1dbb59mr11782954oii.2.1714406252297;
        Mon, 29 Apr 2024 08:57:32 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bf29-20020a056808191d00b003c7443c0efasm3117820oib.1.2024.04.29.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:32 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] udevng: Add "option" module managed ports to gobi driver
Date: Mon, 29 Apr 2024 10:56:57 -0500
Message-ID: <20240429155726.51479-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429155726.51479-1-denkenz@gmail.com>
References: <20240429155726.51479-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes sure that any tty ports that are managed / created by the
"option" module can still be utilized by the gobi driver.
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 14ae2f392da4..1aa9f2e4b4b0 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2014,6 +2014,7 @@ static struct {
 	{ "hso",	"hso"				},
 	{ "gobi",	"qmi_wwan"			},
 	{ "gobi",	"qcserial"			},
+	{ "gobi",	"option"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
-- 
2.44.0


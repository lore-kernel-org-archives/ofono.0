Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D8BE5D
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311263; cv=none; b=rs7vp1GF7rMNv47u05dEw5HuMC8KPacibokM4okxE0vwwj4wXGnPZ/tXzGimAuqrVsa8CvN677++wfHRREW9idPtE9QKWc3BqYlp4AqaFg5fE7AYhA1WoHVOS7gdPrit0dTktWIDYCVeKHexHFNOBPGusHgbpSQBalyZUhofDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311263; c=relaxed/simple;
	bh=ElP2wNR8Y+GTbmzRbEek5m45mnOfx5qgVHYi/ude8sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0gfOCi2egD3Db5cTmBfE9Nm0hgb/KPe8/D4HYVRAwL9sQ3gzltwllEEHFdnMSeiYMaaR+wzG0yiflUq/TiRPFjQg+qeEGzK49ejLlZ3w69a0N6CRy/zoZ5tJTPUq9pWzg80lAKFJcM3EzSjLf7hn0vPP4Y065xCZ//0Z9IRmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAj7JlAc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAj7JlAc"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7093f3a1af9so2362211a34.1
        for <ofono@lists.linux.dev>; Mon, 29 Jul 2024 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722311261; x=1722916061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1hOOhZbxtafbDmz/wPHE4y7Q75WJfzGnYG0O/2JH3k=;
        b=UAj7JlAcuwdFREgToedPFkm0dCYJxbT/3Fu8M3EFQv6m3PN0YdSOJw6eSpzzJZQLGV
         VdItqY9up9C1bObfrvgeLZoHegFmgOdI4WqleX2qEFCLEd9cX6V8uRyVLpDzta7jHfDe
         AvQLHSzh9ht1VexZnEhWUlscXC0xWVB8Ig6/Ng64N+mPNViI+5xhOJ7aVVKqYIOdAbXo
         i5BX53k/xXWjCvXQzwQcEsek/FA2+Fvn19ZTYLokqCk+uaecaF0ECcEI9TOfqSSyvN/f
         bV8tsCzhL+inMcdbgIaP/L0VTDqes0LoW2sJAMb6p1omXI7nNdLze/6bZsE/uuKZp7C7
         3+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722311261; x=1722916061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1hOOhZbxtafbDmz/wPHE4y7Q75WJfzGnYG0O/2JH3k=;
        b=u0nA3vhCtLZo4GUcKwlQ0dgDxiAi4NMKvIJwLaOSu92vv1pxhs7W0N6EdYzblVqtJq
         9ZOWSHgIVpBHtsKdoBk4E87BYFu72YUhGABAMBMO2s+ZbqNLnXSI4fAE3wXHrNLrJwiM
         zsNH1j2XD9yTCkdI2hv8bejWSEp1MYbAAgz8pwQPVjfY904s0ZuW+oPPldTKnsCseWxt
         OW3SKiODUycSYffVidYbmzEyqdHHsjQ22PZoeCzhSJ0nTwnQHOAkkc2BdIQkbKdzpyub
         MANmsOgVaCR1FN1GcPkfD+wm3JB0hpEBF2uVoquB+8ytN6+ZWN/+jUTX/8ZYMUriojY7
         qzrg==
X-Gm-Message-State: AOJu0YwYTNSO+hug+xbSVIL+JLDQIljqqvG3dHtSpYLKpYZRwmn5K7yw
	FWnd6X2exaUa+lAT6BXxZ8uhYclbG+Ewnk9FeQkqd52+JGO/JpF8bbEb7Q==
X-Google-Smtp-Source: AGHT+IFa9lk8OKWvL2jIJ8xmomHqXvtt25k3DDI6G5R3szRWynGrfrnWSL7BVPavgyGu5CNfoDkp3w==
X-Received: by 2002:a9d:6c8f:0:b0:709:3585:fd79 with SMTP id 46e09a7af769-70940c1a9c3mr9509832a34.13.1722311260659;
        Mon, 29 Jul 2024 20:47:40 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095aea6f78sm228285a34.56.2024.07.29.20.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:47:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev,
	piggz1@gmail.com
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] qmi: Allow qmi_qmux_device_discover be called from callback
Date: Mon, 29 Jul 2024 22:47:12 -0500
Message-ID: <20240730034738.222227-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the gobi modem plugin performs discovery, it checks whether the WMS
service is present in the callback function provided to
qmi_qmux_device_discover().  If the WMS service isn't present (likely
due to a timeout from the modem firmware), device discovery is
re-attempted from within the callback.  This functionality was broken
since the qmux->discover.tid was not set to 0 until after the callback
function returned.  Allow such re-entrant behavior by making a copy of
device discovery func/user_data/destroy members and de-initializing the
discovery structure prior to invoking the callbacks.

Fixes: 217b57328473 ("qmi: Rename and refactor qmi_device_discover")
---
 drivers/qmimodem/qmi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b8f46a5b4a0e..0ba2e8b9e352 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1152,13 +1152,17 @@ static struct qmi_request *find_control_request(struct qmi_qmux_device *qmux,
 
 static void __qmux_discovery_finished(struct qmi_qmux_device *qmux)
 {
+	qmi_qmux_device_discover_func_t func = qmux->discover.func;
+	void *user_data = qmux->discover.user_data;
+	qmi_destroy_func_t destroy = qmux->discover.destroy;
+
 	l_timeout_remove(qmux->discover.timeout);
-	qmux->discover.func(qmux->discover.user_data);
+	memset(&qmux->discover, 0, sizeof(qmux->discover));
 
-	if (qmux->discover.destroy)
-		qmux->discover.destroy(qmux->discover.user_data);
+	func(user_data);
 
-	memset(&qmux->discover, 0, sizeof(qmux->discover));
+	if (destroy)
+		destroy(user_data);
 }
 
 static void qmux_sync_callback(struct qmi_request *req, uint16_t message,
-- 
2.45.2


Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671212BEAF
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961709; cv=none; b=AVxn2om2lzV1rFWB2xpskRm7+y1bLjyezwBM8PgSqFFxV2XVFjHOK24AfNkPcJVHTqEnfGLSqATFcPRWwxwsj7cFA8OA+A/Rn/+fA8mOC7Fc02lCGD1LXZALmT7d60wYLNRVa2GSbLANobwspEHTKfB5Dmax9OPiPUUp/6pH8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961709; c=relaxed/simple;
	bh=xEZxSXcCD67mBef/SXN0Cvscw/KtOJJZhtPHolxhpdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrFUqgATkKJ2hAK8y4rj+ahtrrwQDULmW+CJeJGku0J1pk3006F1gDlRJmX7cPRclwQpbK6ekPUlko6obsESTe3wB7WoMIiWPcpI/NrneO7jmxCnrRZLF2J42JXGZlJ21NSQ/WpRunzs+/VuKG7eAwUF9YjzS8Lo8Wu8QuWWdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi7PXeTF; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi7PXeTF"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21433afcc53so1784343fac.3
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961707; x=1709566507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQrbnU9xR0agc1lrbNVhSCW3rOMxu0RLrIjSwe2tv4U=;
        b=fi7PXeTFt29douXuCKb/9kt2+uwdHnYdOKLSg39MZ1zmYyKu+wy8CBP+ftJbA8j/+U
         L3lMmzu9q05nvDOXD0a2iE1PFWJ5+FkBM5s2oH0y8SspHxihmjhIXUnCShyYWv7KPwxw
         Azfh7wh9wG60XQudR51kAL1HpVawa6/PQxv4ilGxkia0Ayio3jyzADkZoT8jisCKd8+5
         GwGigdYryWW4o+y3CloT6gkGCX/b2CgqThOX0YsdTQGWJ1nKVlW1N/q6+JFuBO4aE2Vp
         Jk4SR7YTqa5TrUp9+h1eOhsN4MLfobA0BeBFrDAKVme9U/j8YTObHJiy6vuOUdwK61ic
         KINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961707; x=1709566507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQrbnU9xR0agc1lrbNVhSCW3rOMxu0RLrIjSwe2tv4U=;
        b=w5H7pGdDy43Lc1GgeEUqXg/roUErQo0KfxakvDFVfylYHYnB7ChJt8WvCGGF0TPdKt
         AakNgAhOLtTXwm/dZCLOMc0F7XmhJE9hSFpoYNJtBSUBpGBsWs0exM8vT3gmzWjot2PO
         m4HwFr00/n4BY2k15S1L8y7CjI9xvHLOKsQtwNax4IoYm9NwmVNB6gdz0f7LYD5PapYc
         KBYwGvG99tdtqHztivAi8EgGXWGWeuUrVBre1tkNF/HeYN4j/Sy2B3Tkt253cwNbBgHO
         ufxhN9/ZjqhULqnS3tX07/++XfmprxGzIQ4pspChfHRf74pGn2BXFjk1NJtTRbCJlE6Q
         Z9jg==
X-Gm-Message-State: AOJu0Ywo3UFtRQp9po07jlT9rZ9yRerNsA44Bn98OvdWVDfrBk49s3g5
	e4ZCa+9n5hpyXvmQVg9eJlCDvaQ+H0qpxuYGEprpl/P+XYuPa6fGuv5NFHVj
X-Google-Smtp-Source: AGHT+IEr+Ewk5xLNQVQ+0PNv7/Y++sNa9U1K7zxpwV+9gjwJXqW/XbHWjkR1eng0S0z7ClmxRADX0Q==
X-Received: by 2002:a05:6871:211:b0:21e:877d:78d6 with SMTP id t17-20020a056871021100b0021e877d78d6mr8502665oad.59.1708961707444;
        Mon, 26 Feb 2024 07:35:07 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:07 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 8/8] qmi: Make sure to set transaction id as LE16
Date: Mon, 26 Feb 2024 09:34:27 -0600
Message-ID: <20240226153459.1463304-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226153459.1463304-1-denkenz@gmail.com>
References: <20240226153459.1463304-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transaction identifier for QMI service messages was always read in as
LE16 value, however when allocating a request it was set in host byte
order.  Fix that.
---
 drivers/qmimodem/qmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2371f178a4c4..35751d7ce267 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -670,13 +670,13 @@ static uint16_t __request_submit(struct qmi_device *device,
 	struct qmi_service_hdr *hdr =
 		(struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 
-	hdr->type = 0x00;
-	hdr->transaction = device->next_service_tid++;
+	req->tid = device->next_service_tid++;
 
 	if (device->next_service_tid < 256)
 		device->next_service_tid = 256;
 
-	req->tid = hdr->transaction;
+	hdr->type = 0x00;
+	hdr->transaction = L_CPU_TO_LE16(req->tid);
 
 	l_queue_push_tail(device->req_queue, req);
 	wakeup_writer(device);
-- 
2.43.0


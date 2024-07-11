Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAA84047
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716582; cv=none; b=EH3X4VCAlNBCQqnbdm3EYk+iXQ4wglNWG3oFz+euOcYE3h2ey4mvLuQbsW6jXOCE/QZtmeq8J0FLo8qTIqP+j+g/pt3rZI7N42FvzXjPJIg3nrBjw374VVCDyXbTFUXxZ4OMtPM+r45Q6byo44xymZMe0NLDSa686mspZ32TAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716582; c=relaxed/simple;
	bh=dffnGkI17qSPW3b25IONLAlEAPrFwVApJ4+yj4idVS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un7nr8W2ax8P8hF+s+pf70iP+WNBSBO+XQO3uJ8EGSehGlTGZQN70hTswyfUhNA+m3Ed82d9VN1yOmAqGvRuzWeCInh9Lwd9VHMBAiIcpEYfSGoNX1trSo680ak4EMDYfdu4sFT9tkdKR5TxgkF4Ei9Qt7DoPZh05xvS0EnFOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPqCvXOS; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPqCvXOS"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7037c464792so576750a34.2
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716580; x=1721321380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c2JHjrV2CQ00glYH/m2D0yKTwf7Wgj38pYLIWfkVyo=;
        b=UPqCvXOSsPhYswIux1oLGh+lLYo3NgEze5fre1DlW1F9rPeE6AYPQWGlKnkBL18VkB
         In5sNahvk1rEqhRNMy4dJwP+y5N9wK45nzTP3+yNLf8/w54EcX8w3ysrbWfZqyjbSg1z
         IAXcNtV+l5QXoi2vIYSTjJEcYrJyynm9QdDcabD+QdqkV6nGxJMQ3G/5mTcVtb7qUbvv
         5X+fITkafp+OKNj5Ujvz06NVp+JZ8PlqcuFfI5oHW9gOVthWaGLrB1zeZeosna8D0wZy
         S37QMn+I0HjTngmo/awgUl9dx4RpJghnBkf/wXA2OY5RKXyPadxnOwLVLGqn3y+XUqmi
         a1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716580; x=1721321380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c2JHjrV2CQ00glYH/m2D0yKTwf7Wgj38pYLIWfkVyo=;
        b=DmNz/kSGNlI+fbgwca1j2FWd2dMMa6XfQNqoX1G6Fz/YFKP0vsUiVMZwSDDfbO3hOV
         kv/GzKLsky1qmZ6EFrT2Tz56B9eX+zywGWkbZP/cMw8jUwChm8ABqQJQz4hZIn05HSTb
         t2UrX09gH/6Lk1jdq53h9qcgaETevE1j90LPvBhoiZ6HbcSnoMs/gG6mjIOVQlpOAPQW
         XIWE6D411uz1pZtgv/nf+8XZYqpLV4aBa8LmCYgYAjJH5D/ZPOWLUOqnFgkP3RQ4VZz3
         YH/uI4vErhp1vcqHBXekDetV79yXWICwkRb3KHT7OlS9ayqg3mTw7NnHQ8ddJk363NE4
         tghA==
X-Gm-Message-State: AOJu0YzEfdbWO+QWP+b0/pyPQgwyfJtzfBS2bcxoUbLXTqaRoYqepU+J
	2L5M9tCNuee6NzuEf5GHsYc0uruxh6C2BKglnR2ur8wd5+dBYOuUTH+bFg==
X-Google-Smtp-Source: AGHT+IFurVprWC5fejLAzTXu27/QhOQ9AV9WvbeE6de3L4h3Mplcd4GShQpzWwgBhMqijPGxSvI/gQ==
X-Received: by 2002:a05:6830:22ed:b0:704:4995:3733 with SMTP id 46e09a7af769-704499539f5mr6191313a34.31.1720716580368;
        Thu, 11 Jul 2024 09:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/11] qmi: gprs-context: Declare qmi_service objects using _auto_
Date: Thu, 11 Jul 2024 11:49:26 -0500
Message-ID: <20240711164936.1688973-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164936.1688973-1-denkenz@gmail.com>
References: <20240711164936.1688973-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies the error paths slightly.
---
 drivers/qmimodem/gprs-context.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 3c18476142ea..7d13889bf603 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -554,7 +554,8 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 					unsigned int vendor, va_list args)
 {
 	int mux_id = va_arg(args, int);
-	struct qmi_service *wds = va_arg(args, struct qmi_service *);
+	_auto_(qmi_service_free) struct qmi_service *wds =
+					va_arg(args, struct qmi_service *);
 	struct gprs_context_data *data;
 
 	DBG("");
@@ -562,14 +563,12 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 	if (mux_id != -1) {
 		int r = qmi_gprs_context_bind_mux(gc, wds, mux_id);
 
-		if (r < 0) {
-			qmi_service_free(wds);
+		if (r < 0)
 			return r;
-		}
 	}
 
 	data = l_new(struct gprs_context_data, 1);
-	data->wds = wds;
+	data->wds = l_steal_ptr(wds);
 	data->mux_id = mux_id;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
-- 
2.45.2


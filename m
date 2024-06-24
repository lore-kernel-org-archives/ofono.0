Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3B1A01B8
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257609; cv=none; b=jgNUw52PwNYsWenJVc0vZQi5uKsyZrAmX1bYNvjKLHjuIOOPQg23OW+v+cxbu5nNqs1VDo5e9L1VBvTACNCEbW10rV4tSP2W2Swb25tLvko/2LzSGe19BPK9TCi7gUqmPUR/A7vg0EiuiQem/u8ftanwN5uiqy+n9+QaOrswwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257609; c=relaxed/simple;
	bh=DGVm8VvS+27+bhgPWtsLpz38ujd3io0EL7mOBwu273c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSqDxZRWo/33aI1Ef9eBhNbuHORswm1ANBGQaYYJl2Cq2Lnp767XfC/CEyR6Z7QsG7rhG9bKKulCqXv5S6iIKhrcJweojERnSQmv0e9PdUyUaDV7mvFlN2qfXdM0Ca2/iIr/0PHZgEa84tkMGdoG+IbW8bheFUglFfbunOXKB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2axNgvI; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2axNgvI"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5baf982f56dso2369419eaf.3
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257607; x=1719862407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYKlqlN+OxkNKMRugood31xDBn0ycrg0fTG8TycKzzI=;
        b=d2axNgvIV109X7U2/ppm60OWBGbOeZnFKJqwcSNW2EC065z1ZSNVacxx2LejDBbqQ9
         FdIBit0trfaFUEF0Wavp0wZ03d7ODvQFBQkxRvJgDNRBXhida5GosJwzx4CqD6hLpLvj
         zDA8izFpff9JyWN00ozwwA0uFDEIN7VbRbjSD0RSKRlRmUaZALFYVttmlgcHcqVdc0aE
         hPpSYYYIrE2e0PoKWw1tJTqFOxE1SVw6F+mql66YsCCKKOsXWOYEw69zu8TlfTgEGM/Q
         vsR75uI4o1y+yyq94YSb/fSr5RnjUAYy6N2R4UyRZoJpJMzK1N103I/PBTNS4pge/Lnj
         nEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257607; x=1719862407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYKlqlN+OxkNKMRugood31xDBn0ycrg0fTG8TycKzzI=;
        b=M6vPCE/pvZolarmjeBCHqNul45bT3oQOaQbKv6aA9Q5KkygAAeAKXsr9ykda02Jgv1
         xzuW7OayHR6ye3Toe6GScb1ltoxHXDv1RcGRwtQUSB47cnxm1Ewk8TNdYzUy0Rw23mt+
         5odL8/qikXjmSqoGOr5IAEbwdBBOQ1t8lDkw+WGPsdUpEjJu2Blalj2Xk2YSgdAN7D0U
         0OnBTBuGxxkSLQGo55TxuRdr2W1omfEmB6N0o8QSdjlAY81PZQXQl9SwtiuksO7nzKYO
         VFqcnsxeGkICPzFJ1QqYfBS3/V+I4BNIVUVd7J8L/SibogCqZSNUiI3srBS6OGNuUVgS
         nW4A==
X-Gm-Message-State: AOJu0YwJkw/80ILdccg9bqUGKjKwL6Lxyduo7edIuIcc1FLJUEGS1Lpj
	P3pYZrTCkBXnRJSm+v1qqT2xUQQCouSyggIIog7+VdGq+xcxnrw4KuFjJw==
X-Google-Smtp-Source: AGHT+IFr1z2BNUOvs48j/rSjq8dnXIADBIz1j0KRv4CEwL+CHhZLRCIVCDDADDQBFXwp554m1va/ww==
X-Received: by 2002:a4a:354e:0:b0:5bb:294a:cb62 with SMTP id 006d021491bc7-5c201156adcmr3730780eaf.4.1719257607537;
        Mon, 24 Jun 2024 12:33:27 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:27 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/13] unit: Add unit test for QRTR dedicated services
Date: Mon, 24 Jun 2024 14:32:56 -0500
Message-ID: <20240624193315.1164943-13-denkenz@gmail.com>
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

---
 unit/test-qmimodem-qmi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 2ff981391849..f647a025474e 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -566,6 +566,32 @@ static void test_service_notification_independence(const void *data)
 	test_cleanup(info);
 }
 
+static void test_dedicated(const void *data)
+{
+	struct test_info *info = test_setup();
+	struct l_io *io;
+	uint32_t service_type;
+	struct qmi_service *service;
+
+	perform_lookup(info);
+
+	service_type = unique_service_type(0); /* Use the first service */
+	service = qmi_qrtr_node_get_dedicated_service(info->node, service_type);
+	assert(service);
+
+	io = l_io_new(info->service_fds[0]);
+	assert(io);
+	l_io_set_read_handler(io, received_data, info, NULL);
+
+	send_request_via_qmi(info, service);
+	send_response_to_client(info, io);
+
+	l_io_destroy(io);
+	qmi_service_free(service);
+
+	test_cleanup(info);
+}
+
 static void exit_if_qrtr_not_supported(void)
 {
 	int fd;
@@ -598,6 +624,7 @@ int main(int argc, char **argv)
 	l_test_add("QRTR notifications", test_notifications, NULL);
 	l_test_add("QRTR service notifications are independent",
 				test_service_notification_independence, NULL);
+	l_test_add("QRTR dedicated service", test_dedicated, NULL);
 	result = l_test_run();
 
 	__ofono_log_cleanup();
-- 
2.45.0


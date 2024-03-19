Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D1107B2
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866596; cv=none; b=sgeDXYzIhLalr/f4N9d1vy/wxipGLLkjqoYwI2gb2WKsBfCrQUSBVa/pc+SECif9dSlKQw8J4qR3tKNdCYdJlErhsOVtrK2uHsBUNkVdP3GsaGeDW5u/MKRWviQKUjrRh1PT2S0awGosjpHqDJMOvaG/gQm7YpeoYxOzK0HqAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866596; c=relaxed/simple;
	bh=DhEBG91b/0ZEFQ+mtX0ICkbBTgU3lqyxCj4TEXZoa10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmuTnZhlpk+AoySkRrevmoFLPiFt/j9hhkEkJFr9/Z6LkvNpSPJMpK8RtrCrM3BjQA8oLYkFa2bTokQWq57ywVm215/yo2pJagUcpODv49Me68/pw/MryaYFLdcPUVX8xbgXo4rZY9IO3kPUiaZdMbIFD5uAOwc2tAQBli7Dms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLQEAp+J; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLQEAp+J"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a496fde460so1842049eaf.1
        for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866593; x=1711471393; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9ito3dE7JNsK4PqXiFtywLoobhqtpTu5mMxTr5Ncms=;
        b=hLQEAp+JgPqbvmvv44+DWO9f35Ad3CKATWs/PDRqgtAiehf4VsrXSLhrDi/S59OLZY
         ZjgLT0GIUfGwgA5nAjcKBu4F26vlOWtmX2uRSIu8eCt6NYH26E5y32t3IaHntkJ1waAE
         bUoUjbzpeDTa0I+rK3aeSPxno3+CAvuqMvWAQ4c87Hn0HTdYP9KmoaIL5XKM7N/Qlb1o
         u5SNtMndDN0nSL/P+rKvp+RfUkE2FY5E42KeqBjWeouL2Ay4mVDA/+SQ9nyRlHDMcaBl
         QC7qhgZY9AzVLxDAp6ZRyQgFETfqnhM1X8CwmeT3uDhQVWTKNmr4HMBrvzog6ufQ0ZCp
         Y06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866593; x=1711471393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9ito3dE7JNsK4PqXiFtywLoobhqtpTu5mMxTr5Ncms=;
        b=i0Ba9VlsDu0VD2dXNTRIMTSdpiR1LEZrdDSNNn4VwFn/NF4ebeVFcAjzJK+dkMgVZz
         fzvGrfkDD8fn7hrpK1z+1++mUlwge/YUmo5OOxyGJs4lqlNgBHHkgVd3UQfhq06Dt4H9
         b2BEoPvJ/d6Z29BQmz7CcPx74JfKESAQ3k88c5zcojrW8Vc+/tJsmKELJQst5Y6O5tBp
         r4oMXZPjwjhZvLuo2pQmVMAvHzKVe2BnT/cIfuyaghX2vyBcxbwJsylhoImvv3FosqvO
         nH5yPKQ20TsNAR8ZZ1quvwgxWdA0/Le/y658OF0yfCqTdLgiIaVcdO+RB+lXqjJsr+uB
         Eqmg==
X-Gm-Message-State: AOJu0Yyp7zgPissMLxe6I8F46NrzvTlHPZqzgrooF0aPvp15EAxP89Jb
	/m77ZXYwdD7agm0ylqwWx/BCR0oA/wEiWbUwDG1JwSDDCnHifZ2nEp/hEpgc
X-Google-Smtp-Source: AGHT+IFUvI0llUkq8RPBdrtyREAej5VljZIyW6hokgBhFIWCFmqo0M3YeUoIQVxXdPeudbk2ZzktTA==
X-Received: by 2002:a05:6820:a0a:b0:5a4:b8dc:bfa8 with SMTP id ch10-20020a0568200a0a00b005a4b8dcbfa8mr6032785oob.7.1710866593541;
        Tue, 19 Mar 2024 09:43:13 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cp1-20020a056820240100b005a4dc7abc01sm191642oob.11.2024.03.19.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:43:13 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] qmimodem: sms: Silence valgrind warning
Date: Tue, 19 Mar 2024 11:42:54 -0500
Message-ID: <20240319164309.2676887-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319164309.2676887-1-denkenz@gmail.com>
References: <20240319164309.2676887-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ofonod[2670789]: drivers/qmimodem/sms.c:get_msg_protocol_cb()
==2670789== Conditional jump or move depends on uninitialised value(s)
==2670789==    at 0x46552A: get_msg_protocol_cb (sms.c:565)
==2670789==    by 0x45D5C1: service_send_callback (qmi.c:2762)
==2670789==    by 0x4594F5: __rx_message (qmi.c:846)
==2670789==    by 0x45A6A4: received_qmux_data (qmi.c:1393)
==2670789==    by 0x58D71C: io_callback (io.c:105)
==2670789==    by 0x58C073: l_main_iterate (main.c:461)
==2670789==    by 0x500EC0: event_check (main.c:190)
==2670789==    by 0x48FC09D: ??? (in /usr/lib/libglib-2.0.so.0.7800.3)
==2670789==    by 0x49591CF: ??? (in /usr/lib/libglib-2.0.so.0.7800.3)
==2670789==    by 0x48FBB96: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.7800.3)
==2670789==    by 0x5011F5: main (main.c:284)
==2670789==
ofonod[2670789]: drivers/qmimodem/sms.c:get_msg_list()

The warning is triggered because GET_MSG_PROTOCOL command succeeds and
qmi_result_set_error() returns false.  It seems the intent in this case
is to use the msg_mode reported by the device by obtaining it using
qmi_result_get_uint8.  In case GET_MSG_PROTOCOL command fails, both CDMA
and WCDMA messages should be queried.
---
 drivers/qmimodem/sms.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 498a6d778303..b9fe963520d6 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -556,21 +556,23 @@ static void get_msg_protocol_cb(struct qmi_result *result, void *user_data)
 
 	DBG("");
 
-	if (qmi_result_set_error(result, &err) &&
-			(err != QMI_ERR_OP_DEVICE_UNSUPPORTED)) {
-		DBG("Err: protocol %d - %s", err, qmi_result_get_error(result));
-		return;
-	}
+	if (qmi_result_set_error(result, &err)) {
+		if (err != QMI_ERR_OP_DEVICE_UNSUPPORTED) {
+			DBG("Err: protocol %d - %s",
+					err, qmi_result_get_error(result));
+			return;
+		}
 
-	if (err != QMI_ERR_OP_DEVICE_UNSUPPORTED) {
-		/* modem supports only 1 protocol */
-		qmi_result_get_uint8(result, QMI_WMS_PARAM_PROTOCOL,
-					&data->msg_mode);
-	} else {
-		/* check both, start with 1 then switch to other */
-		DBG("device supports CDMA and WCDMA msg protocol");
+		/* Get Message Protocol operation is not supported */
+		DBG("query both CDMA and WCDMA");
 		data->msg_mode_all = true;
 		data->msg_mode = QMI_WMS_MESSAGE_MODE_CDMA;
+	} else {
+		/* Query of current protocol succeeded, use that */
+		qmi_result_get_uint8(result, QMI_WMS_PARAM_PROTOCOL,
+					&data->msg_mode);
+
+		DBG("msg_mode: %s", data->msg_mode ? "WCDMA" : "CDMA");
 	}
 
 	/* check for messages */
-- 
2.43.0


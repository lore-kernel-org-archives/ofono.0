Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4581BF311
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412413; cv=none; b=PNBHSUVQGQOLseaD0fU+RTeAo+WgfnAkRRFPUfz/3c9Jz+dSz0319vT1VDuBtjzKgklKJ0/HInIiv7v5VLMRFhQY7xHdr56EBvF2RRdrSC9Oa2ImSd7UZRchM3OzYE08ZIaaNugWfbG4cjswHwfPj22t6ddnQvxUuNVRqam4nSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412413; c=relaxed/simple;
	bh=HGXJ/r4C6AmiB3QjKmlFK6KmAG6+wwX20S9ietVQRvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y//md8o33V0DI6IJTjRMH4nBDhOET2ORpwUW46e4zsFMbTKBca8UybWsp1rkw5T35hBTgkMIXXp3RAP0gblFXiZMizIBIp5MpBMccaPO1lTA6MX2J83otWa1fIoGmGoFxAXxFQSBV+no5Qen5mdJyrpWwP9g9TAcgXMyGen57pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3KyaBRp; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3KyaBRp"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-715716974baso771338a34.1
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412406; x=1731017206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xng9xLEpYuT45AD+WPG4mpkyy5fbFtYRxR9Zg77oj8E=;
        b=O3KyaBRp1wvfv4k4RtT49RVmD962kUgvxUBdno/yanl7MaoNJRrQOmqT5mXeLt8b4i
         pZ1LHxeulwNyOXSihHN4A7VdFuym1ihy9zJWCEDB0kCVQ1pUnH0UCt0Ffpiq6hcY5Esf
         qkmGAp2mrXw3RvoHgtW4Pf1F7DpLpfMlHiATqgIHai9iWB8kkiwCQrQyavmiBL+MzHrU
         u9UOD7CZx3qAcOh/68lOgfFzCLZ3K+c498GRMdaUtq8/LKNL1Vh0dJ2U6h7JqVHtQeou
         9U+6TJFnq92ZiisCNyXXXpghlbJq/gFYlHbxox7YPo2SOepWfts3WbM9Xg+VDG1+PPVR
         OF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412406; x=1731017206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xng9xLEpYuT45AD+WPG4mpkyy5fbFtYRxR9Zg77oj8E=;
        b=E7izvxKmAfI4OKpgArb2o455D+AUsPedypyvSd3yhEiADu34h8j3GtFAk+vkELLk+U
         +LxR+7+n1dr5mTUgXJmlMXD43V3AYl2JMk9PfzzVsc2PYSmg4NNNrYAJoDh6O5kAquhU
         mosB9gbGS5q4X5dIWnd2m1QI+LocblwlM5/vfYXG5MG3ST6fwJLcYqU7LxLLSfDc748S
         voBoACPzRUUkuIdKhOlSgtyFQ6NOSa9/77/0eRdljCjcFVTh1xV6esia6k9ehH9WsOaJ
         tKgHy/XhVr81FtWaRQp25J9YRHpoMnIkKfo0ADS4AEVZcxxQtEVJVmZIxsZKQ/XtBTI/
         JXdg==
X-Gm-Message-State: AOJu0YwEG8uCNqgSgJpCqc9vsMGIvKEhcsNzUWRf5Bge62K+Enz9pnus
	ODgdPh+YLBs+x8yidmkZXd9USjZnmEyIGHzPnuGf6Gybk2olQk72Jpncng==
X-Google-Smtp-Source: AGHT+IH8kQXPtmPlJxWQjk8iLMNCB0Xq3PVVS+oVD9Rh14NW3VuvzUwrFTPZOZRUkgdQl8nlRQSy9w==
X-Received: by 2002:a05:6830:442b:b0:718:41c6:821c with SMTP id 46e09a7af769-719ca174d66mr1971387a34.5.1730412406537;
        Thu, 31 Oct 2024 15:06:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/13] gobi: Bring down the main interface at startup
Date: Thu, 31 Oct 2024 17:06:17 -0500
Message-ID: <20241031220638.1582166-10-denkenz@gmail.com>
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

The current gobi logic tried to set the qmi_wwan 'raw_ip' state based on
the results of wda_get_data_format.  If link_layer protocol was
'raw_ip', then 'raw_ip' setting on qmi_wwan was set to 'Y'.  For 802.3,
'raw_ip' setting was set to 'N'.

Unfortunately this was broken at some point and the setting could not be
toggled when the main network device was IFF_UP (default when USB device
is detected by the kernel).

Fix this by having .enable callback bring the device down at
initialization time.  oFono core will set the device IFF_UP once the
context is activated, and bring it down when the context is deactivated.
---
 plugins/gobi.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 5c3ae0737a15..e75a0312f6d0 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -230,13 +230,10 @@ static void add_service_request(struct gobi_data *data,
 	data->service_requests[data->num_service_requests++] = req;
 }
 
-static void shutdown_cb(void *user_data)
+static void __shutdown_device(struct ofono_modem *modem)
 {
-	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
 
-	DBG("");
-
 	data->discover_attempts = 0;
 	memset(&data->service_requests, 0, sizeof(data->service_requests));
 	data->cur_service_request = 0;
@@ -245,7 +242,15 @@ static void shutdown_cb(void *user_data)
 
 	qmi_qmux_device_free(data->device);
 	data->device = NULL;
+}
+
+static void shutdown_cb(void *user_data)
+{
+	struct ofono_modem *modem = user_data;
 
+	DBG("");
+
+	__shutdown_device(modem);
 	ofono_modem_set_powered(modem, FALSE);
 }
 
@@ -552,11 +557,32 @@ error:
 	shutdown_device(modem);
 }
 
+static void init_powered_down_cb(int error, uint16_t type,
+					const void *msg, uint32_t len,
+					void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct gobi_data *data = ofono_modem_get_data(modem);
+	int r;
+
+	DBG("error: %d", error);
+
+	data->set_powered_id = 0;
+
+	if (error)
+		goto error;
+
+	r = qmi_qmux_device_discover(data->device, discover_cb, modem, NULL);
+	if (!r)
+		return;
+error:
+	__shutdown_device(modem);
+}
+
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	const char *device;
-	int r;
 
 	DBG("%p", modem);
 
@@ -575,11 +601,15 @@ static int gobi_enable(struct ofono_modem *modem)
 		qmi_qmux_device_set_io_debug(data->device,
 						gobi_io_debug, "QMI: ");
 
-	r = qmi_qmux_device_discover(data->device, discover_cb, modem, NULL);
-	if (!r)
+	data->set_powered_id =
+		l_rtnl_set_powered(l_rtnl_get(), data->main_net_ifindex,
+					false, init_powered_down_cb,
+					modem, NULL);
+	if (data->set_powered_id)
 		return -EINPROGRESS;
 
-	return r;
+	__shutdown_device(modem);
+	return -EIO;
 }
 
 static void power_disable_cb(struct qmi_result *result, void *user_data)
-- 
2.45.2


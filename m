Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663379EF
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232648; cv=none; b=VKlUqm/wTdjZ3e2PvkeKbZzawzgCeZmdj+p/nOPNI8HTUJBqMnfD2jkApyKbvcTHL2i3OuXY9Vp9gwo3IX6tkqIvI6GN1TjaeL3cyCQZo0vJlgnMEMMBxkcO/BK9j6HjUGA2wNyJOvphZkMoJJ1BXPShhTGz1u5pPA8hiWUWqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232648; c=relaxed/simple;
	bh=nLI/3ne0HcQ0M0BVvOTtmEUYyrUtzRR7TFWrOW7HqiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhQ7b5wV5Q/ZmCJ5JggXnmRtfKHcHo1fucbT6qrScs29v7+R1/uOMy6bUypviMkr6YwWhgbtD5Ztvxc7ESR8/IxTmxl5FSsMcO2OlzQu1FCQZ+QkHKKcuDQdhafsY95GIXyZ3O45L5RR+QusdZQ7u5NlGvqTxFueANuh2AH+nto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ/P+X/z; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ/P+X/z"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b27d9fe710so1337351eaf.3
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716232645; x=1716837445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA/q1f76VnCMyqUSqAslTbWfXLOcxzYPPzsEj3FbJJU=;
        b=QQ/P+X/zxUacujyHjezEkmUEG2q22im0xRcHYrrtgRl7tslTKlP54Jj9QuDVb2gsEM
         LIph4oyUjB4GXJk00/k5nUuhcYjWCtIVnBZY5ZaYw6P2Bdg9oa6GWNFj6WQYEFyUrsU4
         f4yx7LHHDopSMEiB7m0f018QXd25g0JUA+X8aHpe1WrwGMob0gX/xfk9OcQOy0EEV6FW
         HaDVpILrN8y+5l8l/C7VZURMe+DUHYM84lbPEobsP+0Ey07IiFtQXFq+cHVV73SjbsDm
         Rw1+c35n7mi57m9nbgTlx8taA9uozPCIGBZoiWgU3DcZsLHUEix49xJEYl6brsIYxN3l
         kmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232645; x=1716837445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA/q1f76VnCMyqUSqAslTbWfXLOcxzYPPzsEj3FbJJU=;
        b=AB/g9h9LoxDyvhhzXOuF9E6vzR+QwohMUOfIMMJmOIeOOi/MswXI0Q1jJIgH/5GP1T
         VVYA0CNiYZvS2CRo4tZfheRN+PNCaeqA6ohx9n63tJ6JSONdwMFsxjWW0L25Rc+qtEOw
         WXdaJnEOTRiKdjHqYwBXT770ODBCExudKtFX/6OShW3shhgvWHQEwy43Y6TW/+yiz6hx
         /ZFKmllaPBAwbtdcmUX2CiIcjcv7La3wLNyNGrR8oglX7l21gRh+FQZBY4wzRyrnIVIY
         sZlRiGp7+/uwupwFj5oUsm9Awe8jBvtUlJeBCe/q6hsV+IQiuFjqxBW4X1TuyB70fq/K
         Xxtw==
X-Gm-Message-State: AOJu0YzqeTRSWb+YfOveWVn/LrRJyGX+eaHmTzdCSauEgwNCy3xKmdCM
	2yhrT/Y+EJz3VyXPiRWwbNdnB5lyq08bQNHMK1IL3QNOt98so+g3htpNJw==
X-Google-Smtp-Source: AGHT+IEua2DoF4NeX7YE6yfpXapdW+QZV5r57YxnqZXnZnZ4R35tC83Vov3DOclwqcHoFTx6mnKHEw==
X-Received: by 2002:a4a:55d2:0:b0:5b1:bf59:7ac0 with SMTP id 006d021491bc7-5b281a50b4amr31874099eaf.9.1716232645461;
        Mon, 20 May 2024 12:17:25 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5390b9c54sm236387eaf.0.2024.05.20.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:17:24 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] gobi: Rename KernelDriver to NetworkInterfaceDriver
Date: Mon, 20 May 2024 14:17:03 -0500
Message-ID: <20240520191722.184977-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520191722.184977-1-denkenz@gmail.com>
References: <20240520191722.184977-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The naming should now more accurately reflect what the driver string
represents.
---
 plugins/gobi.c   | 10 ++++++----
 plugins/udevng.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index d8b78ad6f5b0..5bb0b5ace0ca 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -103,9 +103,9 @@ static void gobi_debug(const char *str, void *user_data)
 static int gobi_probe(struct ofono_modem *modem)
 {
 	struct gobi_data *data;
-	const char *kernel_driver;
 	const char *value;
 	enum qmi_protocol protocol;
+	const char *if_driver;
 
 	DBG("%p", modem);
 
@@ -118,12 +118,14 @@ static int gobi_probe(struct ofono_modem *modem)
 	else
 		return -EPROTO;
 
+	if_driver = ofono_modem_get_string(modem,
+						"NetworkInterfaceKernelDriver");
+	DBG("netdev driver: %s", if_driver);
+
 	data = l_new(struct gobi_data, 1);
 	data->protocol = protocol;
-	kernel_driver = ofono_modem_get_string(modem, "KernelDriver");
-	DBG("kernel_driver: %s", kernel_driver);
 
-	if (!strcmp(kernel_driver, "qmi_wwan_q"))
+	if (!strcmp(if_driver, "qmi_wwan_q"))
 		data->using_qmi_wwan_q = true;
 
 	data->main_net_ifindex =
diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa2a216d4247..c7db66238681 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -216,7 +216,7 @@ static int setup_qmi_netdev(struct modem_info *modem,
 	if (r < 0)
 		return r;
 
-	ofono_modem_set_string(modem->modem, "KernelDriver",
+	ofono_modem_set_string(modem->modem, "NetworkInterfaceKernelDriver",
 							net->kernel_driver);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net->devnode);
 	ofono_modem_set_integer(modem->modem, "NetworkInterfaceIndex",
-- 
2.45.0


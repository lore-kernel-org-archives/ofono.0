Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600D14A4F9
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412412; cv=none; b=F6gQzDGRcqUlX1S1asiFxyfRK+KWEpd6T8j2weOVJAmxGdZ4k2o0oA8S9UTL4vUoyYIuu58RPi5gevgZdf+3UxvPfGI52c/iJB2lzTGSnsndXHBIlqwWmaX01G6VPIz08YygBiUeQXCqe7A3xEz1tYOMhI8O6fTMA38xgXmnsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412412; c=relaxed/simple;
	bh=dy5YfC8aR5Yafxj9SZNxALiklkLqMqXx2W3H2NHO3PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WITQk7O/TNhml7OxvsC/Xn2bW1JXXGvjTZIT+z4RX0T2W9Lrzwwv/5sv+kezdUswvHXGi9wE1FdI9ON0oew6uKK6WGR6teF7EYuDf9YzpEUloOu+YVw3a8kdI0jn7rTJDmV5OGCdFn10JHfd+rZaqo+HGGbkIi4MkZNlAYVvMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUk+uLkr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUk+uLkr"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71809fe188cso713759a34.0
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412406; x=1731017206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18AtsgWHDiTaoS1b/PGZ/dqplJ9MnnwXhQdL835lwfA=;
        b=KUk+uLkrD7raIyA+S0PtDJWxYRg6E+4Xps332+uijN9oEW4xyYZ8CEiT3mDQJM5/kd
         XiWhiesnxhA0qhygq/kUZ4RmqS6pgs1f4RDS5K9wPmlTuEtGIUHHy+qSuW4eXwKui+06
         JOX2FZMnVi9bRncSzGlH1fKe6daxebj2da9cCfc6xf0lL43R+cp0IcHec3Fk0RiXpXte
         Xw1VxjP9s2PJVj3e321Tlyonk+46QJV0qHtm0vaM8Ek2MWiZ51bsM0AYZ25n492LL7UI
         DI6FuvrTMj6oTw6rUG8n/Vip0nAkeIpAEfvul8jBPR/Q1glLiGsbZp3uWEpW95kqsbDw
         Fexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412406; x=1731017206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18AtsgWHDiTaoS1b/PGZ/dqplJ9MnnwXhQdL835lwfA=;
        b=QsXlgIZ9L6wWMZgJbGBUNZ3/QbsnbEQW/eKEo70ztIGvdi9VGN7GlsOTecN6HnyuEu
         Sg7lz5QoxbaGx/CfyH7TZch73vMy4TpAsMttJ5WqaGtEsuFvBccfP8eIMMZS1STqRYi/
         JlCaQCG1GlVh6tIwbDo2tamLHcyHecMyKsf56TmsRJNnJu08Udu+i4yGbTkEA+4ud3sr
         mLeCozcrGPnsoGSA/9WPCwnSQPZro20CpbhtL62F0xRarbUkc4xS8R0QGqgeXFTAWX6I
         HI5xBvgJ4BnnzejKXsR1Qwesuji2nWf8XkZ1+Hk10Dc+GYRBKeobebAYDmiH/RXu5iQ4
         Fjhw==
X-Gm-Message-State: AOJu0YwVrLyRttXgLhttkIn/gg+ODcdp4x/Op379OsGsYZCCO6I/iscI
	9uMI7ShbqR7a79MN3RLR5Sw5rB2wvpT/haTc2A4BNJmVhAR4wdNkEcmVYw==
X-Google-Smtp-Source: AGHT+IFNQEsCHSbiz43u6NLRWxqWNwA/On8iZdvUvFVafJYy8OE4qwqVjeHcBy1+ay669xSNhGrlsg==
X-Received: by 2002:a05:6830:374a:b0:718:8b6:d628 with SMTP id 46e09a7af769-7189b55a986mr3945576a34.32.1730412405847;
        Thu, 31 Oct 2024 15:06:45 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/13] udevng: Remove non-upstream qmi_wwan_q support
Date: Thu, 31 Oct 2024 17:06:16 -0500
Message-ID: <20241031220638.1582166-9-denkenz@gmail.com>
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

This reverts commit:
fd1b44514315 ("udevng: Detect Quectel devices that use qmi_wwan_q driver")
---
 plugins/udevng.c | 71 ++++--------------------------------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index f34cdcb731ee..64875a47752b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1108,19 +1108,6 @@ static gboolean setup_quectel(struct modem_info *modem)
 		return FALSE;
 }
 
-static gboolean is_premultiplexed(const struct device_info *net)
-{
-	struct udev_device *parent = udev_device_get_parent(net->udev_device);
-
-	if (!parent)
-		return FALSE;
-
-	if (g_strcmp0(udev_device_get_subsystem(parent), "net") == 0)
-		return TRUE;
-
-	return FALSE;
-}
-
 static gboolean setup_quectelqmi(struct modem_info *modem)
 {
 	const struct device_info *net = NULL;
@@ -1128,11 +1115,6 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
 	const char *gps = NULL;
 	const char *aux = NULL;
 	GSList *list;
-	const char *premux_interfaces[8];
-	int n_premux = 0;
-	const char *qmap_size;
-
-	memset(premux_interfaces, 0, sizeof(premux_interfaces));
 
 	DBG("%s", modem->syspath);
 
@@ -1144,22 +1126,12 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, subsystem);
 
-		if (g_strcmp0(info->interface, "255/255/255") == 0) {
-			if (g_strcmp0(subsystem, "usbmisc") == 0) {
+		if (g_strcmp0(info->interface, "255/255/255") == 0 &&
+				g_strcmp0(info->number, "04") == 0) {
+			if (g_strcmp0(subsystem, "net") == 0)
+				net = info;
+			else if (g_strcmp0(subsystem, "usbmisc") == 0)
 				qmi = info;
-				continue;
-			}
-
-			if (g_strcmp0(subsystem, "net"))
-				continue;
-
-			if (is_premultiplexed(info)) {
-				premux_interfaces[n_premux] = info->devnode;
-				n_premux += 1;
-				continue;
-			}
-
-			net = info;
 		} else if (g_strcmp0(info->interface, "255/0/0") == 0 &&
 				g_strcmp0(info->number, "01") == 0) {
 			gps = info->devnode;
@@ -1177,44 +1149,12 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
 	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
-	qmap_size = udev_device_get_sysattr_value(net->udev_device,
-							"qmap_size");
-	if (qmap_size) {
-		uint32_t max_aggregation_size;
-
-		if (l_safe_atou32(qmap_size, &max_aggregation_size) == 0)
-			ofono_modem_set_integer(modem->modem,
-						"MaxAggregationSize",
-						max_aggregation_size);
-	}
-
 	if (gps)
 		ofono_modem_set_string(modem->modem, "GPS", gps);
 
 	if (aux)
 		ofono_modem_set_string(modem->modem, "Aux", aux);
 
-	if (n_premux) {
-		char buf[256];
-		int i;
-
-		ofono_modem_set_integer(modem->modem,
-					"NumPremuxInterfaces", n_premux);
-		for (i = 0; i < n_premux; i++) {
-			const char *device = premux_interfaces[i];
-			int len = strlen(device);
-
-			if (!len)
-				continue;
-
-			sprintf(buf, "PremuxInterface%d", i + 1);
-			ofono_modem_set_string(modem->modem, buf, device);
-			sprintf(buf, "PremuxInterface%dMuxId", i + 1);
-			ofono_modem_set_integer(modem->modem, buf,
-						0x80 + device[len - 1] - '0');
-		}
-	}
-
 	return TRUE;
 }
 
@@ -2160,7 +2100,6 @@ static struct {
 	{ "quectelqmi", "qmi_wwan",	"2c7c", "0800"	},
 	{ "quectelqmi", "qcserial",	"2c7c", "0800"	},
 	{ "quectelqmi", "option",	"2c7c", "0800"	},
-	{ "quectelqmi", "qmi_wwan_q",	"2c7c", "0452"	},
 	{ "ublox",	"cdc_acm",	"1546", "1010"	},
 	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
-- 
2.45.2


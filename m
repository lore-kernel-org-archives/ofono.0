Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EF13D249
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=ufe1Mm1dB5uYj2XyQkdB0fuU4VjlTZqKeTOFde/CaY3+ZrvO3BHqL6hDL+zEmEjDQBMNsntWLscJFbCDpXGN6PUA6H2kJleM2qZm0Sqfhw+5YgRbSbjoHCpYsCuLWvJNKUUug7g+pjl/uRMNVQiJFJx4goICETvZGclnKd2XLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=2Mfi14ZT0soB+FBhUQQPCcVRGzEUi8qS3iBcXrpYoz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/WxVnlGJfhyXVr0B2BDCBq4uO9Z2B9LLkWwmAgVzgo3t4ERNtRdwZuHZzrkx7/y76CAxWymIReucLoypfpmSdQaATIy6OK1UJgnMIhJuMIjUkf95/JSLaqR/s/BuIkmpu0nJZ2KSGBqt2fgCDA6XDQnKn74+duLtQTrSgC+BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kjuVeo1g; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kjuVeo1g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=k8K+HkcFSMtud5QKRQ83m6T26fUswEdemsDU4TQGf4E=; b=kjuVeo1g4kbp5aVUv2X9Z32C+W
	LF9jrkfcqI5BUaI8p+9XHb5Ryl3N9o404JzcYa9flFVxRgWX6P0aKKb6TA9ulXZBUplniA1kLg1QW
	fx6tmqyPKzpTloPlnIVNXS0NXZxs0zsFQK2FDHzPvrk7IaXaZGXmZnZSg5kKWS01SBO+p82i7cbFc
	KRWSrEdt/FBYn04uqlP7otS56FNZMAD33lIXBQdaiVS6tIn6YlWNx/10BMC30Ajmpn08mXVE+UjpY
	Cz1aq7nqln02xca0tgV3a462YnPF/uXnO6JQ7tr3VDArrFJs1dFLb6SItvS4ki3OYHUqF6+m55UV5
	OqRC4ukQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000GUh-M1; Tue, 30 Apr 2024 13:52:54 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000LNp-17;
	Tue, 30 Apr 2024 13:52:54 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 08/10] udevng: register support for SIMCom A76XX USB serial modem
Date: Tue, 30 Apr 2024 13:52:31 +0200
Message-ID: <20240430115234.180185-8-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430115234.180185-1-martin@geanix.com>
References: <20240430115234.180185-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27261/Tue Apr 30 10:23:42 2024)

Register the 1e0e:9011 usb id as a specialization of the sim7100 driver.
Use a new setup() function to handle the different order (and amount) of
USB endpoint numbers without introducing too much complexity to the
existing setup() function.
---
 plugins/udevng.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index b9d115f1..4267c892 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1630,6 +1630,57 @@ static gboolean setup_sim7x00(struct modem_info *modem)
 	return TRUE;
 }
 
+static gboolean setup_sim76xx(struct modem_info *modem)
+{
+	const char *diag = NULL;
+	const char *mdm = NULL;
+	const char *ppp = NULL;
+	const char *gps = NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list = modem->devices; list; list = list->next) {
+		const struct device_info *info = list->data;
+		const char *subsystem;
+
+		subsystem = udev_device_get_subsystem(info->udev_device);
+		if (!g_str_equal(subsystem, "tty"))
+			continue;
+
+		DBG("%s %s %s", info->devnode, info->interface, info->number);
+
+		/*
+		 * SIM76xx USB numbering:
+		 * 0: RNDIS (ep_87)
+		 * 1: RNDIS (ep_0c and ep_83)
+		 * 2: QCDM/DIAG (ttyUSB0)
+		 * 3: NMEA (ttyUSB3)
+		 * 4: AT (ttyUSB1)
+		 * 5: AT/PPP (ttyUSB2)
+		 */
+		if (g_str_equal(info->number, "02"))
+			diag = info->devnode;
+		else if (g_str_equal(info->number, "03"))
+			gps = info->devnode;
+		else if (g_str_equal(info->number, "04"))
+			mdm = info->devnode;
+		else if (g_str_equal(info->number, "05"))
+			ppp = info->devnode;
+	}
+
+	if (mdm == NULL)
+		return FALSE;
+
+	DBG("at=%s ppp=%s gps=%s diag=%s", mdm, ppp, gps, diag);
+
+	ofono_modem_set_driver(modem->modem, "sim7100");
+	ofono_modem_set_string(modem->modem, "AT", mdm);
+	ofono_modem_set_string(modem->modem, "PPP", ppp);
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -1650,6 +1701,7 @@ static struct {
 	{ "telitqmi",	setup_telitqmi	},
 	{ "simcom",	setup_simcom	},
 	{ "sim7x00",	setup_sim7x00	},
+	{ "sim76xx",	setup_sim76xx	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
@@ -2033,6 +2085,7 @@ static struct {
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "sim7x00",	"option",	"1e0e", "9001"	},
 	{ "sim7x00",	"qmi_wwan",	"1e0e",	"9001"	},
+	{ "sim76xx",	"option",	"1e0e", "9011"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- 
2.44.0


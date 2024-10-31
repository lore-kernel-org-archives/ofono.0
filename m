Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DB1CDFB6
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412412; cv=none; b=Q4BtYiisqwn6nFdDm3JuIkOUYSPyA2H9+LF8mhRqr+2wo7Pm5CYQOIb0TiHxtKaXiG8da/uNvjnzeYIuN1GtvEsrWpUlzh7Bdd5WSUocPZAAilfWIUNm7f1x/efUExoy2VEEX5nzHd6Cx8oZ8/o+VMD8bJ28+lWDUDnSSnslGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412412; c=relaxed/simple;
	bh=Okk3S1HM1g6gNtefnoPG3ETV0XXja0IyW6xCVU+e98k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsn0xKsAuaJgl5zov1/uVcBBpvfTC99FxigQgNnjGMdpy4Yza9D9ISWeWepcSxj8KRW2Kil2tT9sRmleejoVS8E+RV9j7ZrirgehSyXVbZYMjYPPdBAJqy+1VhwZAnKD1rkYItjAFapkIqgxoRBSMjQtJTNGPajcHrpzLtnwZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPxaUkaS; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPxaUkaS"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-718065d6364so761043a34.3
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412405; x=1731017205; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkcpqLAIqWaqoAEcU0snVUbt7KAKP+bmZalqm6+LTQI=;
        b=WPxaUkaSqtaphoT43pI9z1CZCQfR+On1caF63m2MeLPC1Nlq43sJhvQeGhGV754s++
         WGFzx5TEaRDfnRRmxWqJDaE/QechCiFgsg8rachjXgEtv68i91aQDX0NP4YpkcysQkVT
         /6+//f3QbJeMdCv3Vnadcvl4W+rcE4M5dYx9iwLToUr3UJ99ZtayAFPNwzc3daoG6aWq
         MHQIrnHzvCAbfbOgL3bmgbOE0uUDuRWVrNBzKQKxuF2XIeBaICh/w+rpGjWiktPlk5uf
         8ucGAkWcoSYKXEirqJEmgGrROxko0Iq5ZijMqg25tPr8LFN8St7QX1aE0YvJ3/2wlGl4
         5cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412405; x=1731017205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkcpqLAIqWaqoAEcU0snVUbt7KAKP+bmZalqm6+LTQI=;
        b=nf9Lril8r7eZTLa0Rjm/ScIh7+FLpgNfC/6o5cuGe0bXmsaA0D/JzvV0VHuwWUPKvU
         mt4Ngwo86KbyKpXBzvSe3Klvs8EMF9HT80ztJTTg7UTkOIq88rW/bnuAAwSXpQ43Qv1A
         T3XLjKf+ne/cqdLMYdEeX9IDzTrIvELlgYfarUqRj5w3nn/hT83TTUEhV4R6VC2FP1iu
         5hgymzkubqECGvG3QIXUalMtJ7I3jRCTDyedw6uyrEu8l4QIHYKdihvYfntIXbUVBKjj
         EYE9cEow2i4MYoowN4F5a7BW3dVvb+Zf9XcySrnKftB4bJoaeS4D/XDHEJP+ljxMzq1B
         vpEQ==
X-Gm-Message-State: AOJu0YwGrdlnfk5A4VBczVEM5AeKZQASRK/0jXLI7hXmyq/rX2PQ8Kbd
	LjGKGS0JLysVntQSeMZ8htpLLMntwkpkLuAWGW8TW6oTUPQasrUVdZxp3A==
X-Google-Smtp-Source: AGHT+IEUL0y5lb4xvOZUMqa79KGG/6djUzxc18Cx4XmO/WNsycuIqlwA7gZQcSv2g5woz3eTOG8wEg==
X-Received: by 2002:a05:6830:4117:b0:718:186a:497d with SMTP id 46e09a7af769-719ca191433mr1724329a34.5.1730412405082;
        Thu, 31 Oct 2024 15:06:45 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:44 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/13] gobi: Remove support for qmi_wwan_q
Date: Thu, 31 Oct 2024 17:06:15 -0500
Message-ID: <20241031220638.1582166-8-denkenz@gmail.com>
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

Focus this driver purely on qmi_wwan and its quirks.  This simplifies
the logic considerably.
---
 plugins/gobi.c | 60 +++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index b2c9c3d50ea4..5c3ae0737a15 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -88,8 +88,6 @@ struct gobi_data {
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
 	bool using_mux : 1;
-	bool using_qmi_wwan : 1;
-	bool using_qmi_wwan_q : 1;
 };
 
 static void gobi_debug(const char *str, void *user_data)
@@ -111,15 +109,15 @@ static void gobi_io_debug(const char *str, void *user_data)
  * in order to initialize the driver properly:
  *
  * NetworkInterface
- *   The string that contains the 'main' network device.  This can be
- *   "rmnet_ipa" on SoC systems, or "wwan0" for upstream linux systems.
+ *   The string that contains the 'main' network device.  This is typically
+ *   'wwanX' on upstream linux systems.
  *
  * NetworkInterfaceIndex
  *   The index of the main interface given by NetworkInterface
  *
  * NetworkInterfaceKernelDriver
- *   The kernel driver that is being used by the main network device.  Certain
- *   drivers such as 'qmi_wwan' or 'qmi_wwan_q' are treated specifically.
+ *   The kernel driver that is being used by the main network device.  Only
+ *   'qmi_wwan' is supported.
  *
  * Bus
  *   The bus of the modem.  Values can be "usb", "embedded", or "pci"
@@ -131,7 +129,6 @@ static int gobi_probe(struct ofono_modem *modem)
 	const char *ifname;
 	int ifindex;
 	const char *bus;
-	int n_premux;
 
 	DBG("%p", modem);
 
@@ -140,32 +137,22 @@ static int gobi_probe(struct ofono_modem *modem)
 	ifname = ofono_modem_get_string(modem, "NetworkInterface");
 	ifindex = ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	bus = ofono_modem_get_string(modem, "Bus");
-	n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
 
 	DBG("net: %s[%s](%d) %s", ifname, if_driver, ifindex, bus);
 
-	if (!if_driver || !ifname || !ifindex || !bus || n_premux < 0)
+	if (!if_driver || !ifname || !ifindex || !bus)
 		return -EPROTO;
 
-	data = l_new(struct gobi_data, 1);
-
-	if (!strcmp(if_driver, "qmi_wwan_q"))
-		data->using_qmi_wwan_q = true;
-	else if (!strcmp(if_driver, "qmi_wwan"))
-		data->using_qmi_wwan = true;
-
-	if (n_premux > MAX_CONTEXTS) {
-		l_warn("NumPremuxInterfaces > %d, limiting to %d",
-				MAX_CONTEXTS, MAX_CONTEXTS);
-		n_premux = MAX_CONTEXTS;
-	}
+	if (!L_IN_STRSET(if_driver, "qmi_wwan"))
+		return -ENOTSUP;
 
-	data->n_premux = n_premux;
+	data = l_new(struct gobi_data, 1);
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	l_strlcpy(data->main_net_name,
 			ofono_modem_get_string(modem, "NetworkInterface"),
 			sizeof(data->main_net_name));
+
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
@@ -423,12 +410,7 @@ static void get_data_format_cb(struct qmi_result *result, void *user_data)
 	if (!qmi_result_get_uint32(result, QMI_WDA_LL_PROTOCOL, &llproto))
 		goto done;
 
-	if (data->using_qmi_wwan) {
-		const char *interface =
-			ofono_modem_get_string(modem, "NetworkInterface");
-
-		setup_qmi_wwan(interface, llproto);
-	}
+	setup_qmi_wwan(data->main_net_name, llproto);
 
 done:
 	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
@@ -674,10 +656,6 @@ static void powered_up_cb(int error, uint16_t type,
 	if (!param)
 		goto error;
 
-	if (data->using_qmi_wwan_q)
-		l_sysctl_set_u32(1, "/sys/class/net/%s/link_state",
-					data->main_net_name);
-
 	cb_data_ref(cbd);
 
 	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
@@ -711,10 +689,6 @@ static void powered_down_cb(int error, uint16_t type,
 	if (!param)
 		goto error;
 
-	if (data->using_qmi_wwan_q)
-		l_sysctl_set_u32(0, "/sys/class/net/%s/link_state",
-					data->main_net_name);
-
 	cb_data_ref(cbd);
 
 	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
@@ -792,8 +766,6 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
-	const char *interface;
-	char buf[256];
 	int i;
 
 	gprs = ofono_gprs_create(modem, 0, "qmimodem",
@@ -810,8 +782,6 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		struct qmi_service *ipv4 = data->context_services[0].wds_ipv4;
 		struct qmi_service *ipv6 = data->context_services[0].wds_ipv6;
 
-		interface = ofono_modem_get_string(modem, "NetworkInterface");
-
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
 						qmi_service_clone(ipv4),
 						qmi_service_clone(ipv6));
@@ -822,20 +792,16 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		}
 
 		ofono_gprs_add_context(gprs, gc);
-		ofono_gprs_context_set_interface(gc, interface);
+		ofono_gprs_context_set_interface(gc, data->main_net_name);
 
 		return;
 	}
 
-	data->using_mux = true;
-
-	data->max_aggregation_size =
-		ofono_modem_get_integer(modem, "MaxAggregationSize");
-	DBG("max_aggregation_size: %u", data->max_aggregation_size);
-
 	for (i = 0; i < data->n_premux; i++) {
 		struct qmi_service *ipv4 = data->context_services[i].wds_ipv4;
 		struct qmi_service *ipv6 = data->context_services[i].wds_ipv6;
+		const char *interface;
+		char buf[256];
 		int mux_id;
 
 		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
-- 
2.45.2


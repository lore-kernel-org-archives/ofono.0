Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93218635
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716420; cv=none; b=iWDLX9MWTmm8x6w4nvogH53Ii068iV679E5F+lCKiQ6h2xaRE2To70mlPVqZMGm6e6OHB2AUWmDU58d7Aq2H69Rysqj4A57udW32N76a9XWxXLY72txaHoA0Am5T36T2MUfk7GyghwdcaegXzmSnNGDx2IcHzLoDem5+FzujRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716420; c=relaxed/simple;
	bh=v0v7zU7SfV5hf7UJ7ywGy/Wso6ZtVANjHh6GDJxnbp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbuQqrKLUYUVFCDpCzmFzMmVB/Cedx5GgO36kbS5vOzf44hKhk8h1NqW+U1BFIIp0UbaXxT/Gw/m1b3/Ziv9fcPcTW6JArUvrW1Tkcad/a5y08GaeeHUZ28f2EFJftMzc0bOMA1KT9cail2wA1sJpubemN5EF67QgvQYF7GQ9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bicZ9TCD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bicZ9TCD"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8036ce66164so41661339f.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716418; x=1721321218; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiE7/RanaIDCqOfIBMI4yOLghOxvZGR+2aVfftt5bCU=;
        b=bicZ9TCDH7tJCMc8C1XI3dAnh3quHEFrNS1fWs2W+uExX5xxRy2f9DW858PrzjH9XM
         m/5BdlIs6cBPO+NZWOmjxt3p7M1kq/UnBY13xEeDTXP8SnQ2w++LhH00NEboJfQtKSMG
         ZF28Ef5ZMbFsVxLQ+D04AJS4Dua4oDzEl7xleLzqR/qjx/jSQLD2ASAFlQoHyHBf/1GT
         0S527qVC1Kk5WeMa5xb79X283Kh8ipX9Z6C7Zj0rkn/RMlNQDOUIGmcC5H0eNyZvSB7I
         uMceaNOIng3yfn69Va1rboHTpqUXJ6JTTKeVT6NUEdpHm1W3eL57MXwc+Og9zlezssqz
         uTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716418; x=1721321218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiE7/RanaIDCqOfIBMI4yOLghOxvZGR+2aVfftt5bCU=;
        b=jkvWupZ43sPEqxXTh9FcoApgeSd54WHHdCRIKKlqu5AnPsmBa81GIxKmpnw9oE/FhT
         At3V3dzAflm3U+y6QYjKTgKstm8gioBpbxjA/c3JYiwArBJ+cUjOazS3ALCiuPwu6NAg
         YRAcLm6/HDrYwRYogGbGx+eS92fchiGH3lfxS0FogOypfhzUjZXrI5vqpa0rU8vUDySA
         oTXjmBXeQUkDHrfy6nIyM5RITJlyfaPto35QvS3td+27fFnklA89mhKKc0ImAkcPLQeg
         WUsHacI49k3CtpgQmkuFfBVjK8jkcCf6oe/Ur5jvoA4ebbeu8ZjNjGl/jVQMO73krBcV
         foQA==
X-Gm-Message-State: AOJu0Yyt+iDMOB3dsKALmXwg2Xtz4xVmmW8rdHDvl2ZVqdnKSYO8ino/
	tsRNOoLpew7YLH2sPuZ93xKXbAYWMXF2JSN9ppdXdg1bTmcBT/HJnthPDg==
X-Google-Smtp-Source: AGHT+IF7I1gvW0sBFvF0zcJEIb3w08xXeuOj4eMXtIsgrH+m3Duo+c6d6cYfidWVeYqIp0dHN3vdqw==
X-Received: by 2002:a05:6602:1512:b0:7f6:8636:f89d with SMTP id ca18e2360f4ac-7fffece156dmr1350945339f.3.1720716417956;
        Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/11] gobi: Limit number of premultiplexed contexts to 4
Date: Thu, 11 Jul 2024 11:46:21 -0500
Message-ID: <20240711164654.1688558-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4 was chosen somewhat arbitrarily, but it is the maximum that the
qmi_wwan_q driver can support out of the box.  The only limit is the
number of clients under QMI.  Two WDS clients are typically required for
each active context, one for IPv4 and one for IPv6.  The total number of
clients cannot exceed 255 (uint8).
---
 plugins/gobi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 88e4c7fc4887..b6df849de47e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -55,6 +55,8 @@
 #define GOBI_VOICE	(1 << 6)
 #define GOBI_WDA	(1 << 7)
 
+#define MAX_CONTEXTS 4
+
 struct service_request {
 	struct qmi_service **member;
 	uint32_t service_type;
@@ -75,6 +77,7 @@ struct gobi_data {
 	int num_service_requests;
 	unsigned long features;
 	unsigned int discover_attempts;
+	uint8_t n_premux;
 	uint8_t oper_mode;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
@@ -124,6 +127,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	const char *ifname;
 	int ifindex;
 	const char *bus;
+	int n_premux;
 
 	DBG("%p", modem);
 
@@ -132,10 +136,11 @@ static int gobi_probe(struct ofono_modem *modem)
 	ifname = ofono_modem_get_string(modem, "NetworkInterface");
 	ifindex = ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	bus = ofono_modem_get_string(modem, "Bus");
+	n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
 
 	DBG("net: %s[%s](%d) %s", ifname, if_driver, ifindex, bus);
 
-	if (!if_driver || !ifname || !ifindex || !bus)
+	if (!if_driver || !ifname || !ifindex || !bus || n_premux < 0)
 		return -EPROTO;
 
 	data = l_new(struct gobi_data, 1);
@@ -145,6 +150,13 @@ static int gobi_probe(struct ofono_modem *modem)
 	else if (!strcmp(if_driver, "qmi_wwan"))
 		data->using_qmi_wwan = true;
 
+	if (n_premux > MAX_CONTEXTS) {
+		l_warn("NumPremuxInterfaces > %d, limiting to %d",
+				MAX_CONTEXTS, MAX_CONTEXTS);
+		n_premux = MAX_CONTEXTS;
+	}
+
+	data->n_premux = n_premux;
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	l_strlcpy(data->main_net_name,
@@ -753,7 +765,6 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 static void gobi_setup_gprs(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	int n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	const char *interface;
@@ -770,7 +781,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	}
 
 	/* Simple case of 802.3 interface, no QMAP */
-	if (n_premux == 0) {
+	if (data->n_premux == 0) {
 		interface = ofono_modem_get_string(modem, "NetworkInterface");
 
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
@@ -793,7 +804,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		ofono_modem_get_integer(modem, "MaxAggregationSize");
 	DBG("max_aggregation_size: %u", data->max_aggregation_size);
 
-	for (i = 0; i < n_premux; i++) {
+	for (i = 0; i < data->n_premux; i++) {
 		int mux_id;
 
 		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
-- 
2.45.2


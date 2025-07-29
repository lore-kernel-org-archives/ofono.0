Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE42147E5
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766521; cv=none; b=PcnaXyRchtXfMXRr683JEgN7SNqSFALFWi4S4NrP3O5cNlFugSD9Xr9noesnrw2XbKq4mi+UToM6mRgNKUlrytspvhXbP9iF8qkyuHzRJ8r9dbZB+gM8cqjNSqp+cE4k9JVvp/ynegFLyN8V4986g+dVBV+SWft38WDAN7X29As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766521; c=relaxed/simple;
	bh=YjvUn//zrxxwKHempetFjAbPXgIiWm5AKO8HjUH2Ff0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSjyM9qve+PjqoisVSW0+gujvse8R5yRsBusKC0UcsrvHKcmuFfQM02dTTp55kRF1eIuWwtiwISkTr1tCCFoFYBuNdoiK9yfJ+wGzS5fl4tM1aQ+YO8oTql57CFSX6sJWVUFXFHbyUOxdPBeN5Pyij2D3IKkZeigZ0vJcaryx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbrS2JQC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbrS2JQC"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1083320366b.1
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753766519; x=1754371319; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTeoNPiPUo/ELfZwkzvfQ7EPfw0Sy+OdxqVRx1cTYgc=;
        b=MbrS2JQClOi/IsDA2u2FUXLFbk7RlAmuoZcZrKOoZ6whKBCVYaf/si9IQaL/7h1QCT
         cR5J5WpHJEfOLgw0vAKd4ftlQ8AW3Al5lCorPvGzUfohfBAOiPaeEGNKUmOgduhLzZfU
         lJ307LqyX77fgLeKNUUIhm4MkL8CtKyGZZh1P2Z7OG/JiOOMl4VepEFFNshd8xMsfl6k
         lqqOb5WVHRSL24T644DTpEnDwtofoZm8XWIfp4enC1XJ5zIQkW5PXQQRUkpa64AUwEEP
         Rmp4maHpad5TByWkOsVjrL+9w/hyo1CgdtdlFTYPFyaNzG+ka7txDzyq6XwZFq9sVB9u
         qF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766519; x=1754371319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTeoNPiPUo/ELfZwkzvfQ7EPfw0Sy+OdxqVRx1cTYgc=;
        b=BoajhB7lWGfC9MRjHFhLPzECKseSokK9bHj/BS1+aUIbDgVE+OREVt/bNrwRgjIreg
         Ut4fs7JBxT9YWVuye67NX1f8sxuYFWQRptKRzp4vG371Ugbrx9dNAPqw1hvL2/gYNwoa
         MAjAjihdhmwnn1kAGH72PUwZvRFKPSpNvlX9DBU207Hu4YSpvYvymic5+MzGoEKQQWUz
         So7stViheQ56oKkUQQoWbUOtMR6CKLbBdvpq9sKJ5pxk8zjScjIaTWag8+fbqLUNh5lg
         6yy6lIBmUfWy7iVEekqysp6cSz8HV086424zklrJggDqv9hm0kFw5FC7awf5/MH6yrth
         E16w==
X-Gm-Message-State: AOJu0YxLMk2CkXCa8dXlA8KXEymuKDZE3Px4rt/CtdXixq9ms2zYZ3jE
	ikRKMtIcabpGHBNnbxBuCw0rxC1SW2SQWrBpbCM7U1b0aLYElzM8tjXJah7F4w==
X-Gm-Gg: ASbGncudB/PiEg1s/HMuwxfJBLivy44aDiuSb2NLgFfjJtUwan4ZgZKFndSKU0VXFYR
	V46WGDGLYxS6L+ZI74SYVYC63QSr/RZF/4aFeQBKB3FDEnZIj5cg4Sd6zVlakwVPGbse5ehn2+V
	dkxKoZMGv99zi3jeG7otJEibedoMkAWRmmBkRjvkiMLidm8b7Er9sqgzAEUn5t3KfkSk88RaeOj
	PxGctar/rg1CW4Qv9kLGRidRCSRlIX6uEJ3X4ny7WXFq8IOHPLACdMjXLhjwgDY72m+szqt0TPe
	Of9VMeldblwcVOV0IIoeT1cCGSvvE3uq04nCU0G8UlP+ax+ouh+vA3MIjhdHTLjSuIzXbIeCngo
	YLSGa+xGuzrq5jetRe+QsXZ2KMaF6QjjccDeORG7ohzQ2
X-Google-Smtp-Source: AGHT+IEX0wI0RsWFCpgKYyrW7mYWdADcETlAi7ZUJ2YI3VPCPyC54PiKGsyAx3MXkiF47zJ9IAcJKQ==
X-Received: by 2002:a17:906:1c42:b0:af6:3582:f01f with SMTP id a640c23a62f3a-af63582f0fdmr1014168266b.2.1753766518259;
        Mon, 28 Jul 2025 22:21:58 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589cab0sm525110266b.38.2025.07.28.22.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:21:57 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/3] gobi: Add "OfflineOperatingMode" property
Date: Tue, 29 Jul 2025 08:21:31 +0300
Message-Id: <20250729052132.779994-3-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some modems properly support PersistentLowPower mode when disabled, allow
them to request that
---
 plugins/gobi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index d5a7fc18..ea78a519 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -109,6 +109,7 @@ struct gobi_data {
 	uint32_t set_powered_id;
 	uint32_t set_mtu_id;
 	enum wda_data_format data_format;
+	uint8_t off_opmode;
 	bool no_pass_through : 1;
 };
 
@@ -217,12 +218,14 @@ static int gobi_probe(struct ofono_modem *modem)
 	struct gobi_data *data;
 	const char *if_driver;
 	const char *ifname;
+	const char *opmode;
 	uint8_t interface_number;
 	int ifindex;
 	const char *bus;
 	struct stat st;
 	_auto_(l_free) char *pass_through = NULL;
 	bool no_pass_through = false;
+	uint8_t off_opmode = QMI_DMS_OPER_MODE_LOW_POWER;
 
 	DBG("%p", modem);
 
@@ -231,6 +234,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	ifname = ofono_modem_get_string(modem, "NetworkInterface");
 	ifindex = ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	bus = ofono_modem_get_string(modem, "Bus");
+	opmode = ofono_modem_get_string(modem, "OfflineOperatingMode");
 
 	DBG("net: %s[%s](%d) %s", ifname, if_driver, ifindex, bus);
 
@@ -255,6 +259,15 @@ static int gobi_probe(struct ofono_modem *modem)
 			return -errno;
 	}
 
+	if (opmode) {
+		DBG("offline power mode: %s", opmode);
+
+		if (!strcmp(opmode, "PersistentLowPower"))
+			off_opmode = QMI_DMS_OPER_MODE_PERSIST_LOW_POWER;
+		else if (strcmp(opmode, "LowPower"))
+			return -ENOTSUP;
+	}
+
 	data = l_new(struct gobi_data, 1);
 	data->main_net_ifindex = ifindex;
 	l_strlcpy(data->main_net_name, ifname, sizeof(data->main_net_name));
@@ -262,6 +275,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	data->no_pass_through = no_pass_through;
 	/* See drivers/net/ethernet/qualcomm/rmnet/rmnet_private.h */
 	data->max_aggregation_size = 16384;
+	data->off_opmode = off_opmode;
 
 	ofono_modem_set_data(modem, data);
 
@@ -442,7 +456,7 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
 	switch (data->oper_mode) {
 	case QMI_DMS_OPER_MODE_ONLINE:
 		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_LOW_POWER);
+						data->off_opmode);
 		if (!param) {
 			shutdown_device(modem);
 			return;
@@ -935,8 +949,7 @@ static int gobi_disable(struct ofono_modem *modem)
 	if (ofono_modem_get_boolean(modem, "AlwaysOnline"))
 		goto out;
 
-	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_LOW_POWER);
+	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE, data->off_opmode);
 	if (!param)
 		return -ENOMEM;
 
-- 
2.25.1


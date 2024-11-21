Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C119D080
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202997; cv=none; b=e94zhktljX+QdWbUmYHtFq9LALVi+4kzrKk/ydK8mRWBntyJBrDxyoB6YzQC+doCPQSLAMJwUMah7de4rnMfwK0OfagIJQ2WeChfJboTbL+BXbiIJ6j7S3Y/wQp7VzkVCP2csZqyDGDPwIA0aic9H8mnnt2ypl+7lW6R4W8Jk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202997; c=relaxed/simple;
	bh=goXx78K2KumYVXCBKxzF4raCV0W0ReQPQ98vi51FmHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrLL1gQzeGLZxHqfz88gjq+45zPcWlhuocOuAxzEJmuSTRbzH8ayzvnj9NsNHuySUFgm6nLC5tv0NA8aCKw5PGnsRUWriZyGjIcaE0W99/9KH28NkPNEAnPBnEFAAo5AzMUFggKfg8y2/x+Qdc6uhIUQt4FCmmX8P9KnG5eTy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnSEEsXM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnSEEsXM"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-296b0d2271aso668946fac.0
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202994; x=1732807794; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ej4MTVy6vT9sqHMDE1EKLAEae+qaoh0XppUwehHJDo=;
        b=lnSEEsXMtckDtiukJFBDFPj4RLK966jdO/mHO7NtL/xIiXcpzBwe3L9znfxAYOlM24
         nw2ckY2+T4nZDvxIaF9PEZWoKmasu0J1VAKl04roSsuWTkaknEGNiSktoUZiMhS/XW2p
         Q4miD66CDnNALPFU0/T4K+bQXC05778iJ9kM2s8O3HphulE1qjW5Wlzkpn1S6n8ISisy
         zuKSWUjr4983Z1p1Ly2y7A1JbaTp/OPGuFgT178lbPlw0IAuMo+JM0I2Iu0bVMifYLY8
         ew8NmH825JxT/W/fbL+59uqhsUyP/NQ0+XYUnlrVVfEDSoLxDSL0pEm075c90H2+5sKE
         2KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202994; x=1732807794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ej4MTVy6vT9sqHMDE1EKLAEae+qaoh0XppUwehHJDo=;
        b=L2HRoMRIJ8ol1UaHgAbOw/VGvkf3hznxJ1I7S/l1ZqaqGHwCPIJpU5hnIx4EBbOJ71
         OMb94I46aQQ24mBXl3lIts3edesPOdhihjuJMG5ZH6MVqCPS3xtZNfKzaB4vT/vaMPSv
         UOSMCnYpyxqBIc/yVHD1VY1UYiP6GoPjID9sPAjfBjiY1xbbABp9meQxBL3X9tVxbLuQ
         RZddtQfemGernnWNoAi+YxT/wYU6JHcGtlgOK2SVFVbN4F+naJ4lhJriwnjUPRtR/u/W
         yzmciFEHRULPcq0qw+ox0CEOSUmqiRUHyd7x17LURxYgltPpvO/3/Wgbf0+E5bp2sUnM
         BZZw==
X-Gm-Message-State: AOJu0Yy7fSgdKQILRX8L7/rKENnOucl1Xf1oWUkj8QXNg7zCSHsmaOVO
	/RTzhrmofHQXlOCzNpkNN8eFH7Z2dP+6i5ivzALob2/clgHPLx65/HMa7w==
X-Gm-Gg: ASbGncu72ImQnCSn4Er8XuS1bSD0BXNt4Gns7QxvNfHOUSd4/VzfE7Oy1gyJZEs4ATQ
	m74v8V8DA/95nRfMzU00qXOONBwayidNpYBmChRTchBdnL8DzXfZn/brLdI508Hw0OfCL40iIQV
	qouiXUpcreJQ6zgEzGud1FZg/ByOILibwX6clW4fcead1LibssNq4Jv5AZnr9dm6uOKe2AA7OP6
	Pi5q5wsj+zaE4nf7gaGmeof+cgWxUMxF97sFQPPl//K5loTFpJHuY39JsiVGQoGW9jc0lSvGMsn
	bHT1wSUku9O92gHnAtAcy2u4
X-Google-Smtp-Source: AGHT+IERwkBaGURGRYJhFBNUMxx21M/p0h6CiS1W0CgVKK09G4srv7w4ABIPKor4FaMpbLQeLO8ahw==
X-Received: by 2002:a05:6871:d205:b0:288:6d7e:2e19 with SMTP id 586e51a60fabf-296d9b57fcfmr7518199fac.10.1732202994423;
        Thu, 21 Nov 2024 07:29:54 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:54 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/10] gobi: Detect qmi_wwan pass_through support
Date: Thu, 21 Nov 2024 09:29:32 -0600
Message-ID: <20241121152949.56962-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152949.56962-1-denkenz@gmail.com>
References: <20241121152949.56962-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect the presence of 'pass_through' sysfs entry and record it in a
flag for future reference.  pass_through mode is used when QMI_WWAN and
rmnet interfaces are used in a multiplexed fashion.
---
 plugins/gobi.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 4af3f3846694..87b54ae05f17 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <net/if.h>
+#include <sys/stat.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -59,6 +60,7 @@
 #define MAX_CONTEXTS 4
 
 #define QMI_WWAN_RAW_IP "/sys/class/net/%s/qmi/raw_ip"
+#define QMI_WWAN_PASS_THROUGH "/sys/class/net/%s/qmi/pass_through"
 
 enum wda_data_format {
 	WDA_DATA_FORMAT_UNKNOWN = 0,
@@ -98,6 +100,7 @@ struct gobi_data {
 	uint32_t set_powered_id;
 	enum wda_data_format data_format;
 	bool using_mux : 1;
+	bool no_pass_through : 1;
 };
 
 static void gobi_debug(const char *str, void *user_data)
@@ -136,6 +139,11 @@ static int qmi_wwan_set_raw_ip(const char *interface, char value)
 	return l_sysctl_set_char(value, QMI_WWAN_RAW_IP, interface);
 }
 
+static int qmi_wwan_set_pass_through(const char *interface, char value)
+{
+	return l_sysctl_set_char(value, QMI_WWAN_PASS_THROUGH, interface);
+}
+
 /*
  * Probe the modem.  The following modem properties are expected to be set
  * in order to initialize the driver properly:
@@ -165,6 +173,9 @@ static int gobi_probe(struct ofono_modem *modem)
 	uint8_t interface_number;
 	int ifindex;
 	const char *bus;
+	struct stat st;
+	_auto_(l_free) char *pass_through = NULL;
+	bool no_pass_through = false;
 
 	DBG("%p", modem);
 
@@ -189,10 +200,19 @@ static int gobi_probe(struct ofono_modem *modem)
 				&interface_number) < 0)
 		return -EINVAL;
 
+	pass_through = l_strdup_printf(QMI_WWAN_PASS_THROUGH, ifname);
+	if (stat(pass_through, &st) == -1) {
+		if (errno == ENOENT)
+			no_pass_through = true;
+		else
+			return -errno;
+	}
+
 	data = l_new(struct gobi_data, 1);
 	data->main_net_ifindex = ifindex;
 	l_strlcpy(data->main_net_name, ifname, sizeof(data->main_net_name));
 	data->interface_number = interface_number;
+	data->no_pass_through = no_pass_through;
 
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
@@ -504,7 +524,11 @@ static void create_wda_cb(struct qmi_service *service, void *user_data)
 	}
 
 	data->wda = service;
-	data->data_format = WDA_DATA_FORMAT_UNKNOWN + 1;
+
+	if (data->no_pass_through)
+		data->data_format = WDA_DATA_FORMAT_802_3;
+	else
+		data->data_format = WDA_DATA_FORMAT_UNKNOWN + 1;
 
 	if (!wda_get_data_format(data, &format))
 		goto error;
@@ -604,6 +628,15 @@ static void init_powered_down_cb(int error, uint16_t type,
 
 	DBG("Setting QMI_WWAN to 802.3 mode");
 
+	/* Must set pass_through first, before toggling raw_ip */
+	if (!data->no_pass_through) {
+		r = qmi_wwan_set_pass_through(data->main_net_name, 'N');
+		if (r < 0) {
+			ofono_warn("Unable to reset pass_through");
+			goto error;
+		}
+	}
+
 	r = qmi_wwan_set_raw_ip(data->main_net_name, 'N');
 	if (r < 0) {
 		ofono_warn("Unable to reset raw_ip");
-- 
2.47.0


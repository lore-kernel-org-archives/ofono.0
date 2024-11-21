Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2D1DACB8
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202999; cv=none; b=YAV9NaOv800DKaaeIxWmwk7QOznOPTtE3Z2EOwORcpCv1WayTSp3vz9GBsflvRxb/FFMSAU3Oy/qpRxE659ArIEzfYqCJlJZN41Nndh8MJKPKM6gUEOGQB+oizehaZOjNgv620hztktiPyiBZ4S7ny7M31nZm3s4usuOi0I3McQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202999; c=relaxed/simple;
	bh=jY/wHj5U3dVQgXSkp/y0W5yZpsZ/+GfYTXyDcNS6tLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCSWSslQTHGWIyAWnxL+wpjHXT69mAp/6W2m0VK9osuQL8tkkIPoyI17MaO1tiJXk+Ie6tEEN5NNahFfk4H04HTznjYCQVnfcdJBdWIkczD6BF98nG8kRZUUpr6dQH3+rYMgmSZHbwhJH15oAmxQBNDIUBMUrJof/jNDIUmsIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD1zhy95; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD1zhy95"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29678315c06so577679fac.1
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202996; x=1732807796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHLrc/XyOgHIIittARvCLdeNYWmDnYH7A/qXwEn8zdE=;
        b=fD1zhy95zW3CWBluxcPJnLvWW7PYOdFQzoEbxOl9z9wllbpJjo2EH/XU9atDM3iK86
         2qj8yyKkHaA51QRdRftbf3/GB1fUcu0RNDMb7GOVmo/FAOLLBgFBy1OAeBcRmKBJBPty
         +eqP7wPtq1uJb8VEU6DEO1U4W7DLzvtXuVTdYBLlfXgwkJ9Jh0XLmcMx1nX5SEjTx4tl
         5w24VHX3IafXaSqwlzYcyvGnYfqM3/jp2PdNzDNUWyhxmVL+FhZPBnWcJE3V8Ni+8uNz
         5wR4LcBUT6QmXX6l09s8pVCw/gXGiPfayHLRbGESftE2MAqatQjskt8440KnxUY0d9y6
         quZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202996; x=1732807796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHLrc/XyOgHIIittARvCLdeNYWmDnYH7A/qXwEn8zdE=;
        b=b5XTi6Erw5mbDkAgeTBvQBvungMFalLi+yPEexyWMbKZv/QcMR3roz72zNiU0syPwT
         v+ryV7FZlf3h6JRKg0jExUNfrMA/A+AfNMe5F0SfKi2QBVD4BhRdE/mEnnDAIDdTzqrz
         j0IOB4b0KH4zucII2GGYr4Fq06HaD4iOYNxhZ9cqwvpo+K/iUtRvDqevuxWTSnQqA76L
         i4DjAvXSVVX8mId5rqBoF7fAI/ZdByA04rXC52tHvXw2Fq64EHJeZA+mwSlzjsOMiqnE
         MYRzGlhqZpzfmDt+RdpgLU1DVdfDm7MVxuyTNZWZx/eUKap9aiSTkbn9WOB7N49K/mbr
         oeug==
X-Gm-Message-State: AOJu0YwJja1fT6DaEhp4iqYS46z825fOpDfGzhc4MucL/OdyCZED/rOO
	8PZdqbLsbYr9TEuBSz86CZiuIs1mF1TvcF/eW0i0eh5nJ2B/qOd9FR7ZbA==
X-Gm-Gg: ASbGncsf57mUJUD2IiTfcXZP4T3u79EHsKd4j3liZn1xJNwf/fJv0V+dm/GgHe1qkKT
	WeVcj+dSASoT6dvaEuFQIfW6cUGqairIbqfdNAqJ8Fy6NeJL+14Uoqcxix80qRsHDNBkr//5yDt
	6cbNvy4htapui0ikBzCeOKehHCWFEmU0yEFLklYElOB01OQ9TOgqrz9kjLayrR6PQDsb7mCrwsN
	LMl1u1SZyj0UzjNyjv5qqwqyLoZ9zAXyF8pHWBR0xNecasFMipgSS8vgOdKTHunrBEXkQxeYyhb
	OAo3Sg+QJnHRQQUye8m47XyV
X-Google-Smtp-Source: AGHT+IFklczpuOIse/YOq83/gmoQFgWlwKeO/hRg0Fh8xhkbdcVFDzTXDzBn1pKiyHLCp6PUemX6qw==
X-Received: by 2002:a05:6871:e7c5:b0:270:64ed:c125 with SMTP id 586e51a60fabf-296d9b84f56mr8041515fac.16.1732202996085;
        Thu, 21 Nov 2024 07:29:56 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:55 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/10] gobi: Set MTU when initializing QMI_WWAN
Date: Thu, 21 Nov 2024 09:29:34 -0600
Message-ID: <20241121152949.56962-6-denkenz@gmail.com>
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

MTU on cellular networks is generally smaller than the default 1500 MTU
used by ethernet.  Most network providers recommend a particular
setting, typically around ~1430 bytes.  The recommended MTU should also
be provided by the network when the context is activated.
On AT command modems, the setting can be read using +CGDCONTRDP.

oFono does not currently manage MTU settings; setup a conservative
1400 byte MTU to bootstrap.
---
 plugins/gobi.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 321a2ae0bca7..cb53ec582385 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -58,6 +58,7 @@
 #define GOBI_WDA	(1 << 7)
 
 #define MAX_CONTEXTS 4
+#define DEFAULT_MTU 1400
 
 #define QMI_WWAN_RAW_IP "/sys/class/net/%s/qmi/raw_ip"
 #define QMI_WWAN_PASS_THROUGH "/sys/class/net/%s/qmi/pass_through"
@@ -98,6 +99,7 @@ struct gobi_data {
 	uint8_t interface_number;
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
+	uint32_t set_mtu_id;
 	enum wda_data_format data_format;
 	bool using_mux : 1;
 	bool no_pass_through : 1;
@@ -134,6 +136,24 @@ static bool wda_get_data_format(struct gobi_data *data,
 	return false;
 }
 
+static int wda_data_format_to_mtu(enum wda_data_format format, uint32_t *out_mtu)
+{
+	uint32_t mtu;
+
+	switch (format) {
+	case WDA_DATA_FORMAT_802_3:
+		mtu = DEFAULT_MTU;
+		break;
+	default:
+		return -ENOTSUP;
+	}
+
+	if (out_mtu)
+		*out_mtu = mtu;
+
+	return 0;
+}
+
 static int qmi_wwan_set_raw_ip(const char *interface, char value)
 {
 	return l_sysctl_set_char(value, QMI_WWAN_RAW_IP, interface);
@@ -269,6 +289,11 @@ static void gobi_remove(struct ofono_modem *modem)
 		data->set_powered_id = 0;
 	}
 
+	if (data->set_mtu_id) {
+		l_netlink_cancel(l_rtnl_get(), data->set_mtu_id);
+		data->set_mtu_id = 0;
+	}
+
 	cleanup_services(data);
 
 	qmi_qmux_device_free(data->device);
@@ -461,6 +486,29 @@ error:
 	shutdown_device(modem);
 }
 
+static void enable_set_mtu_cb(int error, uint16_t type,
+					const void *msg, uint32_t len,
+					void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct gobi_data *data = ofono_modem_get_data(modem);
+
+	DBG("error: %d", error);
+
+	data->set_mtu_id = 0;
+
+	if (error)
+		goto error;
+
+	DBG("Requesting services");
+
+	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
+				request_service_cb, modem, NULL) > 0)
+		return;
+error:
+	shutdown_device(modem);
+}
+
 /*
  * Some firmware accepts the Set Data Format command successfully, but doesn't
  * change anything.  Try to detect and warn if that happens
@@ -497,6 +545,7 @@ static void set_data_format_cb(struct qmi_result *result, void *user_data)
 		.interface_number = data->interface_number,
 	};
 	struct qmi_wda_data_format format;
+	uint32_t mtu;
 
 	DBG("");
 
@@ -523,10 +572,15 @@ static void set_data_format_cb(struct qmi_result *result, void *user_data)
 	goto error;
 
 done:
-	DBG("Set Data Format succeeded, proceeding to create services");
+	DBG("Set Data Format succeeded, try to set MTU...");
 
-	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
-				request_service_cb, modem, NULL) > 0)
+	if (L_WARN_ON(wda_data_format_to_mtu(data->data_format, &mtu) < 0))
+		goto error;
+
+	data->set_mtu_id = l_rtnl_link_set_mtu(l_rtnl_get(),
+						data->main_net_ifindex, mtu,
+						enable_set_mtu_cb, modem, NULL);
+	if (data->set_mtu_id)
 		return;
 error:
 	shutdown_device(modem);
-- 
2.47.0


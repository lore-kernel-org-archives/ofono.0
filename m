Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEB15B995
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032694; cv=none; b=tTCr2ln1mp1nFLSEuUmmHDV7KRr+cqJt39UHJ31//SCiDaF3KvSJ4vR7YAswTkl0nx05Dpbvo+hZ2OOsf2BWsdms9heV6usxYybS0LYIF9SqQvR6pwMXwVlczVAVbdqioBFcz4U7yPOTERvvm/YujMw9ZLh/oisjTte0nJU2kYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032694; c=relaxed/simple;
	bh=Gg4FUUxImDFijCMY1yf5Hm+htsp0/LOZYBMlD7LKeLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYqCfzoag7TzsS3LHgOj68luJgHSpPah/s5/qHNJ/KKuoz7tiOITqCR1OaQrC5UFmBDb6thtXARdds3d5cQI87x1W3hZN58xVacq5qgO6NLUa/+Z4rmJTspcBB+2575Fpk8vOALaJNjNVq6fvT7UCabEiLyJpXuk0Pv87apK+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHCcBgu6; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHCcBgu6"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5acb737b508so1033816eaf.0
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032692; x=1715637492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bv8p6sCluT97Kxfk2HWuslVDffgzuyEwgnnR+kGTY0=;
        b=ZHCcBgu6E1zPzqBJn8bPHCJiPKcsgQiyEzMwlyidH4TNzC5DA/pWYaws2A+qyCsw58
         GwunxluzJq6ZhhlZlVrVVNdv78jzbVnqfkmvL5XDlGLO4Mbd9Qdc7QwIY+pOV9Yjp/gY
         yWJnoQ8lqKwjIIT4wtMV62uZzF8Ajc43csWMz9T8JFlaH5qF7av0wdIkMR0L6oZy7QQF
         cs5ToUJGBACDB0s8MZox4PO5kvqJQWRv8ceuTUy2aFSsKfnB23l4tnouOK8wUVxHRCTZ
         6PPtz7iDUfSygIV4ly0JGC+ZZfa7aBaUYlsag7rDjdCs2UCiPa2kFp1U2XXMSW8+E3Lb
         /UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032692; x=1715637492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bv8p6sCluT97Kxfk2HWuslVDffgzuyEwgnnR+kGTY0=;
        b=Oj5ks/DkeG/31TT6D0cHCOazEKyO+4yL1ph7rIiH1Sa8Z8EkvHZT2RGK7DJ/c4Gpgk
         l5nCJAggxy8+cZOjZCQIKcYlRnVvWkQ+v7SQfeUqbbMXHwDJc0K2FCzY+SwzqCF+NDIx
         VZgseP6M41K4Uq/N3BYMALBjCeUp/eKFi5eKw2cqbnLEdJM8rzqFzaFemvVXhiiergyp
         I2eEaxAlHwlriqnvuCx50F+aDe8fnC/bMkicGUhdHrwkMAQcIwK+rHfAVravDE6Bd3Aj
         cLy3tM4HPKiwXfa5ePwmfeHYI/c5LP0J7R7trpER9pI4altqixGxMQQP3ggcj8b4gm7z
         WixQ==
X-Gm-Message-State: AOJu0Yya/wxohZyREA97e/I+XTQZuB4mpyjj6wHOHefDEM0Z7zKBMYRM
	T8YxVaWbPiAiv/7GQ2j1oPW6lyklEH+lyp+pwAeG35YXHua04TV7qvrFlA==
X-Google-Smtp-Source: AGHT+IEHVyqSThoIewC0PJLwJUWMJAIVvNesIi84Ztk0R2+Psld44niOuL+PZcHrdgT+s86rEg4kvw==
X-Received: by 2002:a4a:4bc6:0:b0:5b1:bf03:d1c6 with SMTP id q189-20020a4a4bc6000000b005b1bf03d1c6mr12178083ooa.1.1715032691615;
        Mon, 06 May 2024 14:58:11 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:11 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 8/8] qmi: gprs-context: Obtain initial bearer IP support
Date: Mon,  6 May 2024 16:58:02 -0500
Message-ID: <20240506215804.57124-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506215804.57124-1-denkenz@gmail.com>
References: <20240506215804.57124-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.read_settings is used by the core to setup the network interface for
the initial bearer.  This initial bearer is typically an internet
context, but can be something else, depending on the carrier.  The
initial bearer might also be configured by the network itself, and can
be IPv4, IPv6 or dual stack.  Have the gprs-context driver query the
initial attach parameters to obtain this information, and only then
invoke the WDS Start Network command.

Supporting Dual Stack contexts requires multiple WDS handles to be
allocated, with each handle issuing a Start Network request with a
different IP family preference.  This is currently not supported by the
underlying QMUX/QRTR transport.  For now, choose invoke Start Network
with IPv4 family preference for IPV4 and Dual Stack contexts, and IPv6
famiily preference for IPv6 contexts.
---
 drivers/qmimodem/gprs-context.c | 64 ++++++++++++++++++++++++++++-----
 drivers/qmimodem/wds.h          |  6 ++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 21ef1237758e..e04821c3ca6d 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -282,6 +282,55 @@ error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 
+static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
+{
+	static const uint8_t RESULT_IP_SUPPORT_TYPE = 0x11;
+	struct cb_data *cbd = user_data;
+	ofono_gprs_context_cb_t cb = cbd->cb;
+	struct ofono_gprs_context *gc = cbd->user;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
+	uint8_t iptype;
+	struct qmi_param *param;
+	uint8_t ip_family;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error))
+		goto error;
+
+	if (!qmi_result_get_uint8(result, RESULT_IP_SUPPORT_TYPE, &iptype))
+		goto error;
+
+	switch (iptype) {
+	case QMI_WDS_IP_SUPPORT_IPV4:
+		ip_family = QMI_WDS_IP_FAMILY_IPV4;
+		break;
+	case QMI_WDS_IP_SUPPORT_IPV6:
+		ip_family = QMI_WDS_IP_FAMILY_IPV6;
+		break;
+	case QMI_WDS_IP_SUPPORT_IPV4V6:
+		ip_family = QMI_WDS_IP_FAMILY_IPV4;
+		break;
+	default:
+		goto error;
+	}
+
+	param = qmi_param_new_uint8(QMI_WDS_PARAM_IP_FAMILY, ip_family);
+
+	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, param,
+					start_net_cb, cbd, cb_data_unref) > 0) {
+		cb_data_ref(cbd);
+		return;
+	}
+
+	qmi_param_free(param);
+
+error:
+	data->active_context = 0;
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 /*
  * This function gets called for "automatic" contexts, those which are
  * not activated via activate_primary.  For these, we will still need
@@ -299,18 +348,15 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 
 	DBG("cid %u", cid);
 
-	data->active_context = cid;
-
-	cbd->user = gc;
-
-	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, NULL,
-					start_net_cb, cbd, cb_data_unref) > 0)
+	if (qmi_service_send(data->wds, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
+				NULL, get_lte_attach_param_cb, cbd,
+				cb_data_unref) > 0) {
+		data->active_context = cid;
+		cbd->user = gc;
 		return;
-
-	data->active_context = 0;
+	}
 
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
 	l_free(cbd);
 }
 
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 026402e7a3f6..a308767177a3 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -46,6 +46,12 @@ enum qmi_wds_pdp_type {
 	QMI_WDS_PDP_TYPE_IPV4V6		= 0x03,
 };
 
+enum qmi_wds_ip_support {
+	QMI_WDS_IP_SUPPORT_IPV4		= 0x00,
+	QMI_WDS_IP_SUPPORT_IPV6		= 0x01,
+	QMI_WDS_IP_SUPPORT_IPV4V6	= 0x02,
+};
+
 enum qmi_wds_ip_family {
 	QMI_WDS_IP_FAMILY_UNKNOWN = 0,
 	QMI_WDS_IP_FAMILY_IPV4 = 4,
-- 
2.45.0


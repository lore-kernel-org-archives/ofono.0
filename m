Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62561369B4
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202996; cv=none; b=eLTh5AFlaiOIwPbz2oH+dE1zi0K/e1Sa4W2tqJFnDp0MbANRjEzr0HogQEFOWXLlag/fX+jgnvVQs55QzY99f+lyCl5ej6lPIq5BAJcRpq9+Q5ZoED3Z5oPCo47c+vkI4QEuIfnJuMqb7RV1zLeSms9W3fgjn3fWDtvS9QgVJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202996; c=relaxed/simple;
	bh=xregUDOpLXmogpkaDnz5Rcr5Qh6XR4lIzMjwLez0j6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1Gi0wEjtuhRLXAtwDgZuZMBVymggjwVNOkKGvfgtePr/IClogUirkjjSvBNt+RJgjHnY1I/WNGlPlA8vc1dRgcKKDiCnTSbIYp3J2mkuv+DPlD7qAUBn+DWDG8oPYYZBcjHiWKsG/RfO+jfsIALEtGLvxmofbx7U66IxsZLdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0tec7il; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0tec7il"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-296c184ed6bso642165fac.0
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202993; x=1732807793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80CTRyuEUF3ZQoRGp6bgbgOH1IDCwiiaGWfqq1ywHNc=;
        b=K0tec7il7GlIfQJ93lyp/q45G6srGotETebmQWbFJddu7tSIdAomPA0eJxoiwJ9j2H
         YchvL5HHLtDfmMMAyHTYbxMKJ1wENUWSrbv7JHoa68oFpInSFQECgyJX2nydrEZuCHYm
         TsaGvey/qiYNt1OOfpnQIzvMeGoafQ0Idd3GUW1ElYNeS2XXM/6pMpotVKtSlbvgey2L
         XYZHrKuWQ937Cny9Vw0N+bxwFNkXhS+U6czsdb1GSqMHB78wg2qY+yN9BXBbvXBFQCvM
         GMln8+SincSsmbWJitDk4A0RAgCOqTnlhIorgNpxnlvfYsU0l0PG9eZHMb9aa8gLj2N3
         qlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202993; x=1732807793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80CTRyuEUF3ZQoRGp6bgbgOH1IDCwiiaGWfqq1ywHNc=;
        b=H9Y3EtDv8M+jVXCLOceWEGP4GPIQSQNKzsV144fqo8W14e7w4f0MVq5ziB1VjUsZlZ
         fLsU3VH6rlJ7XOKq1GOvmx1q+iLfn9bF5KunjiUELpLm+c8DfmYh/eZ207MzQyT4T1nh
         GOYVXM2NA4+TjoBi0tg/1C2RbkMFMYOuRKmpyxEObf1qlxiK46IvOOiD5dh2RgCBRnqN
         v4O4X5IeGoKJ44U2AFZNXTe+tsZqxiVBh+JAPEiZf53miFFdNjD7s/yGsp3F/w//2fSX
         1kxvzncPsKCLTaJ0p6CatxmEzNTxuldXAlRk5oTPsxve5OyhI5/J+fPdB5i0gIdRx9KX
         61sA==
X-Gm-Message-State: AOJu0YxFXisSBcgKjJ7QZMHhkiQ57N7Jz1rjugOmxTig6o7SeSICu4Z0
	FbMmEG7rsaXMxJBaoEY+9G5vGxid5Nl5EdRxF/dW5FLLq/MYoLEn+nNC8g==
X-Gm-Gg: ASbGncvVVrW7SfdVJ7pZD8xElc3q5PuFCxXbHBP/dQrDWKR10nlwNhAoNNOMtG8S5wY
	PCO0EZQFXT9LZ79cBaHR9Yq8kZHWAFjsO4VWHZ44biitOHn0k27gxxY1colf/pFrFT3az6wVk8O
	+4ioiN8Dny5T2aagJkkQUjGlF1Y5mNp8LDEt/D1RTcXr7m5e+e5CNRZmwU6XX5weit2gXKsAm6u
	Jo6CWek7S8fIwOd8P4TRuFPMaGvhnkPBvGDCtTCA89H9y5wkNrNv8qAUTV7AcTCD28eiYkn9ek6
	RjrjRvhdSdtm//yn2BbQ/t41
X-Google-Smtp-Source: AGHT+IGk62XZmdItay4SDXYKWfR277dMbuXdVxnlVhzkR36YRM0ELzVRRmmdGjK5oxxzDZXm2Xki6Q==
X-Received: by 2002:a05:6871:5287:b0:296:a7bf:b503 with SMTP id 586e51a60fabf-296d9ae0a64mr7392417fac.7.1732202993554;
        Thu, 21 Nov 2024 07:29:53 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:53 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/10] gobi: Explicitly set 802.3 data format
Date: Thu, 21 Nov 2024 09:29:31 -0600
Message-ID: <20241121152949.56962-3-denkenz@gmail.com>
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

The current logic relies on querying the current data format, and
setting the qmi_wwan parameters accordingly.  Unfortunately, the logic
does not take data aggregation settings into account and can get
confused if the modem is using such settings.  Fix this by explicitly
setting the WDA data format to 802.3.

While here, add some preparatory logic to support other data modes
easily.  This will be used in the future to support multiple contexts
using RMNet + QMAP.
---
 plugins/gobi.c | 191 ++++++++++++++++++++++++++++---------------------
 1 file changed, 108 insertions(+), 83 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 54b64acb7871..4af3f3846694 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -45,6 +45,7 @@
 #include <drivers/qmimodem/dms.h>
 #include <drivers/qmimodem/wda.h>
 #include <drivers/qmimodem/util.h>
+#include <drivers/qmimodem/common.h>
 
 #define GOBI_DMS	(1 << 0)
 #define GOBI_NAS	(1 << 1)
@@ -57,6 +58,13 @@
 
 #define MAX_CONTEXTS 4
 
+#define QMI_WWAN_RAW_IP "/sys/class/net/%s/qmi/raw_ip"
+
+enum wda_data_format {
+	WDA_DATA_FORMAT_UNKNOWN = 0,
+	WDA_DATA_FORMAT_802_3,	/* Last, most compatible legacy fallback */
+};
+
 struct service_request {
 	struct qmi_service **member;
 	uint32_t service_type;
@@ -88,6 +96,7 @@ struct gobi_data {
 	uint8_t interface_number;
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
+	enum wda_data_format data_format;
 	bool using_mux : 1;
 };
 
@@ -105,6 +114,28 @@ static void gobi_io_debug(const char *str, void *user_data)
 	ofono_debug("%s%s", prefix, str);
 }
 
+static bool wda_get_data_format(struct gobi_data *data,
+				struct qmi_wda_data_format *out_format)
+{
+	if (data->data_format == WDA_DATA_FORMAT_UNKNOWN ||
+			data->data_format > WDA_DATA_FORMAT_802_3)
+		return false;
+
+	memset(out_format, 0, sizeof(struct qmi_wda_data_format));
+
+	if (data->data_format == WDA_DATA_FORMAT_802_3) {
+		out_format->ll_protocol = QMI_WDA_DATA_LINK_PROTOCOL_802_3;
+		return true;
+	}
+
+	return false;
+}
+
+static int qmi_wwan_set_raw_ip(const char *interface, char value)
+{
+	return l_sysctl_set_char(value, QMI_WWAN_RAW_IP, interface);
+}
+
 /*
  * Probe the modem.  The following modem properties are expected to be set
  * in order to initialize the driver properly:
@@ -159,11 +190,8 @@ static int gobi_probe(struct ofono_modem *modem)
 		return -EINVAL;
 
 	data = l_new(struct gobi_data, 1);
-	data->main_net_ifindex =
-		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
-	l_strlcpy(data->main_net_name,
-			ofono_modem_get_string(modem, "NetworkInterface"),
-			sizeof(data->main_net_name));
+	data->main_net_ifindex = ifindex;
+	l_strlcpy(data->main_net_name, ifname, sizeof(data->main_net_name));
 	data->interface_number = interface_number;
 
 	ofono_modem_set_data(modem, data);
@@ -252,6 +280,7 @@ static void __shutdown_device(struct ofono_modem *modem)
 	data->cur_service_request = 0;
 	data->num_service_requests = 0;
 	data->features = 0;
+	data->data_format = WDA_DATA_FORMAT_UNKNOWN;
 
 	qmi_qmux_device_free(data->device);
 	data->device = NULL;
@@ -376,126 +405,113 @@ error:
 	shutdown_device(modem);
 }
 
-static void setup_qmi_wwan(const char *interface, uint32_t llproto)
-{
-	char raw_ip;
-	char new_raw_ip;
-
-	if (l_sysctl_get_char(&raw_ip, "/sys/class/net/%s/qmi/raw_ip",
-				interface) < 0) {
-		DBG("Couldn't query raw_ip setting");
-		return;
-	}
-
-	if (raw_ip != 'Y' && raw_ip != 'N') {
-		DBG("Unexpected value: %c", raw_ip);
-		return;
-	}
-
-	switch (llproto) {
-	case QMI_WDA_DATA_LINK_PROTOCOL_802_3:
-		new_raw_ip = 'N';
-		break;
-	case QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP:
-		new_raw_ip = 'Y';
-		break;
-	default:
-		DBG("Unknown WDA Link Protocol");
-		return;
-	}
-
-	DBG("raw_ip: %c, want: %c", raw_ip, new_raw_ip);
-
-	if (raw_ip == new_raw_ip)
-		return;
-
-	if (l_sysctl_set_char(new_raw_ip, "/sys/class/net/%s/qmi/raw_ip",
-				interface) < 0)
-		DBG("Fail to set raw_ip to %c", new_raw_ip);
-}
-
-static void get_data_format_cb(struct qmi_result *result, void *user_data)
+static void request_service_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	uint32_t llproto;
+	struct service_request *req =
+		&data->service_requests[data->cur_service_request];
 
 	DBG("");
 
-	if (qmi_result_set_error(result, NULL))
-		goto done;
+	if (!service)
+		goto error;
 
-	if (!qmi_result_get_uint32(result, QMI_WDA_LL_PROTOCOL, &llproto))
-		goto done;
+	*req->member = service;
 
-	setup_qmi_wwan(data->main_net_name, llproto);
+	data->cur_service_request += 1;
+	if (data->cur_service_request == data->num_service_requests) {
+		DBG("All services requested, query DMS Capabilities");
 
-done:
-	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
+		if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
 						get_caps_cb, modem, NULL) > 0)
+			return;
+
+		goto error;
+	}
+
+	req = &data->service_requests[data->cur_service_request];
+	DBG("Requesting: %u", req->service_type);
+
+	if (qmi_qmux_device_create_client(data->device, req->service_type,
+					request_service_cb, modem, NULL))
 		return;
 
+error:
 	shutdown_device(modem);
 }
 
-static void create_wda_cb(struct qmi_service *service, void *user_data)
+static void set_data_format_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
+	struct qmi_endpoint_info endpoint_info = {
+		.endpoint_type = QMI_DATA_ENDPOINT_TYPE_HSUSB,
+		.interface_number = data->interface_number,
+	};
+	struct qmi_wda_data_format format;
 
 	DBG("");
 
-	if (!service) {
-		DBG("Failed to request WDA service, continue initialization");
+	if (!qmi_result_set_error(result, NULL))
+		goto done;
+
+	if (data->data_format == WDA_DATA_FORMAT_802_3)
 		goto error;
-	}
 
-	data->wda = service;
+	DBG("Trying next data format");
+	data->data_format += 1;
 
-	if (qmi_service_send(data->wda, QMI_WDA_GET_DATA_FORMAT, NULL,
-				get_data_format_cb, modem, NULL) > 0)
-		return;
+	if (!wda_get_data_format(data, &format))
+		goto error;
 
-error:
-	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
-						get_caps_cb, modem, NULL) > 0)
+	if (qmi_wda_set_data_format(data->wda, &endpoint_info, &format,
+					set_data_format_cb, modem, NULL) > 0)
 		return;
 
+	goto error;
+
+done:
+	DBG("Set Data Format succeeded, proceeding to create services");
+
+	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
+				request_service_cb, modem, NULL) > 0)
+		return;
+error:
 	shutdown_device(modem);
 }
 
-static void request_service_cb(struct qmi_service *service, void *user_data)
+static void create_wda_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	struct service_request *req =
-		&data->service_requests[data->cur_service_request];
+	struct qmi_endpoint_info endpoint_info = {
+		.endpoint_type = QMI_DATA_ENDPOINT_TYPE_HSUSB,
+		.interface_number = data->interface_number,
+	};
+	struct qmi_wda_data_format format;
 
 	DBG("");
 
-	if (!service)
-		goto error;
-
-	*req->member = service;
-
-	data->cur_service_request += 1;
-	if (data->cur_service_request == data->num_service_requests) {
-		DBG("All services requested, proceeding to create WDA");
+	if (!service) {
+		DBG("Failed to request WDA service, assume 802.3");
 
-		if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_WDA,
-						create_wda_cb, modem, NULL))
+		if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
+					request_service_cb, modem, NULL) > 0)
 			return;
 
 		goto error;
 	}
 
-	req = &data->service_requests[data->cur_service_request];
-	DBG("Requesting: %u", req->service_type);
+	data->wda = service;
+	data->data_format = WDA_DATA_FORMAT_UNKNOWN + 1;
 
-	if (qmi_qmux_device_create_client(data->device, req->service_type,
-					request_service_cb, modem, NULL))
-		return;
+	if (!wda_get_data_format(data, &format))
+		goto error;
 
+	if (qmi_wda_set_data_format(data->wda, &endpoint_info, &format,
+					set_data_format_cb, modem, NULL) > 0)
+		return;
 error:
 	shutdown_device(modem);
 }
@@ -563,9 +579,10 @@ static void discover_cb(void *user_data)
 							QMI_SERVICE_WDS);
 	}
 
-	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
-					request_service_cb, modem, NULL) > 0)
+	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_WDA,
+						create_wda_cb, modem, NULL))
 		return;
+
 error:
 	shutdown_device(modem);
 }
@@ -585,6 +602,14 @@ static void init_powered_down_cb(int error, uint16_t type,
 	if (error)
 		goto error;
 
+	DBG("Setting QMI_WWAN to 802.3 mode");
+
+	r = qmi_wwan_set_raw_ip(data->main_net_name, 'N');
+	if (r < 0) {
+		ofono_warn("Unable to reset raw_ip");
+		goto error;
+	}
+
 	r = qmi_qmux_device_discover(data->device, discover_cb, modem, NULL);
 	if (!r)
 		return;
-- 
2.47.0


Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61718176255
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895115; cv=none; b=nA4wC2QdS4Zgu/Oxvh2SxNE2KiTcPJFQEks64icb6CoX1xZ1qjr359Qo/APwJlNlegiKkYiNLu/hKObiFmY6Psdl2bBlPQX6Kn4Gcx8B1YFz6mMaAP5loK96vBd7I1ilhmop42otsX1aYKdkSxJz4ppyX0wUtqjgHxQum6Ibxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895115; c=relaxed/simple;
	bh=H3QsSyyWhQW3NsalYj13U8DxijWHPiHDGMiGEpfhiiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErH/lDaCYmEZmlQt2IteXSVx0+F2rp/aDHi8bcrr+FRJtDA+86k7yGZ/6TBEJIbRNS4HEQlRad8gpaxA1u8QonKXAueK57fL00c/tTjJSKXaUgC0+Ate1xKIUtmycQeycNid/1tvN5Tz1pTHscxKRplETE5gXq8iVAO5haznme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez1sR4t2; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez1sR4t2"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d215a594b9so462236b6e.3
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895112; x=1719499912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzzL3/8tP9XuVP9bHSpPPMmIL15+rFeLNzCIZlRE1kQ=;
        b=ez1sR4t2Hnj3vE2x4sLIxBZvQTRbHuqAwuHb7T8mWPskH77YGWMdjYHUjZRZUzVaFt
         v0//wKhpgBYKQAZQ02MerRaY0g1/IRXNI/XRyKnHosZiI4Ovgb1LOdv1VgSBhhidNLAX
         knTFOBt7s5DRqJ798cp8BTMLYbkFjkcyTTRJRdsM1b8G7MeMP/mqyAMuLI+uhJjTgsqA
         ddkNtu9Ec1EFk4oZGdts1ru1D/T6GQImXRDDloDvwOkzzq2UbaiHApY85WlnXYKxlWqF
         OVAof8wGt0ncQV7tmqePXGr9nlH7VZ+xGw45jUS0IsnuTjTz6Y2jaicU4Ng2xWFCLoHa
         SD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895112; x=1719499912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzzL3/8tP9XuVP9bHSpPPMmIL15+rFeLNzCIZlRE1kQ=;
        b=HAaVXfrqe27K6RkFW0fBRG1keM+rpcxyHO9pWQe2yxIIjDf5pJM3ZIxLJib8Zxk/eE
         BE+vA/A1NXxGi7pyKuMblOGUDu1bWj045jVquaDUWOO/kWpwsrn4tGE/MFntK7dAHD6B
         Tf5N66rPRbV3rLTKgL0TfJe47qhwo1vu8ACL/VQX5IhvTLBEVPoTJk7py9kset6OjAQy
         4JUXLX4JIj9UeJW6E58IaPL3u9YPrs/0Cx0ufT3969AppecHBHRQZWGWgVuivH6bwckq
         XPAFjMd3kAXtopfF5/0OTxxH2bjhSOndfNhjZgt5z26S0Gw1JGzgf30Dq2niEX/Vskdt
         wrLA==
X-Gm-Message-State: AOJu0Yz6fgp9fDEW5xW+RYIWRKdUQ4f3eyfERK8PGF344R6gFaZEOOvE
	c5muHSoh/Be0SQK+OKOHnxDZ6DCOjR+PJcq+HX1Gy76r+161ELnMw96efw==
X-Google-Smtp-Source: AGHT+IG6FFSgVAGX3o2VSIaUzr2Hc8a5I/VynfaNwfYQ5pLpDfoYjTGvJaPJJFIvbaoce/LK4n7l9g==
X-Received: by 2002:a05:6808:16a7:b0:3d2:292e:1a3b with SMTP id 5614622812f47-3d527fd2e41mr3057575b6e.0.1718895110261;
        Thu, 20 Jun 2024 07:51:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 05/33] plugins: Add new qrtrqmi modem driver
Date: Thu, 20 Jun 2024 09:50:52 -0500
Message-ID: <20240620145139.1135899-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver will be used for QRTR based devices (MHI bus and SoC)
---
 Makefile.am       |   1 +
 plugins/qrtrqmi.c | 430 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 431 insertions(+)
 create mode 100644 plugins/qrtrqmi.c

diff --git a/Makefile.am b/Makefile.am
index d904dd95c761..d379201d362b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -387,6 +387,7 @@ builtin_sources += $(qmi_sources) \
 			drivers/qmimodem/call-forwarding.c
 
 builtin_sources += plugins/gobi.c
+builtin_sources += plugins/qrtrqmi.c
 endif
 
 if MBIMMODEM
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
new file mode 100644
index 000000000000..9d2038a9b50c
--- /dev/null
+++ b/plugins/qrtrqmi.c
@@ -0,0 +1,430 @@
+/*
+ * oFono - Open Source Telephony
+ * Copyright (C) 2008-2012  Intel Corporation
+ * Copyright (C) 2024  Cruise, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <net/if.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+#include <ofono/netreg.h>
+#include <ofono/netmon.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/lte.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
+#include <ofono/location-reporting.h>
+#include <ofono/log.h>
+#include <ofono/message-waiting.h>
+
+#include <ell/ell.h>
+
+#include <drivers/qmimodem/qmi.h>
+#include <drivers/qmimodem/dms.h>
+#include <drivers/qmimodem/util.h>
+
+struct qrtrqmi_data {
+	struct qmi_device *node;
+	struct qmi_service *dms;
+	int main_net_ifindex;
+	char main_net_name[IFNAMSIZ];
+	bool have_voice : 1;
+};
+
+static void qrtrqmi_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+/*
+ * Probe the modem.  The following modem properties are expected to be set
+ * in order to initialize the driver properly:
+ *
+ * NetworkInterface
+ *   The string that contains the 'main' network device.  This can be
+ *   "rmnet_ipa" on SoC systems, or "wwan0" for upstream linux systems.
+ *
+ * NetworkInterfaceIndex
+ *   The index of the main interface given by NetworkInterface
+ *
+ * NetworkInterfaceKernelDriver
+ *   The kernel driver that is being used by the main network device.
+ *
+ * Bus
+ *   The bus of the modem.  Values can be "embedded", or "pci"
+ */
+static int qrtrqmi_probe(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data;
+	const char *if_driver;
+	const char *ifname;
+	int ifindex;
+	const char *bus;
+
+	DBG("%p", modem);
+
+	if_driver = ofono_modem_get_string(modem,
+						"NetworkInterfaceKernelDriver");
+	ifname = ofono_modem_get_string(modem, "NetworkInterface");
+	ifindex = ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
+	bus = ofono_modem_get_string(modem, "Bus");
+
+	DBG("net: %s[%s](%d) %s", ifname, if_driver, ifindex, bus);
+
+	if (!if_driver || !ifname || !ifindex || !bus)
+		return -EPROTO;
+
+	data = l_new(struct qrtrqmi_data, 1);
+	data->main_net_ifindex =
+		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
+	l_strlcpy(data->main_net_name,
+			ofono_modem_get_string(modem, "NetworkInterface"),
+			sizeof(data->main_net_name));
+	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
+	return 0;
+}
+
+static void qrtrqmi_deinit(struct qrtrqmi_data *data)
+{
+	qmi_service_free(data->dms);
+	data->dms = NULL;
+	qmi_device_free(data->node);
+	data->node = NULL;
+}
+
+static void qrtrqmi_remove(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	qrtrqmi_deinit(data);
+	l_free(data);
+}
+
+static void power_reset_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		qrtrqmi_deinit(ofono_modem_get_data(modem));
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_param *param;
+	uint8_t mode;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	if (!qmi_result_get_uint8(result, QMI_DMS_RESULT_OPER_MODE, &mode))
+		goto error;
+
+	switch (mode) {
+	case QMI_DMS_OPER_MODE_ONLINE:
+		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
+						QMI_DMS_OPER_MODE_LOW_POWER);
+
+		if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+					power_reset_cb, modem, NULL) > 0)
+			return;
+
+		break;
+	default:
+		ofono_modem_set_powered(modem, TRUE);
+		return;
+	}
+
+error:
+	qrtrqmi_deinit(data);
+}
+
+static void lookup_done(void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_device *node = data->node;
+
+	DBG("");
+
+	if (!qmi_device_has_service(node, QMI_SERVICE_DMS) ||
+			!qmi_device_has_service(node, QMI_SERVICE_UIM) ||
+			!qmi_device_has_service(node, QMI_SERVICE_WDS) ||
+			!qmi_device_has_service(node, QMI_SERVICE_NAS))
+		goto error;
+
+	data->dms = qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS);
+	if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
+					get_oper_mode_cb, modem, NULL) > 0)
+		return;
+error:
+	qrtrqmi_deinit(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static int qrtrqmi_enable(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	int r;
+
+	DBG("%p", modem);
+
+	data->node = qmi_device_new_qrtr();
+	if (!data->node)
+		return -EIO;
+
+	if (getenv("OFONO_QMI_DEBUG"))
+		qmi_device_set_debug(data->node, qrtrqmi_debug, "QRTR: ");
+
+	r = qmi_device_discover(data->node, lookup_done, modem, NULL);
+	if (!r)
+		return -EINPROGRESS;
+
+	return r;
+}
+
+static void power_disable_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+
+	DBG("");
+
+	qrtrqmi_deinit(ofono_modem_get_data(modem));
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static int qrtrqmi_disable(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_param *param;
+
+	DBG("%p", modem);
+
+	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
+					QMI_DMS_OPER_MODE_LOW_POWER);
+
+	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+					power_disable_cb, modem, NULL))
+		return -EINPROGRESS;
+
+	qmi_param_free(param);
+	qrtrqmi_deinit(data);
+	return -EIO;
+}
+
+static void set_online_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_modem_online_cb_t cb = cbd->cb;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	else
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void qrtrqmi_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	struct qmi_param *param;
+
+	DBG("%p %s", modem, online ? "online" : "offline");
+
+	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
+					online ? QMI_DMS_OPER_MODE_ONLINE :
+						QMI_DMS_OPER_MODE_LOW_POWER);
+
+	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+				set_online_cb, cbd, l_free) > 0)
+		return;
+
+	qmi_param_free(param);
+	l_free(cbd);
+}
+
+static void qrtrqmi_pre_sim(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_device *node = data->node;
+	struct qmi_service *voice;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS));
+
+	ofono_sim_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS),
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_UIM));
+
+	voice = qmi_qrtr_node_get_service(node, QMI_SERVICE_VOICE);
+	if (voice) {
+		data->have_voice = true;
+		ofono_voicecall_create(modem, 0, "qmimodem", voice);
+	}
+}
+
+static int setup_gprs_context(uint8_t mux_id, const char *interface,
+				struct ofono_gprs *gprs)
+{
+	struct ofono_modem *modem = ofono_gprs_get_modem(gprs);
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_qrtr_node *node = data->node;
+	struct ofono_gprs_context *gc;
+
+	gc = ofono_gprs_context_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS));
+	if (!gc) {
+		ofono_warn("Unable to create gprs-context for: %s, %s[%u]",
+				ofono_modem_get_path(modem), interface, mux_id);
+		return -ENOPKG;
+	}
+
+	ofono_gprs_add_context(gprs, gc);
+	ofono_gprs_context_set_interface(gc, interface);
+	return 0;
+}
+
+static void setup_gprs(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_qrtr_node *node = data->node;
+	int n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
+	struct ofono_gprs *gprs;
+	const char *interface;
+	char buf[256];
+	int i;
+
+	gprs = ofono_gprs_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS),
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_NAS));
+	if (!gprs) {
+		ofono_warn("Unable to create gprs for: %s",
+					ofono_modem_get_path(modem));
+		return;
+	}
+
+	for (i = 0; i < n_premux; i++) {
+		int mux_id;
+
+		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
+		mux_id = ofono_modem_get_integer(modem, buf);
+
+		sprintf(buf, "PremuxInterface%d", i + 1);
+		interface = ofono_modem_get_string(modem, buf);
+
+		setup_gprs_context(mux_id, interface, gprs);
+	}
+}
+
+static void qrtrqmi_post_sim(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_device *node = data->node;
+	struct qmi_service *wms;
+
+	DBG("%p", modem);
+
+	ofono_lte_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS));
+
+	ofono_radio_settings_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS),
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_NAS));
+
+	wms = qmi_qrtr_node_get_service(node, QMI_SERVICE_WMS);
+	if (wms) {
+		struct ofono_message_waiting *mw = NULL;
+
+		ofono_sms_create(modem, 0, "qmimodem", wms);
+
+		if (qmi_device_has_service(node, QMI_SERVICE_UIM))
+			mw = ofono_message_waiting_create(modem);
+
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
+
+	setup_gprs(modem);
+}
+
+static void qrtrqmi_post_online(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_device *node = data->node;
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_NAS));
+	ofono_netmon_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_NAS));
+
+	if (!data->have_voice)
+		return;
+
+	ofono_ussd_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_VOICE));
+	ofono_call_settings_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_VOICE));
+	ofono_call_barring_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_VOICE));
+	ofono_call_forwarding_create(modem, 0, "qmimodem",
+			qmi_qrtr_node_get_service(node, QMI_SERVICE_VOICE));
+}
+
+static struct ofono_modem_driver qrtrqmi_driver = {
+	.probe		= qrtrqmi_probe,
+	.remove		= qrtrqmi_remove,
+	.enable		= qrtrqmi_enable,
+	.disable	= qrtrqmi_disable,
+	.set_online	= qrtrqmi_set_online,
+	.pre_sim	= qrtrqmi_pre_sim,
+	.post_sim	= qrtrqmi_post_sim,
+	.post_online	= qrtrqmi_post_online,
+};
+
+OFONO_MODEM_DRIVER_BUILTIN(qrtrqmi, &qrtrqmi_driver)
-- 
2.45.0


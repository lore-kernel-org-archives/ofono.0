Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07C143876
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740960; cv=none; b=F5kDAZahe3zIcP87K7szhVcjo1suSHiDOI5lWLdszCS/7n4yVHxmSUflPD49qgBU0u0noB8DSXRimNzi9DErlde578FuyzqrP2TxN+6QM6tHDcGz7R2e2QjGtbt/Y3rdd+ZZI34XNJLO3tOlU/mOG0KVLLiLGuKATobwR+8BG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740960; c=relaxed/simple;
	bh=xCPRcOMir23ErzpMFbLAKCc68Fb6zC7MqsoGs7cmpaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbNsos6PVtXnjNzTfsJLtX6BVtMn+nIgQOuKy/stRz4tmIdZ5WPp473rnV8bAcOa4XRiGGPI16hsyyvkc+aMndfwTlN/9N8rHGRaQGamoDr7WD6u8cRKtV4S2lt4u3wGgGGMO/upsEv4pIE/H7hZAhBLKl1UheQJu5V5qCmyhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJyQdrwK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJyQdrwK"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2550aa6f994so3591969fac.3
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740957; x=1719345757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHH0FPmnVXc1se3cvpEwERue28eWfxm8kHgTHoIviMA=;
        b=IJyQdrwKM3QJ1ioErkA+YDguuEggASqn59ivCuS0m9oWg7AWZvcItR4Qjc0DWA5WrT
         ZcykNGhf8eh8bubc2wJmpEhk/Lv3U+9BfKibxmRBZdN3ip6PYsH4KnorlGtOdBDfuXua
         znBy+CK/eZqotk2ENYQEqXV6V0v5hACuuB9xDOKJxcZLx85fleK9qr42v5Jynn1fNdBK
         M76kZdbNjJU4PzCwD9B+wEtBDlOokLl7ZyXhQDVTS46+5f7EB5mOJIxP6mYX2+gnLaEp
         CZx7/1ZSOrv34LeaQnsKxOiUrnk6BHsvy4l40Jrx8UUBqBSGuuGSOGIYHk79qNeuhGGl
         F83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740957; x=1719345757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHH0FPmnVXc1se3cvpEwERue28eWfxm8kHgTHoIviMA=;
        b=SVsnKMYgJR1yRlXmkBS70JtNMlg13VWiaVxG/HfGZ4vFhombDBg2jmFoi+FI9P2T2N
         744BOekhLMyuNpSYvugoTz0UTBDZaMN1ycM94d6DQ6qrwLwUyIUrfhM4YwFmTFOPR1xX
         JjSm0eVxpHRrWSgizxK5Kas7pTCOXHikaJiaABHzk5F+p981a3+FOXrFspI4Cv4UEXO/
         jWvhEFkpjE9aDUiOY6qNMtz3Nj1BuPG5rTuDlFaowSGPP+QM+3i8sK0k6z3z7yneUy//
         UIz66eii7wU42SopgAh/2ziRiYa6qxGb9rxjFeqhSsCPToowMfIZGXohbkyu5NIgv/lZ
         K4qQ==
X-Gm-Message-State: AOJu0YzbvoeY+virTEfJV+7X2TA4xRuUQOUua6z9woWRzItVG+AQK/UI
	yzKeQvx2NuV8p/nl1B85c0tBqitE7Q1SKPMqeqXVU9xw6VAJ9PCmZmw/oQ==
X-Google-Smtp-Source: AGHT+IH7uhTFT9Vda1qxQAZjuHY2W9qYqjhsRMW1uTj6FvbNkZNScUs0144vzPhVxV7XSqxbbnSrJg==
X-Received: by 2002:a05:6870:718c:b0:258:3455:4b37 with SMTP id 586e51a60fabf-25c94e50b1bmr821318fac.59.1718740956778;
        Tue, 18 Jun 2024 13:02:36 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:36 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/33] plugins: Add new qrtrqmi modem driver
Date: Tue, 18 Jun 2024 15:01:47 -0500
Message-ID: <20240618200231.1129282-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
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
index 000000000000..f75742f98508
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
+		ofono_warn("Unable to create gprs-context for: %s, %s[%hhu]",
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


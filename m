Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCE1DFD8E
	for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656430; cv=none; b=PhGuTdrjFhKLEOCqOsRwuk0oZAQC/js/4PkgDhmqgrjMO/6lKPJr+Ow/A3P5rxwj9jSxug86cwngUYcTFM05OT0nIEQ+mmA9xrMqO3BdYxJD3zS9OjJq80VH9K8qhgdqM8RRnV2o2FJCsfuRCWFw7CKteA45fxqgGDvhX9hWvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656430; c=relaxed/simple;
	bh=yRW9Zupoa5zATuTqIJwYsbSSWygLnHE81YSrGfZVW2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR1PfjiYZ1jEiagntC53WkO/BfeyBNVam5AdLS2asNHgENYjQbhourhpXi+/SppuqpldCulMyJOghFKIsRg2GLIQgutRlxKua4Ylxe6qDZFqrBJbJe6m6qjPsE6XBxhvKkxoKMzGNqSJ/NMDm74TTPTeR0TuxExjBwGq2rXuWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOtj4WtN; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOtj4WtN"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ea52520327so1145718b6e.1
        for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732656428; x=1733261228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciq0TS0HGbSLegbXe1gmUm7Bhj1zByC+oR6oyWVuqQM=;
        b=EOtj4WtNaaS23nyrmS/92CqRIFL/FTP1AAVivJ8GxEbBcunnXbDXCV1UXOtlYThRff
         hhZ/EV5H7IwbeHO4F5P9tuKGeFhkzEMs352AXOyslGsSE41wh+HKHsc15s9Bpfngzt5D
         tp3X6CJYeE/iocdbM0DEBIqEQYbj2d56J/YNT/1YXCNFKilzZM8WPCf574cZg6R+aUpt
         Q8Qx+yCLKrg11Btq8+ajyCB+aVPQWbzRRae/hbKVyxaTolX373p/pPprG9Uh3rDEfaRu
         7J/t7MEEaR5skIEGYlr+9PCDAX/qkAci4RMi5uHywyUMUG0lxcbPm1S6/DaJ8JUNbnEA
         PYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656428; x=1733261228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciq0TS0HGbSLegbXe1gmUm7Bhj1zByC+oR6oyWVuqQM=;
        b=Pcr04AOBpCtxJ1w3R1awdzc8xN8HTzXSkB8boDhd4WpVJ8e2VMXorSQFcOB20TOvnX
         j0l5ZZYu8LC9+7xWFTmfWUNOJUZ+qtjtbJt85+5pLkB+/sKjYCr0qkv7nme69noq9I7l
         SxWmApDUkbpmIsL6EFmh9ZP0cQV59NdFH5f5RSjvIeHbJ8QuDof6JN8g6s2pzkqSTJKh
         o1UW+c2V2/f1fUHvTpTQWmu2MJldZgW9WQ6+Xnxyd23wfwKuPFIwC5dfvtNF6CG7xQ2i
         VHXf8NUKZdJo/5wQnIn1dqBQztf1lQiuzQfh2tuk75dFJojZcjEW0KaoBuUCBc9xSw9S
         LKFA==
X-Gm-Message-State: AOJu0YxLcq95guF8c4XQ5ORRoPSOtJIOspW8h06EavwMsZDr98jtf0Te
	etMRCKt5qBrCtXh6vZKDda+df45On9x1kUKUvZaqZGZ/Plt6SkVYwBhQbw==
X-Gm-Gg: ASbGnct+mrU1srubLSehy367Gzy/fMmDoncaHyHgnmYaUeChIqdvI5yidoN0Mq7kefy
	WYyN4BO/QQ11FDa4FqqYDWYUhJYLqcCyj7qe62ETlpWr5C9WsrT4TDDkTZM1lWxBxjfootabwl0
	Y5HMponda2ylyaoJXqFD6t9bNigL7IEJcDE5wOkJ5ov29Z27iLkQeAGBPwzDDIYhG5ZcX2gGFvR
	HsviS+DBhukRprt4FPFQy5rMFC2VT1xsVYlabBpnVk2lY6rrd50q9gVDWJhF5e5svtTKKUUXiSI
	6IDQn9I8r7ibckIyGYOfCKEf
X-Google-Smtp-Source: AGHT+IFejsQCh1Iqos8SE6q0f56iDN2b5bXilc6VgFgIHNjAT1cNtZUCHU//3Z2VPTeomfsqlxtSoA==
X-Received: by 2002:a05:6808:1a02:b0:3ea:367e:db44 with SMTP id 5614622812f47-3ea6db6d67cmr946570b6e.3.1732656427985;
        Tue, 26 Nov 2024 13:27:07 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e835e2sm3177531b6e.13.2024.11.26.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:27:07 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] qrtrqmi: Add multiple bearer support
Date: Tue, 26 Nov 2024 15:26:17 -0600
Message-ID: <20241126212703.196003-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126212703.196003-1-denkenz@gmail.com>
References: <20241126212703.196003-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new rmnet module to request multiple rmnet interfaces that will
sit on top of the main mhi_net interface (typically mhi_hwipX).  These
interfaces can then be used to support multiple simultaneous active
contexts.
---
 plugins/qrtrqmi.c | 145 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 23 deletions(-)

diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 21103371046a..8bfbb11d167e 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -42,13 +42,25 @@
 
 #include <drivers/qmimodem/qmi.h>
 #include <drivers/qmimodem/dms.h>
+#include <drivers/qmimodem/wda.h>
 #include <drivers/qmimodem/util.h>
+#include <drivers/qmimodem/common.h>
+#include "src/rmnet.h"
+
+#define MAX_CONTEXTS 4
+#define DEFAULT_DL_DATAGRAMS 32
+#define DEFAULT_DL_AGGREGATION_SIZE 32768
+#define DEFAULT_UL_AGGREGATION_SIZE 16384
 
 struct qrtrqmi_data {
 	struct qmi_qrtr_node *node;
 	struct qmi_service *dms;
+	struct qmi_service *wda;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
+	struct rmnet_ifinfo rmnet_interfaces[MAX_CONTEXTS];
+	uint8_t n_premux;
+	int rmnet_id;
 	bool have_voice : 1;
 };
 
@@ -120,6 +132,8 @@ static void qrtrqmi_deinit(struct qrtrqmi_data *data)
 {
 	qmi_service_free(data->dms);
 	data->dms = NULL;
+	qmi_service_free(data->wda);
+	data->wda = NULL;
 	qmi_qrtr_node_free(data->node);
 	data->node = NULL;
 }
@@ -132,10 +146,105 @@ static void qrtrqmi_remove(struct ofono_modem *modem)
 
 	ofono_modem_set_data(modem, NULL);
 
+	if (data->rmnet_id) {
+		rmnet_cancel(data->rmnet_id);
+		data->rmnet_id = 0;
+	}
+
 	qrtrqmi_deinit(data);
 	l_free(data);
 }
 
+static void rmnet_get_interfaces_cb(int error, unsigned int n_interfaces,
+					const struct rmnet_ifinfo *interfaces,
+					void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	unsigned int i;
+
+	DBG("error: %d, n_interfaces: %u", error, n_interfaces);
+	data->rmnet_id = 0;
+
+	if (error)
+		goto error;
+
+	DBG("RMNet interfaces created:");
+	for (i = 0; i < n_interfaces; i++)
+		DBG("\t%s[%d], mux_id: %u",
+			interfaces[i].ifname, interfaces[i].ifindex,
+			interfaces[i].mux_id);
+
+	memcpy(data->rmnet_interfaces, interfaces,
+			sizeof(struct rmnet_ifinfo) * n_interfaces);
+	data->n_premux = n_interfaces;
+	ofono_modem_set_powered(modem, TRUE);
+	return;
+error:
+	qrtrqmi_deinit(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void set_data_format_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_wda_data_format format;
+	int r;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	r = qmi_wda_parse_data_format(result, &format);
+	if (r < 0)
+		goto error;
+
+	DBG("DL Aggregation Size: %u", format.dl_max_size);
+	DBG("DL Max Datagrams: %u", format.dl_max_datagrams);
+	DBG("DL Aggregation Protocol: %u", format.dl_aggregation_protocol);
+	DBG("UL Aggregation Protocol: %u", format.ul_aggregation_protocol);
+
+	data->rmnet_id = rmnet_get_interfaces(data->main_net_ifindex,
+						MAX_CONTEXTS,
+						rmnet_get_interfaces_cb,
+						modem, NULL);
+	if (data->rmnet_id > 0)
+		return;
+
+	ofono_error("Unable to request RMNet interfaces");
+error:
+	qrtrqmi_deinit(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void setup_data_format(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct qmi_endpoint_info endpoint_info = {
+		.endpoint_type = QMI_DATA_ENDPOINT_TYPE_PCIE,
+		.interface_number = 0x04,
+	};
+	struct qmi_wda_data_format format = {
+		.ll_protocol = QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP,
+		.dl_aggregation_protocol = QMI_WDA_AGGREGATION_PROTOCOL_QMAPV5,
+		.ul_aggregation_protocol = QMI_WDA_AGGREGATION_PROTOCOL_QMAPV5,
+		.dl_max_datagrams = DEFAULT_DL_DATAGRAMS,
+		.dl_max_size = DEFAULT_DL_AGGREGATION_SIZE,
+	};
+
+	DBG("%p", modem);
+
+	data->wda = qmi_qrtr_node_get_service(data->node, QMI_SERVICE_WDA);
+	if (qmi_wda_set_data_format(data->wda, &endpoint_info, &format,
+					set_data_format_cb, modem, NULL) > 0)
+		return;
+
+	qrtrqmi_deinit(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static void power_reset_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -148,7 +257,7 @@ static void power_reset_cb(struct qmi_result *result, void *user_data)
 		return;
 	}
 
-	ofono_modem_set_powered(modem, TRUE);
+	setup_data_format(modem);
 }
 
 static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
@@ -177,7 +286,7 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
 
 		break;
 	default:
-		ofono_modem_set_powered(modem, TRUE);
+		setup_data_format(modem);
 		return;
 	}
 
@@ -196,6 +305,7 @@ static void lookup_done(void *user_data)
 	if (!qmi_qrtr_node_has_service(node, QMI_SERVICE_DMS) ||
 			!qmi_qrtr_node_has_service(node, QMI_SERVICE_UIM) ||
 			!qmi_qrtr_node_has_service(node, QMI_SERVICE_WDS) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_WDA) ||
 			!qmi_qrtr_node_has_service(node, QMI_SERVICE_NAS))
 		goto error;
 
@@ -236,10 +346,15 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 static void power_disable_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	qrtrqmi_deinit(ofono_modem_get_data(modem));
+	rmnet_del_interfaces(data->n_premux, data->rmnet_interfaces);
+	data->n_premux = 0;
+	memset(data->rmnet_interfaces, 0, sizeof(data->rmnet_interfaces));
+
+	qrtrqmi_deinit(data);
 	ofono_modem_set_powered(modem, FALSE);
 }
 
@@ -346,11 +461,8 @@ static void setup_gprs(struct ofono_modem *modem)
 {
 	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
 	struct qmi_qrtr_node *node = data->node;
-	int n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
 	struct ofono_gprs *gprs;
-	const char *interface;
-	char buf[256];
-	int i;
+	unsigned int i;
 
 	gprs = ofono_gprs_create(modem, 0, "qmimodem",
 			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS),
@@ -361,23 +473,10 @@ static void setup_gprs(struct ofono_modem *modem)
 		return;
 	}
 
-	/* Upstream driver default, single interface, single context */
-	if (!n_premux) {
-		interface = ofono_modem_get_string(modem, "NetworkInterface");
-		setup_gprs_context(0, interface, gprs);
-		return;
-	}
-
-	for (i = 0; i < n_premux; i++) {
-		int mux_id;
-
-		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
-		mux_id = ofono_modem_get_integer(modem, buf);
-
-		sprintf(buf, "PremuxInterface%d", i + 1);
-		interface = ofono_modem_get_string(modem, buf);
+	for (i = 0; i < data->n_premux; i++) {
+		struct rmnet_ifinfo *ifinfo = data->rmnet_interfaces + i;
 
-		setup_gprs_context(mux_id, interface, gprs);
+		setup_gprs_context(ifinfo->mux_id, ifinfo->ifname, gprs);
 	}
 }
 
-- 
2.47.0


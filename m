Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD38BE5
	for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743129; cv=none; b=QXZB/yPQmmW5dPt1g7SdE7nr23nAGrnAXwja58Cdw5QOzMAzWRo/5KIfS4V1ZPioK4OpNsHj1McbaAe78hK48Hvj4mpx1CR+m7RtAZX4uWd6h/tetkqoKez/O7Cl2STSqiSPPyw6kb0ZVBp0uuCWNEU72UUEYM3ZNf5FOf4aFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743129; c=relaxed/simple;
	bh=mI0L8i3m4/EJNGOmVQJYLnp6CCKW3GWaHxlLIaXCzy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRJ/Lfkix4+edPnnvFXyxg0g+NwaTRKHo9X0JYX/wwYODUQ21y2pLWrPziE7uxb0yyeeFh6vOB+GjfJiXRZoBwhqA9bnlM4VUWp9B4LclhKasrI7tXExqWySIePdyfnza0KfLO4cz1fVLiwKgX6tgqcC51GbbuONXjOWi5oDhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWLITDT0; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWLITDT0"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-296bff3f5e8so169718fac.2
        for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743126; x=1733347926; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bR2AiJV9WCM1g4gkusYNTzn+tVuZD//DSHbotcE1C0=;
        b=dWLITDT0ZGDnBc47iY+G73zEj8Vao4AuF2hhRe4A3UNgKUfDDFkXxh8dMk/QjjcdV7
         d2YBr0fnwgBOhxsmAlhordivf3v10tzDcjDL/c+l9+Hui4R1MyVlCJZLnQfZOLtKLxmd
         dhCzU7E5GRWraVIwSMtceYSVKG/26JAKDuba053VHbXzwNDX7ys69h9QFhJ5Dx72rYz2
         qb40nKIoY82FWzwPNqkiY1rodJ2LVUdDNz/GMlkdhiz4TXpIVjMqJKvFF33ji9kmbEte
         sFtZp1DRMIEZxUlID+0zJEg/1weoA3ufiZiDvD9QZc0ZRJFD630wxd6FUo/2i7UdBKjY
         UMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743126; x=1733347926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bR2AiJV9WCM1g4gkusYNTzn+tVuZD//DSHbotcE1C0=;
        b=TnyERI0CIPwXiU4G6oHmUS/K2/cpzfA3yB8QFZVHWnbPuoEq+NXcCD2HhdfMXo8yvy
         gKcVsIsAupWfVsSzJgfJwT+LCez9JsPDnAv2iTalkFVDsz8TExDtab+OZihCpctBLN7o
         rcbJhVvC5PFtuxhyBtShbdZ9tXixZ3Kmh87kYC54t4nKdQdAMDWnYa+yVYT4A9TkBbdt
         r0OCek6zmxwxuh6GiIFLxPmphVBmBM8gTUtayMGH1FIlu+mmfMIcbPman8nz1uiUVEzq
         2taaIPj7LbvgSTyQK8Ufz6tqw7ziLvddE7FQ4vkXuAD/1copdvAPZ6KB+WmejejOlMeb
         Cz/g==
X-Gm-Message-State: AOJu0YxwRDt7Dt8CE05SW0LvurcCUpKzt+IU/1RqVSVnLYpX75s1+/O1
	tc0ifEBW8f2Q6fgNsMDAfHe573PP5K/5uA/l93fXoNY0+kVDN4/H3Q1Kbg==
X-Gm-Gg: ASbGncvLzLj/p0vbPq6YF2/ylVDuQBjougn4szFWCEB5Xc/4WgA7q+CHKoQwB//q021
	uik0cK8Lkk0qBuqkfUQAvkdFMmCUUd3QP/tdl8YfOwRjtautNZ8x16haQdKNrS1uNaNooYt2uwp
	024PzyAPBSfMddJxWCFagMgHbMFxK1uzLm+zsTA3SEoX7LhE0O2wYXMRmk6KeC/uPx9bcKylREE
	4Sea3ZA+kiiuM7aw6I4sf6JGE3IaAyL6oOniZ63BK/JkB/46KrdLkV/bO/27/h2idPaYAoynNia
	U9www9ZVM2J4c3bl3KZEnIQE
X-Google-Smtp-Source: AGHT+IHNXFnvgGbtBfTGZJOrg8kWrnTp6PS49IZ+w1hK6EnAe4hFuIFP4tjSzQ8GnYST8Bu43HkDTg==
X-Received: by 2002:a05:6871:e805:b0:29d:ca30:5c21 with SMTP id 586e51a60fabf-29dca308d5dmr3618437fac.29.1732743125710;
        Wed, 27 Nov 2024 13:32:05 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9ba6bbfsm29114fac.48.2024.11.27.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:32:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/4] qrtrqmi: Add multiple bearer support on mhi_net
Date: Wed, 27 Nov 2024 15:31:50 -0600
Message-ID: <20241127213200.202536-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127213200.202536-1-denkenz@gmail.com>
References: <20241127213200.202536-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for multiple simultaneous active bearers for devices
that use the upstream mhi_net driver.  Use the newly added rmnet module
to request multiple rmnet interfaces that will sit on top of the main
mhi_net interface (typically mhi_hwipX).  WDA service is also requested,
and the data format is setup to perform data aggregation.

For drivers that use pre-multiplexed interfaces (i.e. rmnet / IPA),
migrate the pre-multiplexing logic to use rmnet_ifinfo structure.
---
 plugins/qrtrqmi.c | 213 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 191 insertions(+), 22 deletions(-)

diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 21103371046a..4a00fa45a110 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -42,14 +42,27 @@
 
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
+	bool soc_premux : 1;
 };
 
 static void qrtrqmi_io_debug(const char *str, void *user_data)
@@ -66,6 +79,31 @@ static void qrtrqmi_debug(const char *str, void *user_data)
 	ofono_debug("%s%s", prefix, str);
 }
 
+static int setup_soc_premux_interfaces(struct ofono_modem *modem)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	const char *interface;
+	unsigned int i;
+	char buf[256];
+	int mux_id;
+
+	for (i = 0; i < data->n_premux; i++) {
+		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
+		mux_id = ofono_modem_get_integer(modem, buf);
+
+		sprintf(buf, "PremuxInterface%d", i + 1);
+		interface = ofono_modem_get_string(modem, buf);
+		if (!interface)
+			return -ENOENT;
+
+		data->rmnet_interfaces[i].mux_id = mux_id;
+		l_strlcpy(data->rmnet_interfaces[i].ifname, interface,
+				sizeof(data->rmnet_interfaces[i].ifname));
+	}
+
+	return 0;
+}
+
 /*
  * Probe the modem.  The following modem properties are expected to be set
  * in order to initialize the driver properly:
@@ -82,6 +120,15 @@ static void qrtrqmi_debug(const char *str, void *user_data)
  *
  * Bus
  *   The bus of the modem.  Values can be "embedded", or "pci"
+ *
+ * PremuxInterface{0..N}MuxId
+ *   The mux identifier of the pre-multiplexed interface (e.g. 1 for rmnet0)
+ *
+ * PremuxInterface{0..N}
+ *   The netdev name of the pre-multiplexed interface (e.g. rmnet0)
+ *
+ * NumPremuxInterfaces
+ *   The number of pre-multiplexed interfaces
  */
 static int qrtrqmi_probe(struct ofono_modem *modem)
 {
@@ -104,6 +151,9 @@ static int qrtrqmi_probe(struct ofono_modem *modem)
 	if (!if_driver || !ifname || !ifindex || !bus)
 		return -EPROTO;
 
+	if (!L_IN_STRSET(bus, "pcie", "embedded"))
+		return -ENOTSUP;
+
 	data = l_new(struct qrtrqmi_data, 1);
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
@@ -113,6 +163,22 @@ static int qrtrqmi_probe(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
+	data->n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
+	if (data->n_premux) {
+		int err;
+
+		if (data->n_premux > MAX_CONTEXTS)
+			data->n_premux = MAX_CONTEXTS;
+
+		err = setup_soc_premux_interfaces(modem);
+		if (err) {
+			l_free(data);
+			return err;
+		}
+
+		data->soc_premux = true;
+	}
+
 	return 0;
 }
 
@@ -120,6 +186,8 @@ static void qrtrqmi_deinit(struct qrtrqmi_data *data)
 {
 	qmi_service_free(data->dms);
 	data->dms = NULL;
+	qmi_service_free(data->wda);
+	data->wda = NULL;
 	qmi_qrtr_node_free(data->node);
 	data->node = NULL;
 }
@@ -132,13 +200,109 @@ static void qrtrqmi_remove(struct ofono_modem *modem)
 
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
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
@@ -148,6 +312,11 @@ static void power_reset_cb(struct qmi_result *result, void *user_data)
 		return;
 	}
 
+	if (!data->soc_premux) {
+		setup_data_format(modem);
+		return;
+	}
+
 	ofono_modem_set_powered(modem, TRUE);
 }
 
@@ -177,7 +346,11 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
 
 		break;
 	default:
-		ofono_modem_set_powered(modem, TRUE);
+		if (!data->soc_premux)
+			setup_data_format(modem);
+		else
+			ofono_modem_set_powered(modem, TRUE);
+
 		return;
 	}
 
@@ -199,6 +372,10 @@ static void lookup_done(void *user_data)
 			!qmi_qrtr_node_has_service(node, QMI_SERVICE_NAS))
 		goto error;
 
+	if (!data->soc_premux &&
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_WDA))
+		goto error;
+
 	data->dms = qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS);
 	if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
 					get_oper_mode_cb, modem, NULL) > 0)
@@ -236,10 +413,18 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 static void power_disable_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	qrtrqmi_deinit(ofono_modem_get_data(modem));
+	if (!data->soc_premux) {
+		rmnet_del_interfaces(data->n_premux, data->rmnet_interfaces);
+		data->n_premux = 0;
+		memset(data->rmnet_interfaces, 0,
+				sizeof(data->rmnet_interfaces));
+	}
+
+	qrtrqmi_deinit(data);
 	ofono_modem_set_powered(modem, FALSE);
 }
 
@@ -346,11 +531,8 @@ static void setup_gprs(struct ofono_modem *modem)
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
@@ -361,23 +543,10 @@ static void setup_gprs(struct ofono_modem *modem)
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


Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989B1DBB13
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203000; cv=none; b=jthNd0dhrgsk5ob2SXutMfzKxKqm461UMZWLY0fGnXkl+1EXHsqSGUcjIggH8avLSiOHJBKBa2Clt+recmqGal6Hz2H0K+mimyP1D6G9BDs70jPAITPIhNgNeLIgi8PifOsxNLEuaeM3EXT2DPn3FarXrTEijgaLmIauxJnntCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203000; c=relaxed/simple;
	bh=mPD0504gBx1l+cPecc6GnM39mSnPgmSFttPXqr1A7CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaxLUdFzgTAQVObHpmSFSWdO9mBNlDiK4TIQSxCpdVcQG8cOfaIPuoYhtB2VQzxdhlyINWACX9YRcREvo2oIwE7oclSGnZJzrI7qv1p5R4kgW0/1yopVZBsaTYSwbwiQtK4vZbXCEJ9n/BrPpLugPgx0OoX34aJv9Rq/EX8lhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c25+HXx6; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c25+HXx6"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-296b567bc30so354780fac.2
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202998; x=1732807798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L++HG8+vyI9/naIo65G0NsZ7CozBCIgZRKJU3NHzqK4=;
        b=c25+HXx6FiwVGOUpUf8Nemkyh74jUa2JSiyaVB2BcG9a4YeSXFJmjjCxffUoqf4Pqx
         YU/J1hgpe9g99Ye8mLkXmv0e4VxZWO2jXC8rylPynHrRoK/K5T2L7oT+ecqFGRV7/ec4
         9Z0V/0n8oIW/2o7Rc/sxJEnzfUwZ77l0XUmnLASSa6iUrx186iMTg63E4qon3zwGJa20
         vDDKv+ujxg14nka4nrcPy0k4TpEx9clMU8e2C2WsvUwPUTMz1ieDCd3hZ6NTr/53ZcvK
         VbFgKedE3YER0VKB+xtNyYbSHXIpxOhBaXpiXpJIUmb8L3GnB5Jz9YE42PkIT/Zuii75
         84vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202998; x=1732807798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L++HG8+vyI9/naIo65G0NsZ7CozBCIgZRKJU3NHzqK4=;
        b=QewL9e+mccB+QsYmVckeYlOB2YHjbacszRigR69hEms1E+3WlhgVMoBxHMoNDiwKWc
         PcyeRe/3AgIQcMlZFab/TPiAtioSxHwFutMs8ziguqH4e0GcX+ijYP4bRWrIW0pl7SkR
         wQbPzIF7STXBS4UFHlX0KeL46azB8RonQkBz/NPUi/Hi1ZG7qU74aVvkJ0MljsoNivxW
         lWExLYLAsoUlWxaRiDoXp/Ez3wJ1gS7Bos7wuasyXhVmHIRBNxDs1Vv3EUodPc2wDNP5
         qXlUGZpxun97rd+/lfy/o9gxnDDanG7LtjZStg/R7eFrNH6KkEaX3+zsiAmMzbwpDb3M
         XZHA==
X-Gm-Message-State: AOJu0YxZFPXiKJHr8TONVDqr1waC1OE3xa62FI0GUdBJaXz/aPAu6Ux1
	g+2PTAwHZUjdoxRLgXDekT15+Cs24Q+X9sJ0xQoxrwp6EdOaGxjwDZGUeA==
X-Gm-Gg: ASbGncv8Ttzj3Vdjsce0++jvgB7X/kTIfuc15NC3XlAo/Jpv6lS5LCLT6L/7T9TMRFi
	nuQiB3AVNZ+jQb86XoVzKUewDVPYUc3uCEAJQJGkgp4KFFk7VWzRPpmsFXbpcZM6oodk2r1p+pI
	zAJEKwiW1+Bx9JH1A5YIhfE9GMlI/rKWUZJ5zrTWWYbYenI1oab1VVYS6Er2ntkJiTqavZ4vbHx
	I4RAcbXT6cFVni5kaqQRJ8EaWaRD2NTIAcLLWETF+Bs2Z82xMoHUsKiPR+HBrqKA2FvLx0DnB0M
	QfKbgFeaVJaTqZZ5DIZZRcEU
X-Google-Smtp-Source: AGHT+IFpu4Hme5Wb6G5cC7+J4tdtd6SYpAeILqdDcgOmFSb7b2Eh47zFcKyJkM5gdveGCkJt6kopMw==
X-Received: by 2002:a05:6870:5b0b:b0:296:de5e:569b with SMTP id 586e51a60fabf-296de5e58demr5491765fac.18.1732202997962;
        Thu, 21 Nov 2024 07:29:57 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:57 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/10] gobi: Add support for multiple active contexts
Date: Thu, 21 Nov 2024 09:29:36 -0600
Message-ID: <20241121152949.56962-8-denkenz@gmail.com>
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

Add support for multiple contexts based on qmi_wwan 'passthrough' +
rmnet combination.  This is a newer and more flexible approach compared
to the legacy qmi_wwan 'add_mux' / 'del_mux' design.  Multiple contexts
are enabled as follows:
  - If the device supports passthrough, attempt to set the modem to use
    QMAPv5 for both downlink and uplink aggregation.
  - If successful, request rmnet module to create multiple rmnet
    network interfaces to use for each context / PDN that will be
    simultaneously active
  - Request WDS service handles for each rmnet device created

With the above setup, the main network interface MTU is changed to
16384, which is the maximum supported by the current qmi_wwan driver.
Note that modems might be capable of larger aggregation sizes,
particularly for the download direction.  However, such sizes will
exceed the maximum URB (corresponding to the MTU) which qmi_wwan
supports.
---
 plugins/gobi.c | 140 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 113 insertions(+), 27 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 111ddd3464fe..027aa91d6ade 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -47,6 +47,7 @@
 #include <drivers/qmimodem/wda.h>
 #include <drivers/qmimodem/util.h>
 #include <drivers/qmimodem/common.h>
+#include "src/rmnet.h"
 
 #define GOBI_DMS	(1 << 0)
 #define GOBI_NAS	(1 << 1)
@@ -59,12 +60,15 @@
 
 #define MAX_CONTEXTS 4
 #define DEFAULT_MTU 1400
+#define RMNET_MAX_MTU 16384
+#define DEFAULT_DL_DATAGRAMS 32
 
 #define QMI_WWAN_RAW_IP "/sys/class/net/%s/qmi/raw_ip"
 #define QMI_WWAN_PASS_THROUGH "/sys/class/net/%s/qmi/pass_through"
 
 enum wda_data_format {
 	WDA_DATA_FORMAT_UNKNOWN = 0,
+	WDA_DATA_FORMAT_RMNET_QMAP5,
 	WDA_DATA_FORMAT_RAW_IP,
 	WDA_DATA_FORMAT_802_3,	/* Last, most compatible legacy fallback */
 };
@@ -88,12 +92,14 @@ struct gobi_data {
 		struct qmi_service *wds_ipv4;
 		struct qmi_service *wds_ipv6;
 	} context_services[MAX_CONTEXTS];
+	struct rmnet_ifinfo rmnet_interfaces[MAX_CONTEXTS];
+	uint8_t n_premux;
+	int rmnet_id;
 	struct service_request service_requests[8 + MAX_CONTEXTS * 2];
 	int cur_service_request;
 	int num_service_requests;
 	unsigned long features;
 	unsigned int discover_attempts;
-	uint8_t n_premux;
 	uint8_t oper_mode;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
@@ -102,7 +108,6 @@ struct gobi_data {
 	uint32_t set_powered_id;
 	uint32_t set_mtu_id;
 	enum wda_data_format data_format;
-	bool using_mux : 1;
 	bool no_pass_through : 1;
 };
 
@@ -137,6 +142,19 @@ static bool wda_get_data_format(struct gobi_data *data,
 	/* For everything except 802.3, use RAW_IP */
 	out_format->ll_protocol = QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP;
 
+	if (data->data_format == WDA_DATA_FORMAT_RAW_IP)
+		goto done;
+
+	out_format->dl_max_datagrams = DEFAULT_DL_DATAGRAMS;
+	out_format->dl_max_size = data->max_aggregation_size;
+
+	if (data->data_format == WDA_DATA_FORMAT_RMNET_QMAP5) {
+		out_format->ul_aggregation_protocol =
+					QMI_WDA_AGGREGATION_PROTOCOL_QMAPV5;
+		out_format->dl_aggregation_protocol =
+					QMI_WDA_AGGREGATION_PROTOCOL_QMAPV5;
+	}
+done:
 	return true;
 }
 
@@ -149,6 +167,9 @@ static int wda_data_format_to_mtu(enum wda_data_format format, uint32_t *out_mtu
 	case WDA_DATA_FORMAT_RAW_IP:
 		mtu = DEFAULT_MTU;
 		break;
+	case WDA_DATA_FORMAT_RMNET_QMAP5:
+		mtu = RMNET_MAX_MTU;
+		break;
 	default:
 		return -ENOTSUP;
 	}
@@ -238,6 +259,8 @@ static int gobi_probe(struct ofono_modem *modem)
 	l_strlcpy(data->main_net_name, ifname, sizeof(data->main_net_name));
 	data->interface_number = interface_number;
 	data->no_pass_through = no_pass_through;
+	/* See drivers/net/ethernet/qualcomm/rmnet/rmnet_private.h */
+	data->max_aggregation_size = 16384;
 
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
@@ -299,6 +322,11 @@ static void gobi_remove(struct ofono_modem *modem)
 		data->set_mtu_id = 0;
 	}
 
+	if (data->rmnet_id) {
+		rmnet_cancel(data->rmnet_id);
+		data->rmnet_id = 0;
+	}
+
 	cleanup_services(data);
 
 	qmi_qmux_device_free(data->device);
@@ -354,6 +382,14 @@ static void shutdown_device(struct ofono_modem *modem)
 
 	cleanup_services(data);
 
+	if (!l_memeqzero(data->rmnet_interfaces,
+					sizeof(data->rmnet_interfaces))) {
+		rmnet_del_interfaces(data->n_premux, data->rmnet_interfaces);
+		data->n_premux = 0;
+		memset(data->rmnet_interfaces, 0,
+						sizeof(data->rmnet_interfaces));
+	}
+
 	if (qmi_qmux_device_shutdown(data->device, shutdown_cb, modem, NULL) < 0)
 		shutdown_cb(modem);
 }
@@ -491,6 +527,55 @@ error:
 	shutdown_device(modem);
 }
 
+static uint32_t start_service_requests(struct ofono_modem *modem)
+{
+	struct gobi_data *data = ofono_modem_get_data(modem);
+	unsigned int i;
+
+	DBG("");
+
+	for (i = 0; i < (data->n_premux ? data->n_premux : 1); i++) {
+		add_service_request(data, &data->context_services[i].wds_ipv4,
+					QMI_SERVICE_WDS);
+		add_service_request(data, &data->context_services[i].wds_ipv6,
+					QMI_SERVICE_WDS);
+	}
+
+	return qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
+				request_service_cb, modem, NULL);
+}
+
+static void rmnet_get_interfaces_cb(int error, unsigned int n_interfaces,
+					const struct rmnet_ifinfo *interfaces,
+					void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct gobi_data *data = ofono_modem_get_data(modem);
+	unsigned int i;
+
+	DBG("error: %d, n_interfaces: %u", error, n_interfaces);
+	data->rmnet_id = 0;
+
+	if (error)
+		goto error;
+
+	DBG("RMNet interfaces created:");
+
+	for (i = 0; i < n_interfaces; i++)
+		DBG("\t%s[%d], mux_id: %u",
+			interfaces[i].ifname, interfaces[i].ifindex,
+			interfaces[i].mux_id);
+
+	memcpy(data->rmnet_interfaces, interfaces,
+				sizeof(struct rmnet_ifinfo) * n_interfaces);
+	data->n_premux = n_interfaces;
+
+	if (start_service_requests(modem) > 0)
+		return;
+error:
+	shutdown_device(modem);
+}
+
 static void enable_set_mtu_cb(int error, uint16_t type,
 					const void *msg, uint32_t len,
 					void *user_data)
@@ -505,7 +590,7 @@ static void enable_set_mtu_cb(int error, uint16_t type,
 	if (error)
 		goto error;
 
-	if (data->data_format == WDA_DATA_FORMAT_RAW_IP) {
+	if (data->data_format != WDA_DATA_FORMAT_802_3) {
 		DBG("Setting QMI WWAN to raw_ip");
 
 		if (qmi_wwan_set_raw_ip(data->main_net_name, 'Y') < 0) {
@@ -514,10 +599,26 @@ static void enable_set_mtu_cb(int error, uint16_t type,
 		}
 	}
 
-	DBG("Requesting services");
+	if (L_IN_SET(data->data_format, WDA_DATA_FORMAT_RMNET_QMAP5)) {
+		DBG("Setting QMI WWAN to pass_through");
+
+		if (qmi_wwan_set_pass_through(data->main_net_name, 'Y') < 0) {
+			ofono_error("Unable to set pass_through");
+			goto error;
+		}
+
+		data->rmnet_id = rmnet_get_interfaces(data->main_net_ifindex,
+							MAX_CONTEXTS,
+							rmnet_get_interfaces_cb,
+							modem, NULL);
+		if (data->rmnet_id > 0)
+			return;
 
-	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
-				request_service_cb, modem, NULL) > 0)
+		ofono_error("Unable to request RMNet interfaces");
+		goto error;
+	}
+
+	if (start_service_requests(modem) > 0)
 		return;
 error:
 	shutdown_device(modem);
@@ -645,7 +746,6 @@ static void discover_cb(void *user_data)
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	uint16_t major;
 	uint16_t minor;
-	int i;
 
 	DBG("");
 
@@ -695,13 +795,6 @@ static void discover_cb(void *user_data)
 	if (data->features & GOBI_UIM)
 		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
 
-	for (i = 0; i < (data->n_premux ? data->n_premux : 1); i++) {
-		add_service_request(data, &data->context_services[i].wds_ipv4,
-							QMI_SERVICE_WDS);
-		add_service_request(data, &data->context_services[i].wds_ipv6,
-							QMI_SERVICE_WDS);
-	}
-
 	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_WDA,
 						create_wda_cb, modem, NULL))
 		return;
@@ -910,7 +1003,7 @@ static void gobi_set_online(struct ofono_modem *modem, ofono_bool_t online,
 	l_netlink_command_func_t powered_cb;
 
 	DBG("%p %s using_mux: %s", modem, online ? "online" : "offline",
-		data->using_mux ? "yes" : "no");
+		data->n_premux ? "yes" : "no");
 
 	cbd->user = data;
 
@@ -919,7 +1012,7 @@ static void gobi_set_online(struct ofono_modem *modem, ofono_bool_t online,
 	else
 		powered_cb = powered_down_cb;
 
-	if (!data->using_mux) {
+	if (!data->n_premux) {
 		powered_cb(0, 0, NULL, 0, cbd);
 		cb_data_unref(cbd);
 		return;
@@ -1000,14 +1093,10 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	for (i = 0; i < data->n_premux; i++) {
 		struct qmi_service *ipv4 = data->context_services[i].wds_ipv4;
 		struct qmi_service *ipv6 = data->context_services[i].wds_ipv6;
-		const char *interface;
-		char buf[256];
-		int mux_id;
-
-		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
-		mux_id = ofono_modem_get_integer(modem, buf);
+		struct rmnet_ifinfo *ifinfo = data->rmnet_interfaces + i;
 
-		gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id,
+		gc = ofono_gprs_context_create(modem, 0, "qmimodem",
+						ifinfo->mux_id,
 						qmi_service_clone(ipv4),
 						qmi_service_clone(ipv6));
 
@@ -1017,11 +1106,8 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 			continue;
 		}
 
-		sprintf(buf, "PremuxInterface%d", i + 1);
-		interface = ofono_modem_get_string(modem, buf);
-
 		ofono_gprs_add_context(gprs, gc);
-		ofono_gprs_context_set_interface(gc, interface);
+		ofono_gprs_context_set_interface(gc, ifinfo->ifname);
 	}
 }
 
-- 
2.47.0


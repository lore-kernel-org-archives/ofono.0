Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6EE27269
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032690; cv=none; b=jxdllxUrFdwOc7cuvBIQ7lOuFh9U7KSHF0YRUGfFx0GFZ7XYyrP0e9VUkfl7Tns2ht1m4QADojsDA8SWxYJloXo1SxgVFtWW65QgfHeqd9hnkqEVcyGl+xKJNdQxN4tZBW6iFZmSCIra6N+vkDryWxacpUb4yL9Xu1CdEGb+YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032690; c=relaxed/simple;
	bh=7qL3YG4Ft8H0L0xNHKQgX4b+4eax3GeSO7SDbfekV98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoiVT4mAbsru4vK+7zZlwisJkMm8q3Xn+oOR2Y7u9Md/1opQe/+h4T1dMtc39PvpfcM8fQDCXYhQGUQI12dF5YNXQVI6VrdEJVJ4HIn1wGtzzw0VS2dk6KuziVNfoTlC6nERIsqiubiI2yfDxO/xYQ27VkmkJ2AWklqkLgbUvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFg41q3G; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFg41q3G"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b203c9933dso1302904eaf.3
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032688; x=1715637488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YL6BWKmc3Ajq8Dxl4BibiTwvEytnLgPe7mWyZHjFhvU=;
        b=ZFg41q3GkGYEVL3YVpts1behRLexuDOCJiUxxJWoYbYzfNA516Rhnn8HopqeO2m17j
         tUx3ekLXlNDnFy0ldR7SW5p5/Oxm0PiCf4U3TAzwQLO1Gm9orRdZvQe64u8AYuUHmXRe
         vzs8oN1uJ4gEKlsTv4caoC8QAOOH2Y9RxIMiAcLpkPVLZbVmPC8rCxiMrZAuEc8+3O0X
         Zm1oxI5lpxz2cdN7HZOk2emi3zzjS2WCNiE7siUO8FLRh9nkJR6fupCVYVflnlXtqnym
         /zRrr1SJdNJFEhpe44fEgGZ51EVfyd0QA12XPPfxK4iteB0uYlkFW1shTL+Mt59x/Ab/
         XK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032688; x=1715637488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL6BWKmc3Ajq8Dxl4BibiTwvEytnLgPe7mWyZHjFhvU=;
        b=mbOcn+/vpwpbF4ANWogFtC+oBZz7pQFaDpb/2Zdjzu5iXazRVNVDE3D3I5NyyUnKLh
         qhCqAa2RjxqZHwGgtVZrFxr/D5IpTpdT7k36FRXpHxCVaVhbjP/k4rrAPrk1IRfTOMLN
         FZgwVR3DJpCfIO+HDIq4OphTRdcnR1YkQb0L1FFSm0C8pYuoWy1VCend+rq3XnK/iXTd
         vEcg7duL+yCqjrXR0X5sIhSs0e4bZyPzFq8zYzUi2mpcBO3Gyg2kzAZvcH9c07K+RMY5
         fXd/abgLRsNGeVgK63EQzUVsHESqtNchWgRofdmUCvUytpvKVIODptZxE5l8HMu3M+Y6
         X78g==
X-Gm-Message-State: AOJu0YwcY8ba++zg1z4YelMFwA3YKgyqKCcrQilkzQZjFiWgcgijWDRB
	d92Y+tFCN3hBvvtLLC379mH/Y6h3VGEIgJS/Y7BsLuf3BOsKhDLXx8lBCQ==
X-Google-Smtp-Source: AGHT+IHwaI5I7HgQC8WuKRRd+KY3/MeW7k0z1YnN1kX9f+gc9eqKSlna7E85WmdOJjRAx5+cVjD0JA==
X-Received: by 2002:a4a:aec2:0:b0:5a4:75f2:54d0 with SMTP id v2-20020a4aaec2000000b005a475f254d0mr12038111oon.9.1715032687632;
        Mon, 06 May 2024 14:58:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/8] qmi: netreg: Print network capability
Date: Mon,  6 May 2024 16:57:57 -0500
Message-ID: <20240506215804.57124-3-denkenz@gmail.com>
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

Since gprs driver no longer uses DATA_CAPABILITY_STATUS TLV to report
the bearer to the core, move the parsing of this element to
network-registration atom driver.  Introduce a new utility to convert
the DATA_CAPABILITY_STATUS TLV to a string list.  For now, simply print
the capability when this TLV is received.

While here, eliminate CDMA specific enumerations as they're now
obsolete.
---
 drivers/qmimodem/gprs.c                 | 25 ---------
 drivers/qmimodem/nas.c                  | 74 +++++++++++++++++++++++--
 drivers/qmimodem/nas.h                  | 37 ++++++-------
 drivers/qmimodem/network-registration.c | 15 +++++
 4 files changed, 99 insertions(+), 52 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index e406eba3b19a..3ee0ce36307c 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -68,28 +68,6 @@ static bool extract_ss_info(struct qmi_result *result, int *status, int *tech)
 	return true;
 }
 
-static bool extract_dc_info(struct qmi_result *result, int *bearer_tech)
-{
-	const struct qmi_nas_data_capability *dc;
-	uint16_t len;
-	int i;
-
-	DBG("");
-
-	dc = qmi_result_get(result, QMI_NAS_RESULT_DATA_CAPABILITY_STATUS, &len);
-	if (!dc)
-		return false;
-
-	*bearer_tech = -1;
-	for (i = 0; i < dc->cap_count; i++) {
-		DBG("radio tech in use %d", dc->cap[i]);
-
-		*bearer_tech = qmi_nas_cap_to_bearer_tech(dc->cap[i]);
-	}
-
-	return true;
-}
-
 static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_gprs *gprs = user_data;
@@ -144,15 +122,12 @@ static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 {
 	int status;
 	int tech;
-	int bearer_tech;
 
 	DBG("");
 
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 
-	extract_dc_info(result, &bearer_tech);
-
 	return status;
 }
 
diff --git a/drivers/qmimodem/nas.c b/drivers/qmimodem/nas.c
index 630f901d8eb6..6146958cb869 100644
--- a/drivers/qmimodem/nas.c
+++ b/drivers/qmimodem/nas.c
@@ -19,6 +19,8 @@
  *
  */
 
+#include <ell/ell.h>
+
 #include "nas.h"
 
 #include "src/common.h"
@@ -37,6 +39,70 @@ int qmi_nas_rat_to_tech(uint8_t rat)
 	return -1;
 }
 
+static const char *qmi_nas_data_capability_to_string(
+					enum qmi_nas_data_capability cap)
+{
+	switch(cap) {
+	case QMI_NAS_DATA_CAPABILITY_NONE:
+		return "none";
+	case QMI_NAS_DATA_CAPABILITY_GPRS:
+		return "gprs";
+	case QMI_NAS_DATA_CAPABILITY_EDGE:
+		return "edge";
+	case QMI_NAS_DATA_CAPABILITY_HSDPA:
+		return "hsdpa";
+	case QMI_NAS_DATA_CAPABILITY_HSUPA:
+		return "hsupa";
+	case QMI_NAS_DATA_CAPABILITY_WCDMA:
+		return "wcdma";
+	case QMI_NAS_DATA_CAPABILITY_GSM:
+		return "gsm";
+	case QMI_NAS_DATA_CAPABILITY_LTE:
+		return "lte";
+	case QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS:
+		return "hsdpa-plus";
+	case QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS:
+		return "dc-hsdpa-plus";
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+char **qmi_nas_data_capability_status_to_string_list(const void *tlv,
+								uint16_t len)
+{
+	uint8_t num;
+	uint8_t cap;
+	uint8_t i;
+	char **ret;
+
+	if (len < 1)
+		return NULL;
+
+	num = l_get_u8(tlv);
+	if (len != num + 1)
+		return NULL;
+
+	ret = l_new(char *, num + 1);
+	tlv += 1;
+
+	for (i = 0; i < num; i++) {
+		const char *v;
+
+		cap = l_get_u8(tlv + i);
+		v = qmi_nas_data_capability_to_string(cap);
+
+		if (v)
+			ret[i] = l_strdup(v);
+		else
+			ret[i] = l_strdup_printf("0x%02x", cap);
+	}
+
+	return ret;
+}
+
 int qmi_nas_cap_to_bearer_tech(int cap_tech)
 {
 
@@ -48,16 +114,12 @@ int qmi_nas_cap_to_bearer_tech(int cap_tech)
 		return PACKET_BEARER_GPRS;
 	case QMI_NAS_DATA_CAPABILITY_EDGE:
 		return PACKET_BEARER_EGPRS;
-	case QMI_NAS_DATA_CAPABILITY_EVDO_REV_0:
-	case QMI_NAS_DATA_CAPABILITY_EVDO_REV_A:
-	case QMI_NAS_DATA_CAPABILITY_EVDO_REV_B:
-		return PACKET_BEARER_UMTS;
 	case QMI_NAS_DATA_CAPABILITY_HSDPA:
 		return PACKET_BEARER_HSDPA;
 	case QMI_NAS_DATA_CAPABILITY_HSUPA:
 		return PACKET_BEARER_HSUPA;
-    case QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS:
-    case QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS:
+	case QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS:
+	case QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS:
 		/*
 		 * HSPAP is HSPA+; which ofono doesn't define;
 		 * so, if differentiating HSPA and HSPA+ is
diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index cb0a927bf049..937486282dbc 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -107,27 +107,6 @@ struct qmi_nas_serving_system {
 } __attribute__((__packed__));
 #define QMI_NAS_RESULT_ROAMING_STATUS		0x10	/* uint8 */
 
-#define QMI_NAS_RESULT_DATA_CAPABILITY_STATUS		0x11	/* uint8 */
-struct qmi_nas_data_capability {
-	uint8_t cap_count;
-	uint8_t cap[0];
-} __attribute__((__packed__));
-
-#define QMI_NAS_DATA_CAPABILITY_NONE          0x00
-#define QMI_NAS_DATA_CAPABILITY_GPRS          0x01
-#define QMI_NAS_DATA_CAPABILITY_EDGE          0x02
-#define QMI_NAS_DATA_CAPABILITY_HSDPA         0x03
-#define QMI_NAS_DATA_CAPABILITY_HSUPA         0x04
-#define QMI_NAS_DATA_CAPABILITY_WCDMA         0x05
-#define QMI_NAS_DATA_CAPABILITY_CDMA          0x06
-#define QMI_NAS_DATA_CAPABILITY_EVDO_REV_0    0x07
-#define QMI_NAS_DATA_CAPABILITY_EVDO_REV_A    0x08
-#define QMI_NAS_DATA_CAPABILITY_GSM           0x09
-#define QMI_NAS_DATA_CAPABILITY_EVDO_REV_B    0x0A
-#define QMI_NAS_DATA_CAPABILITY_LTE           0x0B
-#define QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS    0x0C
-#define QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS 0x0D
-
 #define QMI_NAS_RESULT_CURRENT_PLMN		0x12
 struct qmi_nas_current_plmn {
 	uint16_t mcc;
@@ -180,6 +159,19 @@ struct qmi_nas_home_network {
 
 #define QMI_NAS_RESULT_SYSTEM_SELECTION_PREF_MODE	0x11
 
+enum qmi_nas_data_capability {
+	QMI_NAS_DATA_CAPABILITY_NONE				= 0x00,
+	QMI_NAS_DATA_CAPABILITY_GPRS				= 0x01,
+	QMI_NAS_DATA_CAPABILITY_EDGE				= 0x02,
+	QMI_NAS_DATA_CAPABILITY_HSDPA				= 0x03,
+	QMI_NAS_DATA_CAPABILITY_HSUPA				= 0x04,
+	QMI_NAS_DATA_CAPABILITY_WCDMA				= 0x05,
+	QMI_NAS_DATA_CAPABILITY_GSM				= 0x09,
+	QMI_NAS_DATA_CAPABILITY_LTE				= 0x0B,
+	QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS			= 0x0C,
+	QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS			= 0x0D,
+};
+
 enum qmi_nas_command {
 	/* Reset NAS service state variables */
 	QMI_NAS_RESET				= 0x00,
@@ -231,4 +223,7 @@ enum qmi_nas_command {
 };
 
 int qmi_nas_rat_to_tech(uint8_t rat);
+
+char **qmi_nas_data_capability_status_to_string_list(const void *tlv,
+								uint16_t len);
 int qmi_nas_cap_to_bearer_tech(int cap_tech);
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index 2e2e4a10dbf8..9041199b0b53 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -94,11 +94,13 @@ static bool extract_ss_info(struct qmi_result *result, int *status,
 				enum roaming_status *roaming,
 				struct ofono_network_operator *operator)
 {
+	static const uint8_t RESULT_DATA_CAPABILITY_STATUS = 0x11;
 	const struct qmi_nas_serving_system *ss;
 	const struct qmi_nas_current_plmn *plmn;
 	uint8_t i, roaming_status;
 	uint16_t value16, len, opname_len;
 	uint32_t value32;
+	const void *dcs;
 
 	DBG("");
 
@@ -163,6 +165,19 @@ static bool extract_ss_info(struct qmi_result *result, int *status,
 		DBG("%s (%s:%s)", operator->name, operator->mcc, operator->mnc);
 	}
 
+	dcs = qmi_result_get(result, RESULT_DATA_CAPABILITY_STATUS, &len);
+	if (dcs) {
+		_auto_(l_strv_free) char **techs =
+			qmi_nas_data_capability_status_to_string_list(dcs, len);
+
+		if (techs) {
+			_auto_(l_free) char *joined =
+						l_strjoinv(techs, ',');
+
+			DBG("radio techs in use: %s", joined);
+		}
+	}
+
 	if (qmi_result_get_uint16(result, QMI_NAS_RESULT_LOCATION_AREA_CODE,
 								&value16))
 		*lac = value16;
-- 
2.45.0


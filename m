Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710815B15C
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027999; cv=none; b=dW8CNmp/5t99IqT2yjuqLlvRRLv97AOy9QPHQ3lqAaLQO+CigsyhWie06V0LSrlOiXfRPJuFU3+gt82IKT5yHtd8aB2i/Y/Zi+FaFucaPtsfBP9bt9vAw7dlEMnvVfuFhIUwpTcsluB0KTPPsyFYWxgfP6IjFOOTLfTaUNbdQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027999; c=relaxed/simple;
	bh=YbViJ6031WMF/7kqXJvjLfqYtlyo5M9IYSjfHEPbNWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuS+tzXlmcYKHrjH2I0pO1ktsM/017YcRkD0xUHLwU9UMQqnRQU3XtvBYj/4q+EUqEm7dVApz2EKNJ1pVJc3MBrXQO5kmPQopQOm19ifyfElgeDzsfQr7Bln1enWARvqtNCjkyHaQkRpZ42uRF5yOBYwMG2IFZqCWG7g7RnILqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjVGl2aD; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjVGl2aD"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23db0b5dd28so1675867fac.2
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027996; x=1715632796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41FMOYQ+VGM0yAl1WQBGlOIgPSpo/6L47RObb6IBoTY=;
        b=CjVGl2aDbxMymz1meJAFm8KHjKhxGVeJXXIc7hDDkoRkb8PBgrjBQgLdCl2l92WwlU
         4xQf9mucG8hyDsjIqUQxhb7UqJmAlonldx8k+MvUNvCKnIcCoP3z4EZ0/CPZaTFuHc+T
         HIr83evsHxQ8aU5xlVcTmYp7ZkhIRnpWp3S1fUPj8Hv1Ak9xxg0UntXNAtuEXJxsDUQg
         0ruABWaF/OKHK1EGEygXNboNJRyWVCkxFJu6mj/nWnxpG+bdAVPvJJJCz7i1A55xRLV2
         qhcVuquJCW0YmQt7BWmvE4gP9+9NWn7nPkD6umiFfDApfLdcfcMVcxwdUkioUTThmBau
         18kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027996; x=1715632796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41FMOYQ+VGM0yAl1WQBGlOIgPSpo/6L47RObb6IBoTY=;
        b=TMCsnzQZ1CVYJPj56CqTJ1pOg17dnJp8rHbMg1lDMNJV32l0C8yDnASYB7S9zNtJWV
         kn8PkLQybCl/OTTnlnHnzG1F0dBg3LIDdBeuk7JFLv6yXYdqOQx09SIK9RwhuUOqwUNB
         KckokSBwBhyd3RT1u+BT2Vz61C30/859e1oM3Y8JqDwuj+IxjN7uZz6cacpbndIWFbC5
         mvig+bjBQl34D+yzlWvJOns0nas1vziBmb+Pvlp7PQeMEF0lURAE4613OAX/Fm7kICXD
         R8mBiwQTXurWBGOZHDSDR4wSMdx94A7YtCq+bC74BeFhZc9ixPiTp/D8Z351KnkP5qJ8
         3k+A==
X-Gm-Message-State: AOJu0YzcProVEz0wOv65PcoEMeuu18p3BW+TqKgVmIa7dtk8BJLO+tF2
	ZXnXdbXfwLN//7MA2zrNKYbV2VR6cfiRuP2qlhepnKn9/0pNgzEA1smrPA==
X-Google-Smtp-Source: AGHT+IExR4ycTScczSB12O23nNE4w0XTGkiSIeXdt54myc4v82cT6Br2ke7LHfP6O/tqv/I86d8PiQ==
X-Received: by 2002:a05:6870:b692:b0:23f:dd5:f7a8 with SMTP id cy18-20020a056870b69200b0023f0dd5f7a8mr7870801oab.37.1715027996196;
        Mon, 06 May 2024 13:39:56 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:55 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/8] qmi: netreg: Print network capability
Date: Mon,  6 May 2024 15:39:25 -0500
Message-ID: <20240506203952.55806-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506203952.55806-1-denkenz@gmail.com>
References: <20240506203952.55806-1-denkenz@gmail.com>
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
 drivers/qmimodem/gprs.c                 | 26 ---------
 drivers/qmimodem/nas.c                  | 74 +++++++++++++++++++++++--
 drivers/qmimodem/nas.h                  | 37 ++++++-------
 drivers/qmimodem/network-registration.c | 15 +++++
 4 files changed, 99 insertions(+), 53 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 0cf3e95a56aa..3ee0ce36307c 100644
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
@@ -144,16 +122,12 @@ static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 {
 	int status;
 	int tech;
-	int bearer_tech;
 
 	DBG("");
 
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 
-	/* DC is optional so only notify on successful extraction */
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


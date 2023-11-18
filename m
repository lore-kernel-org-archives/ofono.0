Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F500F4F7
	for <ofono@lists.linux.dev>; Sat, 18 Nov 2023 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCWhk2IL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4079ed65471so3411515e9.1
        for <ofono@lists.linux.dev>; Sat, 18 Nov 2023 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700310633; x=1700915433; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUnuRE7EwCt9ijjblksn6ncorqttlORTv0mfKoZJiVE=;
        b=OCWhk2ILW/iqKOv6cM4Qj5K2nQuehHv1RjKqxFYZ0m0lLX6q/Xb5t47GaYrgiygici
         E9wq6Ageq2D9CL74sRnmbmyYonrjPvCszn3S2dmI4gJQFYWxJ58ug6/1eug5Vpa3/AwI
         nX9jh88RdDnkTYExKUUZbG+oASUUlgGF6IuGxfRfVfL357KrMziTdJuNzTg5Md5sBxWC
         yZkJ6nIW7Bte5M7unqGd5K+tkzHfFidBWIZ6FM0mMKfDJSH+U3CZoA1syhsJe3DzSDls
         wJx2FTkQBc+dEsOxhKxPOm5kUo93L6D6UDWZKZBlt5txz0lVk1mVLjbBxRQ0lEMIzioW
         ekCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700310633; x=1700915433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUnuRE7EwCt9ijjblksn6ncorqttlORTv0mfKoZJiVE=;
        b=QOrTCBoh1QkG6HFGVo8OAHR3ehWG1gPrkIRv5566Ea9yvwClFI4eKbvI7kyKg7rQJO
         rk2ZKtG3O7O0YVV9rtNMvjTdDqqDjxeQU3nce56vFOBUdzFiubo8mdGLoGzPXL0sVDWk
         55YH+iRFDRBtqZP1H50vZwmjaTbFZBtUVM2ytVDRppIwkZ/kxOIYbW4w64HKQOPRpOR7
         J+tzJN8DOPBTSorRIrwBGxiTi76OL244t5ScTghY5A9eblniqY9ly8FPskq478eUkyKK
         Obw5agygKUvPsUgbi7hT4PeMXWhi4qzTrma0uwW3x+P65wpEgeGqfq+PhHf9FhR8g3NB
         tP2A==
X-Gm-Message-State: AOJu0YwoL9CXIrFFLwnHR2duFS1ja7+luQwX0pqDdeieXfE9shh/Jv3y
	oZkuGzXxoIKfsncBh5i+Vf5RFOwHB4n8tlWb
X-Google-Smtp-Source: AGHT+IF4G8tycWs1M3iDwFNUK9DnBuM8kdCrUSTV32MiAhJWy6qjfPec1kcc83TD/vWNSU/+OwpDtg==
X-Received: by 2002:a05:600c:190c:b0:408:4160:150a with SMTP id j12-20020a05600c190c00b004084160150amr1655599wmq.33.1700310633160;
        Sat, 18 Nov 2023 04:30:33 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05600c520b00b004076f522058sm10647440wmb.0.2023.11.18.04.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 04:30:32 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] isimodem: parse extra details from REG_STATUS_IND
Date: Sat, 18 Nov 2023 14:29:27 +0200
Message-ID: <20231118122948.418378-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract additional operator information available in REG_STATUS_IND messages.
These include mnc, mnc, and different variations of operator name.

Additionally, in case NET_OPER_NAME_READ_RESP is an error result, which happens
with some operators, report the extracted information to core instead of
bailing out.
---
 drivers/isimodem/debug.c                |  1 +
 drivers/isimodem/network-registration.c | 73 ++++++++++++++++++++++++-
 drivers/isimodem/network.h              |  1 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 18055791..8edcd972 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -1190,6 +1190,7 @@ const char *net_subblock_name(enum net_subblock value)
 		_(NET_REGISTRATION_CONF1_INFO);
 		_(NET_ROAMING_CONF1_INFO);
 		_(NET_AVAIL_NETWORK_INFO_COMMON);
+		_(NET_REG_STATUS_IND_OPER_NAME);
 		_(NET_OPER_NAME_INFO);
 	}
 	return "NET_<UNKNOWN>";
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/network-registration.c
index 8f70b3ee..bdfb8fd0 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -80,6 +80,8 @@ struct netreg_data {
 	struct rat_info rat;
 	GIsiVersion version;
 	char nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
 };
 
 static inline guint8 *mccmnc_to_bcd(const char *mcc, const char *mnc,
@@ -193,6 +195,12 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
 	struct netreg_data *nd = ofono_netreg_get_data(netreg);
 	GIsiSubBlockIter iter;
 
+	uint8_t len = 0;
+	uint8_t type = 0;
+	char *abbrev = NULL;
+	char *an = NULL;
+	char *fn = NULL;
+
 	if (netreg == NULL || nd == NULL)
 		return;
 
@@ -209,16 +217,69 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
 
 			if (!parse_common_info(&iter, &nd->reg))
 				return;
+
+			/* Parse abbreviated operator name */
+			if (!g_isi_sb_iter_get_byte(&iter, &len, 7))
+				return;
+
+			len *= 2;
+
+			if (!g_isi_sb_iter_get_alpha_tag(&iter, &abbrev, len, 8))
+				return;
 			break;
 
 		case NET_GSM_REG_INFO:
 
 			if (!parse_gsm_info(&iter, &nd->gsm))
 				return;
+
+			/* Parse mcc and mnc */
+			if (!g_isi_sb_iter_get_oper_code(&iter, nd->mcc,
+								nd->mnc, 8))
+				return;
+			break;
+
+		case NET_REG_STATUS_IND_OPER_NAME:
+
+			if (!g_isi_sb_iter_get_byte(&iter, &type, 2))
+				return;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &len, 5))
+				return;
+
+			/* Name is UCS-2 encoded */
+			len *= 2;
+
+			switch (type) {
+			case 2:
+				/*
+				 * Alternate full name, which is similar to
+				 * long name, but may have less whitespace
+				 */
+				g_isi_sb_iter_get_alpha_tag(&iter, &an, len, 6);
+				break;
+			case 3:
+				/* Full name */
+				g_isi_sb_iter_get_alpha_tag(&iter, &fn, len, 6);
+				break;
+			}
 			break;
 		}
 	}
 
+	if (fn[0] != '\0')
+		strncpy(nd->nitz_name, fn, OFONO_MAX_OPERATOR_NAME_LENGTH);
+	else if (an[0] != '\0')
+		strncpy(nd->nitz_name, an, OFONO_MAX_OPERATOR_NAME_LENGTH);
+	else if (abbrev[0] != '\0')
+		strncpy(nd->nitz_name, abbrev, OFONO_MAX_OPERATOR_NAME_LENGTH);
+
+	nd->nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
+
+	g_free(an);
+	g_free(fn);
+	g_free(abbrev);
+
 	ofono_netreg_status_notify(netreg, isi_status_to_at_status(&nd->reg),
 					nd->gsm.lac, nd->gsm.ci,
 					isi_to_at_tech(&nd->rat, &nd->gsm));
@@ -458,6 +519,8 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd = data;
 	ofono_netreg_operator_cb_t cb = cbd->cb;
+	struct ofono_netreg *netreg = cbd->user;
+	struct netreg_data *nd = ofono_netreg_get_data(netreg);
 	struct ofono_network_operator op;
 
 	GIsiSubBlockIter iter;
@@ -468,7 +531,14 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
 
 	if (!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP) &&
 			!check_response_status(msg, NET_OPER_NAME_READ_RESP))
-		goto error;
+		if (nd->nitz_name[0] == '\0')
+			goto error;
+
+		strncpy(op.name, nd->nitz_name, OFONO_MAX_OPERATOR_NAME_LENGTH);
+		op.name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
+		strncpy(op.mcc, nd->mcc, OFONO_MAX_MCC_LENGTH);
+		strncpy(op.mnc, nd->mnc, OFONO_MAX_MNC_LENGTH);
+		goto success;
 
 	for (g_isi_sb_iter_init(&iter, msg, 6);
 			g_isi_sb_iter_is_valid(&iter);
@@ -500,6 +570,7 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
 		}
 	}
 
+success:
 	CALLBACK_WITH_SUCCESS(cb, &op, cbd->data);
 	return;
 
diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index 7449a1d0..3282b383 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -90,6 +90,7 @@ enum net_subblock {
 	NET_REGISTRATION_CONF1_INFO =			0x59,
 	NET_ROAMING_CONF1_INFO =			0x5A,
 	NET_AVAIL_NETWORK_INFO_COMMON =			0xE1,
+	NET_REG_STATUS_IND_OPER_NAME =                  0xE3,
 	NET_OPER_NAME_INFO =				0xE7,
 };
 
-- 
2.42.0


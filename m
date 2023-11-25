Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B722C1B3
	for <ofono@lists.linux.dev>; Sat, 25 Nov 2023 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkQRjaO6"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-32deb2809daso1956566f8f.3
        for <ofono@lists.linux.dev>; Sat, 25 Nov 2023 12:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700943337; x=1701548137; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3abUrWFVotPZYGXCJI1UdH6UpzTH08ck307uXH8vbQ=;
        b=hkQRjaO6QOcK3rsDVaGOOkkCccpVLuHARRfbx0HEGBTyZprS6iag5ndGyH6ijnAIfH
         o/I9Yn5iVdX7FDeCmWIhbsehwyV+PyOwi+WO8/EZeiY2ehkf/7ivILd6F0dg6WkkUTGf
         DqbREICRys0o3kYBCCye+OLZ+WI3IA2rmEPHGp6hpZK1KMDClhbkj4thZjcf8UPzlk7P
         aC0lefopBBPqzGo/ABv0iJFHGtv+iJQtMniLapWEUrb/zTTcmn0Rh2ug6Hk3KIa2vNIq
         5ipxIFQQtnhHA5Dj5BT/w1/PfFtlprAsGuRnqH2oJrot6R9kVyJUANMSCxsBy/45VPag
         Jh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700943337; x=1701548137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3abUrWFVotPZYGXCJI1UdH6UpzTH08ck307uXH8vbQ=;
        b=oXOxeP95qmRhW94TxFmjS6ijgtwfkADapjUzdVEYCPygbrIXSKErIDxFalLm0M3XiN
         YIfdeRJcpaRPQQhZdUOV17oP/cTDCH9xsHIolMKvlyv9iFddUyomC15So96dFH+oc2MX
         AIP7yFI8E0eiW5rttlVi1ij47bV0cwhh5t+UOIqeKvKX4t9xEq1V3ap1Y20EWTQhL5xk
         8Ife+5GYFxQlB6EOSFA6QHLbVaQLFskCm54y7PGhvj9qJ6TbwV3kRfnJ8T3wphGqur8b
         y8zelYTtROuI3p1I7wd5EUKQ0rW+WaHoKarmffSokTwCXmTwtTxcoC2LMCvRqG0wQoel
         E96Q==
X-Gm-Message-State: AOJu0YywVZfb6utk89bSNOSKl+tBOavvIBSWXbYazZoVY02VKhCKXJGw
	c6SXfJGEhyCJNrsBzqis7ktcSOoUnwyICw==
X-Google-Smtp-Source: AGHT+IGFXnG3OAxRQLK6nzmfVzfLTDyFHMOYq58o2AFJWg3MOUKVb8AD+7JOOqQBDRw8LR90F25w/A==
X-Received: by 2002:adf:e911:0:b0:32d:8bf9:1990 with SMTP id f17-20020adfe911000000b0032d8bf91990mr5938587wrm.37.1700943336712;
        Sat, 25 Nov 2023 12:15:36 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040b3e7569fcsm3245221wmq.11.2023.11.25.12.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 12:15:36 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2] isimodem: parse extra details from REG_STATUS_IND
Date: Sat, 25 Nov 2023 21:50:46 +0200
Message-ID: <20231125201451.224574-1-absicsz@gmail.com>
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
with some operators, report the extracted information to core instead.
---
Changes in v2:
 - use l_strlcpy in place of strncpy
 - replace early `return` statements with `break` in reg_status_ind_cb
 - check abbrev, fn, and an for NULL
 - add alt_method label for alternative operator name method in order to
     resolve compilation issue involving nested ifs
---
 drivers/isimodem/debug.c                |  1 +
 drivers/isimodem/network-registration.c | 78 ++++++++++++++++++++++++-
 drivers/isimodem/network.h              |  1 +
 3 files changed, 77 insertions(+), 3 deletions(-)

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
index 8f70b3ee..1baa4d33 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -28,6 +28,7 @@
 #include <string.h>
 #include <errno.h>
 
+#include <ell/ell.h>
 #include <glib.h>
 
 #include <gisi/message.h>
@@ -80,6 +81,8 @@ struct netreg_data {
 	struct rat_info rat;
 	GIsiVersion version;
 	char nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
 };
 
 static inline guint8 *mccmnc_to_bcd(const char *mcc, const char *mnc,
@@ -193,6 +196,12 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
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
 
@@ -208,17 +217,67 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
 		case NET_REG_INFO_COMMON:
 
 			if (!parse_common_info(&iter, &nd->reg))
-				return;
+				break;
+
+			/* Parse abbreviated operator name */
+			if (!g_isi_sb_iter_get_byte(&iter, &len, 7))
+				break;
+
+			len *= 2;
+
+			g_isi_sb_iter_get_alpha_tag(&iter, &abbrev, len, 8);
 			break;
 
 		case NET_GSM_REG_INFO:
 
 			if (!parse_gsm_info(&iter, &nd->gsm))
-				return;
+				break;
+
+			/* Parse mcc and mnc */
+			g_isi_sb_iter_get_oper_code(&iter, nd->mcc,
+							   nd->mnc, 8);
+			break;
+
+		case NET_REG_STATUS_IND_OPER_NAME:
+
+			if (!g_isi_sb_iter_get_byte(&iter, &type, 2))
+				break;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &len, 5))
+				break;
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
+
 			break;
 		}
 	}
 
+	if (fn && fn[0] != '\0')
+		l_strlcpy(nd->nitz_name, fn, sizeof(nd->nitz_name));
+	else if (an && an[0] != '\0')
+		l_strlcpy(nd->nitz_name, an, sizeof(nd->nitz_name));
+	else if (abbrev && abbrev[0] != '\0')
+		l_strlcpy(nd->nitz_name, abbrev, sizeof(nd->nitz_name));
+
+	g_free(an);
+	g_free(fn);
+	g_free(abbrev);
+
 	ofono_netreg_status_notify(netreg, isi_status_to_at_status(&nd->reg),
 					nd->gsm.lac, nd->gsm.ci,
 					isi_to_at_tech(&nd->rat, &nd->gsm));
@@ -458,6 +517,8 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd = data;
 	ofono_netreg_operator_cb_t cb = cbd->cb;
+	struct ofono_netreg *netreg = cbd->user;
+	struct netreg_data *nd = ofono_netreg_get_data(netreg);
 	struct ofono_network_operator op;
 
 	GIsiSubBlockIter iter;
@@ -468,7 +529,7 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
 
 	if (!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP) &&
 			!check_response_status(msg, NET_OPER_NAME_READ_RESP))
-		goto error;
+		goto alt_method;
 
 	for (g_isi_sb_iter_init(&iter, msg, 6);
 			g_isi_sb_iter_is_valid(&iter);
@@ -500,9 +561,20 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
 		}
 	}
 
+success:
 	CALLBACK_WITH_SUCCESS(cb, &op, cbd->data);
 	return;
 
+alt_method:
+	if (nd->nitz_name[0] == '\0' || nd->mcc[0] == '\0' ||
+					nd->mnc[0] == '\0')
+		goto error;
+
+	l_strlcpy(op.name, nd->nitz_name, sizeof(op.name));
+	l_strlcpy(op.mcc, nd->mcc, sizeof(op.mcc));
+	l_strlcpy(op.mnc, nd->mnc, sizeof(op.mnc));
+	goto success;
+
 error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
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


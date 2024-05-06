Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292915B0FE
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032689; cv=none; b=GQT25tkR+fs5BFfQaEKhfeDCxE4YY/9db8Gv0bfZLKRhiuHVS5ccOYUgCRV5BRuQdQ7bLGapKhqAOlA0tlK5J/bT4Eg3vUhNelem+z3n5aj1Xisl5RjOJJ6azAcL0l3Rui3s4a98iQ29mD92b6UmEUcYP+znuF7BhPW1a3Y3nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032689; c=relaxed/simple;
	bh=TNp+sBADUHaZ5ZfGsbHdQkG2TO0iBao7JjqhYKXnzbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN5NHUqmsvNnzJZJZlZJgHJ57CpkGBWLdF7jPA7CcGv405GqABxpBxZEVUCB2MwFItd+G6oJqMlaoO/XUzMhDRc2yNgp7WvColHmDR6GS/uXJmMs89z8JYyiDFK5goK1Zs8ZsS9x/M5CLfsca+59TkGejSyFv4UqEdEH96ihr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6BiCPpK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6BiCPpK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b1ffd24c58so1315155eaf.2
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032687; x=1715637487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOgBfdbVhNBiD4mFtVHohxEIQ+nXvyisFWt91q/kgf4=;
        b=W6BiCPpKhO2Hv3jmNtk7JgHbmkBJXfvldvtTdI7vpl7eCle7S8X9iNnJo+u3e6Pmy5
         oxOe2Lhd3npTCXUgxNN43o6NFt3lIo5qGv8yZZiJimw3vu8BArqzow+/TTXivpeR+IAj
         eacT+UniR15cAXZEHrH++3YAScyfsN74utmdCgPcqZ1+J/hXgfTs4n1kjHL3hZqr7REq
         n8k+74yI31HbQMTQCBQQ6+4Cv8DEg4OkI/RWh1E0qtsrPmzcT9BLHPX3m3j4x3Anh5Dq
         VaByuPmnD03jtnyofNHzCgDuhulGTK9INREUUiVDzDtz6xvbRlbSpZcnZ780boDKZZOC
         HQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032687; x=1715637487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOgBfdbVhNBiD4mFtVHohxEIQ+nXvyisFWt91q/kgf4=;
        b=LtBjwbKavVSfd3yNusyQJGzN7jnMmpwMcBb3wd5VFiVF1ghuasKNOMWsjJ/g2a9XLE
         +946r4Uy7WVUpusI4L02apeNua0VPAUD01pg7RtqcKPgCJxl57pZZTwzgApFmx3hSU9J
         U7lrRLc+MoYorE9tPItonqWttf7K1VNHA2uw5o7viPY3TpEHreiKrrJoIydqw1h0af+Y
         xjFcHnPtGFbwNHJL01Fyu1l4XaJ9poILq1a5MUqxrmJeSHtHwYRHrWM6aoSIYHDJiTzs
         T6Kfkpp0VyIZGUG5DP+vhBzajxtB2wzeqAI34A0dZyCJysYwAB2+zqS0qejWQcWQ1BD+
         e5Mg==
X-Gm-Message-State: AOJu0Yy2iA2MQY7U1XzZWjLxL7h76MTv1X+kXYN6wN6VidwawoWTrhIt
	Dqod3vpv1uDeHoGw1GgqhB7/MWWHomUeIWXgIlTGaE2960cp1p7eAfgbrA==
X-Google-Smtp-Source: AGHT+IEywk9FLxlVy5h4HqNIiG28qCgvK6r2alJhbiMq5LcQMJVN9FYr71fheG2roXWzFIOqrr74Qg==
X-Received: by 2002:a4a:4bc6:0:b0:5aa:4d6d:2674 with SMTP id q189-20020a4a4bc6000000b005aa4d6d2674mr10871004ooa.2.1715032686689;
        Mon, 06 May 2024 14:58:06 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/8] qmi: gprs: use Extended Data Bearer Technology
Date: Mon,  6 May 2024 16:57:56 -0500
Message-ID: <20240506215804.57124-2-denkenz@gmail.com>
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

This TLV is reported by WDS "Event Report" indication and contains a
better representation of the current bearer compared to the Data Service
Capability TLV reported in the NAS Serving System indication.

 TLV:
   type       = "Extended Data Bearer Technology" (0x2a)
   length     = 16
   value      = 00:00:00:00:03:00:00:00:00:10:00:00:00:00:00:00
   translated = [ data_bearer_technology = '3gpp'
 		  radio_access_technology = '3gpp-lte'
		  extended_data_bearer_technology_3gpp = 'lte-fdd'
		  ...]

 TLV:
   type       = "Data Service Capability" (0x11)
   length     = 2
   value      = 01:0B
   translated = { [0] = 'lte '}

Some of the 5G and more esoteric technologies are not yet handled in
this commit.  Support for these technologies needs to be added in the
core first.

Modify the logic in the gprs driver to use this new mechanism.
---
 drivers/qmimodem/gprs.c | 20 ++++++++++++---
 drivers/qmimodem/wds.c  | 55 +++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/wds.h  | 39 +++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index ebb235545e21..e406eba3b19a 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -151,9 +151,7 @@ static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 
-	/* DC is optional so only notify on successful extraction */
-	if (extract_dc_info(result, &bearer_tech))
-		ofono_gprs_bearer_notify(gprs, bearer_tech);
+	extract_dc_info(result, &bearer_tech);
 
 	return status;
 }
@@ -174,6 +172,7 @@ static void ss_info_notify(struct qmi_result *result, void *user_data)
 static void event_report_notify(struct qmi_result *result, void *user_data)
 {
 	static const uint8_t RESULT_DATA_SYSTEM_STATUS = 0x24;
+	static const uint8_t RESULT_EXTENDED_DATA_BEARER_TECHNOLOGY = 0x2a;
 	struct ofono_gprs *gprs = user_data;
 	const void *tlv;
 	uint16_t len;
@@ -198,6 +197,21 @@ static void event_report_notify(struct qmi_result *result, void *user_data)
 		return;
 	}
 
+	tlv = qmi_result_get(result,
+				RESULT_EXTENDED_DATA_BEARER_TECHNOLOGY, &len);
+	if (tlv) {
+		int r = qmi_wds_parse_extended_data_bearer_technology(tlv, len);
+
+		if (r < 0) {
+			ofono_warn("extended_data_bearer_technology: %s(%d)",
+					strerror(-r), r);
+			return;
+		}
+
+		ofono_gprs_bearer_notify(gprs, r);
+		return;
+	}
+
 	qmi_result_print_tlvs(result);
 }
 
diff --git a/drivers/qmimodem/wds.c b/drivers/qmimodem/wds.c
index 77e22f443db0..ced0c5e5308d 100644
--- a/drivers/qmimodem/wds.c
+++ b/drivers/qmimodem/wds.c
@@ -75,3 +75,58 @@ int qmi_wds_parse_data_system_status(const void *dss, uint16_t len)
 
 	return -ENOENT;
 }
+
+int qmi_wds_parse_extended_data_bearer_technology(const void *edbt, uint16_t len)
+{
+	uint32_t technology;
+	uint32_t rat;
+	uint32_t so;
+	int bearer;
+
+	if (len != sizeof(uint32_t) * 2 + sizeof(uint64_t))
+		return -EBADMSG;
+
+	technology = l_get_le32(edbt);
+	rat = l_get_le32(edbt + sizeof(uint32_t));
+	so = l_get_le64(edbt + sizeof(uint32_t) * 2);
+
+	if (technology != QMI_WDS_PROFILE_TYPE_3GPP)
+		return -EINVAL;
+
+	switch (rat) {
+	case QMI_WDS_RAT_WCDMA:
+		bearer = PACKET_BEARER_UMTS;
+		break;
+	case QMI_WDS_RAT_LTE:
+		bearer = PACKET_BEARER_EPS;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (so & (QMI_WDS_SO_LTE_LIMITED | QMI_WDS_SO_LTE_FDD |
+			QMI_WDS_SO_LTE_TDD))
+		return PACKET_BEARER_EPS;
+
+	if (so & (QMI_WDS_SO_HSDPAPLUS | QMI_WDS_SO_DC_HSDPAPLUS |
+			QMI_WDS_SO_64_QAM | QMI_WDS_SO_HSPA))
+		return PACKET_BEARER_HSUPA_HSDPA;
+
+	if (so & (QMI_WDS_SO_HSUPA | QMI_WDS_SO_DC_HSUPA))
+		return PACKET_BEARER_HSUPA;
+
+	if (so & QMI_WDS_SO_HSDPA)
+		return PACKET_BEARER_HSDPA;
+
+	if (so & QMI_WDS_SO_WCDMA)
+		return PACKET_BEARER_UMTS;
+
+	if (so & QMI_WDS_SO_EDGE)
+		return PACKET_BEARER_EGPRS;
+
+	if (so & QMI_WDS_SO_GPRS)
+		return PACKET_BEARER_GPRS;
+
+	/* Fall back to rat */
+	return bearer;
+}
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 218587c3e437..026402e7a3f6 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -83,6 +83,43 @@ enum qmi_wds_rat_3gpp {
 	QMI_WDS_RAT_3GPP_NULL_BEARER		= 0x8000,
 };
 
+enum qmi_wds_rat {
+	QMI_WDS_RAT_WCDMA			= 0x01,
+	QMI_WDS_RAT_GERAN			= 0x02,
+	QMI_WDS_RAT_LTE				= 0x03,
+	QMI_WDS_RAT_TDSCDMA			= 0x04,
+	QMI_WDS_RAT_WLAN			= 0x05,
+};
+
+enum qmi_wds_service_option {
+	QMI_WDS_SO_WCDMA			= 0x01ULL,
+	QMI_WDS_SO_HSDPA			= 0x02ULL,
+	QMI_WDS_SO_HSUPA			= 0x04ULL,
+	QMI_WDS_SO_HSDPAPLUS			= 0x08ULL,
+	QMI_WDS_SO_DC_HSDPAPLUS			= 0x10ULL,
+	QMI_WDS_SO_64_QAM			= 0x20ULL,
+	QMI_WDS_SO_HSPA				= 0x40ULL,
+	QMI_WDS_SO_GPRS				= 0x80ULL,
+	QMI_WDS_SO_EDGE				= 0x100ULL,
+	QMI_WDS_SO_GSM				= 0x200ULL,
+	QMI_WDS_SO_S2B				= 0x400ULL,
+	QMI_WDS_SO_LTE_LIMITED			= 0x800ULL,
+	QMI_WDS_SO_LTE_FDD			= 0x1000ULL,
+	QMI_WDS_SO_LTE_TDD			= 0x2000ULL,
+	QMI_WDS_SO_TDSCDMA			= 0x4000ULL,
+	QMI_WDS_SO_DC_HSUPA			= 0x8000ULL,
+	QMI_WDS_SO_LTE_CA_DL			= 0x10000ULL,
+	QMI_WDS_SO_LTE_CA_UL			= 0x20000ULL,
+	QMI_WDS_SO_S2B_LIMITED			= 0x40000ULL,
+	QMI_WDS_SO_FOUR_POINT_FIVE_G		= 0x80000ULL,
+	QMI_WDS_SO_FOUR_POINT_FIVE_G_PLUS	= 0x100000ULL,
+	QMI_WDS_SO_5G_TDD			= 0x10000000000ULL,
+	QMI_WDS_SO_5G_SUB6			= 0x20000000000ULL,
+	QMI_WDS_SO_5G_MMWAVE			= 0x40000000000ULL,
+	QMI_WDS_SO_5G_NSA			= 0x80000000000ULL,
+	QMI_WDS_SO_5G_SA			= 0x100000000000ULL,
+};
+
 enum qmi_wds_command {
 	QMI_WDS_RESET					= 0x00,
 	QMI_WDS_EVENT_REPORT				= 0x01,
@@ -128,3 +165,5 @@ int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method);
 int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto);
 
 int qmi_wds_parse_data_system_status(const void *dss, uint16_t len);
+int qmi_wds_parse_extended_data_bearer_technology(const void *edbt,
+							uint16_t len);
-- 
2.45.0


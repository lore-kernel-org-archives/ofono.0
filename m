Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69991635B5
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596711; cv=none; b=ZEDe8hoIi48CIBC1AXPeA8U5+GJy5aw8V+56oFvnumK1yRD2H7tNA3QInkNtjSyka7ctWuVYmV/Sc7TxBprAc6iPLaR7c8IwM93eEc/er36wmYn07MFSifq+WYFWeD7CeqSG0sGN9t2ON1PbbmthdZ4uQiwU6lCb+AZGnHk97bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596711; c=relaxed/simple;
	bh=v5kf1cPWnpyOcgxDnM833nGyyDhhHKN/BQPUJCBt9r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jot4Foq6gldoOYeNLwBu7F0hxTw78Xd0VhHUXo9tq/CiAD1UEQPI88THimKOtKhM8sS75YSkgI7YUCA5Al77zOFMPirW63RBH2qt0sT62CeHB/P2QXdMtXXgur33OtnnneLlQNd7iY5wSNn9Oh8X8oR7OW5y/jMrfc7ULLeWgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpQRogNG; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpQRogNG"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23da78d835cso373625fac.1
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596709; x=1715201509; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czT/NyS0EkWiZkNj+C4NAl+OImgYqjSv7JQCs7lMJuA=;
        b=gpQRogNGfmKgAEOOgkpXjwar/EpXPhfskgtOWageINtCIOCMrm6qpqnUkY0PQh4pr5
         nP0BZFbwGCPn0c4SQ6cbQC7nb+01mTXfeddmu652M/YIP+GVF0ESa2aJZIUMWLcZqRDm
         axgywa2lPESiofxhUpf4bxOMe7IcykZZ6oFc0dDVnJiGzdVu0s5fBSfUMwcxtK+DfPFj
         gjWNmW+puldEXuDm2k++TtXLR4hlCHAt7sk1EB2UAuXyoU64RqXMOZGbnoHnUTnjezYx
         pzlW8Fzzp7vs6Be1GTpt1vkdvqeKoDXsw/v/4X0kprpEKdap4vr2q1YxbMMEQX3Kgb4m
         l+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596709; x=1715201509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czT/NyS0EkWiZkNj+C4NAl+OImgYqjSv7JQCs7lMJuA=;
        b=mlGVOs07G7WVH/bDg65eS8GPQ4v6eEpFUPrh8MQya34sWjF/YR5O2N7hqkIQSgJeV+
         EhO4GhwujPMhOvf3gKvioeDw3RYBA2n9YPaHMaFYhKzY0OtX7ECalIg6yOjK/O3EZNjT
         anwZdP7iM9GjlDXuFDhhVM7sGky8tF8596Yn9AVe4J7z3NOWZo3BGPrgX911y4HYwA/9
         76ZX69vrAfbHRArSyuIW5s4dOlj4khn6yLHCMfnWTn2CMLM3fX7GkMKTtYUN2d6/GeJN
         PpUn4fgKF0kVzlCu50wpmpIboGcFW0iDIW5s/K54nmYq/eg6mTFTfp/xwFT28WY0g7AI
         mwkg==
X-Gm-Message-State: AOJu0YzEtHh0wrM2kC11xGGMIs5HScMxgSyl+1dfajHIROp7GbDC6B4w
	RuB05vsRmkA7Un86R0RWwm7/zVC8V13yL6Gjt/m7WTP0HBnHOo0QeNNucA==
X-Google-Smtp-Source: AGHT+IFqk2KEAESZVBSpRW6vnOyi27gdGV/59qS1ceHApKzWDB/ogoy20wtKDso0f625vNyzxHgz6A==
X-Received: by 2002:a05:6870:701e:b0:235:489d:cea2 with SMTP id u30-20020a056870701e00b00235489dcea2mr4299573oae.7.1714596708837;
        Wed, 01 May 2024 13:51:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id or3-20020a0568715c0300b00234bc052521sm5883658oac.10.2024.05.01.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:51:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] qmi: gprs: Obtain LTE attach parameters after indication
Date: Wed,  1 May 2024 15:51:27 -0500
Message-ID: <20240501205142.12777-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501205142.12777-1-denkenz@gmail.com>
References: <20240501205142.12777-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems this TLV/Indication combination is needed in order for the
GET_LTE_ATTACH_PARAMETERS command to succeed:
ofonod[3257238]: Failed to query LTE attach params: 74
ofonod[3257238]: LTE bearer established but APN not set
---
 drivers/qmimodem/gprs.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 8329f56a2ba8..662fea41fc2f 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -151,19 +151,6 @@ static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 
-	if (status == NETWORK_REGISTRATION_STATUS_REGISTERED) {
-		if (tech == ACCESS_TECHNOLOGY_EUTRAN) {
-			/* On LTE we are effectively always attached; and
-			 * the default bearer is established as soon as the
-			 * network is joined.  We just need to query the
-			 * parameters in effect on the default bearer and
-			 * let the ofono core know about the activated
-			 * context.
-			 */
-			get_lte_attach_params(gprs);
-		}
-	}
-
 	/* DC is optional so only notify on successful extraction */
 	if (extract_dc_info(result, &bearer_tech))
 		ofono_gprs_bearer_notify(gprs, bearer_tech);
@@ -186,8 +173,31 @@ static void ss_info_notify(struct qmi_result *result, void *user_data)
 
 static void event_report_notify(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_DATA_SYSTEM_STATUS = 0x24;
+	struct ofono_gprs *gprs = user_data;
+	const void *tlv;
+	uint16_t len;
+
 	DBG("");
 
+	/*
+	 * On LTE we are effectively always attached; and the default bearer is
+	 * established as soon as the network is joined.  We just need to query
+	 * the parameters in effect on the default bearer and let the ofono core
+	 * know about the activated context.
+	 */
+	tlv = qmi_result_get(result, RESULT_DATA_SYSTEM_STATUS, &len);
+	if (tlv) {
+		int r = qmi_wds_parse_data_system_status(tlv, len);
+		static const uint32_t lte_5g = QMI_WDS_RAT_3GPP_LTE |
+						QMI_WDS_RAT_3GPP_5GNR;
+
+		if (r >= 0 && (r & lte_5g))
+			get_lte_attach_params(gprs);
+
+		return;
+	}
+
 	qmi_result_print_tlvs(result);
 }
 
-- 
2.44.0


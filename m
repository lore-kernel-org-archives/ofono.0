Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A67F9C1
	for <ofono@lists.linux.dev>; Mon,  4 Mar 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584511; cv=none; b=TFuiTiP/2VA8k9OXxJOcpkNVtBwLVwe1ONC2WDdqs0Cb+PIv6LxNjQpAUVzTALk0OiHKkO5tqoNMfxW6tC31lnZ01xTxN5ppSJjpmVAEoir8Dlhst9Ko+sRw2fdl0vLW8pemDXDJqW+A+xlfbTXSzrGUPO5xicCPT7KiRG8k2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584511; c=relaxed/simple;
	bh=aLOIAAUov0HjTzyPxMv/J90iAnqkwQU7iKnK7Mu575E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9jCLh9Uyvo0RiXQ6Tvs/vZUD9E7QqoQL7XxFg/H+tp+Z39A8DA48/V3rWxdLhi/UYoOfhoz4FsrNWOmJYlTP6HFju8AJmLnjTjX6++7gJpHClfNWDmIlLRn3HlIidLdJvlZSaAU8xEr/pdK62V2UJz4tMDuF5Z/wjvvraZ15Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNAPVA79; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNAPVA79"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1e950e312so516320b6e.0
        for <ofono@lists.linux.dev>; Mon, 04 Mar 2024 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584509; x=1710189309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0EnnSvQF8wg1lENuyQpwpAk4W0kICz7JDKKhwBMsOQ=;
        b=WNAPVA79Vj2iEJBeNU+jEfYtkdY29/oUJGrFSOkW+DVDJnlKr+rlbSVWiJ9kSlR0Gm
         pJNhuNcGXb3KBECD9lzCgmkZpPiv8I3geUTlKc3Gi64X8BjnLbBsAbifP/tl65QrUdUw
         dwnyNgT2hw9FTYlwrBejzAPjX8AD8Xk06vHO92mPXRJ4iklLOabkcnZwC789w6EVyIMn
         9gUzuTKasNYfbfAw7MPtSPcTyf+a0YAehYvdCEOE2hHYm9GEUWfRKsOdEdPCy4PjumbL
         /19CwRVpSxmAYeXt2ecTkWoKec3iy/rGxEVP4kCNNwxHGZFBieqVEmH1x706l5iUlwms
         i2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584509; x=1710189309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0EnnSvQF8wg1lENuyQpwpAk4W0kICz7JDKKhwBMsOQ=;
        b=Ovte4puMXF4d13SsBy087Vb4SzuRelvjpTRG1Es7XD5/a2GuQ9EBoPnC3GQiTu3PzJ
         mEeCeTYcOIjOiYYi57gJJKgFfQ1ofNN6zT3cO0CkPst6EeMMpMtQuT9Dcmp29AZMB5E7
         CcA10TXhLz6KX5w4ExGZnCo4AzO/SOR/WDoykb93j+YlvYZFGTvOg5QgM3jOMy0nnCQc
         7kvcD+bvldj+KK+gHRWfVf+ySsgRRwdNQmMd1WFqR0ThARA7PRfyFU/Q5kA5y0ns4vIR
         dSyGjc1jkd3Lo62WdORMxArQ0bM/nZ/0GQzdHNk/oAGVFw7LBLEq42CtIsPNk141aMc8
         wwhQ==
X-Gm-Message-State: AOJu0Yxdta10zvKhpE6KQeJLoUdcFUlYheJDPHkMg8nm+cLlMYDoUXM+
	DUykxbPjtvHSPB2eVftLsYHCVnAUA6k2v/yPvdUhkUEXZY23TIDHAM01Ru7n
X-Google-Smtp-Source: AGHT+IF4YoOwBwDGot73ZwyajqcrokQ0ds5SJgnPDR0E+M+VEN4hc2Vy7Ym/PSrInrp+B71V1Y+KeQ==
X-Received: by 2002:a05:6808:7ce:b0:3c1:33fe:5411 with SMTP id f14-20020a05680807ce00b003c133fe5411mr215745oij.21.1709584508954;
        Mon, 04 Mar 2024 12:35:08 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2101000000b003c0408e5b06sm1642582oiz.55.2024.03.04.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:35:08 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/5] qmimodem: Use ell endianness converter helpers
Date: Mon,  4 Mar 2024 14:34:50 -0600
Message-ID: <20240304203506.1725220-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304203506.1725220-1-denkenz@gmail.com>
References: <20240304203506.1725220-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/netmon.c               |  8 ++++----
 drivers/qmimodem/network-registration.c | 12 ++++++------
 drivers/qmimodem/sim.c                  |  4 ++--
 drivers/qmimodem/sms.c                  | 24 ++++++++++++------------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index f9f85eeeae0e..1190a37d66a7 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -90,7 +90,7 @@ static void get_rssi_cb(struct qmi_result *result, void *user_data)
 	/* RSSI */
 	rssi = qmi_result_get(result, 0x11, &len);
 	if (rssi) {
-		num = GUINT16_FROM_LE(rssi->count);
+		num = L_LE16_TO_CPU(rssi->count);
 		for (i = 0; i < num; i++) {
 			DBG("RSSI: %hhu on RAT %hhd",
 				rssi->info[i].rssi,
@@ -127,14 +127,14 @@ static void get_rssi_cb(struct qmi_result *result, void *user_data)
 	/* Bit error rate */
 	ber = qmi_result_get(result, 0x15, &len);
 	if (ber) {
-		num = GUINT16_FROM_LE(ber->count);
+		num = L_LE16_TO_CPU(ber->count);
 		for (i = 0; i < ber->count; i++) {
 			DBG("Bit error rate: %hu on RAT %hhd",
-				GUINT16_FROM_LE(ber->info[i].rate),
+				L_LE16_TO_CPU(ber->info[i].rate),
 				ber->info[i].rat);
 		}
 
-		props.ber = GUINT16_FROM_LE(ber->info[0].rate);
+		props.ber = L_LE16_TO_CPU(ber->info[0].rate);
 		if (props.ber > 7)
 			props.ber = -1;
 	} else {
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index 6bc8fbc5d226..a1c507eb371f 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -134,8 +134,8 @@ static bool extract_ss_info(struct qmi_result *result, int *status,
 
 	plmn = qmi_result_get(result, QMI_NAS_RESULT_CURRENT_PLMN, &len);
 	if (plmn) {
-		uint16_t mcc = GUINT16_FROM_LE(plmn->mcc);
-		uint16_t mnc = GUINT16_FROM_LE(plmn->mnc);
+		uint16_t mcc = L_LE16_TO_CPU(plmn->mcc);
+		uint16_t mnc = L_LE16_TO_CPU(plmn->mnc);
 
 		if (mcc > 999)
 			mcc = 999;
@@ -311,7 +311,7 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 
 	netlist = ptr;
 
-	num = GUINT16_FROM_LE(netlist->count);
+	num = L_LE16_TO_CPU(netlist->count);
 
 	DBG("found %d operators", num);
 
@@ -325,8 +325,8 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 
 	for (i = 0; i < num; i++) {
 		const struct qmi_nas_network_info *netinfo = ptr + offset;
-		uint16_t mcc = GUINT16_FROM_LE(netinfo->mcc);
-		uint16_t mnc = GUINT16_FROM_LE(netinfo->mnc);
+		uint16_t mcc = L_LE16_TO_CPU(netinfo->mcc);
+		uint16_t mnc = L_LE16_TO_CPU(netinfo->mnc);
 
 		if (mcc > 999)
 			mcc = 999;
@@ -361,7 +361,7 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 	if (!netrat)
 		goto done;
 
-	if (GUINT16_FROM_LE(netrat->count) != num)
+	if (L_LE16_TO_CPU(netrat->count) != num)
 		goto done;
 
 	for (i = 0; i < num; i++) {
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 0b73b3c7598b..07cbbaa47992 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -132,7 +132,7 @@ static void get_file_attributes_cb(struct qmi_result *result, void *user_data)
 	if (!attr)
 		goto error;
 
-	raw_len = GUINT16_FROM_LE(attr->raw_len);
+	raw_len = L_LE16_TO_CPU(attr->raw_len);
 
 	switch (data->app_type) {
 	case 0x01:	/* SIM card */
@@ -547,7 +547,7 @@ static enum get_card_status_result handle_get_card_status_data(
 			info2 = ptr + offset;
 			offset += sizeof(struct qmi_uim_app_info2);
 
-			index = GUINT16_FROM_LE(status->index_gw_pri);
+			index = L_LE16_TO_CPU(status->index_gw_pri);
 
 			if ((index & 0xff) == n && (index >> 8) == i) {
 				if (get_card_status(slot, info1, info2,
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 041344bb3044..f8ed96c435e0 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -197,7 +197,7 @@ static void qmi_submit(struct ofono_sms *sms,
 	message = alloca(3 + pdu_len);
 
 	message->msg_format = 0x06;
-	message->msg_length = GUINT16_TO_LE(pdu_len);
+	message->msg_length = L_CPU_TO_LE16(pdu_len);
 	memcpy(message->msg_data, pdu, pdu_len);
 
 	param = qmi_param_new();
@@ -357,7 +357,7 @@ static void delete_msg_cb(struct qmi_result *result, void *user_data)
 		 */
 		if (msg < data->msg_list->cnt)
 			raw_read(sms, data->msg_list->msg[msg].type,
-				GUINT32_FROM_LE(data->msg_list->msg[msg].ndx));
+				L_LE32_TO_CPU(data->msg_list->msg[msg].ndx));
 		else
 			get_msg_list(sms);
 	}
@@ -422,7 +422,7 @@ static void raw_read_cb(struct qmi_result *result, void *user_data)
 		uint16_t plen;
 		uint16_t tpdu_len;
 
-		plen = GUINT16_FROM_LE(msg->msg_length);
+		plen = L_LE16_TO_CPU(msg->msg_length);
 		tpdu_len = plen - msg->msg_data[0] - 1;
 
 		ofono_sms_deliver_notify(sms, msg->msg_data, plen, tpdu_len);
@@ -482,12 +482,12 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 		goto done;
 	}
 
-	cnt = GUINT32_FROM_LE(list->cnt);
+	cnt = L_LE32_TO_CPU(list->cnt);
 	DBG("msgs found %d", cnt);
 
 	for (tmp = 0; tmp < cnt; tmp++) {
 		DBG("unread type %d ndx %d", list->msg[tmp].type,
-			GUINT32_FROM_LE(list->msg[tmp].ndx));
+			L_LE32_TO_CPU(list->msg[tmp].ndx));
 	}
 
 	/* free list from last time */
@@ -509,7 +509,7 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 
 		data->rd_msg_num = 0;
 		raw_read(sms, data->msg_list->msg[0].type,
-				GUINT32_FROM_LE(data->msg_list->msg[0].ndx));
+				L_LE32_TO_CPU(data->msg_list->msg[0].ndx));
 		return;
 	}
 
@@ -612,12 +612,12 @@ static void event_notify(struct qmi_result *result, void *user_data)
 			DBG("msg mode not found, use mode %d", data->msg_mode);
 
 		DBG("msg type %d ndx %d mode %d", notify->storage_type,
-			GUINT32_FROM_LE(notify->storage_index), data->msg_mode);
+			L_LE32_TO_CPU(notify->storage_index), data->msg_mode);
 
 		/* don't read if list is being processed, get this msg later */
 		if (!data->msg_list_chk)
 			raw_read(sms, notify->storage_type,
-					GUINT32_FROM_LE(notify->storage_index));
+					L_LE32_TO_CPU(notify->storage_index));
 	} else {
 		/* route is either transfer only or transfer and ACK */
 		const struct qmi_wms_result_message *message;
@@ -626,11 +626,11 @@ static void event_notify(struct qmi_result *result, void *user_data)
 		if (message) {
 			uint16_t plen;
 
-			plen = GUINT16_FROM_LE(message->msg_length);
+			plen = L_LE16_TO_CPU(message->msg_length);
 
 			DBG("ack_required %d transaction id %u",
 				message->ack_required,
-				GUINT32_FROM_LE(message->transaction_id));
+				L_LE32_TO_CPU(message->transaction_id));
 			DBG("msg format %d PDU length %d",
 				message->msg_format, plen);
 
@@ -688,7 +688,7 @@ static void get_routes_cb(struct qmi_result *result, void *user_data)
         if (!list)
 		goto done;
 
-	num = GUINT16_FROM_LE(list->count);
+	num = L_LE16_TO_CPU(list->count);
 
 	DBG("found %d routes", num);
 
@@ -705,7 +705,7 @@ static void get_routes_cb(struct qmi_result *result, void *user_data)
 	len = 2 + (1 * 4);
 	new_list = alloca(len);
 
-	new_list->count = GUINT16_TO_LE(1);
+	new_list->count = L_CPU_TO_LE16(1);
 	new_list->route[0].msg_type = QMI_WMS_MSG_TYPE_P2P;
 	new_list->route[0].msg_class = QMI_WMS_MSG_CLASS_NONE;
 	new_list->route[0].storage_type = QMI_WMS_STORAGE_TYPE_NV;
-- 
2.43.0


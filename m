Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F91107A8
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866595; cv=none; b=gG8DhuaIQRT6e6W0+q35YGWhYAvvDeQvo8idvwVXPGdPio8g7ggqz4b43VevAUDoFW3hGSR3cAukD7q9YqnJwRioEshPlr5bRkIU4r9bReVd6sdq6ZYOR2QptwzH2f5S6yslF0sD1jXPcdcKlI22glACXotrLyYSWnwjv2NFiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866595; c=relaxed/simple;
	bh=yc15sj0nFclzzLsu8eLtNMTHipvMK6JbdYUz45o3+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llfewT10ik5cmDc9YBVUogOHbRqbVCElsgK7J+WUAQ8vnTeMNon7v+o+BSaVcoldh/xuXoQKyNPxcAaNeun6WhpfPAGpDWMV2GVt5KOZDqszQhf2HEPJ/VpuToXH+oeaghcqoPXVnpA+7UDVCA7U5Il8IDwGdo0tmms1hXaBnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSOMR5jo; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSOMR5jo"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0932aa9ecso2219498eaf.3
        for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866592; x=1711471392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IiFZpeUi4cNegRwxUgbdjXLX0QkxWFAfQSGfhMos0bo=;
        b=QSOMR5jo3+WUE9QRZOsg7f6J3LV3fBFNx3Ufi9V+TfTqNWO9/RWXyhGyZsJmfkmKeW
         OACW1RW7CIea4v5ws2dfm2R1GLQjhqSBUHqwqk3veGdl7HUclAmvGGO9mSPvqmVKNKg+
         HznzNbxLVrq+T+MgDlW6+YszOqealIH9PQRspL1TuBBdBhKimXxg0+4steLGebQj6bkj
         8e5Q8NZXrNv8Jl3yEZrn5Yqu7AoIak3JVEbbz0/KjCvstmiR2NlqoIpMkt/nxmd9vz5z
         ZyU4nVRrk5wkTsghjD+HEO3T31l0XOQBRwQRPuLU/bH3Kr5Y1Lopy0qIck2nkqx5IhAe
         XNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866592; x=1711471392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiFZpeUi4cNegRwxUgbdjXLX0QkxWFAfQSGfhMos0bo=;
        b=PvEM3eZVd7Qg9lhiINKnuuXPynXtW6HNgB5Bx5txkn5i/3xLpA+TDBJQe3YrITyBVT
         0nB2S99BdteOjysQnnwjnLNovrTNMUa+fHAuVM8V4S0VwUfkn6EDcJcR8uSDFhLxpjct
         ghkEPQI8xJLMO32lSo84B3iEddvAj3kU/Er1g7PO6Azmui7KIxQx2JFtptf7vM/iNtUF
         fgxTHI6ywxS95oYXhSmUpyPywbsS/7VGj98M5IjhMq164/0OBv9oKzkXY+0opzessEJe
         qMF4qjb9eXI/D7W61DPwhGalU0Bw4CcaQfvQHiPOjgYiJIK8L/4lH7WW/cg1eTZEfkp6
         zIew==
X-Gm-Message-State: AOJu0YzMtOgnvlU80N6B1H52N2/K39/uR4V9x1hjLxN7MOWL1u1jZbnt
	PEY9xmlfMbuV4oReEdKrLUEMeBLQLWhqwp5uUUcIAHszT0sqgy4y5nm/qvME
X-Google-Smtp-Source: AGHT+IF3y9TZtiAYKViO5bDlaul+PLQfYd6myqqDzu6TMfDOnbi3goA2RFiVnuMonqJJ6B6ZrBwt+Q==
X-Received: by 2002:a05:6820:1b8e:b0:5a1:8ca1:ae47 with SMTP id cb14-20020a0568201b8e00b005a18ca1ae47mr14954616oob.5.1710866592618;
        Tue, 19 Mar 2024 09:43:12 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cp1-20020a056820240100b005a4dc7abc01sm191642oob.11.2024.03.19.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:43:12 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] qmimodem: Rework GET_CARD_STATUS retry logic
Date: Tue, 19 Mar 2024 11:42:53 -0500
Message-ID: <20240319164309.2676887-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Port the retry logic from glib based implementation that uses
g_timeout_add to use l_timeout instead.  While here, fix the existing
logic to not leak memory when a retry is performed.  This happens in one
of two ways:

- When retry_cbd is allocated via cb_data_new, it is never freed when
  the timeout GSource fires.
- If the timeout GSource is removed early (i.e. due to remove() being
  called), the associated retry_cbd is not freed

Fix this by using cb_data_ref / cb_data_unref and utilize destroy
callbacks properly.
---
 drivers/qmimodem/sim.c | 86 +++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 8605e03c6f4f..e561e269f1f2 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -64,13 +64,10 @@ struct sim_data {
 	uint32_t event_mask;
 	uint8_t app_type;
 	uint32_t retry_count;
-	guint poll_source;
+	struct l_timeout *retry_timer;
 	uint16_t card_status_indication_id;
 };
 
-static void qmi_query_passwd_state(struct ofono_sim *sim,
-				ofono_sim_passwd_cb_t cb, void *user_data);
-
 static int create_fileid_data(uint8_t app_type, int fileid,
 					const unsigned char *path,
 					unsigned int path_len,
@@ -574,22 +571,28 @@ static enum get_card_status_result handle_get_card_status_result(
 	return handle_get_card_status_data(result, sim_stat);
 }
 
-static gboolean query_passwd_state_retry(gpointer userdata)
+static void query_passwd_state_cb(struct qmi_result *result, void *user_data);
+
+static void query_passwd_state_retry(struct l_timeout *timeout, void *user)
 {
-	struct cb_data *cbd = userdata;
+	struct cb_data *cbd = user;
 	ofono_sim_passwd_cb_t cb = cbd->cb;
 	struct ofono_sim *sim = cbd->user;
 	struct sim_data *data = ofono_sim_get_data(sim);
 
-	data->poll_source = 0;
+	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
+				query_passwd_state_cb, cbd, cb_data_unref) > 0) {
+		cb_data_ref(cbd);
+		return;
+	}
 
-	qmi_query_passwd_state(sim, cb, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 
-	return FALSE;
+	l_timeout_remove(data->retry_timer);
+	data->retry_timer = NULL;
 }
 
-static void query_passwd_state_cb(struct qmi_result *result,
-					void *user_data)
+static void query_passwd_state_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
 	ofono_sim_passwd_cb_t cb = cbd->cb;
@@ -597,49 +600,54 @@ static void query_passwd_state_cb(struct qmi_result *result,
 	struct sim_data *data = ofono_sim_get_data(sim);
 	struct sim_status sim_stat;
 	enum get_card_status_result res;
-	struct cb_data *retry_cbd;
 	unsigned int i;
 
 	for (i = 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
 		sim_stat.retries[i] = -1;
 
 	res = handle_get_card_status_result(result, &sim_stat);
+	if (res == GET_CARD_STATUS_RESULT_TEMP_ERROR &&
+			++data->retry_count <= MAX_RETRY_COUNT) {
+		DBG("Retry command");
+
+		if (!data->retry_timer) {
+			cb_data_ref(cbd);
+			data->retry_timer = l_timeout_create_ms(20,
+					query_passwd_state_retry,
+					cbd, cb_data_unref);
+		} else
+			l_timeout_modify_ms(data->retry_timer, 20);
+
+		return;
+	}
+
+	l_timeout_remove(data->retry_timer);
+	data->retry_timer = NULL;
+	data->retry_count = 0;
+
 	switch (res) {
 	case GET_CARD_STATUS_RESULT_OK:
 		DBG("passwd state %d", sim_stat.passwd_state);
-		data->retry_count = 0;
-		if (sim_stat.passwd_state == OFONO_SIM_PASSWORD_INVALID) {
-			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-			ofono_sim_inserted_notify(sim, false);
-		} else
+
+		if (sim_stat.passwd_state != OFONO_SIM_PASSWORD_INVALID) {
 			CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state,
 								cbd->data);
+			return;
+		}
+
 		break;
 	case GET_CARD_STATUS_RESULT_TEMP_ERROR:
-		data->retry_count++;
-		if (data->retry_count > MAX_RETRY_COUNT) {
-			DBG("Failed after %d attempts. Card state:%d",
-							data->retry_count,
-							sim_stat.card_state);
-			data->retry_count = 0;
-			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-			ofono_sim_inserted_notify(sim, false);
-		} else {
-			DBG("Retry command");
-			retry_cbd = cb_data_new(cb, cbd->data);
-			retry_cbd->user = sim;
-			data->poll_source = g_timeout_add(20,
-						query_passwd_state_retry,
-						retry_cbd);
-		}
+		DBG("Failed after %d attempts. Card state:%d",
+						data->retry_count,
+						sim_stat.card_state);
 		break;
 	case GET_CARD_STATUS_RESULT_ERROR:
 		DBG("Command failed");
-		data->retry_count = 0;
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		ofono_sim_inserted_notify(sim, false);
 		break;
 	}
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	ofono_sim_inserted_notify(sim, false);
 }
 
 static void qmi_query_passwd_state(struct ofono_sim *sim,
@@ -653,7 +661,7 @@ static void qmi_query_passwd_state(struct ofono_sim *sim,
 	cbd->user = sim;
 
 	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
-					query_passwd_state_cb, cbd, l_free) > 0)
+				query_passwd_state_cb, cbd, cb_data_unref) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
@@ -920,8 +928,8 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 
 	ofono_sim_set_data(sim, NULL);
 
-	if (data->poll_source > 0)
-		g_source_remove(data->poll_source);
+	l_timeout_remove(data->retry_timer);
+	data->retry_timer = NULL;
 
 	if (data->uim) {
 		if (data->card_status_indication_id) {
-- 
2.43.0


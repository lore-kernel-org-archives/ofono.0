Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027214036B
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646123; cv=none; b=ABGKKr0zOqZD4El9l4StQdRQvSvbIK4uZQgi+RMXntfvhFXf5M46UAPduMqq//san89lxV8mZH59GipWPWnu95f/KLt7iQJuDoTNwX0jsUe6SChUmlEXa76hLfCPwXK8f0kWYSdg657ZcUJIKCYCpzjWXoniLafra5AG+xY//X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646123; c=relaxed/simple;
	bh=rKzMM7maBnwAvWtxkOcZFSgbEbW8YkFqKOqoU+IzxcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pzpm9DZvlkm28WHoWvNumC3Ct4Wi5crkLjHYDcN7sJwSC7h7xAT0ZgsRgZMBF0jQtu9Ok2HjUl/e6xc5+6adIZFPCt/YF6nzdDZnpAE5fiS/rozi/alMy5qf0LbkBp6GnKKO32GBNQSVn/Zd30gjFSEFsSgX9EobPRQC+uF9XOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=LDpN2qcX; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Vqqyfvy/; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="LDpN2qcX";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Vqqyfvy/"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MM1wtt006985
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 15:55:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=RiJ6gfmlZJp8Xt6pGxeN2Lw5UTJG8k1h4/56jLvwu1k=; b=L
	DpN2qcXVjfUKPmIdyH/4b9akDesmD/q9px7W3rT/FRfay2MKRY6qnG/9bEb3OPe2
	HYTnc1L6ExXjE1tAk1QPTU1ZEMzKky2FRW66wjVzMeSJAiRzPIe+ctXvWXd4KmUC
	O+ykT+it2ke/2xyX4DsN7numVGZCdlCEBrd1bTBpBtY1DCt5/4cKXNYrT4vHt92N
	sabwu8g95CClxX8X6jA+wesgmJWtvDoWyfSBWqSiemP27h/g647nQTe/nOfD22sR
	hhCaUr0CAyil1AIJ9mKbskrj0BzniooR8Me7hpGeljBLysZSlrMAw39mmcbb/5Ah
	nBZecAcF350VkGdR8nYog==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3weeq284a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 15:55:13 -0800 (PST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f992cd47bso4672166d6.3
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708646112; x=1709250912; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RiJ6gfmlZJp8Xt6pGxeN2Lw5UTJG8k1h4/56jLvwu1k=;
        b=Vqqyfvy/TcoMAotV/etu2cSCLYRB+tXBP9DPzt8RkQ2IcavVGPz/0h2mF9Biopbxie
         NMPXx4FvcndDkcAnDZ7xuQcm5s1HKJi0l16pPBPgvKK41yAlidIW//8ia0CQ7STof4F7
         F297wH4Xw7n2Fqvu49NlxsyDnzXxNpeDSSKpyiKLARs68QmO1XAq3E25nRSB1FFlQGJZ
         GQKDyMDiSADkAfzAXM6K5TJBStRre3Ofgjw7iu+jesmPqb9LYgwCLbVpGirh6AxndyAI
         MWnlGYJF8eL8H09AunGbt5OsxUttZH/xvHR9XCcZkcR1kjss0rVjNVcvWRXc54n7ifsG
         UKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646112; x=1709250912;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiJ6gfmlZJp8Xt6pGxeN2Lw5UTJG8k1h4/56jLvwu1k=;
        b=tg3espfPxsu20zJy0XlDAI86VZB/NgXFDEhUWq53e5YHMUsRQ27g3BMLPjCdnkEG5h
         r9hRve4e8QVaaKRJ6wDzXUmFjsU/rmm4Xt4xlJ57CM4hvcrpHDl+0EJPX4ysz/8HNuQ5
         TNMHlPBTiFv/IdOsVOPR0MJRskIXZ9YwvwNvjr1045qMuIYR4HI6jlVOUbrbIa4ZzvDP
         YC4jSUydHpn9W1zipZpVOqWLUnUoxQjyMjkMjyTTa3PdHrEbvS8bhXlMSIH/PhAfyaOp
         c1yznUF6zs0bJbMEYj8rfVVVUjIab46I+g1t1S9kidOSl2oHVawMJnDDeVioJlPOghTI
         2xmg==
X-Gm-Message-State: AOJu0Yz+U9pFI7D6Auilr0RwY0mmZaJxxWY6h1bQGKHxfyKR4J5/Z+y/
	/DU8QjmdXLhdfxrtV0Wuc+jFI8for/u4gJIZNCAQZ5w8yWE5okOrn5cyb6uvH8bYGD3PUtApeSZ
	jcQJBqbkiNRxmS8p4V0N4oDMqTA1xh2/ojDhndNLocYzMZJP2/LftdA5dJKdAr9cFogNvDIBbK4
	kHNRrvBNJQD+dVMhOKklBJtsTsn1QwZrMV2BO92YY4AyA6RHM=
X-Received: by 2002:a0c:de03:0:b0:68f:8d9d:cca6 with SMTP id t3-20020a0cde03000000b0068f8d9dcca6mr648021qvk.63.1708646112567;
        Thu, 22 Feb 2024 15:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtj+6hAUi61X7oytNGyfxXHXw5TdDyYx5VdY9MU5CMKAPrpkg9TUwNa83EZX2qcvLFQ3pr9g==
X-Received: by 2002:a0c:de03:0:b0:68f:8d9d:cca6 with SMTP id t3-20020a0cde03000000b0068f8d9dcca6mr648004qvk.63.1708646112181;
        Thu, 22 Feb 2024 15:55:12 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id ny13-20020a056214398d00b006862b537412sm7473837qvb.123.2024.02.22.15.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:55:11 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/2] qmimodem: Use l_queue instead of GList for notifications
Date: Thu, 22 Feb 2024 23:53:55 +0000
Message-Id: <20240222235356.32485-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: E4tQXYVZyB8eIivxOVVXR3QOS62NjkI9
X-Proofpoint-GUID: E4tQXYVZyB8eIivxOVVXR3QOS62NjkI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220184

---
 drivers/qmimodem/qmi.c | 52 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 268db1f7..168dee1a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -112,7 +112,7 @@ struct qmi_service {
 	uint16_t minor;
 	uint8_t client_id;
 	uint16_t next_notify_id;
-	GList *notify_list;
+	struct l_queue *notify_list;
 };
 
 struct qmi_param {
@@ -256,7 +256,7 @@ static void __discovery_free(void *data)
 	destroy(d);
 }
 
-static void __notify_free(gpointer data, gpointer user_data)
+static void __notify_free(void *data)
 {
 	struct qmi_notify *notify = data;
 
@@ -266,12 +266,12 @@ static void __notify_free(gpointer data, gpointer user_data)
 	l_free(notify);
 }
 
-static gint __notify_compare(gconstpointer a, gconstpointer b)
+static bool __notify_compare(const void *data, const void *user_data)
 {
-	const struct qmi_notify *notify = a;
-	uint16_t id = L_PTR_TO_UINT(b);
+	const struct qmi_notify *notify = data;
+	uint16_t id = L_PTR_TO_UINT(user_data);
 
-	return notify->id - id;
+	return notify->id == id;
 }
 
 struct service_find_by_type_data {
@@ -717,23 +717,26 @@ static uint16_t __request_submit(struct qmi_device *device,
 	return req->tid;
 }
 
+static void service_notify_if_message_matches(void *data, void *user_data)
+{
+	struct qmi_notify *notify = data;
+	struct qmi_result *result = user_data;
+
+	if (notify->message == result->message)
+		notify->callback(result, notify->user_data);
+}
+
 static void service_notify(const void *key, void *value, void *user_data)
 {
 	struct qmi_service *service = value;
 	struct qmi_result *result = user_data;
-	GList *list;
 
 	/* ignore those that are in process of creation */
 	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
-	for (list = g_list_first(service->notify_list); list;
-						list = g_list_next(list)) {
-		struct qmi_notify *notify = list->data;
-
-		if (notify->message == result->message)
-			notify->callback(result, notify->user_data);
-	}
+	l_queue_foreach(service->notify_list, service_notify_if_message_matches,
+				result);
 }
 
 static void handle_indication(struct qmi_device *device,
@@ -1666,6 +1669,7 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	service->minor = data->minor;
 
 	service->client_id = client_id->client;
+	service->notify_list = l_queue_new();
 
 	__debug_device(device, "service created [client=%d,type=%d]",
 					service->client_id, service->type);
@@ -2452,7 +2456,7 @@ uint16_t qmi_service_register(struct qmi_service *service,
 	notify->user_data = user_data;
 	notify->destroy = destroy;
 
-	service->notify_list = g_list_append(service->notify_list, notify);
+	l_queue_push_tail(service->notify_list, notify);
 
 	return notify->id;
 }
@@ -2461,21 +2465,17 @@ bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 {
 	unsigned int nid = id;
 	struct qmi_notify *notify;
-	GList *list;
 
 	if (!service || !id)
 		return false;
 
-	list = g_list_find_custom(service->notify_list,
-				L_UINT_TO_PTR(nid), __notify_compare);
-	if (!list)
-		return false;
-
-	notify = list->data;
+	notify = l_queue_remove_if(service->notify_list, __notify_compare,
+					L_UINT_TO_PTR(nid));
 
-	service->notify_list = g_list_delete_link(service->notify_list, list);
+	if (!notify)
+		return false;
 
-	__notify_free(notify, NULL);
+	__notify_free(notify);
 
 	return true;
 }
@@ -2485,9 +2485,7 @@ bool qmi_service_unregister_all(struct qmi_service *service)
 	if (!service)
 		return false;
 
-	g_list_foreach(service->notify_list, __notify_free, NULL);
-	g_list_free(service->notify_list);
-
+	l_queue_destroy(service->notify_list, __notify_free);
 	service->notify_list = NULL;
 
 	return true;
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.

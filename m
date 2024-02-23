Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529A85921
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707253; cv=none; b=H86AgP2e0m7FzM8MJqzFuzqitIY0dHcsJhGK4GDzETfurFCHvq/FnWfjSOzETFiV4hBeBEjaomHuiHLaWMU54swr0/XvJmAMTxkfArJLviLPTnp5W5Us0t8tg09ZECDQZYyvTkgRfxuBQ5uTOkdsvyL/wsCstluAlmWndkkg4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707253; c=relaxed/simple;
	bh=pr9CCOTtbYmcrF+X7TIAlr/v+cjJuegpDn5fsBq3eNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KipzX4PZ6zPn1fwmGu0JPjQPqfa6iPzwgviXNF4zmwnuBsuI4C9ErSTzr0eYeZMUxMBIOrmDUOj1kuTi1H6D+pyiYvjhgb2DubnADp28wtKEr/zuIinAXrR7LMarqL/mYXaqn9u8Dps1dYpCJdqoFA9a6Jk3oSrJgFGPNVulyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=BUO5zD6W; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=ihtXl5Ml; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="BUO5zD6W";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="ihtXl5Ml"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NE16Ix023560
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 08:54:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=zPvitMFt9XyhS751Pr5SjayIxwAuQvEGu8owGeCFOhM=; b=B
	UO5zD6WlW4q13os76yUzf7LFaXt48PrTBgcLQDZlZgp95186IOI4MsWvmpLyoQRq
	LPB6DbT7HGrDV+bofArSWO1+fDPP15PhPyN+T2MhbypEkXMyEXxNty7+MdRnMk3C
	+TYRqMDGtiyxpd95ZcW9zJM0MgG0OnLkM6Wu+j8ZTwLwa3eauV8zBmeN/lpvAG0m
	BF9e6ynkHgwNoIlXOlnN5lNZCl7pcSLm2ldtcjhKmnXt2gTGm6twbYvtceHWohec
	WZ4yXw37QzjLk6FsbfdSfHBSaU+a3Y80u8N0iR6P1dDt6DOxoEy4BHlid5Yzgofj
	khTm7UeyTJyEYA7rWpRnQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565k3wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 08:54:10 -0800 (PST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68f75cca6aaso4895406d6.1
        for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708707249; x=1709312049; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPvitMFt9XyhS751Pr5SjayIxwAuQvEGu8owGeCFOhM=;
        b=ihtXl5MlQU6N5Xx+5SVkgCv1Q+i00BcZr+urtWnKfTcTIGZAaYQL0X1mkp4RqbGHFY
         2FuxvDrMLUlYk4+oqGVPZWej9UkHBsR4R4aMu9QHZOybLh0vuVBy2SIzK/63IGxuakb8
         pzrjvoW7xn5vAHUpxu5gX4M7lpRQiVvfMoVzud/HMnOlbz6e5Y9LRzeCY5xgbexzn+0+
         JvypiW/eVOCPRJ4+Yff+T8nS8VXBzI9N0qR8PKBWL2KLGPudZHI8+zQtDC3VC2vZPudR
         5OkQZl99DeQjdrDywyBpnSte8GsA+FeGEXIggfCH+upECTiqKUqit+mod6j9E02J6jtr
         jNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707249; x=1709312049;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPvitMFt9XyhS751Pr5SjayIxwAuQvEGu8owGeCFOhM=;
        b=JWFzu8dwiFLHQpdpMHle8nFe9S5VvPfz9FqJxwRGlzIUMKy0+ohAxgoeMTDX3FnPQY
         p3KC8CxAawQT5JY6ERWjVIkKxkBPv7Dj4WhYLoBS9zzxkz9ihgggXsLGfntjuU8FwAUz
         rsTazlA1ofx7+5WMoXrFK2Nyx1TbVxeXyBL3kz0Z90Fbjpx9t36xvNfBUKfVL0erW7UC
         NxzSLAFwW4ejJz9DBnecFZzI/CcL2+bDZd+5LiCuVKP8szl50DNXoOS2MoTZ/EHnzMH7
         AhcHsXrep0glvy7OPEnOBUfenyUfsYzMXCD2wLAGxp7MFFgFZ4zObV2lJaltnAdbozfa
         Nz6Q==
X-Gm-Message-State: AOJu0Ywj6rHAcTi5XfaGYtJkKrpHYTeoN9M0dXiu14hsOyZ56/8ILIQU
	/qY7andgdklmgXLyMlUbgLA2KYRvBNDXT5jGP25EzTaWm8JHOgt2CfGxux3PNSYWlHtlzZ+uX5e
	j5xYJriQBOJMFZF5v9OclhEFYGHb8OkbVD3t4P7NZry8yNfhdsH1Guan2bXMmCLzV2TbiPTOpsq
	NTr9IfRo9F2hzyZkCP9q6gLA+zbqHgjU8wq9qvgtaPKSLIiEk=
X-Received: by 2002:a05:6214:daa:b0:68f:359a:896e with SMTP id h10-20020a0562140daa00b0068f359a896emr443328qvh.12.1708707249169;
        Fri, 23 Feb 2024 08:54:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTNrBSdDis2gBw3LDTCBXQBmbRv6RiECLmzIUANVCkYBvQxx4cQyseE6exX2OdwWSf7ave9w==
X-Received: by 2002:a05:6214:daa:b0:68f:359a:896e with SMTP id h10-20020a0562140daa00b0068f359a896emr443309qvh.12.1708707248760;
        Fri, 23 Feb 2024 08:54:08 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id oj10-20020a056214440a00b0068fda0c74b6sm842926qvb.27.2024.02.23.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:54:08 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmimodem: Use l_queue instead of GList for pending service creation
Date: Fri, 23 Feb 2024 16:52:56 +0000
Message-Id: <20240223165256.9541-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: T5hc0DUxKK-AfeZoR9jWe-AFT322Fo9W
X-Proofpoint-ORIG-GUID: T5hc0DUxKK-AfeZoR9jWe-AFT322Fo9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=799 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230123

---
 drivers/qmimodem/qmi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 168dee1a..93e4991e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1386,20 +1386,19 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 						unsigned int type,
 						struct qmi_service *service)
 {
-	gpointer key = L_UINT_TO_PTR(type | 0x80000000);
-	GList **shared = l_hashmap_remove(device->service_list, key);
-	GList *l;
+	void *key = L_UINT_TO_PTR(type | 0x80000000);
+	struct l_queue *shared = l_hashmap_remove(device->service_list, key);
+	const struct l_queue_entry *entry;
 
-	for (l = *shared; l; l = l->next) {
-		struct service_create_shared_data *shared_data = l->data;
+	for (entry = l_queue_get_entries(shared); entry; entry = entry->next) {
+		struct service_create_shared_data *shared_data = entry->data;
 
 		shared_data->service = qmi_service_ref(service);
 		shared_data->idle = l_idle_create(service_create_shared_reply,
 							shared_data, NULL);
 	}
 
-	g_list_free(*shared);
-	l_free(shared);
+	l_queue_destroy(shared, NULL);
 }
 
 static void service_create_shared_data_free(gpointer user_data)
@@ -1699,14 +1698,14 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	struct qmi_request *req;
 	struct qmux_client_create_data *data;
-	GList **shared;
+	struct l_queue *shared;
 	unsigned int type_val = service_type;
 	int i;
 
 	if (!device->version_list)
 		return -ENOENT;
 
-	shared = l_new(GList *, 1);
+	shared = l_queue_new();
 	data = l_new(struct qmux_client_create_data, 1);
 
 	data->super.destroy = qmux_client_create_data_free;
@@ -2148,7 +2147,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
 {
-	GList **l = NULL;
+	struct l_queue *shared;
 	struct qmi_service *service = NULL;
 	unsigned int type_val = type;
 	int r;
@@ -2159,10 +2158,10 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
-	l = l_hashmap_lookup(device->service_list,
-				L_UINT_TO_PTR(type_val | 0x80000000));
+	shared = l_hashmap_lookup(device->service_list,
+					L_UINT_TO_PTR(type_val | 0x80000000));
 
-	if (!l) {
+	if (!shared) {
 		/*
 		 * There is no way to find in an l_hashmap using a custom
 		 * function. Instead we use a temporary struct to store the
@@ -2179,7 +2178,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	} else
 		type_val |= 0x80000000;
 
-	if (l || service) {
+	if (shared || service) {
 		struct service_create_shared_data *data;
 
 		data = l_new(struct service_create_shared_data, 1);
@@ -2195,7 +2194,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
 		} else
-			*l = g_list_prepend(*l, data);
+			l_queue_push_head(shared, data);
 
 		__qmi_device_discovery_started(device, &data->super);
 
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

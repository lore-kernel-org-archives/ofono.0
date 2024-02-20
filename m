Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752C76414
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472941; cv=none; b=LT8k8L6SVB9XoxyICuSGX6w95LPPieNw0zqwn6NjWwFhGPtvC7WzHA5uiAF/TdMdPdh2GXTaYIpcEvBmN5XpUayZxyIixrE3BLHhkLT2m9dT7zCkvrZ9ODjOMKzwPADe97QpKBPZkJsR0RFwMdKFWzRg7UY8+bciC3UsBaDpapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472941; c=relaxed/simple;
	bh=bVLMIYks2Iq7lgx5RnEUMqgnT9p67T3jutQkuawJXpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxRdIW8G6OYOXkUyuHy4j1gT56Ef8TYENsh14DVfgUkIZfdm7oZrnRI29yRJtGmMwY8QmHwZn1gwVQ1QAw3wZ4L/1NTwqV6WWnpodCD1LrS1pO+FRH4SnYSMfFALXT84HV6eiv8BWROyvw1MEm6aWOqspS/mmMESX6SATkhGe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=MJsiU7qf; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=XC03uud2; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="MJsiU7qf";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="XC03uud2"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KMq5l4013651
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=3Ql6Zk8hQLNbEi3k/t/276
	AGKtWK0ed5yf44KsJmbko=; b=MJsiU7qfa8M5dLgvTOpWpYJ16TDkIJwLBzeqw5
	Ttw4HzbIak+Caf78YfJ6lAnHNGV3/3CKIMPjXSwkNM1rGgZNO8Tf/daCDsjRSu93
	/ZLqcD5TOtnQp8TvGxw1iECBBmAoikdvSoblclvNmEWfhfaHGQqYt12URWeB1M4w
	LsIphvMKANlZTt6lEd5JV4zWrYPxwyinAdktgqfUMh3fjjQyKxb2vVfHySpC/cwS
	9UDMshVfuPuUbozAvX6/mY3RuIXuUX6mxj2DZqYHVe2kJ1XkeWY7iCaArDMjmBhU
	IRLwjGVsR3q8wSK02Y5WEr/6o/j30Wns4rilxf5gwIxztonw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd58hr196-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:55 -0800 (PST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68f95177e25so14935866d6.2
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708471614; x=1709076414; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ql6Zk8hQLNbEi3k/t/276AGKtWK0ed5yf44KsJmbko=;
        b=XC03uud2MlA0zOLs1xUtTL9ihHZaOQCpisudcUIPZ61MqDj/CA6DKYtehwYYvrlAxH
         Ky9AIG82Yazp+UdeV1q5Tajxo1mIzzioMLNck9J2fly7yJYHhLmETw+8YCG7A1sotdGF
         qTBOY2dq6rC9jZTfy5sMuxSA/ZABF3Z/RQT7+tUQf6jCc3bq1ovzcNAJPTNLjo5nRPxM
         I5KWTAliz2AVjZVNPkLLwa6TmDraUDd2RHQ7xrdTGilt7u5L6UavceoTlbqDyeBWSHYp
         J/n8Bm8B2wnRr30QFv0NUwj04/uNcHHWq2XJkqkYjbiHCUgvAS4vm+e6/KUblFuVb5fc
         /v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471614; x=1709076414;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ql6Zk8hQLNbEi3k/t/276AGKtWK0ed5yf44KsJmbko=;
        b=dHb5rnO/BP1G2cLCXRfS+QSrOse5oGjtu/EN7uma/oZAbwyUKUIpuBg5neUTSFmD2P
         GlUlDpT2juTDzd0cYhl+IMS/dPSeC3axG0eyYOcXiKuGQKoYjM3fRctBwo71n3OFn0N2
         U6cc7iyvlKp8siBaoVqGeggGLuk4Ns+uTNx/SHIllOKUR86k8ovYePFFXMd3GDyLSY3j
         cgeI6mSD1dVqMUoB6TQlmZxOYZCo8FQxjGPTylfq4uqCmfPRbrujFDHW+lrfMSNXlPEo
         Vr6vt/WCnvTZzEgZ2UwmwpT7Kcz6zsXT6Xw2zhU+TjjNFtpdAiqBW7/TOWK2h+xLXn2H
         XqQA==
X-Gm-Message-State: AOJu0YzYPzy8iaKLxqwtLX/IOTJ0bRcXuZ9kLNZekwI0naoc2+MDIfx0
	0dxjv5JVRvVeIg4tlVjyIRV8em//Yg596h/d/QBc/Kxt8ymnibqPappWI3f6Tl9TWrgeTX3g1kg
	+hl7wWpOkSLoKHi4wD5UNXvnD+//s8l5Xla5Vd7gtQ6IkTinUE4PgFdp2FOeq3Eu0BXX5OxJ1oX
	fLWLlCryzh8VtnxNtyUSmyLXhen+EZgv388BEig/Cux3h1bCI=
X-Received: by 2002:a05:6214:5090:b0:68f:8808:8d04 with SMTP id kk16-20020a056214509000b0068f88088d04mr5493852qvb.29.1708471614538;
        Tue, 20 Feb 2024 15:26:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKsoKqL8cqXeRAeyqQF3GLQIUsAl8pgO5Q/1WeZ0I5S319u7036TXr/5sdzN2kepSWjocTeQ==
X-Received: by 2002:a05:6214:5090:b0:68f:8808:8d04 with SMTP id kk16-20020a056214509000b0068f88088d04mr5493826qvb.29.1708471614060;
        Tue, 20 Feb 2024 15:26:54 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068f85706ecfsm1931983qvb.104.2024.02.20.15.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:26:53 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 4/4] qmimodem: Use l_hashmap instead of GHashTable
Date: Tue, 20 Feb 2024 23:25:29 +0000
Message-Id: <20240220232529.128477-4-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220232529.128477-1-steve.schrock@getcruise.com>
References: <20240220232529.128477-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: kARcviL4wfmLepIJyj4Q1q8PvWlYG313
X-Proofpoint-ORIG-GUID: kARcviL4wfmLepIJyj4Q1q8PvWlYG313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=945
 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402200168

---
 drivers/qmimodem/qmi.c | 90 ++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 95c9ef75..30c39603 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -75,7 +75,7 @@ struct qmi_device {
 	char *version_str;
 	struct qmi_version *version_list;
 	uint8_t version_count;
-	GHashTable *service_list;
+	struct l_hashmap *service_list;
 	unsigned int release_users;
 	qmi_shutdown_func_t shutdown_func;
 	void *shutdown_user_data;
@@ -255,20 +255,23 @@ static gint __notify_compare(gconstpointer a, gconstpointer b)
 	return notify->id - id;
 }
 
-static gboolean __service_compare_shared(gpointer key, gpointer value,
-							gpointer user_data)
+struct service_find_by_type_data {
+	unsigned int type;
+	struct qmi_service *found_service;
+};
+
+static void __service_find_by_type(const void *key, void *value,
+					void *user_data)
 {
 	struct qmi_service *service = value;
-	uint8_t type = GPOINTER_TO_UINT(user_data);
+	struct service_find_by_type_data *data = user_data;
 
 	/* ignore those that are in process of creation */
 	if (GPOINTER_TO_UINT(key) & 0x80000000)
-		return FALSE;
-
-	if (service->type == type)
-		return TRUE;
+		return;
 
-	return FALSE;
+	if (service->type == data->type)
+		data->found_service = service;
 }
 
 static const char *__service_type_to_string(uint8_t type)
@@ -695,7 +698,7 @@ static uint16_t __request_submit(struct qmi_device *device,
 	return req->tid;
 }
 
-static void service_notify(gpointer key, gpointer value, gpointer user_data)
+static void service_notify(const void *key, void *value, void *user_data)
 {
 	struct qmi_service *service = value;
 	struct qmi_result *result = user_data;
@@ -732,15 +735,16 @@ static void handle_indication(struct qmi_device *device,
 	result.length = length;
 
 	if (client_id == 0xff) {
-		g_hash_table_foreach(device->service_list,
-						service_notify, &result);
+		l_hashmap_foreach(device->service_list, service_notify,
+					&result);
 		return;
 	}
 
 	hash_id = service_type | (client_id << 8);
 
-	service = g_hash_table_lookup(device->service_list,
+	service = l_hashmap_lookup(device->service_list,
 					GUINT_TO_POINTER(hash_id));
+
 	if (!service)
 		return;
 
@@ -891,7 +895,7 @@ static void __qmi_device_discovery_complete(struct qmi_device *device,
 	__discovery_free(d);
 }
 
-static void service_destroy(gpointer data)
+static void service_destroy(void *data)
 {
 	struct qmi_service *service = data;
 
@@ -944,8 +948,7 @@ struct qmi_device *qmi_device_new(int fd)
 	device->service_queue = l_queue_new();
 	device->discovery_queue = l_queue_new();
 
-	device->service_list = g_hash_table_new_full(g_direct_hash,
-					g_direct_equal, NULL, service_destroy);
+	device->service_list = l_hashmap_new();
 
 	device->next_control_tid = 1;
 	device->next_service_tid = 256;
@@ -990,7 +993,7 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->shutdown_source)
 		g_source_remove(device->shutdown_source);
 
-	g_hash_table_destroy(device->service_list);
+	l_hashmap_destroy(device->service_list, service_destroy);
 
 	l_free(device->version_str);
 	l_free(device->version_list);
@@ -1930,11 +1933,9 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 						struct qmi_service *service)
 {
 	gpointer key = GUINT_TO_POINTER(type | 0x80000000);
-	GList **shared = g_hash_table_lookup(device->service_list, key);
+	GList **shared = l_hashmap_remove(device->service_list, key);
 	GList *l;
 
-	g_hash_table_steal(device->service_list, key);
-
 	for (l = *shared; l; l = l->next) {
 		struct service_create_shared_data *shared_data = l->data;
 
@@ -1977,6 +1978,7 @@ static void service_create_callback(uint16_t message, uint16_t length,
 	struct service_create_data *data = user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_service *service = NULL;
+	struct qmi_service *old_service = NULL;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
 	uint16_t len;
@@ -2015,8 +2017,11 @@ static void service_create_callback(uint16_t message, uint16_t length,
 
 	hash_id = service->type | (service->client_id << 8);
 
-	g_hash_table_replace(device->service_list,
-				GUINT_TO_POINTER(hash_id), service);
+	l_hashmap_replace(device->service_list, GUINT_TO_POINTER(hash_id),
+				service, (void **) &old_service);
+
+	if (old_service)
+		service_destroy(old_service);
 
 done:
 	service_create_shared_pending_reply(device, data->type, service);
@@ -2072,7 +2077,7 @@ static bool service_create(struct qmi_device *device,
 	__qmi_device_discovery_started(device, &data->super);
 
 	/* Mark service creation as pending */
-	g_hash_table_insert(device->service_list,
+	l_hashmap_insert(device->service_list,
 			GUINT_TO_POINTER(type_val | 0x80000000), shared);
 
 	return true;
@@ -2099,7 +2104,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
 {
-	gpointer service;
+	GList **l = NULL;
+	struct qmi_service *service = NULL;
 	unsigned int type_val = type;
 
 	if (!device || !func)
@@ -2108,15 +2114,27 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
-	service = g_hash_table_lookup(device->service_list,
+	l = l_hashmap_lookup(device->service_list,
 				GUINT_TO_POINTER(type_val | 0x80000000));
-	if (!service) {
-		service = g_hash_table_find(device->service_list,
-			__service_compare_shared, GUINT_TO_POINTER(type_val));
+
+	if (!l) {
+		/*
+		 * There is no way to find in an l_hashmap using a custom
+		 * function. Instead we use a temporary struct to store the
+		 * found service. This is not very clean, but we expect this
+		 * code to be refactored soon.
+		 */
+		struct service_find_by_type_data data;
+
+		data.type = type_val;
+		data.found_service = NULL;
+		l_hashmap_foreach(device->service_list,	__service_find_by_type,
+					&data);
+		service = data.found_service;
 	} else
 		type_val |= 0x80000000;
 
-	if (service) {
+	if (l || service) {
 		struct service_create_shared_data *data;
 
 		data = l_new(struct service_create_shared_data, 1);
@@ -2127,18 +2145,12 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data->user_data = user_data;
 		data->destroy = destroy;
 
-		if (!data)
-			return false;
-
 		if (!(type_val & 0x80000000)) {
 			data->service = qmi_service_ref(service);
 			data->timeout = g_timeout_add(
 					0, service_create_shared_reply, data);
-		} else {
-			GList **l = service;
-
+		} else
 			*l = g_list_prepend(*l, data);
-		}
 
 		__qmi_device_discovery_started(device, &data->super);
 
@@ -2197,8 +2209,8 @@ void qmi_service_unref(struct qmi_service *service)
 
 	hash_id = service->type | (service->client_id << 8);
 
-	g_hash_table_steal(service->device->service_list,
-					GUINT_TO_POINTER(hash_id));
+	l_hashmap_remove(service->device->service_list,
+				GUINT_TO_POINTER(hash_id));
 
 	service->device->release_users++;
 
@@ -2347,7 +2359,7 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 	return true;
 }
 
-static bool remove_req_if_match(void* data, void* user_data)
+static bool remove_req_if_match(void *data, void *user_data)
 {
 	struct qmi_request *req = data;
 	uint8_t client = GPOINTER_TO_UINT(user_data);
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

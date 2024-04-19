Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6713667D
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545181; cv=none; b=OWPxqpQk1IadzUliOeLWs6U0G98gnQz4KAQgRyo5abdfDNJrc3snfWzf3AjRnWd/kQMBmIHD9P0NdGXVmCzP8Cjom3AeYM2wTmSTy50O8fsNjXVLkum1hN72lkLFw8tK9PRUgHPKv6djzb3kleuHHLVrz4Lrp6wiSbjmxytyb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545181; c=relaxed/simple;
	bh=UF2m1UVNrt/5w7mm8CVS4FJS8nAFec28kBYJglsmZjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XneFcQ68Z+S9xC1+echVzuzmkKt18NfNbdtE1zXVGIZZHNHvgP6EAMW+hLSQ6B2FoUE4+Kbp+tO9SCg2+r0cIFzCF/msZIUAnSeyYrx5tW2SkCEnKj099XvzEXBxr/7ZtR07reb2z+hYE3T7O2ChizcVDXkujrIHckT/UH1oyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=SUGwBD7D; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=OtcNTSTv; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="SUGwBD7D";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="OtcNTSTv"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JDSFkf017160
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=MnGAY95XNUICm5Kn+ZTERd
	oeOlQFewaIMLYO1O0VljI=; b=SUGwBD7DrRwxBQjGKcdlRLP9pPdZOMd9ufv6e9
	8SIA1Ka35UJtWk3zt9d/lCU3RG1Mf0r0UpJOkyLxUm1xS2SIUMYSfCpThjLfSca3
	wi9QMIJr9aaGgBVTpfRn3waPNNf4kNh+hv/UzhYSEMm56W+qWFfoec89TKBXaSj/
	aMSRkHxoTP/rO2ujaA79IhLAjoT3gplSKg8RwLyj8i4xDx4mymNhNCnFL5DNXqiL
	0pM260K6wFPz8rDoJeE2JVSFEIToUrTrXzhU3zjs9tx1vxi4r/LxV2uE2dn8cnMl
	eb6aA9zLDEQpBmBcyxHfoK4QfOR2kJ/zpEdG7fNrFPBdbo1g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xk8m70wk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78ed20d9423so308570585a.3
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545177; x=1714149977; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnGAY95XNUICm5Kn+ZTERdoeOlQFewaIMLYO1O0VljI=;
        b=OtcNTSTvzK+kbyEqcvVos/9dwSnePoaEz5TxqbOtHh5ceD7sOdqcfCRyqFDkLABUH8
         VLAqYNlIXAFSHAhR6ixdPLpfKxOhe8s6CorlAVNUrK08wH9oZPTNFcg66LVIqLgK1hLc
         iB0a43a0dzb9A5WIZmz7GuUYNxB40XIPmyPsa1Y0lyNAIXpIqkXftxmoMQrXAqkEh/Xc
         aN5unVcvIbfdKAOcvepou1Si5udNxDviFiOJXNm5jr4VStoSEgOfpX1qJBBM/YTvx7ul
         lAvHBAHNrrgRiFwGFkseY5UD/zm0E/5gQ1K3c4VZB1JsMJv2Stddn8DekNjq66QM7ld+
         uqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545177; x=1714149977;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnGAY95XNUICm5Kn+ZTERdoeOlQFewaIMLYO1O0VljI=;
        b=eRauWc17d4kWff6dH8Xr0IV1Ly5NFGHBb3UPYY8urDb9eyoZzSbJKG7Y8KEcPdl5zn
         O0XwMuAlLRIz/Ozn1SxRPwXYLIz7HcPlbHovxzxRFhvngj/nI33o1RbsdskZ5WnOup/R
         Hv2hSFbeVC0bOGEQeahQGqmPNvbdHsK7AeZC20N7vqQ0JTy9nB8MtiwMhwiX4qnvKhrJ
         c4s/puNY8MEIZDNK6WCFhO/DYJCUzQli37G3JZnK3vj7StDXBFR3zuTjwYO1WR0iwZIU
         FR5v1WqmX+bzDckek10tz9HpDGMrQzfB2QTrumfz/3BGcLHZrqjR3jwlnelSy3m9dqQ4
         bjQw==
X-Gm-Message-State: AOJu0YyZdxNNhGbHcBmKLPJVoN1jlmXe/S70CPsoAxEdvxzad8oxhWdZ
	ovupVLteQLm1xCktCQdlfkew7X7VoObBr1F6MJLWQUHBeTyr4OyL/CIN5ahccBpuqQJNEKSukwh
	yqz8DKHsFAtlA/oRryzCYQNAQD3akvD4ohJ4pC1ZE0AVJt2RCmw17qJt4tXaqN/JNynepzU8PJM
	KxLs613S+nWLTZz/Fz6hm6N18kowShhHIN4dFW21ybhvRIPIg=
X-Received: by 2002:a05:622a:46:b0:437:97a5:e89a with SMTP id y6-20020a05622a004600b0043797a5e89amr3140102qtw.58.1713545176735;
        Fri, 19 Apr 2024 09:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr4c8JBxrqk/icmDcYnjz4umwTWkZzK23OT+nBNnamxiHlZQBlFK2bnpNg6+qyh748iRCOrQ==
X-Received: by 2002:a05:622a:46:b0:437:97a5:e89a with SMTP id y6-20020a05622a004600b0043797a5e89amr3140067qtw.58.1713545176149;
        Fri, 19 Apr 2024 09:46:16 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:15 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/8] qmi: Create a better client service abstraction
Date: Fri, 19 Apr 2024 16:44:53 +0000
Message-Id: <20240419164458.36078-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419164458.36078-1-steve.schrock@getcruise.com>
References: <20240419164458.36078-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: x41DDHpfWC63K_R-Jhln1mZTZsaiGGf_
X-Proofpoint-GUID: x41DDHpfWC63K_R-Jhln1mZTZsaiGGf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190127

Currently any client can cancel any other client's requests and
notifications. This change separates out the service "family" which is
shared among clients that create services for the same qmi service
type. The qmi_service gets its own unique handle so that clients
are more independent and cannot interfere with other clients as
easily.
---
 drivers/qmimodem/qmi.c | 290 ++++++++++++++++++++++++++---------------
 1 file changed, 185 insertions(+), 105 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 0811eaf2faec..e1091b872f23 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -64,6 +64,7 @@ struct qmi_service_info {
 struct qmi_request {
 	uint16_t tid;
 	unsigned int group_id;		/* Always 0 for control */
+	unsigned int service_handle;	/* Always 0 for control */
 	uint8_t client;			/* Always 0 for control and qrtr */
 	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
@@ -95,11 +96,12 @@ struct qmi_device {
 	struct l_queue *service_queue;
 	struct l_queue *discovery_queue;
 	unsigned int next_group_id;	/* Matches requests with services */
+	unsigned int next_service_handle;
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
 	struct l_queue *service_infos;
-	struct l_hashmap *service_list;
+	struct l_hashmap *family_list;
 	const struct qmi_device_ops *ops;
 	bool writer_active : 1;
 	bool shutting_down : 1;
@@ -120,7 +122,7 @@ struct qmi_device_qmux {
 	struct l_queue *control_queue;
 };
 
-struct qmi_service {
+struct service_family {
 	int ref_count;
 	struct qmi_device *device;
 	struct qmi_service_info info;
@@ -130,6 +132,12 @@ struct qmi_service {
 	struct l_queue *notify_list;
 };
 
+struct qmi_service {
+	int ref_count;
+	unsigned int handle;	/* Uniquely identifies this client's reqs */
+	struct service_family *family;
+};
+
 struct qmi_param {
 	void *data;
 	uint16_t length;
@@ -146,6 +154,7 @@ struct qmi_result {
 struct qmi_notify {
 	uint16_t id;
 	uint16_t message;
+	unsigned int service_handle;
 	qmi_result_func_t callback;
 	void *user_data;
 	qmi_destroy_func_t destroy;
@@ -239,6 +248,7 @@ static struct qmi_request *__request_alloc(uint32_t service_type,
 	req = l_malloc(sizeof(struct qmi_request) + msglen);
 	req->tid = 0;
 	req->group_id = 0;
+	req->service_handle = 0;
 	req->len = msglen;
 	req->client = client;
 
@@ -330,21 +340,21 @@ static bool __notify_compare(const void *data, const void *user_data)
 
 struct service_find_by_type_data {
 	unsigned int type;
-	struct qmi_service *found_service;
+	struct service_family *found_family;
 };
 
-static void __service_find_by_type(const void *key, void *value,
+static void __family_find_by_type(const void *key, void *value,
 					void *user_data)
 {
-	struct qmi_service *service = value;
+	struct service_family *family = value;
 	struct service_find_by_type_data *data = user_data;
 
 	/* ignore those that are in process of creation */
 	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
-	if (service->info.service_type == data->type)
-		data->found_service = service;
+	if (family->info.service_type == data->type)
+		data->found_family = family;
 }
 
 static const char *__service_type_to_string(uint8_t type)
@@ -744,7 +754,8 @@ static uint16_t __service_request_submit(struct qmi_device *device,
 	if (device->next_service_tid < 256)
 		device->next_service_tid = 256;
 
-	req->group_id = service->group_id;
+	req->group_id = service->family->group_id;
+	req->service_handle = service->handle;
 
 	hdr->type = 0x00;
 	hdr->transaction = L_CPU_TO_LE16(req->tid);
@@ -766,18 +777,18 @@ static void service_notify_if_message_matches(void *data, void *user_data)
 
 static void service_notify(const void *key, void *value, void *user_data)
 {
-	struct qmi_service *service = value;
+	struct service_family *family = value;
 	struct qmi_result *result = user_data;
 
 	/* ignore those that are in process of creation */
 	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
-	l_queue_foreach(service->notify_list, service_notify_if_message_matches,
+	l_queue_foreach(family->notify_list, service_notify_if_message_matches,
 				result);
 }
 
-static unsigned int service_list_create_hash(uint16_t service_type,
+static unsigned int family_list_create_hash(uint16_t service_type,
 							uint8_t client_id)
 {
 	return (service_type | (client_id << 16));
@@ -787,7 +798,7 @@ static void handle_indication(struct qmi_device *device,
 			uint32_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
 {
-	struct qmi_service *service;
+	struct service_family *family;
 	struct qmi_result result;
 	unsigned int hash_id;
 
@@ -801,19 +812,19 @@ static void handle_indication(struct qmi_device *device,
 	result.length = length;
 
 	if (client_id == 0xff) {
-		l_hashmap_foreach(device->service_list, service_notify,
+		l_hashmap_foreach(device->family_list, service_notify,
 					&result);
 		return;
 	}
 
-	hash_id = service_list_create_hash(service_type, client_id);
-	service = l_hashmap_lookup(device->service_list,
+	hash_id = family_list_create_hash(service_type, client_id);
+	family = l_hashmap_lookup(device->family_list,
 					L_UINT_TO_PTR(hash_id));
 
-	if (!service)
+	if (!family)
 		return;
 
-	service_notify(NULL, service, &result);
+	service_notify(NULL, family, &result);
 }
 
 static void __rx_message(struct qmi_device *device,
@@ -876,14 +887,14 @@ do {\
 	__discovery_free(&data->super);\
 } while (0)
 
-static void service_destroy(void *data)
+static void family_destroy(void *data)
 {
-	struct qmi_service *service = data;
+	struct service_family *family = data;
 
-	if (!service->device)
+	if (!family->device)
 		return;
 
-	service->device = NULL;
+	family->device = NULL;
 }
 
 static int qmi_device_init(struct qmi_device *device, int fd,
@@ -911,7 +922,7 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	device->service_queue = l_queue_new();
 	device->discovery_queue = l_queue_new();
 	device->service_infos = l_queue_new();
-	device->service_list = l_hashmap_new();
+	device->family_list = l_hashmap_new();
 
 	device->next_service_tid = 256;
 
@@ -939,7 +950,7 @@ void qmi_device_free(struct qmi_device *device)
 
 	l_io_destroy(device->io);
 
-	l_hashmap_destroy(device->service_list, service_destroy);
+	l_hashmap_destroy(device->family_list, family_destroy);
 
 	l_queue_destroy(device->service_infos, l_free);
 
@@ -1400,9 +1411,41 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 	return true;
 }
 
+static struct service_family *service_family_ref(struct service_family *family)
+{
+	family->ref_count++;
+
+	return family;
+}
+
+static void service_family_unref(struct service_family *family)
+{
+	struct qmi_device *device;
+	unsigned int hash_id;
+
+	if (--family->ref_count)
+		return;
+
+	device = family->device;
+	if (!device)
+		goto done;
+
+	hash_id = family_list_create_hash(family->info.service_type,
+							family->client_id);
+	l_hashmap_remove(device->family_list, L_UINT_TO_PTR(hash_id));
+
+	if (device->ops->client_release)
+		device->ops->client_release(device, family->info.service_type,
+							family->client_id);
+
+done:
+	l_queue_destroy(family->notify_list, NULL);
+	l_free(family);
+}
+
 struct service_create_shared_data {
 	struct discovery super;
-	struct qmi_service *service;
+	struct service_family *family;
 	struct qmi_device *device;
 	qmi_create_func_t func;
 	void *user_data;
@@ -1430,26 +1473,46 @@ static uint8_t __ctl_request_submit(struct qmi_device_qmux *qmux,
 	return req->tid;
 }
 
-static struct qmi_service *service_create(struct qmi_device *device,
+static struct service_family *service_family_create(struct qmi_device *device,
 			const struct qmi_service_info *info, uint8_t client_id)
 {
-	struct qmi_service *service = l_new(struct qmi_service, 1);
+	struct service_family *family = l_new(struct service_family, 1);
 
-	service->ref_count = 1;
-	service->device = device;
-	service->client_id = client_id;
-	service->notify_list = l_queue_new();
+	family->ref_count = 0;
+	family->device = device;
+	family->client_id = client_id;
+	family->notify_list = l_queue_new();
 
 	if (device->next_group_id == 0) /* 0 is reserved for control */
 		device->next_group_id = 1;
 
-	service->group_id = device->next_group_id++;
+	family->group_id = device->next_group_id++;
+
+	memcpy(&family->info, info, sizeof(family->info));
+
+	__debug_device(device, "service family created [client=%d,type=%d]",
+					family->client_id,
+					family->info.service_type);
+
+	return family;
+}
+
+static struct qmi_service *service_create(struct service_family *family)
+{
+	struct qmi_device *device = family->device;
+	struct qmi_service *service;
 
-	memcpy(&service->info, info, sizeof(service->info));
+	if (device->next_service_handle == 0) /* 0 is reserved for control */
+		device->next_service_handle = 1;
+
+	service = l_new(struct qmi_service, 1);
+	service->ref_count = 1;
+	service->handle = device->next_service_handle++;
+	service->family = service_family_ref(family);
 
 	__debug_device(device, "service created [client=%d,type=%d]",
-					service->client_id,
-					service->info.service_type);
+					family->client_id,
+					family->info.service_type);
 
 	return service;
 }
@@ -1457,25 +1520,28 @@ static struct qmi_service *service_create(struct qmi_device *device,
 static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
+	struct qmi_service *service;
 
 	l_idle_remove(data->idle);
 	data->idle = NULL;
 
-	DISCOVERY_DONE(data, data->service, data->user_data);
+	service = service_create(data->family);
+	DISCOVERY_DONE(data, service, data->user_data);
+	qmi_service_unref(service);
 }
 
 static void service_create_shared_pending_reply(struct qmi_device *device,
 						unsigned int type,
-						struct qmi_service *service)
+						struct service_family *family)
 {
 	void *key = L_UINT_TO_PTR(type | 0x80000000);
-	struct l_queue *shared = l_hashmap_remove(device->service_list, key);
+	struct l_queue *shared = l_hashmap_remove(device->family_list, key);
 	const struct l_queue_entry *entry;
 
 	for (entry = l_queue_get_entries(shared); entry; entry = entry->next) {
 		struct service_create_shared_data *shared_data = entry->data;
 
-		shared_data->service = qmi_service_ref(service);
+		shared_data->family = service_family_ref(family);
 		shared_data->idle = l_idle_create(service_create_shared_reply,
 							shared_data, NULL);
 	}
@@ -1490,7 +1556,7 @@ static void service_create_shared_data_free(void *user_data)
 	if (data->idle)
 		l_idle_remove(data->idle);
 
-	qmi_service_unref(data->service);
+	service_family_unref(data->family);
 
 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1727,8 +1793,9 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct service_family *family = NULL;
+	struct service_family *old_family = NULL;
 	struct qmi_service *service = NULL;
-	struct qmi_service *old_service = NULL;
 	struct qmi_service_info info;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
@@ -1752,23 +1819,25 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	if (client_id->service != data->type)
 		goto done;
 
-	memset(&info, 0, sizeof(service->info));
+	memset(&info, 0, sizeof(family->info));
 	info.service_type = data->type;
 	info.major = data->major;
 	info.minor = data->minor;
 
-	service = service_create(device, &info, client_id->client);
+	family = service_family_create(device, &info, client_id->client);
 
-	hash_id = service_list_create_hash(service->info.service_type,
-							service->client_id);
-	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
-				service, (void **) &old_service);
+	hash_id = family_list_create_hash(family->info.service_type,
+							family->client_id);
+	l_hashmap_replace(device->family_list, L_UINT_TO_PTR(hash_id),
+				family, (void **) &old_family);
 
-	if (old_service)
-		service_destroy(old_service);
+	if (old_family)
+		family_destroy(old_family);
+
+	service = service_create(family);
 
 done:
-	service_create_shared_pending_reply(device, data->type, service);
+	service_create_shared_pending_reply(device, data->type, family);
 
 	DISCOVERY_DONE(data, service, data->user_data);
 	qmi_service_unref(service);
@@ -1816,7 +1885,7 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	__qmi_device_discovery_started(device, &data->super);
 
 	/* Mark service creation as pending */
-	l_hashmap_insert(device->service_list,
+	l_hashmap_insert(device->family_list,
 			L_UINT_TO_PTR(type_val | 0x80000000), shared);
 
 	return 0;
@@ -2553,7 +2622,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_destroy_func_t destroy)
 {
 	struct l_queue *shared;
-	struct qmi_service *service = NULL;
+	struct service_family *family = NULL;
 	unsigned int type_val = type;
 	int r;
 
@@ -2570,20 +2639,19 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		 * The hash id is simply the service type in this case. There
 		 * is no "pending" state for discovery and no client id.
 		 */
-		service = l_hashmap_lookup(device->service_list,
+		family = l_hashmap_lookup(device->family_list,
 						L_UINT_TO_PTR(type_val));
-		if (!service) {
+		if (!family) {
 			const struct qmi_service_info *info;
 
 			info = __find_service_info_by_type(device, type);
 			if (!info)
 				return false;
 
-			service = service_create(device, info, 0);
-			l_hashmap_insert(device->service_list,
-					L_UINT_TO_PTR(type_val), service);
-		} else
-			service = qmi_service_ref(service);
+			family = service_family_create(device, info, 0);
+			l_hashmap_insert(device->family_list,
+					L_UINT_TO_PTR(type_val), family);
+		}
 
 		data = l_new(struct service_create_shared_data, 1);
 
@@ -2592,7 +2660,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data->func = func;
 		data->user_data = user_data;
 		data->destroy = destroy;
-		data->service = service;
+		data->family = service_family_ref(family);
 
 		data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
@@ -2603,7 +2671,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		return true;
 	}
 
-	shared = l_hashmap_lookup(device->service_list,
+	shared = l_hashmap_lookup(device->family_list,
 					L_UINT_TO_PTR(type_val | 0x80000000));
 
 	if (!shared) {
@@ -2616,14 +2684,14 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		struct service_find_by_type_data data;
 
 		data.type = type_val;
-		data.found_service = NULL;
-		l_hashmap_foreach(device->service_list,	__service_find_by_type,
+		data.found_family = NULL;
+		l_hashmap_foreach(device->family_list,	__family_find_by_type,
 					&data);
-		service = data.found_service;
+		family = data.found_family;
 	} else
 		type_val |= 0x80000000;
 
-	if (shared || service) {
+	if (shared || family) {
 		struct service_create_shared_data *data;
 
 		data = l_new(struct service_create_shared_data, 1);
@@ -2635,7 +2703,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data->destroy = destroy;
 
 		if (!(type_val & 0x80000000)) {
-			data->service = qmi_service_ref(service);
+			data->family = service_family_ref(family);
 			data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
 		} else
@@ -2668,31 +2736,16 @@ struct qmi_service *qmi_service_ref(struct qmi_service *service)
 
 void qmi_service_unref(struct qmi_service *service)
 {
-	struct qmi_device *device;
-	unsigned int hash_id;
-
 	if (!service)
 		return;
 
 	if (--service->ref_count)
 		return;
 
-	device = service->device;
-	if (!device) {
-		l_free(service);
-		return;
-	}
-
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 
-	hash_id = service_list_create_hash(service->info.service_type,
-							service->client_id);
-	l_hashmap_remove(device->service_list, L_UINT_TO_PTR(hash_id));
-
-	if (device->ops->client_release)
-		device->ops->client_release(device, service->info.service_type,
-							service->client_id);
+	service_family_unref(service->family);
 
 	l_free(service);
 }
@@ -2702,7 +2755,7 @@ const char *qmi_service_get_identifier(struct qmi_service *service)
 	if (!service)
 		return NULL;
 
-	return __service_type_to_string(service->info.service_type);
+	return __service_type_to_string(service->family->info.service_type);
 }
 
 bool qmi_service_get_version(struct qmi_service *service,
@@ -2712,10 +2765,10 @@ bool qmi_service_get_version(struct qmi_service *service,
 		return false;
 
 	if (major)
-		*major = service->info.major;
+		*major = service->family->info.major;
 
 	if (minor)
-		*minor = service->info.minor;
+		*minor = service->family->info.minor;
 
 	return true;
 }
@@ -2769,6 +2822,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct qmi_device *device;
+	struct service_family *family;
 	struct service_send_data *data;
 	struct qmi_request *req;
 	uint16_t tid;
@@ -2776,10 +2830,12 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!service)
 		return 0;
 
-	if (!service->group_id)
+	family = service->family;
+
+	if (!family->group_id)
 		return 0;
 
-	device = service->device;
+	device = family->device;
 	if (!device)
 		return 0;
 
@@ -2789,8 +2845,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __service_request_alloc(&service->info,
-					service->client_id, message,
+	req = __service_request_alloc(&family->info,
+					family->client_id, message,
 					param ? param->data : NULL,
 					param ? param->length : 0,
 					service_send_callback, data);
@@ -2807,14 +2863,17 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 	unsigned int tid = id;
 	struct qmi_device *device;
 	struct qmi_request *req;
+	struct service_family *family;
 
 	if (!service || !tid)
 		return false;
 
-	if (!service->client_id)
+	family = service->family;
+
+	if (!family->client_id)
 		return false;
 
-	device = service->device;
+	device = family->device;
 	if (!device)
 		return false;
 
@@ -2838,9 +2897,9 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 static bool remove_req_if_match(void *data, void *user_data)
 {
 	struct qmi_request *req = data;
-	unsigned int group_id = L_PTR_TO_UINT(user_data);
+	unsigned int service_handle = L_PTR_TO_UINT(user_data);
 
-	if (req->group_id != group_id)
+	if (req->service_handle != service_handle)
 		return false;
 
 	service_send_free(req->user_data);
@@ -2849,10 +2908,10 @@ static bool remove_req_if_match(void *data, void *user_data)
 	return true;
 }
 
-static void remove_client(struct l_queue *queue, unsigned int group_id)
+static void remove_client(struct l_queue *queue, unsigned int service_handle)
 {
 	l_queue_foreach_remove(queue, remove_req_if_match,
-				L_UINT_TO_PTR(group_id));
+				L_UINT_TO_PTR(service_handle));
 }
 
 bool qmi_service_cancel_all(struct qmi_service *service)
@@ -2862,15 +2921,15 @@ bool qmi_service_cancel_all(struct qmi_service *service)
 	if (!service)
 		return false;
 
-	if (!service->group_id)
+	if (!service->family->group_id)
 		return false;
 
-	device = service->device;
+	device = service->family->device;
 	if (!device)
 		return false;
 
-	remove_client(device->req_queue, service->group_id);
-	remove_client(device->service_queue, service->group_id);
+	remove_client(device->req_queue, service->handle);
+	remove_client(device->service_queue, service->handle);
 
 	return true;
 }
@@ -2880,22 +2939,26 @@ uint16_t qmi_service_register(struct qmi_service *service,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct qmi_notify *notify;
+	struct service_family *family;
 
 	if (!service || !func)
 		return 0;
 
+	family = service->family;
+
 	notify = l_new(struct qmi_notify, 1);
 
-	if (service->next_notify_id < 1)
-		service->next_notify_id = 1;
+	if (family->next_notify_id < 1)
+		family->next_notify_id = 1;
 
-	notify->id = service->next_notify_id++;
+	notify->id = family->next_notify_id++;
 	notify->message = message;
+	notify->service_handle = service->handle;
 	notify->callback = func;
 	notify->user_data = user_data;
 	notify->destroy = destroy;
 
-	l_queue_push_tail(service->notify_list, notify);
+	l_queue_push_tail(family->notify_list, notify);
 
 	return notify->id;
 }
@@ -2903,12 +2966,15 @@ uint16_t qmi_service_register(struct qmi_service *service,
 bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 {
 	unsigned int nid = id;
+	struct service_family *family;
 	struct qmi_notify *notify;
 
 	if (!service || !id)
 		return false;
 
-	notify = l_queue_remove_if(service->notify_list, __notify_compare,
+	family = service->family;
+
+	notify = l_queue_remove_if(family->notify_list, __notify_compare,
 					L_UINT_TO_PTR(nid));
 
 	if (!notify)
@@ -2919,13 +2985,27 @@ bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 	return true;
 }
 
+static bool remove_notify_if_handle_match(void *data, void *user_data)
+{
+	struct qmi_notify *notify = data;
+	unsigned int handle = L_PTR_TO_UINT(user_data);
+
+	if (notify->service_handle != handle)
+		return false;
+
+	__notify_free(notify);
+
+	return true;
+}
+
 bool qmi_service_unregister_all(struct qmi_service *service)
 {
 	if (!service)
 		return false;
 
-	l_queue_destroy(service->notify_list, __notify_free);
-	service->notify_list = NULL;
+	l_queue_foreach_remove(service->family->notify_list,
+					remove_notify_if_handle_match,
+					L_UINT_TO_PTR(service->handle));
 
 	return true;
 }
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

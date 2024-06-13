Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87613FD66
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314899; cv=none; b=TXMGCUwqIjgmqunNYFLG6S4Flf3yutfwlJPY3DfkWusUP6ZQ/Soui53Vdm8Dzgvl38Xc2Ct6xRK3EzoVIIxTX3uNiUj4yUEjv9teDL14rwUM+KDiIf6q5wvhlQ5CA2SqzTrj90Id03/wv9Umia9AFP1XRve4m6nC7mCSDRzyzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314899; c=relaxed/simple;
	bh=QBF+sciQyaGmQX8QMmhepIuCOAVjsoEDOP/io7RtMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CC4ts4muJY3qnG3MVORZeGFPwhBBVVN8qv1lROOwOtTVsXFqea//BCtt2Pb3oKUAzgXKqytuppr30ukQTS20FqmXR9Jv4RlnxGxrgq2fdA6ig5es2rKGiBHy7doyFwqRvUEYScajwrZeI29e6j19p658BYRkIdtk+olEawW0xGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncm9Vdc3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncm9Vdc3"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2551f9437d3so876020fac.0
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314897; x=1718919697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tIEe+wwLE2x1wnF43/mr+uxIejVrRX6mo7zzHX7PxA=;
        b=Ncm9Vdc3FRToQd82CVlnL/ZNPGD6/oy62oGPhV5ynmPZ+qkuUf61huVhYHDMC2WkAv
         JSUAp4CVcLRRm2+hTQ1GqlNzIN4ITD9qACYg68pMtXuDboWLpWYD+hyUgbxRluFPNiTX
         aHVp/0kHsgIjtpTMcp7xtRq4S5Nh3zx6qFSpDrssx15IVcX6q0rFwyB3H1KLlifQpj+M
         EBWbTOHPtr47ZDvviHQ2rBEARs9HXxQ8mvIwa5jcOnZDX1wEZGQBNSQPE+nRTVK0Kxzi
         g8blWrHrmrgTuX/Xp8jqS4OxQ/bhEezOCg4oYK959OPIkE9FTzPy7NUAtKTatLsqMQ8y
         Llxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314897; x=1718919697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tIEe+wwLE2x1wnF43/mr+uxIejVrRX6mo7zzHX7PxA=;
        b=oLzvXRkiCVCMIf8wASIuU1SzQvWdPHiyVYn6IfweG82mNuGtniCLR6BOBXEnft2vfg
         68iFPPsR1VPs61e/t/wnfZkkBosMF4gxxaSiMpgIZlsDderhJBUpyasSBzwujlIENogB
         bfQq9vKtFV6Y+l6riqUH/rtnjGgxXNBkFFmH9FFb3x+S6lfbBR1vqxWHOINz+2Xr+Y1K
         yWF1xfYy2vnD69nw0SAmNABaYFrFs7zyAC1LM4FDYaVLb++UROpc2PxOE17LmLDS+Eor
         c6B5uMu3iaxQ2ZTdQhEbjQZXhxFz57/rs8CWtEdNppTH+vG0dY0imVbWmyuklhM1DCHi
         warA==
X-Gm-Message-State: AOJu0YziKapb8vOzoyi2oWcGXJ7JC/JcMi04Gi8VX+1bDeRkk67dHiHx
	Gr4DNyR0IWjurQRraOBcscM2MYUlLQegppGdz9m9UVIM73C6UJGQFE+Xdw==
X-Google-Smtp-Source: AGHT+IHPPXS5/24NRMYUpjU+jGeUxG2dF1XYLoWoaEWSYD7+vlsLXeXqVd8RSQtuRxh9GXsYbvYQPQ==
X-Received: by 2002:a05:6870:9589:b0:254:de02:4c65 with SMTP id 586e51a60fabf-2584288e57emr1076015fac.6.1718314897321;
        Thu, 13 Jun 2024 14:41:37 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/23] qmi: lookup shared family directly by type
Date: Thu, 13 Jun 2024 16:41:11 -0500
Message-ID: <20240613214134.1056517-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it is currently no longer possible to create dedicated clients for
a given service type, use the service type as the key to the family_list
hashtable.  For QMUX, this allows the service family to be looked up
directly instead of iterating over the entire hash table.  The hash
table entry at key=service_type will always point to the shared service
family.
---
 drivers/qmimodem/qmi.c | 61 +++++++++---------------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index dfcf46a6e35e..1b3fa34f685c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -330,21 +330,6 @@ static bool __notify_compare(const void *data, const void *user_data)
 			notify->service_handle == details->service_handle;
 }
 
-struct service_find_by_type_data {
-	unsigned int type;
-	struct service_family *found_family;
-};
-
-static void __family_find_by_type(const void *key, void *value,
-					void *user_data)
-{
-	struct service_family *family = value;
-	struct service_find_by_type_data *data = user_data;
-
-	if (family->info.service_type == data->type)
-		data->found_family = family;
-}
-
 static const char *__service_type_to_string(uint8_t type)
 {
 	switch (type) {
@@ -1403,7 +1388,6 @@ static struct service_family *service_family_ref(struct service_family *family)
 static void service_family_unref(struct service_family *family)
 {
 	struct qmi_device *device;
-	unsigned int hash_id;
 
 	if (--family->ref_count)
 		return;
@@ -1412,9 +1396,15 @@ static void service_family_unref(struct service_family *family)
 	if (!device)
 		goto done;
 
-	hash_id = family_list_create_hash(family->info.service_type,
+	if (family->client_id) {
+		unsigned int hash_id =
+			family_list_create_hash(family->info.service_type,
 							family->client_id);
-	l_hashmap_remove(device->family_list, L_UINT_TO_PTR(hash_id));
+		l_hashmap_remove(device->family_list, L_UINT_TO_PTR(hash_id));
+	}
+
+	l_hashmap_remove(device->family_list,
+				L_UINT_TO_PTR(family->info.service_type));
 
 	if (device->ops->client_release)
 		device->ops->client_release(device, family->info.service_type,
@@ -1799,7 +1789,6 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 	struct service_family *family = NULL;
-	struct service_family *old_family = NULL;
 	struct qmi_service_info info;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
@@ -1829,16 +1818,13 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	info.minor = data->minor;
 
 	family = service_family_create(device, &info, client_id->client);
-
+	family = service_family_ref(family);
 	hash_id = family_list_create_hash(family->info.service_type,
 							family->client_id);
-	l_hashmap_replace(device->family_list, L_UINT_TO_PTR(hash_id),
-				family, (void **) &old_family);
-
-	if (old_family)
-		family_destroy(old_family);
-
-	family = service_family_ref(family);
+	l_hashmap_insert(device->family_list, L_UINT_TO_PTR(hash_id), family);
+	l_hashmap_insert(device->family_list,
+				L_UINT_TO_PTR(family->info.service_type),
+				family);
 done:
 	service_create_shared_pending_reply(qmux, data->type, family);
 	if (family)
@@ -2636,28 +2622,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
-	/*
-	 * First check to see if the bare type is in the hashmap. If it is not
-	 * the family might exist already, but have the client id included in
-	 * the hash id.
-	 */
 	family = l_hashmap_lookup(device->family_list, L_UINT_TO_PTR(type));
-
-	if (!family) {
-		struct service_find_by_type_data find_data;
-
-		/*
-		 * There is no way to find in an l_hashmap using a custom
-		 * function. Instead we use a temporary struct to store the
-		 * found service family.
-		 */
-		find_data.type = type;
-		find_data.found_family = NULL;
-		l_hashmap_foreach(device->family_list,	__family_find_by_type,
-						&find_data);
-		family = find_data.found_family;
-	}
-
 	if (!family) {
 		const struct qmi_service_info *info;
 
-- 
2.45.0


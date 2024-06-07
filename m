Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493871CAB5
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800472; cv=none; b=teiJjec54Y5TNUPeQwD0gUw8+tj1jA1d2Jjl68IFAr7r3xgPIB6Dj2wdqBECHuoLnN/zPjL/lIAFqobWlqJh8E3oWVvFxfzaDn6xGqKMqu5zjZsKURFYNTaStoecWKGGcuo7NUWVqbjhHlBSBuz8t5J/L4txKfSbqhXm/HWSpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800472; c=relaxed/simple;
	bh=QBF+sciQyaGmQX8QMmhepIuCOAVjsoEDOP/io7RtMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7FyuV8fREdPpsQ9VWlr1wOsUh4jV0RKBrKofz5SMWVrHqTwhB9QUd9IzeQU2aL6SfjTHfqEakCnfMtPNYyZ/3Sru+V6E+Uk3KLoYiS/gRqd/gk5T8muKbChzSfQ088u74qJ4N2ClQN02fpM0Ex808nPDxcgaSLXWcj3XcnCq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFbN8RgD; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFbN8RgD"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b970e90ab8so1537477eaf.3
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800470; x=1718405270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tIEe+wwLE2x1wnF43/mr+uxIejVrRX6mo7zzHX7PxA=;
        b=lFbN8RgD82r+5rIDM9w8H6Md1YOT2gxJ2+6z59T72WjOtQwZLn8AP8OxP0GZKTOhQu
         y+owRZ1qTWSYAVu55dy81VmMmZ963cmekTmKiZGGZ+LumnHeHP0twDxceVN7nO671vkg
         8fsg9tudK0iRVRoiHZpUKnTWtrmn4N3eJVBDeDQ1lIovvCHuRzp0OUJyJJV+onUSceKT
         k62ZZxZZCN45EfCMkJ6HqWGNm9CkDEzFGYYIifH6vcI8SQh4FDJaZGYb/g9gRqwP4lj8
         8XNGz7TYrvDQOe0iU6XWD7xZs4Amkzgw8ROtO9LsyKNez83Z9sh8VmO81OtY8aaoc1rw
         1z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800470; x=1718405270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tIEe+wwLE2x1wnF43/mr+uxIejVrRX6mo7zzHX7PxA=;
        b=JQ8Q1bWabuwG7CeWgT1CW9AQ78QGMLPlls1cWKPtOumXGkCtX2Uhv74ELi7hQ99Zqs
         1vJqY8cIQVGqa7quVQAnwC1xCmK0etbZTB0t42Q8eI1x7nhJQbPwmL3ZLHQ8O6vq+bIX
         575juRmgx58KRQAJdGhqcCGiEScS3o71SdF6eYmAs5HxBuf4fwJ0s+GoS3x1WNIcSOim
         I+uxhDrbPwtyEKIhuzq+EEb6GT8dSGnGGu1a3dDJ7qD7QyDGlWXLTerWv2PKgI+bW1U5
         QiShWd/Dn0ASkSbYv6ZrKRu5jxakzoqx7sw1p3Yb/Xf0/7feMeLTisXsEnO8D28uK4EK
         482g==
X-Gm-Message-State: AOJu0YxyEYV7kY9SxzbOvi1wHp4tzbr+IPUzUZ5a4HgdTsAplS7qxiRY
	bb3GNRsJ6D+jBZZqFrwKCLg33sJTYJaQjTHQS0Dzg3aP6Nlu3A6fzulBkQ==
X-Google-Smtp-Source: AGHT+IF3Fg8eH7rlqs44adW7fIEFI70cbviotW8o2rtlD/KCDidlxRwnY2a1U6McTwTUTHpnPayqag==
X-Received: by 2002:a05:6820:1ad3:b0:5b7:3502:6543 with SMTP id 006d021491bc7-5baae780cfamr4649177eaf.7.1717800470031;
        Fri, 07 Jun 2024 15:47:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/23] qmi: lookup shared family directly by type
Date: Fri,  7 Jun 2024 17:47:02 -0500
Message-ID: <20240607224746.903769-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240607224746.903769-1-denkenz@gmail.com>
References: <20240607224746.903769-1-denkenz@gmail.com>
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


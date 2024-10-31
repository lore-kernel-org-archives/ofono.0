Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CA14A4F9
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412406; cv=none; b=rg4VCx3hiTHXaZY9Lko36Ou53cg2XTfL1YVe966/e59ukHsUYGL94VUroYbcEKqAmnsbhgDJn/2KvepcI4/14ROnQjiAfIWSzT8btkzGuKqUBQkdhRHNbcbYcOKFQ2Kelcg5YkeW4x8jQSjRkOBVzDRhIWRJBNQuVr3n8LzDpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412406; c=relaxed/simple;
	bh=ABxlf500HygPomN7AXYa0dFLPadkFJoUssczq47ZUJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l59asW6dCJu+xGMJJ0B9iSVFZQuD1hrQrbIiUuTdlvfV0hVgqhxyYuT7x2Z9UmVBracNOeiMQUh5Fx9Wzrq4qOzOBCkz2jsQ9rHGb6hP9/Mofd1uAjPYKnRva5Fh4czQBYX4+h6Jr7/QynrmF1Ul5XFrv6ONVxe56JfsVhjzAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFpcMzKA; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFpcMzKA"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71808e95ae2so967487a34.0
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412400; x=1731017200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOC8H79dbjnvDjj4pELVeKMX9OKy9bpviIJPwtgwTZc=;
        b=mFpcMzKAlajBvCWuMDXcUkqlewFdyCFyDz6ptq9vLRGsyASHBkXcgP4kFJwRw5Dxb6
         42voqqkRvDDyJZEIpm4vC5JCau46bjGcyITw35rM7UEVE074S2a0ZePXV9OQ50hm+zqY
         BNGtmFkWmqjn27BtmPVqx+XhDzz/JyAy/3LVzXiIDJZlT2Ua2Wx5GBq50R+QJhFjrUKu
         q2RdicHrUgAlL4Zl8N3pfsKXd7RiVkCb/p8dwSK8ACfYdRwXRcozUgux81ia4aobCW3g
         HvNDBRwYc92T6Nleqg6Qs6T+3RL3cFJdVttExBC1Sx6Oqy/p4YX07iUHNCDfkps6K7cU
         7uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412400; x=1731017200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOC8H79dbjnvDjj4pELVeKMX9OKy9bpviIJPwtgwTZc=;
        b=ZOwFJIdv/X/lN1azC/lA5qUqP6hMZzSnoJer2cnYLg1xwjflv1XDdNLqduRe7tfP3s
         0f8eFiRukjyY+8Gs8m2nGFX0hbDjrJoS9AKZefl4ZgVTDHlyN7/deDmb/0zRfGVPsK44
         XVUYzc6h6y3/Ibcm9lvIpHIQ6T5NLTD3w8xvdRwtvu8qoSE0q5ZEvcG5IM1VL7mfpywD
         PLVinYcd1w2BXbqUkpBqq7jwMM1yzw5hj/2JANp9WluI8FdfF6snVktmJP4P4Iiv/zNM
         3i+dJnkYEgbmUEmjhIQAywWEtTsNQpT2xXUMKg+zrJEA5PJnNvuwgPhAZ+bsuUwNXcnu
         Tdtg==
X-Gm-Message-State: AOJu0Ywz7IxwRrbee9rSZR6glgq69bQDCHc9kTQyE+bSrbxofs9obQDp
	vSPaaGgOJ+e7iMoL7YLF1+0twIQARWTVgcW+SfGbnsy/TmsW+1NDJuCGzQ==
X-Google-Smtp-Source: AGHT+IGECVyA0uJNLsmVUhVDi0TguBeBwBKf8iqc1Iva99174OzHHVOjOZdVSzvMQNJTs5OWWaHWpw==
X-Received: by 2002:a05:6830:3103:b0:717:f66a:9d21 with SMTP id 46e09a7af769-7189d679ccfmr1938431a34.16.1730412399978;
        Thu, 31 Oct 2024 15:06:39 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/13] qmi: validate TLV length
Date: Thu, 31 Oct 2024 17:06:08 -0500
Message-ID: <20241031220638.1582166-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For qmi_result_get_(u)int[8,16,32], make sure that the length
corresponds to the size of the basic type prior to performing the
memcpy.
---
 drivers/qmimodem/qmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 0ba2e8b9e352..10dbdaac8bf6 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2311,7 +2311,7 @@ bool qmi_result_get_uint8(struct qmi_result *result, uint8_t type,
 		return false;
 
 	ptr = tlv_get(result->data, result->length, type, &len);
-	if (!ptr)
+	if (!ptr || len != sizeof(uint8_t))
 		return false;
 
 	if (value)
@@ -2330,7 +2330,7 @@ bool qmi_result_get_int16(struct qmi_result *result, uint8_t type,
 		return false;
 
 	ptr = tlv_get(result->data, result->length, type, &len);
-	if (!ptr)
+	if (!ptr || len != sizeof(int16_t))
 		return false;
 
 	memcpy(&tmp, ptr, 2);
@@ -2351,7 +2351,7 @@ bool qmi_result_get_uint16(struct qmi_result *result, uint8_t type,
 		return false;
 
 	ptr = tlv_get(result->data, result->length, type, &len);
-	if (!ptr)
+	if (!ptr || len != sizeof(uint16_t))
 		return false;
 
 	memcpy(&tmp, ptr, 2);
@@ -2373,7 +2373,7 @@ bool qmi_result_get_uint32(struct qmi_result *result, uint8_t type,
 		return false;
 
 	ptr = tlv_get(result->data, result->length, type, &len);
-	if (!ptr)
+	if (!ptr || len != sizeof(uint32_t))
 		return false;
 
 	memcpy(&tmp, ptr, 4);
@@ -2395,7 +2395,7 @@ bool qmi_result_get_uint64(struct qmi_result *result, uint8_t type,
 		return false;
 
 	ptr = tlv_get(result->data, result->length, type, &len);
-	if (!ptr)
+	if (!ptr || len != sizeof(uint64_t))
 		return false;
 
 	memcpy(&tmp, ptr, 8);
-- 
2.45.2


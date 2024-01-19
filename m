Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AD57867
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698668; cv=none; b=gNND+qJMfCB3qbdEDWxnIDRhoJBC/eXwqBkw8kSL+BhfpSePd4i9coeNht2wMdBi38FMsUbKl6KLzUMS5G8xxDFdeLTuk+pXpF7xKF9xw25kY6mOmXTSbDjh1i3F7XffNUs1TxRoXcfL7g8fFbxx7eM7eqkCKBwU7hfS6uYxX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698668; c=relaxed/simple;
	bh=6QdXd38SSlBQcG0K/3ipWfBdZiQSUD5sV6fE6xjl8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bo+UKlQsc6VuPsRDs7TwEkC3BsFnOjZRmR0RQc2zV51Jlm5oqd8GpqHXFAoeZRV6D6enfc3UCwNYlAUG0oprCXa9mvEnx6fL9ltnqaaVB9P5Parim2cDCkSDesHdmVwjqAZsb5J1q3RXNYqwB7Q4BBFueUo0XNqXx1fiEdCzH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQCQQN71; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQCQQN71"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc83674972so620952a34.1
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698665; x=1706303465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTECqhclkcQEf7Zis94yWVh0FXThprpO9RslCeEURq4=;
        b=dQCQQN71oTtpLLLCy4g13pzYDNmCdfsXCng0ApXphKGbO+cVeC4VD3j9fZJulnC5py
         /NPndnlKd+3Oh9qgsZjj7I8j//YvTMHppHaPyRYP+wVfi8qVCi1fKd9vfrG33r4obXU5
         evc9ItIHNwb3VoB9b43OJFt0wFKKusuCQa9fN8j5e0LokcTBqKVL8+II0iDVvIzFRv/i
         JoOxpo7bAhZxGRbj4EiCb0KvXByh2GDZmqi2K24Js1fjv39qabJYO/V1iD7egU3OGLRN
         8Fda9bdddqxa2zmDwKTTvOs3uLpYPTse4RNzO////5ZAFPdY0EQ5DMqnWOergUemsxfm
         buaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698665; x=1706303465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTECqhclkcQEf7Zis94yWVh0FXThprpO9RslCeEURq4=;
        b=QKiXUP5wElC6irBxr+egmjnGC3GIIj7x/yvFMwbGNLGtOXblzEGpDcsnqlXkvGeWIA
         7GiDcqLymoHxD8c+pq71pdkiLxOc3nURmp4vXLv3i/PdQIxdTKJkcsh7CmbjHn6KV1Eb
         ikhUr58tn6KJnvpQvAoHrrwyk7tz1ERXaD5eOTzKMWIQEedkP+qBvoxpig54VVzQf9RX
         XHnnn3dPmao2N83nm5lZ9ETUctgcGhZdh/X4dJmZTf9y9BS406BeEh8E7W+7icpWlqU0
         XmCyigtxykb4lEcfUMyf0TbduQBTYbEZA+qMkkcWx9WBCLdy88489yKH4piliw4wo6qf
         hYoA==
X-Gm-Message-State: AOJu0Yya33R/U6vhrtWcKWSPnBPvSqOI9KetrDqawT0MbKsAlbT2l8Uo
	aWcxIjjIyK6PLvlVMDOHctZivGDechEWnWGvd4mD0YgzwRsOBS0ETExJoxai
X-Google-Smtp-Source: AGHT+IFPgibZAYrBWxCQCQUUnFGl5kySJEFJ636kCG3woxItig3gBpr03wcL8HyeJD8XO1JnNvltcw==
X-Received: by 2002:a9d:7dc5:0:b0:6dd:f078:b8f3 with SMTP id k5-20020a9d7dc5000000b006ddf078b8f3mr408357otn.76.1705698665542;
        Fri, 19 Jan 2024 13:11:05 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/14] include: Allow multiple context types
Date: Fri, 19 Jan 2024 15:09:37 -0600
Message-ID: <20240119211017.474598-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/gprs-context.h   | 8 ++++----
 include/gprs-provision.h | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 75958284..81055d89 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -33,10 +33,10 @@ struct ofono_modem;
 
 enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_ANY = 0,
-	OFONO_GPRS_CONTEXT_TYPE_INTERNET,
-	OFONO_GPRS_CONTEXT_TYPE_MMS,
-	OFONO_GPRS_CONTEXT_TYPE_WAP,
-	OFONO_GPRS_CONTEXT_TYPE_IMS,
+	OFONO_GPRS_CONTEXT_TYPE_INTERNET	= 0x0001,
+	OFONO_GPRS_CONTEXT_TYPE_MMS		= 0x0002,
+	OFONO_GPRS_CONTEXT_TYPE_WAP		= 0x0004,
+	OFONO_GPRS_CONTEXT_TYPE_IMS		= 0x0008,
 };
 
 struct ofono_gprs_primary_context {
diff --git a/include/gprs-provision.h b/include/gprs-provision.h
index 2dd792b5..75808e66 100644
--- a/include/gprs-provision.h
+++ b/include/gprs-provision.h
@@ -26,10 +26,12 @@
 extern "C" {
 #endif
 
+#include <stdint.h>
+
 #include "gprs-context.h"
 
 struct ofono_gprs_provision_data {
-	enum ofono_gprs_context_type type;
+	uint32_t type; /* Multiple types can be set in a bitmap */
 	enum ofono_gprs_proto proto;
 	char *name;
 	char *apn;
-- 
2.43.0


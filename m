Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D938F91
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqIjW41y"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7b70139d54cso203106239f.1
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011265; x=1703616065; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTECqhclkcQEf7Zis94yWVh0FXThprpO9RslCeEURq4=;
        b=cqIjW41yQ36cyXz8C1P9L6PV0DvopI4eUR3524eUPLmcazmU7GKEsh2OAqEyUfqm8N
         53IVnY1bQpwbDhS3wBP8OX2vpz0r6JxAGnXwuT8NkBZNDud3+Tk4J/GYQS89KEKZsN8z
         DYNqPiXpwOpAGRq54bd8NJ6cqx6Sbvb7Z9HrpeAVzLoZ/q7nxAhOoK8UMgQvsN2jVdci
         JNV/RluW02/8IOtYE3/i3bEIYufAmFqPv7B2W3VxayxlvLqp6s9ws6uVIW7ft4p6D1c6
         lPh+DLxh/F/sO+IWQ5hNvL5R2YIZQa9BACLfy9RN9qb7ifUKyqMd/NgNi+jx6De9fWgo
         kCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011265; x=1703616065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTECqhclkcQEf7Zis94yWVh0FXThprpO9RslCeEURq4=;
        b=nmPeroT2eNizxkvXA8wxtkTisdmZvHVOMI+zcKAl9hGNxayWnaEIKBqraEqXEt5iYw
         DxuoRQ4jc8oI68MpPKmifXHq6OhxVbmG/ycpT5epsdU/DphTo0yrKK+EHTHJj3KisdJz
         bMypp+qVVcVy1aCFNnX7j05FottzylmrHeG4hFiciZ6rPznpYAzxQRO3xsVX4N3llp83
         wb6SuMIOpvGmoZ4kQn+DBib/65dH8DXQogNrOx+ocS4SUzIUMbQg/EKofcwRTmwfB+Xn
         qhlkZ4PQK5LPslhy3IC6y7vXzMFgk9gtczG8CmtJi4ZeIjfX0oAnTxNXIp7X1Q4eC+n8
         Mt3A==
X-Gm-Message-State: AOJu0YwDnE/YMrTlMjKvnRnBGk3nulM+YRfmTm1DSUSwh+WR9ImlWKUD
	yRqYQjoekk/RRfadydbWuowKz89ViL4=
X-Google-Smtp-Source: AGHT+IHPZr+RRtN0t1QUc3WJRuzicn+dBRGew1WD1DMmxuRD09y3dv0Miu4KyCOqjf8mxkSRnjS+GA==
X-Received: by 2002:a05:6602:599:b0:7b6:fc90:c3d8 with SMTP id v25-20020a056602059900b007b6fc90c3d8mr17286413iox.38.1703011265628;
        Tue, 19 Dec 2023 10:41:05 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/15] include: Allow multiple context types
Date: Tue, 19 Dec 2023 12:36:59 -0600
Message-ID: <20231219184016.420116-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219184016.420116-1-denkenz@gmail.com>
References: <20231219184016.420116-1-denkenz@gmail.com>
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


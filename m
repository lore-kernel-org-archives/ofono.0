Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC332749A
	for <ofono@lists.linux.dev>; Mon,  4 Mar 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584513; cv=none; b=sQBhmDqvmK+lEYouc/OTAVXPzry4LQ3qfXQI1uNgWSuZ5KjsQHFH3BuDF5DH0OwwtRUCPkr12n+Td0lat1UiDL2iWLNMssbsHmOll+QWsqrRV3f6ESIDiouLJuEJ9agRwlwGWHybkexywVUYQ5WReLGBLKYylI7NyQnLp61REC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584513; c=relaxed/simple;
	bh=7+f3H9ivSlZI/TYfx1m1FU6si7EsWtNg1cX7y3jZFjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/rKptMlJEE5DiNJjzoaVsNs3ZQvEaROeNm17ghwr01SBMwhUr7fPjnH8LZ1ybFMRh/U0bjR60p2O/JYnGbPy9Bj2uLonB748fFaWWCrj6c/l1F11q8Y3IkyTm4C8iVYa3QXxEm8WDDtSasAIzLS+884EQRkxhN++oKy7kVBFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU2m8uPR; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU2m8uPR"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a1e1e539so4680720b6e.1
        for <ofono@lists.linux.dev>; Mon, 04 Mar 2024 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584511; x=1710189311; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df/4SI/FqCQy20jdCEwfRILnyJTVzpPKGctX5KcrXzo=;
        b=DU2m8uPRab5n9qWxdyEi1WGWEQvsKk6x9UirfBYO7pWwN4Zmcpgd5VzGsUFMVhqFcN
         /yU7xXwyGU+stDoShc4uNyzwgID3a2Gy8kNBX6r3/sPBFco8PO9SYOd6pNJHDMKoLo6n
         aducWiTPD3pQ9fQ4Ui5tL6FEiDAM3pOtoYQMOegcDo5p7QrcZudzCRqwgNS1X4scZ2Xi
         z2tOV9WoSKUO5j8fKGc8n3P754EYYtzOqmboxtAznSBhzso/YSHQdWKRrfBYDfZ1ZEY3
         a1WIG3nuyOpDGeQYrtSyk5DXfeybe8RZPH27cZY4ZsCyPsqqYOVHsJSm5+oEjp87LGSq
         mhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584511; x=1710189311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df/4SI/FqCQy20jdCEwfRILnyJTVzpPKGctX5KcrXzo=;
        b=c6ot6/3vAhtaxJDfqz3/3YXNTlthVjLRSfTP1H7iAnvdNys+EuZfSobf3Mjni4aTPQ
         NbtBHqon1vXAFcs2EvGXNusbeVseIqjAOTTb43NDafkxfKaaPRfb1uwBEvMf0hDJ/cE6
         76k6aq6PB1jQmPOpt8UEfAnvyeAt8dDoFfc0LTMv0eoperJOkfhUeiZwFBdLh1xFAzO2
         fNXhJEg6hzJN8mPT3VU0RMzfl+hFG+b4+XW0p3f564/lUUBrjD9bj1IBDZYE+Hxl9sZz
         ZwnXQKlI4ACLXNpr9fniEglWfF5U6girx/aOaP4Stopm5/OM1TgmvDHdBuUXA6y9APT1
         t9MA==
X-Gm-Message-State: AOJu0YxnQKPRP8ZNT0HOsOuXP/qUOnLB4oz4yE0NnZaoL4AWP83olacr
	BSp/u6Y0rfQGpaY5dCpbZ0SHi87ESixrE26gxgTXcxJkOg6laveKMQqOMfqZ
X-Google-Smtp-Source: AGHT+IGASKZAY3UBC74dtuXfGGQovnvjbuMBYZkXYjnrVoBDB3veglCI+FAGbl48v0cLj5/W4bavIA==
X-Received: by 2002:a05:6808:23ca:b0:3c1:ae6f:e2dc with SMTP id bq10-20020a05680823ca00b003c1ae6fe2dcmr12294647oib.12.1709584510951;
        Mon, 04 Mar 2024 12:35:10 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2101000000b003c0408e5b06sm1642582oiz.55.2024.03.04.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:35:10 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/5] qmimodem: Remove glib use from util.[ch]
Date: Mon,  4 Mar 2024 14:34:53 -0600
Message-ID: <20240304203506.1725220-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304203506.1725220-1-denkenz@gmail.com>
References: <20240304203506.1725220-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glib use is retained by sim and sim-legacy drivers since these drivers
utilize sim related utilities that have not yet been ported to ell.
Also, sim driver uses a single glib timeout source
---
 drivers/qmimodem/sim-legacy.c | 2 ++
 drivers/qmimodem/sim.c        | 2 ++
 drivers/qmimodem/util.h       | 3 +--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index e9ed0a9ec4c1..fd05f219ea52 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -30,6 +30,8 @@
 #include <ofono/modem.h>
 #include <ofono/sim.h>
 
+#include <glib.h>
+
 #include "qmi.h"
 #include "dms.h"
 #include "util.h"
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 110af6686627..8605e03c6f4f 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -29,6 +29,8 @@
 #include <ofono/modem.h>
 #include <ofono/sim.h>
 
+#include <glib.h>
+
 #include "qmi.h"
 #include "dms.h"
 #include "uim.h"
diff --git a/drivers/qmimodem/util.h b/drivers/qmimodem/util.h
index 68bc93837c71..8c0c3c3c76ce 100644
--- a/drivers/qmimodem/util.h
+++ b/drivers/qmimodem/util.h
@@ -19,7 +19,6 @@
  *
  */
 
-#include <glib.h>
 #include <ell/ell.h>
 
 struct cb_data {
@@ -48,7 +47,7 @@ static inline struct cb_data *cb_data_ref(struct cb_data *cbd)
 	return cbd;
 }
 
-static inline void cb_data_unref(gpointer user_data)
+static inline void cb_data_unref(void *user_data)
 {
 	struct cb_data *cbd = user_data;
 
-- 
2.43.0


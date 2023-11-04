Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD75846B
	for <ofono@lists.linux.dev>; Sat,  4 Nov 2023 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahoBHyHm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso22884395e9.0
        for <ofono@lists.linux.dev>; Sat, 04 Nov 2023 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699088028; x=1699692828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rblkpQf+z0d5w3G2Ti4Kzz0mMi4rd9LTabbnZfNRhyk=;
        b=ahoBHyHmOdi6R7KfLo8GmGG4LTegKZrm2RGwfMbJtG7gcdiyhEJQxiIAYo8rYb+CGu
         pSNg/Pj2cbh+AbsWuAtbcFXnty3vbxzv0/OKvhEWNJ7yKjVfqHWnpf/4seOO0C9xg5HG
         /3HLLosgsfPG/mrDaOvQTn06mkR6Ax0bvsfzEVdx5hU4JDAqk87i9pR7AANe/HKOPKZG
         hFA0a1gDgTbQIxxqUBedVfDIo30chYevxK7/4RDXysAgm+7E8XgjTcyh5rNS+lFYv/O3
         Myvw3P6aZ8mEclsZw2zVKSaK5ViRlb3P8EiJ5ARpUwoTd0Jse33IBxa6XAPFj3k7l1kX
         2MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699088028; x=1699692828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rblkpQf+z0d5w3G2Ti4Kzz0mMi4rd9LTabbnZfNRhyk=;
        b=vZ98GtmlhrP0Q4a6qEa7tesms3jSxRHtoyVYeCJ4IZsL91dLt6hACD1KV0feHlV+uj
         j5J96Zk7iHvNnAU/x/DrB0RCJSS1B4HZAS+IPMsTxbiOYm8dKTqTIHrmV0zA1UkjL4ij
         GtyIMal9CtvJrR/Pao5Vfor+OoN77MYbzfPJO/mUSLiPYoPHvYqFz+eE0+rIqHwgFmSO
         AT37Fd8NLRt6igV8r7e0MqFsp1j5Gztd49baXUEsPpep/kxuKorqi/Tn27gFBIk+PX7l
         60JuD/5wf6Oz1Z3px4Y4nKlqkfmx+KEIZPAeMKbsCvm/jvCizoMRQ6qfbluR+dTIMBMH
         G25g==
X-Gm-Message-State: AOJu0YxAV+WLTuieec9pZP9Tjqz8+NQFv5hBhiCSOkvf0xs+K2I2xrSn
	7UzbPZ4IDZ+8NWzoNzT11+X1QbJY5N1l5A==
X-Google-Smtp-Source: AGHT+IE//yZj1R/vB4sj3Pz8j9/iLBx4ccvsAmx0RWhnmgZdvrgSM1SE6X7Pljjxs9l+S0rdnncQHA==
X-Received: by 2002:a05:600c:3103:b0:407:3e94:bcca with SMTP id g3-20020a05600c310300b004073e94bccamr5859863wmo.1.1699088027641;
        Sat, 04 Nov 2023 01:53:47 -0700 (PDT)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b004060f0a0fd5sm5096291wms.13.2023.11.04.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 01:53:47 -0700 (PDT)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] gisi: switch to musl-safe character conversion
Date: Sat,  4 Nov 2023 10:53:05 +0200
Message-ID: <20231104085306.2834870-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support isimodem (gisi) use on musl libc systems by dropping the use
of the iconv TRANSLIT extension when converting from UCS2 to UTF-8 [1]

[1] https://wiki.musl-libc.org/functional-differences-from-glibc.html#iconv
---
 gisi/iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gisi/iter.c b/gisi/iter.c
index 3cc1ae37..74f1c44f 100644
--- a/gisi/iter.c
+++ b/gisi/iter.c
@@ -27,6 +27,7 @@
 #include <string.h>
 #include <glib.h>
 #include <arpa/inet.h>
+#include <ell/ell.h>
 
 #include "iter.h"
 
@@ -257,8 +258,7 @@ gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
 	if (ucs2 + len > iter->end)
 		return FALSE;
 
-	*utf8 = g_convert((const char *) ucs2, len, "UTF-8//TRANSLIT",
-				"UCS-2BE", NULL, NULL, NULL);
+	*utf8 = l_utf8_from_ucs2be((const char *) ucs2, len);
 	return *utf8 != NULL;
 }
 
-- 
2.42.0


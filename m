Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305E38DEF
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WymrU4M6"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b7fdf6e7c1so8778839f.1
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011284; x=1703616084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flYcAywdIwkqY6MNDT407112OOjiHDSQCFW8opnWmpI=;
        b=WymrU4M6nhsr/UEFlX3SvcYapiYVLrfDtAEj4hal4bNxwuxhqPDLeZlDb4ktG4Yq34
         Zh3PDiIrAVS3QEboxhg784zfg6XzI/jBjasx9LF2fr6DgTfDqrpWkeiM2xiLR9W+oOQK
         u7BV280cyVqQ8tqR5G8zeUv20PXv0AOxxjRNOhiAyGc31LVZkavc1ZTl7Z7kyD1h/aqI
         Ugmle9OKnRaKFgwoi9zB1qqyrZooDjx74b+SxMZg6UduYqPQ8gMHuc7VUwPlp3stARR+
         wrVyy6yvmPBO/hAL3J3w38DC2tfRqObGdk6RSXOt6nCpyQ5k2qVUFwk2xH4tF81mdYpz
         adiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011284; x=1703616084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flYcAywdIwkqY6MNDT407112OOjiHDSQCFW8opnWmpI=;
        b=OUScMdwpX3Ou31/rBDG+n8bCN32TT2Fo4egw5imvw48ICyZpF6ydWeJBpcvUQO4VkR
         4MUIyZFuji/0Gll0nlr5qSYGOeLR7QBH+eZ8vXhPLcYlxEh9XxZtXFy70ZyFIvkcfJTV
         y4K6uNxA0NxmRL5BeQek2golSejGnwl81jT+RXyM/3bI2ywWnS/NOwwpBbeo+5RfGInO
         0isuem5jC3CF6p1w8t2LxN27UZWm96zJtgWw6SbU09H9cPhygJE75jXNeLcu7W0ls4GF
         N+wBDJ0DNdxuYmFxBeF7bVXqazlavm6jx38xmrfQkjjo5ma3J61b9p9lNobiRt9Sa2i1
         7d4w==
X-Gm-Message-State: AOJu0YxWpkqgC+0BRowx4WWPvHlFm92IiQaxEAfoV9nnHbFBC/oNXgjT
	bqFLOVEDNddM1+z0G+4pZqXTWatP9SE=
X-Google-Smtp-Source: AGHT+IHtK4TQ+zhyKVcVoyNjj8FWU4GCXWhdt2p+kWHSdIRquiPOfHYrEReInY7nCAj5ygq5uO60vA==
X-Received: by 2002:a6b:a16:0:b0:7b7:cd8:7a6c with SMTP id z22-20020a6b0a16000000b007b70cd87a6cmr19505150ioi.35.1703011284043;
        Tue, 19 Dec 2023 10:41:24 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:23 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 15/15] provision: Detect duplicates
Date: Tue, 19 Dec 2023 12:37:12 -0600
Message-ID: <20231219184016.420116-15-denkenz@gmail.com>
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

Duplicate contexts can't really be handled without user intervention, in
which case it is better to fail provisioning entirely.  Most vendors
will choose to ship a custom provisioning database to ensure that
duplicate contexts do not happen for the supported operators.
---
 src/provision.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/provision.c b/src/provision.c
index e419d15c..cd5cf569 100644
--- a/src/provision.c
+++ b/src/provision.c
@@ -25,6 +25,7 @@ bool __ofono_provision_get_settings(const char *mcc,
 	struct ofono_gprs_provision_data *contexts;
 	int r;
 	size_t i;
+	uint32_t type;
 
 	if (mcc == NULL || strlen(mcc) == 0 || mnc == NULL || strlen(mnc) == 0)
 		return false;
@@ -47,6 +48,20 @@ bool __ofono_provision_get_settings(const char *mcc,
 					ap->message_center);
 	}
 
+	/* Make sure there are no duplicates */
+	for (i = 0, type = 0; i < n_contexts; i++) {
+		struct ofono_gprs_provision_data *ap = contexts + i;
+
+		if (type & ap->type) {
+			ofono_warn("Duplicate detected for %s%s, spn: %s",
+					mcc, mnc, spn);
+			l_free(contexts);
+			return false;
+		}
+
+		type |= ap->type;
+	}
+
 	*count = n_contexts;
 	*settings = contexts;
 
-- 
2.43.0


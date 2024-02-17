Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717236A025
	for <ofono@lists.linux.dev>; Sat, 17 Feb 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177679; cv=none; b=IP3mj5Yll9lxoCHe+DbdlSQuxGG5OJZTG9xyW3KcPyxi7++SxIfG2wpSlXFq1RnYAlYLDlaobMhnCPAH4g52rsEyCXJWHipMRO9UY5tFx4np02TRPUGxA+7auHedrye/Ib8rU4avUSe7S9dxupfLX8r0MpePugI8uFug45pWFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177679; c=relaxed/simple;
	bh=FKPYiGqu1J0AGbgboHOOk9GRQbQlOSwWsYjWCtuQZbQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CjDeqmXPRygY5vv3KuZzmyg6AQ7ZnBxD7G5MGSpc09iDAgC+bHsh2ra5vbWApR9Z/Xxvgey3hyp7LgrtjA7zy+ldMIbfmuFg02Bj9pGCq48tgxItDnUnOvii+GVTs3CI4KKfdO+Sej4uswCsf1Cr/vzGGldHgXLgHUuhYoAH55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOuVUr/V; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOuVUr/V"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563cf3087cfso2756842a12.3
        for <ofono@lists.linux.dev>; Sat, 17 Feb 2024 05:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708177676; x=1708782476; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPMBOi7U/3ihoddXo+v0KkDF3LBmONTOrcHe811UuxY=;
        b=QOuVUr/VtpC+AlzUU8xwhi9oLl+for4AFIIsBtoeertVhrkiQpEo9nJAacJYoP4Ofy
         qdklonivABsJQ6vh7b7EzLzRiN/h0LT1wX5EkLKxLFZX9PZRb28uhuhvqS8LIEYl/9di
         EOZrJC+pZpBQvFEAa9AkUK3EzGClU+Xs+bAwv4oleVVwyCB6Vk0ut3pn14pVGN8Nz5JN
         6Mj1V0qHdAhO0ggVYfUWDYojygaBE+0iJQlU2ECLd5v5srF/DQle7X9emg9xvQYSlSEK
         ZoyMOMJdpQyh+E8rcM77gcVaCiLGuO7agWQUN/KODZqGUj4/s1fUpQyhO7ETfwZgWCaX
         t0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177676; x=1708782476;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPMBOi7U/3ihoddXo+v0KkDF3LBmONTOrcHe811UuxY=;
        b=bo6Dq/+0ko18F9l5xo74k0+MmGUZib+PWzIlHGkV8glyh+k2T1RhI0pJFR56KHFwvv
         PGYzh5YDsWrG4NdLV8ftK+FtyOhxJSo+QYNZis8zwWvLh6azs3jwGdy4iu8mrNsjL1Fm
         ceCZGZwpftMkxdwxOFj4iR2t/+Lwfxv6TyWLzIzqE7MGeWMxUcxrD4XAZEl54zQUBRvk
         nGVaNk2ghymMk/zTy0Jsm9QTAPRTaSPgCUandmVCMrPPDvS9vvd5AQ8MZcSLszMKeOw6
         F1Id9YOCmJIr+XYwdJS2n4L363Wlc4Dhj3C58U5oavD1eFRRFacaeW5CSqvkmZGaeEZw
         jNlw==
X-Gm-Message-State: AOJu0Yx6+1gmPZ5GCuuk1WQ6zIdq2Ad/HBFwxcI+C0WjT36D55AGlSoi
	e5RPClsgu5wO9fd7Smyb8PTnGBIK3/1OoxWCJaqDkejwTmzykDC1ISyB4sPJ
X-Google-Smtp-Source: AGHT+IElhEfCiHcRcz4kK59IJsRlT7M1LphqCSmuZPNCU8P5tsnrVmxjbaCZlPAOjBw8kbiksEbvZQ==
X-Received: by 2002:a05:6402:88c:b0:564:6c0:4a67 with SMTP id e12-20020a056402088c00b0056406c04a67mr2485308edy.1.1708177675506;
        Sat, 17 Feb 2024 05:47:55 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id c40-20020a509fab000000b005607f899175sm957330edf.70.2024.02.17.05.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:47:55 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmimodem: call-forwarding: Fix possible buffer overflow
Date: Sat, 17 Feb 2024 15:47:12 +0200
Message-Id: <1708177632-11449-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 drivers/qmimodem/call-forwarding.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index 9c0c45a..5972055 100644
--- a/drivers/qmimodem/call-forwarding.c
+++ b/drivers/qmimodem/call-forwarding.c
@@ -103,7 +103,7 @@ static void query_cb(struct qmi_result *result, void *user_data)
 	 * FIXME - shall we fallback to 0x10 if there is no extended info?
 	 */
 	p = qmi_result_get(result, 0x16, &length);
-	if (p) {
+	if (p && length) {
 		struct ofono_call_forwarding_condition *list;
 		const uint8_t *end = p + length;
 		int i;
-- 
1.9.1


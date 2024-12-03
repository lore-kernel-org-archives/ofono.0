Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7B7E0E8
	for <ofono@lists.linux.dev>; Tue,  3 Dec 2024 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255052; cv=none; b=IR65+wODm/2Le9yVYh3oISeAvjC5Z69JTWlUjiW+0Ku52xGnWUlSwWwsfk6UUcz6nqm+mRJTW6kwKBFyYEqDg9aDw8cO9EzuILNn0H/+f4V8MxjqdVV3vUDBEKITSfc0o0akSbREGa0of7wkwgU3tWSNA5n/D8J3hNlbDkMaqS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255052; c=relaxed/simple;
	bh=ZnK7vKM6zjrX7qiXlOWDfFZ7JGZBfUzisAc9dNlTxwE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lQGytkTDVE9bBQ9Ul78466aShYyrifnmZ5VgVS42zlnJ42knessh4EFsaVNgeE97tTtXM/rzIYzu2FQGCN06Zwngr+0UxElzBqrAYZUVJqN/hwS6Ufl/qaWqg3kNuj7/8q1DQm8sv/SwvJaI4BYPgKmhhlL3peiho0nVycdYwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeTi3kKR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeTi3kKR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a742481aso48923285e9.3
        for <ofono@lists.linux.dev>; Tue, 03 Dec 2024 11:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255049; x=1733859849; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNB247370OIrls+RAYczpbDPvqzyokPSj12SRkMxsUg=;
        b=jeTi3kKRtYd0dX5f/Z+FsPCIYgEyfMpU8dOvzeF8rEdmIuJFhs08ZnuWQ+D0ZweLjy
         sPI8eysH8ZFNs8+Bxy4qUWpxV9LjoGLH4kXh+3rdDoJvoJDA6zezymWZErnyb6Y9aQnn
         LhLdXkYi8S3Zc8hADhi2jO8tGnbMyoE0/LKOBoCP+LOJ8nW6PcBDX30gw/XlWy8HJBFF
         UCOSQKppQIsIJ927B92x7nnVVvnMTz/HTWHH9ZDH7qSGpYjSuPQ9LiiUb8hXprAXJPoL
         xkIfW2nz3gItPOKZScoKcgxDDRsFfy8bxgp3um9RGLYcBkm9Jseh1pRQUdUauScv04oF
         8B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255049; x=1733859849;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNB247370OIrls+RAYczpbDPvqzyokPSj12SRkMxsUg=;
        b=HLln0mFwAEEscfmm1aKwXcoTJITTM8NSQspThZG26thDkJoFHd2wDvVH29CogUVqSM
         OtwUrr+vQsYmJR7Z+sbNMK98IfY5UA5iE3gEzvJx38DZzOs2KIktbk2BN1oEemJRueYj
         zc5+Pw1dzGjLYTqQwekCETO2Ghe/F6jPQNyEnUwt2ARu/J/BXK+8tML32q1doSwAF9eg
         slL/RtFKLZ4kFYen7D86m2TeGN8iaz4BFieQiSY23H9RWdjVgHU9x+S9nHzbluP6k/Oi
         4OO6AnXqwMSTutkxwrz1TXkqqqj/vWy0TadBVcHt4YcWGKfHbkWT9CXu3EqfHTmN95rW
         +o6w==
X-Gm-Message-State: AOJu0YwvsZvB/SBF7Fce7sbJ/6yd3w9pnL5fc89dfRpU3aooojqD2LEF
	l2L6bzLMYsVMcS1QCK+Bw6iS/SY46aPWVh8//bn8teA0ksB3ZEDVC6w+Vg==
X-Gm-Gg: ASbGncssaVgJpaTmQPklDt5SA3gH6ySyyLEGz9e/EYs/NZkGJclnHBuQHHWpHnuyKpQ
	HUbW5CmVY80i/6ZiyyENDo3dtXlm8QUnk2MqcESxTQb3IJfUdjbDpVQpZdcS9X6rgvQbwdLDPK2
	IUPIPE4LrWvuj/QYDh4pey1VlE+N++Bg90AidNQ1O2QcAAZjDxl8V76JapEqv1wfFRimG7YsBqR
	EyUqhOqhrFFrH1eLLG3MXCAwi7WaZ5K64KxaXOVpWk0OmDG65OaDgzFz+vxo5YAThWgIEpq
X-Google-Smtp-Source: AGHT+IH8T/l3tXvZ/6zNzqJZTO0twMFRZ3h1j1OdMBcuQd2kGbpYUCuuHD9RTwNYoPgCWWIDg0GVqg==
X-Received: by 2002:a05:600c:a4b:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-434d09a8c9bmr35053685e9.5.1733255048901;
        Tue, 03 Dec 2024 11:44:08 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bec1sm204553455e9.5.2024.12.03.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 11:44:08 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/4] stkutil: Fix CVE-2024-7544
Date: Tue,  3 Dec 2024 21:43:49 +0200
Message-Id: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 src/stkutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/stkutil.c b/src/stkutil.c
index 60cad102..066731c9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1880,6 +1880,10 @@ static bool parse_dataobj_mms_id(struct comprehension_tlv_iter *iter,
 
 	data = comprehension_tlv_iter_get_data(iter);
 	mi->len = len;
+
+	if (len > sizeof(mi->id))
+		return false;
+
 	memcpy(mi->id, data, len);
 
 	return true;
-- 
2.17.1


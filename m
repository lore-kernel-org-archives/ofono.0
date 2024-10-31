Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEB1CCEFE
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412409; cv=none; b=dwNzPkAs3Y6EsZ1I4QITuES8q903vwe/s0Ke4Pe0rN6FWAZj9L9dC1fow98c6l0U+dbBXcJVuYHAGl5j/MOYuEyaFcZxyaCUDv4J8lVCZRRE7QNAIK2f8GKVcSNIirg7Ab2XwnJ/HKb2Yafob7nUbf3IDmi2+iiQ4zJC/OkwNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412409; c=relaxed/simple;
	bh=KFXbQSNdIlyeuLbwZ5Oqf3Cb/uQ8X15h2jAUglUp4vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRJEm6GkTb9dAWbWWd/tL+hZ5rDNI4pJn3ySLft1FokDNFloiw8VO0iJixH6mmWjguwDSZdqNFaQ1n0RjD0phOfPUqVYHuleYCo91gYr/EqedG4hPsIn7qxp3gU9/SIvWzb0ak8Yu8y5hfnZZmcPqh4K3cb0LWPVJGGZTltEUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbq/yYQi; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbq/yYQi"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71808b6246bso776409a34.2
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412403; x=1731017203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH7lAQDrcwy8/92b+wCUWPt52cL7l1PwGJU01s+beHI=;
        b=Sbq/yYQi7nfaIcAK9JNlxMIK0Nn2zLZ3Q58Hbboi0SmMkRW1UY/PHuAlf4xhnQrdgA
         47LIAmf7I1RqnEP5dQmnGrlHOBa/+VkhZHO6D8h4lQ6KsZSuiO8W466zWFzT7J00iUXa
         eVE0/l1QWTVAkAUj6BeLcS1eIfMhVfxeArGrwaLTFYGSUGB2nsYcckW8D+NocFyQ8Ujp
         QfbP1Q3UN7i5fVOvVnIz6fPDaYrw5cXSeLxCufYSL1P+WROqi6Jl+xjw1HhSyZNpRZEn
         hTTQ//lqXQk1evhjjlszR4DLRHiBhj6UScJTV9AtzZC7Oim0yEjREzkj4qhIjKsgWe3/
         jwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412403; x=1731017203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH7lAQDrcwy8/92b+wCUWPt52cL7l1PwGJU01s+beHI=;
        b=ZX1ETp3/tjg6dr8kXE25Ac14evZN0gbxdnOJ8zu9AbMkTDSQBx2euUpHBQ9Em5MnSj
         DtrRDWO5jBuCY8hxFEqUxrQh5Ous0+Id9ucWQpUiOyn/y+BmnLgXAaTwiQysKv68iGNS
         d1cDh589qS1hqlHZ6HYK1yN4JB5VvBKnW0aEIN7D2bK4wBvIlD147cjbG8H1FJd6z2KV
         5VLUkiWjNRCwpp4iS15gMa8tV9wdUV5Bnn0Pp6Aoo8dS9BypqJcWemIYTq90qocTyyWP
         v2EOVjc5/uW9k993YY2lbIpE0BVxALaP0rMzyMgyBQCVNxnGi3oPIlnTNVUqil9eoKql
         5fcQ==
X-Gm-Message-State: AOJu0YxI+Q6Gk209TW8uxImqQ8GBUvnoKNYzK6I6CCtWpCCbITHcH6PD
	49cePVZbNEilZz3rBQYjidVAW6l0ssxbhvCAtlT9hw0Y8pXCfl8so5Nkqg==
X-Google-Smtp-Source: AGHT+IEtW4CviWZkyBphyXYIFS1S6Sis36ARQf+qqEyWFs8c9XznG5DNNj77ryAnVr/0fClj6TBODw==
X-Received: by 2002:a05:6830:2682:b0:716:a8a7:fdd6 with SMTP id 46e09a7af769-719ca1c9d01mr1602988a34.18.1730412402924;
        Thu, 31 Oct 2024 15:06:42 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:42 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/13] radio-settings: quiet sanitizer runtime error
Date: Thu, 31 Oct 2024 17:06:12 -0500
Message-ID: <20241031220638.1582166-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

src/radio-settings.c:241:17: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
---
 src/radio-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 1b56cad0a32a..588a355d4e40 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -238,7 +238,7 @@ static DBusMessage *radio_get_properties_reply(DBusMessage *msg,
 		unsigned int i;
 
 		for (i = 0; i < sizeof(uint32_t) * CHAR_BIT; i++) {
-			int tech = 1 << i;
+			unsigned int tech = 1U << i;
 
 			if (!(rs->available_rats & tech))
 				continue;
-- 
2.45.2


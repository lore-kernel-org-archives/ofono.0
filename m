Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF17E0E8
	for <ofono@lists.linux.dev>; Tue,  3 Dec 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255056; cv=none; b=Y+uzbHP8+/ejDqxd0j452PpilODr1t42Y9pA+tAWOTqMV308VBSSNZ+lcvY4V4Ux4Ix0BcLYNNbI7Ne/gHCSA50t8yX/ezIhixBO2OfGLiLG49fHmvV6I+PftumRN1yhjeQQaYNTbxYMLJYKsmOSBnVx78MMXb9YwBpFRZIwYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255056; c=relaxed/simple;
	bh=XLD/g7suYDzpnYPkyW55CWTuVZhCs6M5pQZXfguchXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cTsHaEsNYRPLiFPYpsYwriEf2tFzS3V+0h3B6/Bb6Wp66Jfg298rjUmXtoeDb5hLubq38hIlH/JyXm6bJ1XA2UFCjYm9K0CStBULE5qXmSE0j25Jk4eBMhmHjttdEWu0xqvGcGwOKk7P3nkTZs8AUpRH/vxZOCQIt4daFglxIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQKh38hn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQKh38hn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a95095efso960575e9.0
        for <ofono@lists.linux.dev>; Tue, 03 Dec 2024 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255052; x=1733859852; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7wt+QYlNJJG7LkFNwKEw37fJ2gKHhGefNaET86epVg=;
        b=TQKh38hnthN+x+vKuZUBgCfhgPQezFwgS5UqX4v0tO/17OXcdE8sL3y7i7bMOxzsIQ
         D49Wqt7u8keL0VWsrGz84CAM4sOXyp6M2D0LuxzqRFGlIMBXTUhbPOAZ/Z4EaMIZli+z
         lT9NLlXEcQ5PykJqvNPbaIb0tXaz7J1LvNMqo51Gy7g0P3/iL8tGNWNZiGjplHgmM71F
         eMfkPQYcit4oVopVtEes7ki7YsoBOeY2prQgLgbWuJPIJ46haclVdR8/T8IpwAjrbpNZ
         ItrxOyR829SXj3VGDSi8DCnKXww6TR3lU5r9BdtTJTuA7jefatQLUl3glQQmn7rLuUUO
         uq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255052; x=1733859852;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7wt+QYlNJJG7LkFNwKEw37fJ2gKHhGefNaET86epVg=;
        b=O3/hsz4O3hZ77Euzyb+NuOyrHVOTWz3rmAeNak4ww/bGXMQe4WxEAJrYmbpQxy9/mb
         BKVnK9+lXibpul50Lp8nUyFEoOtUARFfTADpelYuPqBhkPkBqAZGBEu8gruRlljNjQYE
         dRjTVFJz4FjxWHt4b87/o1B5J9c28HjG2TVbuvolBRnuy+SAbh35aWBw/AHPfzzZjBOi
         igF4KkSGW8I+akbRkJNh6CBjxZ5+1lkJo5oFwWUc5nemr/PJ5a1vqXNq3Y84qonc00L7
         FRJkz6UdAaGm6lxhjLJLeuGAPY1y96ZojUsUv+I53c9ZTsWtQhgoNL+2dEfFzqlgVl+u
         mw6g==
X-Gm-Message-State: AOJu0Yx9E9BbOLbB1xLhPnv0iA1tsAj+tvVR2LjQQpPh80B5WyvElPFQ
	3VxvEbimiNptDhfn1I+tBni1QIXV6YpVEmqNHY27SrjsG0+sgg2h7ybqWw==
X-Gm-Gg: ASbGnct/YYx5ph7DU6R+Js5D1RK+T/g5kLpHeoMA9dUyJEtZjKAY4+j+DRyysoMTZ+6
	D3rQMXsNrewlokTCHm+9RK9mUs4ErQFd/6ykYDmwYzR/iST5BSm87kn2p6ahvYA+zVa/8X9egy8
	5ReXtFKBq9gtVXjXI34GX0jdg12fhmbHpydxHVDdMFl0Kw/LZlTLyWSvxprstf7plvgq47q4jOr
	Y9YWItjmPf29x9RhICprkDbqitw3H83H+/pqUjmWyNBJmD8/xxfT0wOsFxyzLj13pr1mxs5
X-Google-Smtp-Source: AGHT+IHjUdjlMP36T785uVfd7XYsl9O29TDx6s1nXn0poD6T/47mg0I0VMaoz1m/R4i961aA3IBGGw==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr207201675e9.8.1733255052482;
        Tue, 03 Dec 2024 11:44:12 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bec1sm204553455e9.5.2024.12.03.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 11:44:12 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/4] stkutil: Fix CVE-2024-7543
Date: Tue,  3 Dec 2024 21:43:50 +0200
Message-Id: <20241203194352.25514-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
References: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 src/stkutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/stkutil.c b/src/stkutil.c
index 066731c9..b6d4b537 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1862,6 +1862,10 @@ static bool parse_dataobj_mms_reference(struct comprehension_tlv_iter *iter,
 
 	data = comprehension_tlv_iter_get_data(iter);
 	mr->len = len;
+
+	if (len > sizeof(mr->ref))
+		return false;
+
 	memcpy(mr->ref, data, len);
 
 	return true;
-- 
2.17.1


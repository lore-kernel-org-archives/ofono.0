Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85488592F
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914501; cv=none; b=Jcjk7n2rslav8CYqkEqkc9RJqbHeFbN8V2BOqzigzKuTETd596bVjW3Ih7w0H1vkR3p9yjtQENhELYgxeqpROJKs5EfTiJPfQhpNJeAN0C+N2g6gYamrT7NH9ZXtvTq47D25ZB5GnEgoapB4zWD7mQXAWSxcHC33B7V3UIhFV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914501; c=relaxed/simple;
	bh=40HRVDw1RTKi4soStL55YwXnBGZc0jxZnzuvjOlhIUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixjdb9YkWVSC7dJ68MLpvh3IPPE/Qsi340aYA0h1n9mCZ3OC7SZCWOFx+12Hd+tZH2Z396/QPeHrcB8tmJlZaCHN9T/O5EhXDmJ5qlE2Z01mknN6yfNQOlBXaU/QPZ9z3HcYSWK5E46+63yGO3niPSNnA0vo4n+PlwQo6sXn4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgOafrvn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgOafrvn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e118da997cso1354034a34.3
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914499; x=1707519299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WEpQGXsL5Z7LPeMPtMuaTVdpXfGJCDv4AbBy0SUiyY=;
        b=LgOafrvneOmHEKygiH6bqSa4Pj1I0680mpNrOMkCqHRKyxSiEn6uGARXrXe1V82f00
         a3WfWBtztMTE6wy8fXi09133DljhNiHed8o76XkvAQwu7ZWDHp7RgpGnlW0Bwp3KCUPc
         OoOOgUfac191Qf9v1lqWQUDqF4T4iRUYU0eciLfgeWdymqFEUultuo50ys/5rE2mwc3G
         6r/CUlsmBfMUefWl9EbCsqH9ayip372vWKKwgdtg7IfML2kgxZhAjfxuurd90yh5p2Uo
         oCN6jHTUiC2oEWzExKqMf1gfYHk3B9GQG4O5fQeOKvrZlPbTq1O7a25wXHHrTmaGa9EV
         CzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914499; x=1707519299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WEpQGXsL5Z7LPeMPtMuaTVdpXfGJCDv4AbBy0SUiyY=;
        b=LoVIPqW1aWDwm0GECKfNYtsLd79zDur5MAoI9PcLEEWe1tiU3WHVitlSH40TZ4zYFE
         EYTaArLACzW/pbOIHX09+o9+ct/la6I9AE1WYZzXKjj2nA2WJ9HtSA6ZKt/7t9SxkEaQ
         kpTqiiOUHcKx+Lk9YlVldUCKGPRXpJhrSPV1KkPnGRlHpjyPeRyDFqrh07cy/viJNxQg
         q1pT6mrv7CiXaaJiEekgc6D8o2vBHY5UET+jXfdEVs7l3zGWV43OA/W/CVuZ+/S2bUVt
         MxTIhAGVJ1viA+4kYkM1zsXrVVZScZefur5tE4LRm/WHfBo6+UzT+mMlMab1LYsHKlyq
         PBlA==
X-Gm-Message-State: AOJu0YyophuH6na6Le/B8aBVebV+E/nhs0OuUdeRMyw7cPZdnzEEIcBq
	n9aKaDpuRytJxdxN3fSglNnreg3ITsF/HvGQGOF9SNKTGFEohWuaCtj5C+SM
X-Google-Smtp-Source: AGHT+IGeJVlZy7/WZqglBg3N2yE6CNg9TkoxV/eOo5lkgiYTxHG6R5NUmMwjG3Ww9oqhmox9Pi9ciA==
X-Received: by 2002:a9d:4f0b:0:b0:6dd:eebc:da3f with SMTP id d11-20020a9d4f0b000000b006ddeebcda3fmr3426588otl.23.1706914498871;
        Fri, 02 Feb 2024 14:54:58 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:58 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/18] storage: Convert g_strdup_* use to l_strdup_*
Date: Fri,  2 Feb 2024 16:53:39 -0600
Message-ID: <20240202225405.993792-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/storage.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index c7bbb1c6142a..2313835a49ce 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -93,12 +93,12 @@ ssize_t read_file(unsigned char *buffer, size_t len,
 	int fd;
 
 	va_start(ap, path_fmt);
-	path = g_strdup_vprintf(path_fmt, ap);
+	path = l_strdup_vprintf(path_fmt, ap);
 	va_end(ap);
 
 	fd = L_TFR(open(path, O_RDONLY));
 
-	g_free(path);
+	l_free(path);
 
 	if (fd == -1)
 		return -1;
@@ -129,10 +129,10 @@ ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
 	int fd;
 
 	va_start(ap, path_fmt);
-	path = g_strdup_vprintf(path_fmt, ap);
+	path = l_strdup_vprintf(path_fmt, ap);
 	va_end(ap);
 
-	tmp_path = g_strdup_printf("%s.XXXXXX.tmp", path);
+	tmp_path = l_strdup_printf("%s.XXXXXX.tmp", path);
 
 	r = -1;
 	if (create_dirs(path, mode | S_IXUSR) != 0)
@@ -166,8 +166,8 @@ error_write:
 	unlink(tmp_path);
 error_mkstemp_full:
 error_create_dirs:
-	g_free(tmp_path);
-	g_free(path);
+	l_free(tmp_path);
+	l_free(path);
 	return r;
 }
 
-- 
2.43.0


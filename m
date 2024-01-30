Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E3762EE
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649750; cv=none; b=LFSbUOgUUp/0tOzel2b4bqxK64wamNzOfX08rNi0afkb0uYY1pcO/QglK9c7FaHTIm1HASWh0NionTWoVtzOei2bX2EmAF8rHSZtZEWC/RjFOHWPX8F0L5KVYg1bxfoQQeAaJ09YaxELtaBh/a7DwRjCIE1BOzqGx5+5uqEh1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649750; c=relaxed/simple;
	bh=40HRVDw1RTKi4soStL55YwXnBGZc0jxZnzuvjOlhIUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJQD51t0IGejebjn4nKzAJimS7nCjPJPTRYHjDGKCQjy0jPAk35dYQHr/ebUX7CH5qtQD3Mzcm73j7hoi3f5bk7Bju12y6i3euWAccDAtkIGwhDFakkylDtUj1faqJtAwW0z+U5QYhISf8r1o/Tc+MKTeN6Z6pOQeGgonAa9VR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwi14a6A; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwi14a6A"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204f50f305cso3182740fac.3
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649748; x=1707254548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WEpQGXsL5Z7LPeMPtMuaTVdpXfGJCDv4AbBy0SUiyY=;
        b=Cwi14a6AcyjjxOQm9Z8z3bQRlfCE1Db8rRJvAuKwnR7zFjVROi6mzgtsXcB2nDyC5e
         XxPV4mAOjJDkbqCI1pA207rxNZOWfl/a7Y6mq167IornLen/lC2pweTGn6FM88mbA9//
         Fajbnyaqa/+r02cM5g4DOFEXqkJtico6n70zLxj27IhmR8C2gnxskpNFcDvipNN822I5
         ze0GFeW4ohlpDC3IOopR6kmFR7Lt83SD5YneC1b60mB6roKe+t+RaYesY+8vAEB950xN
         cCSchGvdiFp8PqaULOD6JAU66U3l2jxtwLRXHRfsGZxm7fstkw08QlPef9Ykm/8f2AK/
         Chqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649748; x=1707254548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WEpQGXsL5Z7LPeMPtMuaTVdpXfGJCDv4AbBy0SUiyY=;
        b=o7o6yjv0JqwP2+Rqpi/UhPrCREDwJjuK6zVdHHu8pyoRyrr84BIMSvGla2v10Xa0eX
         gq8jDvqYsBSQGZ/UnXK12dT/qcl15Hr21GJVKB8oQlfjypVKqnfO8s+3h0g75TyHTAUw
         PsjvpQCKv3t/iPEoy1yDuVhjY5IsUkpPKLut/ocKmTbbRkwh5QA3hsH7twBYcxdOvlJx
         bZ0nMTWUf8wzQ40BdAc47LD9/h26fgGhCnMr919vFko0mVeBplkUeTR7elLxsgUvmnUc
         Dgg36yKW/IMZ0JGWKp4ZUK+uKlbxkILdBRkRAKhzXT+8OtuKBIrBZznNzMyVxzecE+YJ
         1FQg==
X-Gm-Message-State: AOJu0YyELKRj6gqbCEGxEnhBO2VMki89oiQob0Qu78LCPv/uW4aE4+Fw
	f5JeF3klqYF98okfOhcVUyWh/v26MdoYyzXYqCZgi9b/rS2NkMdMBdXQ8sWJ
X-Google-Smtp-Source: AGHT+IEinxFgZ8ZiLsTcB4sVf0rCVSdALAS1j/zRj8zgsi2gDhmS0PO4flfpKSj7lxpH4d/emMzsPA==
X-Received: by 2002:a05:6871:b191:b0:218:55c9:bb20 with SMTP id an17-20020a056871b19100b0021855c9bb20mr438562oac.21.1706649748321;
        Tue, 30 Jan 2024 13:22:28 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:28 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/17] storage: Convert g_strdup_* use to l_strdup_*
Date: Tue, 30 Jan 2024 15:21:11 -0600
Message-ID: <20240130212137.814082-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
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


Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961278B55
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649753; cv=none; b=ig/kUPFBaZjlpAvrA568ogkfnrvfvOZEgr3ALgS9q9i6Grn9MUSu+DPYg4kvxwB1PrgQM3Zj2pgCAHlrk39Y2VlyOJ6n9Y4W4z4GUHYg3S7F8p0RAOIUOIYMnVAeoIMHNHMQYvL0o5xExFVcnNPlzh/3edCv3JoSL+Ng6B7L7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649753; c=relaxed/simple;
	bh=6yxi50K1Wx9rlrL0qY8bOPY+9mfiHds5hJg8RRkZ7LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5tH7iUovQ4WYINuLSJmv2SeeSKecUr3jKmbZRGLbWAHHezr9MiiCySkZd1ti+h7YozYvyulzRpjTMP1b3Bl0feAa/zpA62cBXXcPN4619iqsHnENHbSieDeL8076pMag00WVxgadECTikd/6iUWRk/VBcLVtX6dMyPHtNFoaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYw5NyIm; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYw5NyIm"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-214410e969cso120752fac.0
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649751; x=1707254551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MgbNqvldYRKRfhzhD0Oj6pcvP1XJSeq4OjuQVjxM90=;
        b=LYw5NyImeDnvimmoD6Xf/Y9UEQxJU1a4lq13WyYo8F7lyo6ZGsKAxEaNtql6IVt3eX
         crW8qCK7f77fmKJCuVuN9RT6zkzRxD4xkIBFsG+npkMTRwO0+QiTUIUN2KXCPsxLNkRT
         fYpG1tqArKvNC2Pkrwz8rfBqsDCdxDfD4LBmFMde5OT3MAN0GWaIjuw7d4BZmYS1+6Vc
         Rvv+FEsJg1Su8ogPOQd0QLyXsmOBtH9hUFvAzPfSMgxljhYLecv6bT9OQztwhH7wwd5u
         tkTJFpU+PpFQpy/SXr5WhpGx7rjnQ2+MO0IXY+xyMipK1jokq1z3VjxnxFbT0QkMt8/d
         sx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649751; x=1707254551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MgbNqvldYRKRfhzhD0Oj6pcvP1XJSeq4OjuQVjxM90=;
        b=sLmRi2MN570dNST5Fjvq1D3tMgxHi2yyPHeNWx8lxHbMH65Jdb+w0Ig4DFlC5O8FIS
         +haVwTAqidL4DWBTzN0fXq8KgLRds9MYpQpJkq3S+nU4006HRsRwTr6sa2Kx9M4zal2T
         0eHxsx8tYSgk9gdzWRbXbOuOupYRK9ydsYbd1qs/yEMp9zuHDkv+T90afhQULyeAix+I
         +CEbZ5mITHCYR3P6PoJMzZuGuoz1Y1DymbjC7tYo5juOLst6FH/N/t/0TvMNnwxzkk3C
         iF3M5qZVvhKlkgV1gG6VLAu+PRGb4PZ8I7QdoC3ztn5chq3RoPjmfEXTKZ0LnUAN3Jq9
         1u7A==
X-Gm-Message-State: AOJu0YxBKZ8lykLn60JHkhe7OxzavQsucWYzTPpRLN6Qz+9JVaHxfVii
	EoaWeZ6gbuQirjTtBKbhM70iPo3WwXWPe4iB/rfg7REWB3uxfQSy06kgwgbp
X-Google-Smtp-Source: AGHT+IH+KhA2toHMxZmRDCP52ELi62Dwghed5OQr10bAPDwnGeyL6XSNiabi/AnEK58/Jbl9MZ5NTQ==
X-Received: by 2002:a05:6870:8197:b0:210:c514:2303 with SMTP id k23-20020a056870819700b00210c5142303mr871185oae.31.1706649751175;
        Tue, 30 Jan 2024 13:22:31 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:30 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/17] storage: Use l_malloc
Date: Tue, 30 Jan 2024 15:21:15 -0600
Message-ID: <20240130212137.814082-10-denkenz@gmail.com>
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

Instead of g_try_malloc
---
 src/storage.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 89c11cac4452..1c873474a927 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -61,10 +61,7 @@ int create_dirs(const char *filename, const mode_t mode)
 	if (!err && S_ISREG(st.st_mode))
 		return 0;
 
-	dir = g_try_malloc(strlen(filename) + 1);
-	if (dir == NULL)
-		return -1;
-
+	dir = l_malloc(strlen(filename) + 1);
 	strcpy(dir, "/");
 
 	for (prev = filename; (next = strchr(prev + 1, '/')); prev = next) {
@@ -75,12 +72,12 @@ int create_dirs(const char *filename, const mode_t mode)
 		strncat(dir, prev + 1, next - prev);
 
 		if (mkdir(dir, mode) == -1 && errno != EEXIST) {
-			g_free(dir);
+			l_free(dir);
 			return -1;
 		}
 	}
 
-	g_free(dir);
+	l_free(dir);
 	return 0;
 }
 
-- 
2.43.0


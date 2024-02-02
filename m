Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70512C7ED
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914504; cv=none; b=W2TWujn0M1RYGc1I4+jwTz6Sr7xklCt+94V03ny8uKGFLSrG/ywuTJn7w+bChj/cqg1dG3QcSE0SyUZ8iJdLHHHJlT+TDrHu19ZrzesxF7T/HXOYluajiDJmVztFVoWzOVvCrow4hxqn4UjNlpc0eCE4xzPOqH/euRWZ5zyTDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914504; c=relaxed/simple;
	bh=Z7ctEh4XA2yzXnArktl4KmH0EMMv+ya97IuMrm0sCsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5xmdgb6UNLKli1PVmpTvzWzqEcUPjm+aevUrJZp36wmaTbifet86/0LmGj0FXHWGTXs8hS3TB2M3gcMY/d5vNTo0Syp4efSz8baagWcVySvP/ecq6QJB5CTe/74kDjqjPPXu6eVg4TlPD6EeSxDzqYenPpnzB015T77v82+HoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDg1Nox3; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDg1Nox3"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bfc3c3d5cfso223345b6e.1
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914502; x=1707519302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE87/0wYKXIeyz1wrfXQzQmSBH/HtUrL/kMalNyUS5A=;
        b=XDg1Nox3VIisvj2LeQSEjoPtfPIqQjL/haRc9gi/p9abPx6zBPC/SXodQSDFa0tLCi
         KPf2jhKP9sfOugYsAfqaQqDVCAbO/x/wQJPDPpt5aGEMi5JbuudmXWT5a29T51eiUAqM
         cyoJHnWESfY1+yKksygFJ6yQWvNeVqCFeDM1oi+koJDTJrk9WBi9ugo+C1+jSXqR6BOJ
         4jfjmPkQvnCIdaGqVl8JSaVaMltEgTw1XqGF4xvKNkoeO1G8MiG+Ze8XFJrZZifipQDS
         NxA0PIAOpXWjzIlfcVnOVMPBmv3pb/OA4+e8cNxAxvMyjHclCnHLExhhSZs4RpSlIrER
         VrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914502; x=1707519302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE87/0wYKXIeyz1wrfXQzQmSBH/HtUrL/kMalNyUS5A=;
        b=p5HDa/gWzbQmgKLo0/liwqs4NcYShlGqig5eUHyMybX0mOrg4B990Op0nusmWRaBeX
         xORNEqh1W/yLP/XDY2G6DunBlkQ8KKvno7bXdHAkGtGy0oCBh5X77legnEopP2sNvcd/
         ROyOccHAwpEigWW33xAKbSjslE94mCTmmf4BbvWgKY8qMORRew6Wp5YzayA9v+aMnR/w
         7FjsRM4JQIGlMJWzgqhu2eNODSV4T4J492cAiGyrFGJ2U3AWAEHJ0Fi0hKzbUVPIt6hB
         6zQyategMWJaTcRD0sL+6Ak/M9gY28vM92wKG84MpwwZMWaztZhH0iPpb1QohDm9Ka+Y
         9iFA==
X-Gm-Message-State: AOJu0YwVEMIC+9G906zFlBbSs67bYg9zJPaZ7bgl2tJEeBkMoXqFGaru
	rdZGmw4/lyXuF6W/DTFVmnpRpfBRkq+QymeIEkuDmUKUWI8ac3oxlCMlmAmQ
X-Google-Smtp-Source: AGHT+IHkMJMJobqf4fUbul+V9S+2iC9dVIvhDBehZdT7MsSnjZBuAFZkIgS6Ly5yqKXA2K/nuA+n6Q==
X-Received: by 2002:a05:6808:2a44:b0:3bf:c555:edcd with SMTP id fa4-20020a0568082a4400b003bfc555edcdmr24883oib.9.1706914502121;
        Fri, 02 Feb 2024 14:55:02 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:01 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/18] storage: Use l_malloc
Date: Fri,  2 Feb 2024 16:53:43 -0600
Message-ID: <20240202225405.993792-11-denkenz@gmail.com>
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

Instead of g_try_malloc
---
 src/storage.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index eddb98c79598..47429c22d1bc 100644
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


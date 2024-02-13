Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF06024C
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838577; cv=none; b=BxggVkWk2VIFPpsaBWAYLM0zTZ+h6cmQiYrpCjt52AFYCSFWjZOKBt3z+22yCk5Rh6GhWKUEKjpSBuC8j1jaxyLA1NFnNt0qXcShdcAWJ53ZX4u2YV6/6QBm9qpfnymoN7H//ZxlxvSTKxL5H3jodZsCLDw+fOOc43FIkKDlkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838577; c=relaxed/simple;
	bh=KoFSdFBDVpGkZnow4+flSvzZ2Y55ie+K6Lw2RlH2zuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICu0/jU2qxJT+jerSD6c7n3k4ifZQATLx532L+RdCMYOi24h59JTkAG+r6Va+wCXUkTDplz+9HGRlO4jqqsxbQh3KHtmWEFqst4wQTMRcwYCA1jrMUXjc/zcuqP/UFzRx+IacgVnzBYgRr7xIXdhONZCEpB1cqil2jf66ARNLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDWfMWgh; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDWfMWgh"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2e096e2ccso1197159a34.2
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707838574; x=1708443374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MDt7A1RKLfY2mHyxrWs3iK4/BNy7KuvqoNiIF0syrM=;
        b=dDWfMWghiiIByGPW+H/ROoqa3a86M//2X+cs/5Xiu5vJPuuwLemxN+epWbljW+OHfr
         Pr5fXblVt+9T5b6cItJiMh+wrwh1mrWKnJNO8xbUCKi4WMszpjQcS6UGXbajpvos1Ww9
         pTXw/LHYUPvqogeZaqXyZrgMAjheB1GcOF9u44k6YVCsaEc7Fsbb1HkbBR0j3pCQNrxP
         Jm+7R5x/P7PWFtpJ4jlYdjpb7KfCHl294gX0yiDHc+IHEUY0XrsIkLGRBEKvFPI8RiW0
         S+oAWbdzV624WbTrwqI1wfYb0WrkB1zXnWzcxAjSnPA6yeNuALfkDt1d3A7O2eR0ksGR
         OgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838574; x=1708443374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MDt7A1RKLfY2mHyxrWs3iK4/BNy7KuvqoNiIF0syrM=;
        b=bSP/mWJAbZWs+UNepjBsueNTxUMkMliG8sECWcVsej2GU25OoDGYBp5+ZjBJPYPupn
         Pe4jscQS8MzfSHHjsqEBdNGw1r2ckwfTii/BoQOXn6xmXh3cou8kAbnsgZaKThVb4qdi
         xl2r5m93Co1DcSXhheQa/sP5fLETS2sJj6I4nI2ui/ukj9ZMsxKOMZJz94+6ir2zNn8P
         bLlA4g36tEGh7pLXxOuQZ09jnc2mg2q+jzw2r76zeBthVUfudzG7kst9Pvvdhv1fD8bq
         Ie2QYoszS+I+LWeO73QOgmtFg4ExoXVjDrozK3RwNfozvWkHQZklGFbbggtNJN+eyCU6
         8MOQ==
X-Gm-Message-State: AOJu0YyB2MTVaxuyNa+LFPYmo+9aruze6IqJ7BXy6kWzORzjuhb38A59
	em7pbuVIZcRrayUfytcYjCwuYtANYWlkcBSk7BSDuP9/uZyW6h+EccWA6EEq
X-Google-Smtp-Source: AGHT+IF9gPqsRHe8EJuJCFEqr1aQGJKY48R9OWedtc/9nIDwdK8PHGyawsgNXNxms6hi4tyWscJNdA==
X-Received: by 2002:a05:6871:293:b0:21a:4820:7ed8 with SMTP id i19-20020a056871029300b0021a48207ed8mr7428474oae.8.1707838574591;
        Tue, 13 Feb 2024 07:36:14 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx19-20020a056870769300b0021a0f032341sm1861999oab.22.2024.02.13.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:36:14 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] common: Convert use of g_ascii* to ell
Date: Tue, 13 Feb 2024 09:35:09 -0600
Message-ID: <20240213153524.1085649-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213153524.1085649-1-denkenz@gmail.com>
References: <20240213153524.1085649-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also remove the glib header include since no other GLib use remains.
---
 src/common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/common.c b/src/common.c
index 859f146702ec..aff356da3330 100644
--- a/src/common.c
+++ b/src/common.c
@@ -27,7 +27,6 @@
 #include <string.h>
 #include <errno.h>
 
-#include <glib.h>
 #include <ell/ell.h>
 
 #include <ofono/types.h>
@@ -561,7 +560,7 @@ gboolean parse_ss_control_string(char *str, int *ss_type,
 		goto out;
 
 	for (i = 0; i < strlen(*sc); i++)
-		if (!g_ascii_isdigit((*sc)[i]))
+		if (!l_ascii_isdigit((*sc)[i]))
 			goto out;
 
 	NEXT_FIELD(c, *sia);
@@ -681,7 +680,7 @@ gboolean is_valid_apn(const char *apn)
 		return FALSE;
 
 	for (i = 0; apn[i] != '\0'; i++) {
-		if (g_ascii_isalnum(apn[i]))
+		if (l_ascii_isalnum(apn[i]))
 			continue;
 
 		if (apn[i] == '-')
-- 
2.43.0


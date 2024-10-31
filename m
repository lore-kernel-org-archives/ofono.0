Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C041CCEF9
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412408; cv=none; b=uFYISd0GzPIu1j84IhbX+20i0OFMHRcPa7jVMUnoTGdsPZ5JXCy+zWE2nG3kFvoT3n3SYnw2YjHVFxZKDy4WHrwe/tyoMFPVepHBO2IBfrXV4aVKJXoxmlW8QckFbh8oaTJXYX7KKHbDRQy5D2ZIKPtZo/iniw0E8wdNc5tcbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412408; c=relaxed/simple;
	bh=Rn4LnbyVRXQkAnTgQMpL4dQobKY5k0oqcrqBfCad/Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4Idd+sKT7v7bW2ZuYv0G2X7KaOzQPii4IyQ+NFjNcEHvlqfwvw/vgP4QH65Mndchu/Au8RbNRrerfBUOjiXzW5czl5wquGFF1e5SxaIGZKOKfzgcDGR/CPjmI0CtUxvW+QJB4BEW2OB+bfh4RmXLEwsxaNztRgpvjt2dxTsAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA5Sh5BU; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA5Sh5BU"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7187e0041d5so824732a34.2
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412402; x=1731017202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quuTVaKdgdLjjNyy8oNy0TPYvIzhDwJzO+pEs2vG6P8=;
        b=SA5Sh5BU885OLDLEvh/q6WLyEP0ZJSovOisyRVddXsVdlP51rV9PMHEmHmZOnRrz5Y
         DOepbAF2MbnOzoETyoshW/s1+IOV4+xmKWYYbMRXblYgGktJyhjDP5UHSLgy/f0gO7xz
         Cjx4l9wvGXVdSKtRRwNOGa45CKlnMHV0QS20veLHv+5yPLtp95RjhFiRXfVhFStdkDh7
         OP9UJIvOADQS+meBZz4GWzkCp2ikrY1vv6GPtkSwPtArgBhCqzqNkN0kXNCr2vfDisN4
         0jL/pN4K1Frs5KvoQmNnb9iKe1XJrdA3maKtCdwnh3p5LXKssB9BEj3/Nlg25a0iuhlL
         6caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412402; x=1731017202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quuTVaKdgdLjjNyy8oNy0TPYvIzhDwJzO+pEs2vG6P8=;
        b=pf5EM/Xm7nFexJ76W2Obc7693yGDk2Qk7bMHciG7bEYufG3rc/jYgXxnwSwDJAXa2U
         eirEy/vJNMu3wWLRlBpoMfQhDitLyCyUGSgarBrIrYKzBS87JUfSXHBzKnjBN5ktD5y0
         Q+baexnZqwvtSPoW8eAG+P1pHK71DQCRIuodmAN00AfJo6SY5an0hJHGyScHqzCfuQ11
         yJqLUcJmh7f6jjLfeOK9WTswF1G6+FtQp82dL3SzP5L65mTDSN2RNh2pPC+OKv0k4VPJ
         mQl0Sx3GcpUvC2dDO4NjH5C6v6vB2MD3Xnjj9nqx51zbZ8qERLOhyJzKlVD/nLxos21z
         6kng==
X-Gm-Message-State: AOJu0YyjgLq1YMYVkooGmdh4j37zxUyw9jfnqm8yT6TVIY/40aQUxhxC
	pNH+olISDU0no7u96iTYbjSR2+Fdfvwi/12WpgQY7HnSc2V0jTLDAbtjKg==
X-Google-Smtp-Source: AGHT+IEN3DULmtbEJShxnxbV9+DBike2gZN7M6tDF0e78ztEmwY1rblQenAJnoYjNQ2KnFdXXa3yqA==
X-Received: by 2002:a05:6830:34a2:b0:718:9ae5:9030 with SMTP id 46e09a7af769-7189b4cb762mr4674757a34.4.1730412402182;
        Thu, 31 Oct 2024 15:06:42 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/13] simfs: Quiet sanitizer runtime error
Date: Thu, 31 Oct 2024 17:06:11 -0500
Message-ID: <20241031220638.1582166-4-denkenz@gmail.com>
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

The arguments passed into memcpy for src and 'n' are NULL pointer and 0
respectively.  Strictly speaking null pointers should not be passed to
memcpy, and this raises a sanitizer runtime error:
src/simfs.c:1057:2: runtime error: null pointer passed as argument 2, which is declared to never be null

Use the newly introduced l_memcpy function to avoid triggering the
sanitizers
---
 src/simfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index c86e8d11fd0b..7f0390032bf6 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -9,7 +9,6 @@
 #include <config.h>
 #endif
 
-#include <string.h>
 #include <stdio.h>
 
 #include <glib.h>
@@ -27,6 +26,8 @@
 #include "storage.h"
 #include "missing.h"
 
+#include <ell/ell.h>
+
 #define SIM_CACHE_MODE 0600
 #define SIM_CACHE_BASEPATH STORAGEDIR "/%s-%i"
 #define SIM_CACHE_VERSION SIM_CACHE_BASEPATH "/version"
@@ -1054,7 +1055,7 @@ int sim_fs_read(struct ofono_sim_context *context, int id,
 	op->num_bytes = num_bytes;
 	op->info_only = FALSE;
 	op->context = context;
-	memcpy(op->path, path, path_len);
+	l_memcpy(op->path, path, path_len);
 	op->path_len = path_len;
 
 	g_queue_push_tail(fs->op_q, op);
-- 
2.45.2


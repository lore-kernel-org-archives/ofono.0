Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF759211A2B
	for <ofono@lists.linux.dev>; Wed, 22 Jan 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548004; cv=none; b=Eue/cy4/qR3EwwP1utA6l2N3WGUbIp9rlMMWIZ4AuDpaqz4Es2vFTWZHNU0dzLHt5fBC9yWw6uXsyflNVvB6hOPb6/OBBMVYO1IlBQ6HyJDuJuKViJpmCCr5N6+wWD+uTrJNH1YJlu7MCUOBbqgrPfazrD15uJcALJKhBImaGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548004; c=relaxed/simple;
	bh=QPcDkaJ6VBheQBqQqS+MYYMJLtt81P+mN4+0EcMekzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyUl5GJkLBvKKt3JR3048/akISyDqs1YFBFCC+4/0S46bKIemUTre3v55xX3r0f6e9hsJq39GLRoV5eq3aldVcjOMYAv8pO+C32Ci6p4Zc2MMEaCXzCgBIaRyVVfJwlLYMijY8i7ni4JL3zgNla5WAL+dhYLNxPPIA7SLU006S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.52 with ESMTP; 22 Jan 2025 21:13:18 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: saravanan.s@lge.com
Received: from unknown (HELO si-rd24bld77.lge.net) (10.221.31.77)
	by 156.147.1.121 with ESMTP; 22 Jan 2025 21:13:18 +0900
X-Original-SENDERIP: 10.221.31.77
X-Original-MAILFROM: saravanan.s@lge.com
From: "saravanan.s" <saravanan.s@lge.com>
To: ofono@lists.linux.dev
Cc: "saravanan.s" <saravanan.s@lge.com>
Subject: [PATCH] voicecall: Fix implicit-function-declaration fatal error with GCC-14
Date: Wed, 22 Jan 2025 17:43:14 +0530
Message-Id: <20250122121314.550338-1-saravanan.s@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address below issue by adding missing header:
ofono-2.4/drivers/hfpmodem/voicecall.c:1081:17:
error: implicit declaration of function 'usleep';
did you mean 'g_usleep'? [-Wimplicit-function-declaration]
---
 drivers/hfpmodem/voicecall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 5a84db78..949337dc 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <unistd.h>
 
 #include <glib.h>
 #include <gatchat.h>

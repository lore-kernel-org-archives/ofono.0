Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA81153598
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036719; cv=none; b=nqPnF1ao9WVsCwBbRZQVDmX7alNPm+UJwa4BbYaQbAneuaelz3iqDOFOF4ghxAd2RT7KsnbGU1dEkdA4pGoMaT1GSxd7KqhfFdCG8F8Rb1Q8dkK850PhEEz40Ft2Ls3o1md2UCTc6JK1lkDuInfx/yNLIN/+uJ/oN+qF7GVVq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036719; c=relaxed/simple;
	bh=2y3yf7W5FTQF4oAsUzgpFbw55n/dVLzxrntw8T01hLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxVyLmoAtRAMM00ilhmZYMNPlZ3TibueMAQ01SwRfMTXGyJVMI8HbvFbJyGENmTMMcsHq1avhopn6g4h0DJdQvjJg324vNF1NO0y0T8q9Y3daddwMjHHBgkXzEmeRm6fG49rkl8SlQ3RYArwGnMpeLAW3q+m6Bc4xEI/zjNibsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmJ1csWz; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmJ1csWz"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2968322f5feso1129463fac.0
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036715; x=1732641515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76ipTuZs611cMa72IIm7uS2EmczVP9AEscq2U3NN+rk=;
        b=cmJ1csWzVrZmnBwTGTVR7dWG1rT8Q6kyJACcbspktVdNXMWJszkATLvH8bcWXcrY5A
         hDT9j68wP9mE48V191XN0wg9oWnyzWl0xnzN44DisUl7+6ALRNp4bjTjNSUJ4aVr2oac
         p9XWXqrr3xvU9eP47MhNoaJV/TFDci553grI9N85YvBp4HFA1ZLvVI9LotAnuxGadzgS
         oKJwWcPwk9TZ2VlYDIbaqFEssyaRfMleRxYIVoCGpr138oSoYDzo/dl8Ybst8UIosRhP
         6lgus6ST24plpAIGaj0tO7b16P61buvJuoHWWFzJB7r61jYp91sYtH5WiXMqaRlK78TZ
         5rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036715; x=1732641515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76ipTuZs611cMa72IIm7uS2EmczVP9AEscq2U3NN+rk=;
        b=chR2SDj5FlF5g5vxiOqQDfhXHeELdE94FERn6IX5iruzIwRg1SXuLwY9gsCa6tDXGq
         1Xic4Hx3lLg+WYhDTgA1wZdYqkoR/XZknqnekITG2JabF3w6zkS+K9tlv4vR5V+o0988
         DsyPOrImHo7vGLPuuTVktfhi8261p40H+1icTV5jlMU4PyW7EmfEF4skjDm1B0IHZK06
         smgpm9lThHwKbzaJtqTjsL3Bp06e2axB1e0DUtap/QiKNlWS2uXEkpkRS/WdvbxNIb/k
         rtrJ4nN3hrlvPUyeCBR48iDqldOPeBlJcE/Y2nPuSyC1O/u8KbcdE3E1ESb3mmIRDCcu
         8e+A==
X-Gm-Message-State: AOJu0YyGnKQwnO2JnoJjL01H2HADZxxPegghTVPXYcOp1yb62y+lybxz
	TXDH/09F0ZfA6u+mZ41UdwK/z89wjO2j5b7aRAFiL3mKqCONkCJm5O/YVw==
X-Google-Smtp-Source: AGHT+IGo4kNFylPtWmO4nBiwPXm1S/99YLLWsV2/onX/xBuazhOWEVpnNkGZ6AM8k6LOzp6DdCi7Xg==
X-Received: by 2002:a05:6870:548a:b0:296:2cb4:2394 with SMTP id 586e51a60fabf-2962dd7564fmr12169719fac.17.1732036715155;
        Tue, 19 Nov 2024 09:18:35 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:34 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/8] rmnet: Add skeleton
Date: Tue, 19 Nov 2024 11:18:12 -0600
Message-ID: <20241119171832.1119-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add skeleton of the RMNet interface management module.  Implement the
basic API structure and register the module with oFono core.
---
 Makefile.am |  2 ++
 src/rmnet.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/rmnet.h | 25 +++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 src/rmnet.c
 create mode 100644 src/rmnet.h

diff --git a/Makefile.am b/Makefile.am
index d379201d362b..d107dc410fd2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -353,6 +353,8 @@ builtin_sources += plugins/u8500.c
 endif
 
 if QMIMODEM
+builtin_sources += src/rmnet.h src/rmnet.c
+
 qmi_sources = drivers/qmimodem/qmi.h drivers/qmimodem/qmi.c \
 					drivers/qmimodem/ctl.h \
 					drivers/qmimodem/dms.h \
diff --git a/src/rmnet.c b/src/rmnet.c
new file mode 100644
index 000000000000..58f841a49a59
--- /dev/null
+++ b/src/rmnet.c
@@ -0,0 +1,59 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2024  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stddef.h>
+#include <errno.h>
+#include <unistd.h>
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+
+#include <ell/ell.h>
+
+#include "ofono.h"
+#include "rmnet.h"
+
+static struct l_netlink *rtnl;
+
+int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
+				rmnet_new_interfaces_func_t cb,
+				void *user_data, rmnet_destroy_func_t destroy)
+{
+	return -ENOTSUP;
+}
+
+int rmnet_del_interfaces(unsigned int n_interfaces,
+					const struct rmnet_ifinfo *interfaces)
+{
+	return -ENOTSUP;
+}
+
+int rmnet_cancel(int id)
+{
+	return -ENOTSUP;
+}
+
+static int rmnet_init(void)
+{
+	DBG("");
+
+	rtnl = l_netlink_new(NETLINK_ROUTE);
+	if (!rtnl)
+		return -EIO;
+
+	return 0;
+}
+
+static void rmnet_exit(void)
+{
+	l_netlink_destroy(rtnl);
+}
+
+OFONO_MODULE(rmnet, rmnet_init, rmnet_exit)
diff --git a/src/rmnet.h b/src/rmnet.h
new file mode 100644
index 000000000000..dc416e0d5d51
--- /dev/null
+++ b/src/rmnet.h
@@ -0,0 +1,25 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2024  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+struct rmnet_ifinfo {
+	uint32_t ifindex;
+	uint16_t mux_id;
+	char ifname[IF_NAMESIZE];
+};
+
+typedef void (*rmnet_new_interfaces_func_t)(int error,
+					unsigned int n_interfaces,
+					const struct rmnet_ifinfo *interfaces,
+					void *user_data);
+typedef void (*rmnet_destroy_func_t)(void *user_data);
+
+int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
+				rmnet_new_interfaces_func_t cb,
+				void *user_data, rmnet_destroy_func_t destroy);
+int rmnet_del_interfaces(unsigned int n_interfaces,
+					const struct rmnet_ifinfo *interfaces);
+int rmnet_cancel(int id);
-- 
2.47.0


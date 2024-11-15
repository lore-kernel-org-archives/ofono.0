Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821A1E0E0C
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708059; cv=none; b=O8qbJhyI8z0DAJydOmRBGGsqtXR6gVZnMYOOCe4O/q+WPgL4VuGEQgmB2iV+sE7C/yzO9MMRsSr3HWf1UZ38Ou5Gep5W+uR9e5Q+C/plY7JJ3GM3tJUv1dbzapDoyuWWW8z0VooCW8s80swtPzFVqnNa+wIrn7Ii0+LP+mUvFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708059; c=relaxed/simple;
	bh=2y3yf7W5FTQF4oAsUzgpFbw55n/dVLzxrntw8T01hLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrllQ3x+PsVIw94WktFJPrRVVNJIqImtnP4zu76oR9LElQOsn/thPiQZWopAuU5hWtBH8A/aQ675m11L0SdpxSfcclY/oEAraAYojQJ3ry8Lzj1h/k0ygibkIOhxwv2Fv7Jnw8t7LtwGJUsn1eCkeMwfCE7Taxbxvtfh+yBBSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNfIbzgV; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNfIbzgV"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e604425aa0so1267207b6e.0
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708056; x=1732312856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76ipTuZs611cMa72IIm7uS2EmczVP9AEscq2U3NN+rk=;
        b=mNfIbzgV3GiOZhQhfuiPRJv67YgC765c7MKg2DbL4AjqKGPSMtFikR9GDPVF/gcFPw
         Jac4aIYQynWq3c3GWm3UJ+wwnCmlMiPIigsum5Yo2Et0GIfXm1duRWWzg/P0cTwJmvjR
         UWhmlPbuY6URvED2sYVpc4caQi1FQ+fP/ApVuJypQI8h+w/hdsmD7LrWQy4rR6sguary
         g6QgGn3VBX+5ZRDas7DB35EVB9rtZBQu562hlYHLJUa82M9MA1urZ7DMPeqAJHyogBlC
         l5aMRNVVHTjDiixa/FhSKtuSMH+4bvhyx/XxYF8PmS52MCIgXOoTlNw34a1iaZm1Wxxp
         +h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708056; x=1732312856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76ipTuZs611cMa72IIm7uS2EmczVP9AEscq2U3NN+rk=;
        b=DY48Ol3PlQOgd0TOqz5RZHoWfBJy3wflRYDYwMFC9qU2UDU6lbJJBmkD2CKj3vmfQG
         3r3zWdLudzdis8jow0ko0owDNZSqxV0jZEVhzjSOHWvsLrvFTvWWdkSYDr658ZMslmFF
         sBxWTY4OiIqu+8RG7ERWZb1IfD4kd4gR9Imo7y96irrIqm3cp/Q6zXyYgKsAmRz7qkXB
         s0VtOy7t2nknLsfCoZYTSyisQyd54FdHaIzjyg6J+dpo8t+eidrewCBbvW9OqJW6kjIx
         6EVWc5/W5WOwIhblLfZB08tDd2pRHEuaDpsAzwKD69eeacNyjwmNnfZF9JmNmYg7wDXS
         wdCQ==
X-Gm-Message-State: AOJu0YylLchWcovWGBj6cScCf5QXAUCGUZtWI932KGy+Ne8Ie4WqG29w
	3icrlfWYtsZZVxq7RfTVp9P4PK1H0do7KPtkn3JwDF4poUjgY0nxMx16Uw==
X-Google-Smtp-Source: AGHT+IGug2tYoh5ACxQH1BpitYfoEiZ5oAeOLY43cpy7gZlaEb1d18BrRePyTsqDGfRdV1O+b08Jvg==
X-Received: by 2002:a05:6808:1449:b0:3e6:4f5b:afd1 with SMTP id 5614622812f47-3e7bc7a58c6mr4141333b6e.6.1731708056570;
        Fri, 15 Nov 2024 14:00:56 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:00:56 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/8] rmnet: Add skeleton
Date: Fri, 15 Nov 2024 16:00:26 -0600
Message-ID: <20241115220053.49613-1-denkenz@gmail.com>
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


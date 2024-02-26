Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3205DDDC
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918653; cv=none; b=W9k1gikVpzSxRABpKAWZ6fqlvloOIFj8Mgu9wEZAqMAt/2mUupzYBnpD0VF+eVxRFF2wJ/isz8lGc+zhmJiRPMAuLqg+GNZfGDIV1diMiU5SvBRQCfhkmi3QDwENV/PM1au6ZOMcMniSGB7B4WfuyvI37fLiqP8bX4QVTaWOYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918653; c=relaxed/simple;
	bh=hqFVu02ic8R1trtME6BpjVbeNsXhZHGjMwsqKN2Dd8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLLXdJtfo4fla7MV/cg19vf3UF60av4VY0DkiXo84RC8gtH4pRUeDGEwBs4p/Ub7tcP0GxxPAzoA+7B/cElO8g0G4qu4BhLCEm88ZtW8dEMlWs7cqqGdpu7V5/UAmr18a/kuDJKO+b3B5PukNEene6MtObRUaMckhTE8/q1mm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs7kIAg0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs7kIAg0"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1535496b6e.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918650; x=1709523450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7dLHEfLQ42SROzcUDGEmQ80CzWJlvbdGfW9FhtTznU=;
        b=gs7kIAg0e5vuXh4iHQuxXPudCNVD0lWsAwiyB9B00AV+WhpkVTqjjexClauo/57l6e
         e6ydq2PsBfX7j4PBZLgj9jmmglO+zdLIh5q+fDnEhkWRFWdkn2UuOVOMEEzo87sGi0ri
         KMt+2/JfNh2lvjqnGNsqHsbtqGMocRlnOrCvnnSQuIsI0LDxxDKQJj9MI3qWfb9LkVRm
         3+yIs5Qcn0cTgq1isXEd6d/7LFaXJReP8XIUqgfvNq/hN0PBDs+cKQjMdngogztnVr/+
         aWQf/H5K7rp3Du2LrbG73bZd5leOA1eAMobEdcsMLJo3EUDNOhdMl5P52coekUoPofhf
         1CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918650; x=1709523450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7dLHEfLQ42SROzcUDGEmQ80CzWJlvbdGfW9FhtTznU=;
        b=MD48WPNJSZ8UdU/DnV+8QH8zS5v8OQqvsF4MEXCqTKiCPvrCnuMFNQG2rjyXJwoWgv
         0Q5Mn+G73LXaNX96XE9spIDEScS4MBV99OnolHwB6T+dbxuo2Fj+JJM4eKPJmew/j+T7
         VRq1wDjY7LfEjZYQLoICx2Zlt7WvFl20SV21H/aJlPdgHutddueixt8MNjproxdp4dtg
         mF7TVm/fh8SmztHE+7Qfcjwd9OSwq/fK/RSeriJZdUF2SJxkRMC8kd3XdptxziisN3VO
         L+Ei7mdU/2cb2ExosjvfU63lTPqagYjH7Z1eE+FlCxBUnmGxqzsgwD6nRi6i5wOhJspY
         3AcA==
X-Gm-Message-State: AOJu0Yx8oYdIWOprCKWHh4bUuf6qkCCXHo32BcLbS0OMUbj2oNCzrG1S
	wPqjFxEthw9IgLAP1tH0oFVj2jHr4ycjMvvxZn5jnwayIDCKdfieTJvmer1l
X-Google-Smtp-Source: AGHT+IF0YoJnzltAyymF32UdWi0jYiEF9kHoYcXtUapbR7Vr0H8EfJ9nEAICmUsekLHV8DNoafoNjw==
X-Received: by 2002:a05:6808:1795:b0:3c1:6ed1:949a with SMTP id bg21-20020a056808179500b003c16ed1949amr2714346oib.12.1708918650689;
        Sun, 25 Feb 2024 19:37:30 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:30 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/22] hfp_hf_bluez5: Drop use of g_strconcat
Date: Sun, 25 Feb 2024 21:36:50 -0600
Message-ID: <20240226033724.1460079-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_strdup_printf instead
---
 plugins/hfp_hf_bluez5.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index d45dda9d4196..944d44ba3fc8 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -32,6 +32,7 @@
 #include <fcntl.h>
 #include <sys/socket.h>
 
+#include <ell/ell.h>
 #include <glib.h>
 
 #include <gdbus.h>
@@ -213,11 +214,9 @@ static struct ofono_modem *modem_register(const char *device, GDBusProxy *proxy)
 
 	dbus_message_iter_get_basic(&iter, &remote);
 
-	path = g_strconcat("hfp", device, NULL);
-
+	path = l_strdup_printf("hfp%s", device);
 	modem = ofono_modem_create(path, "hfp");
-
-	g_free(path);
+	l_free(path);
 
 	if (modem == NULL)
 		return NULL;
-- 
2.43.0


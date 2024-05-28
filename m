Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD2446A2
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924755; cv=none; b=JZ+r9wGTBpjFXPqLNVL8tDD9GZkc6JpAYpOKfHJ2v/IZDtLJ8+FgUczDjMItsFIEKUzMxMMcBjUOkeJ7Un+o8Al64+bOTpf32Ly4wvMYeqccewV1qunVvF1NoIE2tNazLLNv7ipO92xmCpYOa9qCwUVf5yvXwPiknJ0DXspojsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924755; c=relaxed/simple;
	bh=p8euwUjQHn5I/P71ymsg8AYSca4ABkhXAqeuNgOep9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9B7ZWXg7Fgmzz5jVNpywphKljtvhWg4YUXCFRk9t28pAgsHzkMjGg+sYk4gY+34gsWpCfHAstsehkWsympsWqniD5ETC2WNhlMq8Q/JL3mSs5kQE8mLg/gGLQb/I94Dim1AQHuYH8BzLkNfIB6mIHaOUYdYA2pinHclSgZ688U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY1z5XIs; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY1z5XIs"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9a5be6668so688582eaf.1
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716924753; x=1717529553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9UIYlPrYhmQms74vgQcbaaF5tDKCbhmeuZBRpPdmKQ=;
        b=UY1z5XIskr8L6qLXvfwbHs/aNUumGH8+Liw+LxHLNhu5+c7v/30JmLpGLI3iA7YsDe
         dLwhZ073Wsnd9f5co0FozBCsyfGwpBgvcuigYTVLQiOQtH1KMicuYgutNBT7dCl1NVQA
         26t3yQArWjj/E0M2HZg7NPPDzC/vQy/Fp4ewznZLjdTePVygvhh+XrA1euegxpKTQ3xt
         a+YLlBVH5hPDkUT56+8bNBoah1QELa6e1yQewhbQIVeixaghpQ5ML5YF6UU2eXlHBBTw
         6jgwZT4uTlL7N9X/XmXl+1I543/i1oS2Z9C5r35YzUtAzNDslPHlVxbq6GD2/WBZ/Z5M
         ixmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716924753; x=1717529553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9UIYlPrYhmQms74vgQcbaaF5tDKCbhmeuZBRpPdmKQ=;
        b=FZH1EoVRpsY4b//Ag08UUClCmm2h6nvH3+wxCtXMAS5F05uSRsI9wW7aUp4D2O6uGt
         csR2k7cbaPYgSqYWre8i5z43Shd7Qvx6PslUrRJMyaqs8AR2vI4OVTgMsYBmrj0JrUi2
         /yIbj9vsIdqKvbOtX31k/K8K2DSKFAF8TxyiONObA36c3hEkfjK6bBIZW35nacf0xSiG
         EcjAAxxAmCzbmB7mv6kNwzVQXaqaE5zzK6/sqNva5RmoMQF1b1A6pjcnDUaGRW4jfHxd
         KT5spTTnsV79fSyjrTj+tLNDBO7gYMc5JzBADECt7yIEOgOT057i7hpUF+c+zS3a4Tr/
         fRkw==
X-Gm-Message-State: AOJu0YyIWrx1+o5HBa4ELv2PlMPRxkPbvOa6Va6eklA3xw+W1+8YwB6/
	BNb5frwiX32UgTFRSVJSEHe31YibCD1TFKvltWTK7+CrxeuKWyokSFgGwA==
X-Google-Smtp-Source: AGHT+IFe1Hg28zM9nGsL+nU273RF2tXOvIt65P1RNpVG6zz4PwIe/Xuq24bVV8URNN0juxGU6GndRA==
X-Received: by 2002:a05:6820:1606:b0:5b2:72e5:c12d with SMTP id 006d021491bc7-5b961b5dda1mr15786491eaf.5.1716924753319;
        Tue, 28 May 2024 12:32:33 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c699953sm2278337eaf.31.2024.05.28.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:32:33 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/3] log: Use l_basename instead of basename
Date: Tue, 28 May 2024 14:32:20 -0500
Message-ID: <20240528193229.225499-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528193229.225499-1-denkenz@gmail.com>
References: <20240528193229.225499-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/log.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index fdfad362cfd1..4348f1be6191 100644
--- a/src/log.c
+++ b/src/log.c
@@ -28,13 +28,14 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <string.h>
 #include <syslog.h>
 #ifdef HAVE_BACKTRACE
 #include <execinfo.h>
 #endif
 #include <dlfcn.h>
 
+#include <ell/ell.h>
+
 #include "ofono.h"
 
 static const char *program_exec;
@@ -309,7 +310,7 @@ int __ofono_log_init(const char *program, const char *debug,
 	signal_setup(signal_handler);
 #endif
 
-	openlog(basename(program), option, LOG_DAEMON);
+	openlog(l_basename(program), option, LOG_DAEMON);
 
 	syslog(LOG_INFO, "oFono version %s", VERSION);
 
-- 
2.45.0


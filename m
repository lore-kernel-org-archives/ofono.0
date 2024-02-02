Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364985934
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914497; cv=none; b=CNjE7/6v121uF0t9Pca/NBHEHAIJhu/2YYpqUGzXiezNlk4Ewytn81CJqIOE+C9SmGCQ/TREv4rc/sNluPu7jAzwij2iqK5DtGVOC7RiEoGVut58DSGwmII5p4zswc6M88mMIgdZSrs9p7+htT3wL6ayT2VJUYgaHWv3zp39rdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914497; c=relaxed/simple;
	bh=SVq3h8lFWDedz+JfWGYEjrib5K0S3qC4CbGyaa7Vu8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iaen6vo56opMx77xM1HoAKQWbbeLYlSvFaLnJN6QwH18ZZyw5U0KBHdFgzEghcGBuY3v897f7dh99wRzkipjQY/UOZto8PM9eUpYznQm0h9sRrRzyGYH9U7muhfT+DK/+QINjfdKYjBNCLPTs4bEfyZX4tpjhIx0bxG/Iky7FiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhrfgQCg; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhrfgQCg"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e27401a244so1230484a34.0
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914495; x=1707519295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WweB9jMXpj+jfBpvMM2LyldcXE3A5CZcgD4gDZEx9Q=;
        b=VhrfgQCg/9U61noB4mLEvFzz8fvsyiwaYgKxeLGUdX6fNx04IxSqwXQHgWoiiMXK0C
         q/YQMZJw6p/+hUFNfFCE5esihVkVEHI7rEdMOhUcuKfaXAurQEVEXh86m5GH9NeZ4bOt
         belwZR7ymIs/eYvt+AnfWXq6chniwBKv36YQ5WmRrd2bfTMUSxvMwORVSIrW39re64j4
         y+r46gqacR/fqQgX71S6BYFz9AyAbq2mwRDSguz5iW0fSJ09koO0AeUVVSZ1Mu3zjNbZ
         tL+0lsKItCEkeJHIKLhYB9sMWw75wZAT0BcTxrKniQOUdsCV+yVGs58p0OG7SHN+AxJE
         gaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914495; x=1707519295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WweB9jMXpj+jfBpvMM2LyldcXE3A5CZcgD4gDZEx9Q=;
        b=uyZxgU5SYSknLACKZJtAyOlt38Xc8z/4sNTKCeXweJowvtew0s7WWnvp7+cgYCBAp/
         2vKMhLUFoeRu0m+dqavDejkR+XaTTskatqfcaGRznuBjpNM0IOgqUuBmsWqWYica7LJQ
         JvB1oHhu3K8v+jCKKrrwvo6fUXvgYkGmQKZtqupPxY08BJAYwl3pZIUKKVvkOn2pjLRp
         pkTancQyPJgbdAIxiBD1/ZD51RHiM2DINBxxMCdcYdhMP71jLbGDd6uzLZbIp6nZ8hR9
         0saARiZK4krGWfNO1VLf9y4RjO86P2cudrdFj7HxWI1+4NOKCZ+fOQG7A7TviNxpu85i
         +oCA==
X-Gm-Message-State: AOJu0Yy09lpociUJK0eFYUl5SJGMunfV1x23gEThILJBvQe9DLxp7Zlo
	eyOLmSJbpTDWOzU+o39do7NLZHWQP+FwEZm34Cv1UnwR8k+iF3L2f+EBmzbF
X-Google-Smtp-Source: AGHT+IFGgvHR4gLIle5VOn8l8YgHmenxtRjxzp0UwI/6zuv2ylN+OTfDSkzT+91Q+FgAeXSOknYvqA==
X-Received: by 2002:a05:6830:1bc8:b0:6e1:79a:fc8f with SMTP id v8-20020a0568301bc800b006e1079afc8fmr3051153ota.35.1706914494860;
        Fri, 02 Feb 2024 14:54:54 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:54 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 03/18] build: Bring in more ell classes
Date: Fri,  2 Feb 2024 16:53:35 -0600
Message-ID: <20240202225405.993792-3-denkenz@gmail.com>
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

Some ell classes are still not used by oFono.  Bring them all into the
build for future use.
---
 Makefile.am | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 60ea9d193eac..8517bc0309d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -36,8 +36,8 @@ ell_headers = ell/util.h \
 			ell/checksum.h \
 			ell/netlink.h \
 			ell/genl.h \
-			ell/dbus.h \
 			ell/rtnl.h \
+			ell/dbus.h \
 			ell/dbus-service.h \
 			ell/dbus-client.h \
 			ell/hwdb.h \
@@ -52,14 +52,20 @@ ell_headers = ell/util.h \
 			ell/file.h \
 			ell/dir.h \
 			ell/net.h \
+			ell/dhcp.h \
+			ell/dhcp6.h \
 			ell/cert.h \
 			ell/ecc.h \
 			ell/ecdh.h \
 			ell/time.h \
+			ell/gpio.h \
 			ell/path.h \
+			ell/icmp6.h \
+			ell/acd.h \
 			ell/cleanup.h \
+			ell/netconfig.h \
 			ell/sysctl.h \
-			ell/gpio.h
+			ell/minheap.h
 
 ell_sources = ell/private.h \
 			ell/missing.h \
@@ -103,30 +109,46 @@ ell_sources = ell/private.h \
 			ell/uintset.c \
 			ell/base64.c \
 			ell/asn1-private.h \
-			ell/pem.c \
 			ell/pem-private.h \
+			ell/pem.c \
 			ell/tls-private.h \
 			ell/tls.c \
 			ell/tls-record.c \
-			ell/tls-suites.c \
 			ell/tls-extensions.c \
+			ell/tls-suites.c \
 			ell/uuid.c \
 			ell/key.c \
 			ell/file.c \
 			ell/dir.c \
 			ell/net-private.h \
 			ell/net.c \
+			ell/dhcp-private.h \
+			ell/dhcp.c \
+			ell/dhcp-transport.c \
+			ell/dhcp-lease.c \
+			ell/dhcp6-private.h \
+			ell/dhcp6.c \
+			ell/dhcp6-transport.c \
+			ell/dhcp6-lease.c \
+			ell/dhcp-util.c \
+			ell/dhcp-server.c \
 			ell/cert-private.h \
 			ell/cert.c \
-			ell/ecc-external.c \
+			ell/cert-crypto.c \
 			ell/ecc-private.h \
+			ell/ecc-external.c \
 			ell/ecc.c \
 			ell/ecdh.c \
 			ell/time.c \
 			ell/time-private.h \
+			ell/gpio.c \
 			ell/path.c \
+			ell/icmp6.c \
+			ell/icmp6-private.h \
+			ell/acd.c \
+			ell/netconfig.c \
 			ell/sysctl.c \
-			ell/gpio.c
+			ell/minheap.c
 
 ell_shared = ell/useful.h ell/asn1-private.h
 
-- 
2.43.0


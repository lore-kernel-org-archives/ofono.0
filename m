Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CE762E1
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649749; cv=none; b=kHnao4Thkw65+QlD5SNHadY1UmDgLyty34otHyPmrUlqCg1t93alCVOmFF4H1P8I9V6Hn/l4DXFvMGxbUw5pJXz7jEgkT4c+rFYydOGxjmHPxYwKXuvEM1zB5Fi8z/nUeHWD8a/1WuL2P9MRR6sqKuLvdz0eKTqGzpy01j9SBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649749; c=relaxed/simple;
	bh=7mCWKmsWvh/ZoiGpWL5uPaBYS2+/oCLqsMZR+ujRYuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WswYvUqyu17QhsbObbusjUi7YQjw2DaIpv0Isu7l/EMtB6o5XddvxY3QPrn3DdBZT/TvpxvmaGWyPg42WexGZL3AaOAdCbgrnQuQwBbCsqe8Z3bBNuaqQPGe0IjSUMdly287lTIooaGQ/a123CovyfIY2qmc++zhPqVjYUEsv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwD7zTXA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwD7zTXA"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3beb504c985so62579b6e.0
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649746; x=1707254546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7IP0miPNvtr+ajfcDCLcomjndNqqOknwYRYE7egskI=;
        b=EwD7zTXAw7/1aOE4o0iQbDvNn8abJrtLm//RxofJCGhvVlfFt16xjSqiH/oAY8bqVp
         gFuoKO+RqfL/YAawJQ6MEKATv8JCnEeVdhwAwRHelCU0Y95Ey/gQPOjF4xYppC9sRMKJ
         1zuHewsEauj7oXlEs6XZNWmwztOPuIXE1nQ7azxWV0V2LYn/fQB7iHUoRAKyOmHMlmA8
         i1bjNcuzewzBgIicE7DT5GOqBByhhsQDCk0AmvEhDd598Sn2ko6Mj9yXG9LYEA2uIjrx
         JOLBSEmKCFRiWeUM1ldEF1S1SR+SKM2Xx8HqIcTU/JEParq8xGFih/AiS0IGzcAdrrYM
         t9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649746; x=1707254546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7IP0miPNvtr+ajfcDCLcomjndNqqOknwYRYE7egskI=;
        b=ZmhW5kx20ztrPEVA7ttj4th2+FqyDvZIKk6NWL9UGAFkBxoyizJSfeXfAX/n3ZkBNT
         8/ZDHdVpZ7CMktbHysk4fGe9pFAhi/GaqCXdaL4yXJq/GKQ+1oukmDeP4SRkT+XbXmdx
         5heCeX8oKhPvj0i6NnAlKTQouoMfcfEGxMp8fHFkMZhAXFn4DAdt5yCOHbrV9IxYkam+
         zW+g48Oii/GoOAviN8AAApoBB1M3LM3+oSetLsWgHIdGwqEElqKpjhX0O6tAZgV/ibf2
         m3kycr4VjWnCjq4gBgIDKclhZiK2hI8Lsbtf69rnJ8cXBARY+fvVv/OPLhItceGq8hnB
         ruwg==
X-Gm-Message-State: AOJu0YxKJEWmECSWXCeImg7JrRmDHidFEU8+AY1N3htleq003q3jhzg/
	lRI9CKTJ8VCEVjOZuh8kbxgTYU/X1hnwb5C7vO/OBwYeCH68GtcEk/OlTGK6
X-Google-Smtp-Source: AGHT+IHcyiSxXlpZ6XBiyLvZtim8sasUUE2O7Cr5IEHkfQZd1yYVlTWUc2Vy5eNVnN7L6OCHtTsE7A==
X-Received: by 2002:a05:6871:e78a:b0:218:6f54:966f with SMTP id qb10-20020a056871e78a00b002186f54966fmr581835oac.9.1706649746496;
        Tue, 30 Jan 2024 13:22:26 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:26 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/17] build: Bring in more ell classes
Date: Tue, 30 Jan 2024 15:21:08 -0600
Message-ID: <20240130212137.814082-3-denkenz@gmail.com>
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

Some ell classes are still not used by oFono.  Bring them all into the
build for future use.
---
 Makefile.am | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 79645e767b05..5221b1cca138 100644
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


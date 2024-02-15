Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBF9449
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025837; cv=none; b=UE91mLmPAy8xtnCDxS4O5Rq71LSrLLfag1WVxzgvEUkuFoD58fuI02q7r05gxsbyq+8kt1N1GXcCYfk9GxLLTIEDk7HeqG8AxLXjh55Idac9H9BLrg1m17CXN/j0RFlXeg1ksd5pmU361hr8HGZgdHiEfREiVEzepfmNumTEoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025837; c=relaxed/simple;
	bh=l2gPVfjNvsRqzyuMQ+zRijio/t/jOhDmSir+KV83WWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4+J6j0V1DBm1w5b3JeFNg5+YtrwsvVTXP6U2LhW8IuxJW95KHGt08oW261ExZ0r6AuMswcF2nzZrRu11h+r99KG+L3RupKNcb5qaEYLyKmbL6iD4qKtW7gy9R+hzzMXL7DwEv/uLweiZKYj38KG+7ui6VEh+j5k6IeLamIiILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inqGlbR0; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inqGlbR0"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-595b3644acbso974711eaf.1
        for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708025834; x=1708630634; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P1MM/CyCF2vMPahKb/uJ+dgGAslLHqsrJgZ+jqOmWU=;
        b=inqGlbR0ZZ6CHaH7AwgT4zu0s38CCEWbE62y9x6oQMidaDHi2loFCGRTIiEUHxxOK7
         bm/C4SjKW5GKQ50pXduqhigwzh/AKyCV+vTrNJqUkLFZI71ET712vtOMYEdr5824c6pB
         /GNQ6XOTNgluxVdur6vdyriB0UjqlCHC21Spc1kjtQOuM4cMLp/sWYLT8HOYFkq/LaTk
         y/p+St+Ls4Ia4sXWKudkr1KXH5zwSwgkgbjrO5KcX7AddGD8v9MJ2z/iN5VPyc+dt/9X
         WLxe6PPab9tUCEF9v9AeEbBNsOkuljArB2w3r/gg9nkWLkO+Q/gmf6ZP0jgbwdwxudSc
         CpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025834; x=1708630634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7P1MM/CyCF2vMPahKb/uJ+dgGAslLHqsrJgZ+jqOmWU=;
        b=o8obFkMSkPuAnhpSdZr4GTIX86PSqj5OKnIetQ4QPgD9KyHCtw1+7k9PxbazGdKP0R
         BB8YoikrS+roVFrUqiy2SCSSEcOsq/4I3/2G2aGVFboi+t6dtXhL6PCafN9XKI3TnQPT
         tbluD8fxV3MVJJYYMd7oANvMmv14ME8MblxeztGVdMQ1Z/adJx4QMDlgMxnU2LJchECc
         4qu6NLxt2hMutySaAdaVrVyL6XeYaP7ywR6JFdwqIbhFlCC2ZeRlusglYOkN9usFy76n
         NKRaywyHdbiqsfqSPU8UzdT7p3bwGRxelF4p1kAw2kDa3NnOoOnmEljgAoeV5iGHh3Ek
         zduw==
X-Gm-Message-State: AOJu0Yxt1oFbV0nE1LccLusA1PyZAIFZgvy/5DskinRIGIVfMwOMj6AA
	eyDQbvgg4+HMWqhzhT98UHgbXTnVdeaeYhY+FDDzkuM1GiYhkmDbxqJi+tGi
X-Google-Smtp-Source: AGHT+IFel7ueRd7W0ZXspFhORcGu3eg9x8Ud3wxpH3cJb+DcOVDPLgWVrihuyapYiUgsbdRtZS4rGw==
X-Received: by 2002:a05:6870:fb88:b0:21e:45a6:524f with SMTP id kv8-20020a056870fb8800b0021e45a6524fmr847643oab.16.1708025834200;
        Thu, 15 Feb 2024 11:37:14 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id na9-20020a0568706c0900b00219cf69f50csm462686oab.14.2024.02.15.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:37:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] caif: Remove caif plugin
Date: Thu, 15 Feb 2024 13:36:23 -0600
Message-ID: <20240215193625.1140095-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215193625.1140095-1-denkenz@gmail.com>
References: <20240215193625.1140095-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This plugin does not do anything useful as the modem creation logic is
completely commented out.
---
 Makefile.am    |  3 ---
 plugins/caif.c | 70 --------------------------------------------------
 2 files changed, 73 deletions(-)
 delete mode 100644 plugins/caif.c

diff --git a/Makefile.am b/Makefile.am
index da7a655216ab..8f7cc518bfe3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -571,9 +571,6 @@ builtin_sources += plugins/droid.c
 builtin_modules += stemgr
 builtin_sources += plugins/stemgr.c
 
-builtin_modules += caif
-builtin_sources += plugins/caif.c
-
 builtin_modules += connman
 builtin_sources += plugins/connman.c
 
diff --git a/plugins/caif.c b/plugins/caif.c
deleted file mode 100644
index 97b13beac51f..000000000000
--- a/plugins/caif.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdio.h>
-
-#include <glib.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/modem.h>
-#include <ofono/log.h>
-
-static GSList *modem_list = NULL;
-
-static int caif_init(void)
-{
-#if 0
-	struct ofono_modem *modem;
-
-	modem = ofono_modem_create("caif", "ste");
-	if (modem == NULL)
-		return -EIO;
-
-	modem_list = g_slist_prepend(modem_list, modem);
-
-	ofono_modem_register(modem);
-#endif
-
-	return 0;
-}
-
-static void caif_exit(void)
-{
-	GSList *list;
-
-	for (list = modem_list; list; list = list->next) {
-		struct ofono_modem *modem = list->data;
-
-		ofono_modem_remove(modem);
-	}
-
-	g_slist_free(modem_list);
-	modem_list = NULL;
-}
-
-OFONO_PLUGIN_DEFINE(caif, "CAIF device detection", VERSION,
-			OFONO_PLUGIN_PRIORITY_LOW, caif_init, caif_exit)
-- 
2.43.0


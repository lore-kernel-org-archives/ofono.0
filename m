Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B418635
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716418; cv=none; b=EWOCqITbRU7a8HeCEmDIgWrsRAaxlFeVNXLBxbeVoQPJaLHf/rpq/2jZhaSya+Y3zOlHJVTbElaaLJlH54NFiGW5vSCifJ51hwqHOb1CQpzxlzzr7P8o52Et2hk0MiEJerYl6enqG8eU+LOb45TK3T9tC1HeHqf128nqiN9SSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716418; c=relaxed/simple;
	bh=l1huZGrmXqn0UMA7l8WGq0/+fA6GNTo/pOOC3qpVgfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGDzaYOQ6X9c3lCRxElTXFpK/rAozY170krFQO6JFEg+0jqyA80/X3WonrWLLmHR+FRpcynodRilMCJvGy0XwmJ8i5geJrbmw25D40f8q8r4T1uhZfSrThMjXyZ0nFd58wGwyeV02UomkdFfD+lgra5YFxGFffIGrH8ew4AFdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjk+XtFp; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjk+XtFp"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f97e794f34so45358739f.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716416; x=1721321216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFCzeO+ozKDPkkyLFJiavIOkviiiJC4MdbLNaDE2pvY=;
        b=jjk+XtFpWzbOXdDIaVmmLKZX1q/H1fgVzgPgAbBUQGixgi99i0BA/6vrq0PFsjNOw2
         2xrbzr/3PbwsH48lM4mo52nDy4A4y1ncOwzYyH4TAmfcZNAATwLGJowU8O6SYUM/lj6V
         ZUHCY/njsihXqc6QKwVvCjxOYtGPROEiXpN0O0kCbcUIxN6XUUWKdBLKVrxxf57nUMZs
         Esk3tprnjb5ztVwELBlNPudg88xbS4NXzCeY/YgCnqlcf1eFrje+bwjqg7Chy7QG9J3/
         fB1yORY4eMkO0ng+8yhOAT2nc2HrMOxgAaouP3ItW2yQKVNO3JLFi2HSmVavEmVT7RoK
         gqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716416; x=1721321216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFCzeO+ozKDPkkyLFJiavIOkviiiJC4MdbLNaDE2pvY=;
        b=sKc8sMfqJX6R5SRvUkNTA/DmCSJ3OS2Zc2FB6EqsqIqyjlfpRijY4efDrJKuztyEpz
         Iowzj/luKxzKqkcjPp9Flse+6yJbf34WcYYNR8rD/LExNDHF3XIbRV15vpz25qZwcuM1
         EmXewi4Bc59hMra61CX6kNAE/Fk7zqET0Z+sCJGYtR0loqWcByUMop8b5wJGQk56zGZo
         q87RO0jGRBal9W/6g4EQwfk6OWKVvqYsIKrcDJl5Sic8SQ2hpnQfLYvPHN/e8iI2w678
         Yc4vizPyqJ5aVDRnFjrZ6jvIVbEVMAklDxOcV/3zGQlFZ9y2s1xwh8ktsyxS07jaEj9M
         8+Og==
X-Gm-Message-State: AOJu0YySNPbJhcHPv0RAB1uy4XQUXc43JUJxboN+Sh1R9PVS9mKts7cw
	XDv+KoRlV4u/j99LoGZZoJ8mKkXI49UawaOYPa0nErgykMvI9HAvtO+ONQ==
X-Google-Smtp-Source: AGHT+IEHLcxa/2aewW5tLAdGD1MNJcxzLSyi/iGtdlpvs+vELeV/imCk1R3q8uBImn2AeZCt0PRvFw==
X-Received: by 2002:a5d:8708:0:b0:7fa:d16f:82f7 with SMTP id ca18e2360f4ac-80004173dfcmr949542439f.19.1720716415912;
        Thu, 11 Jul 2024 09:46:55 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:55 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 01/11] udevng: Remove gps from setup_gobi
Date: Thu, 11 Jul 2024 11:46:18 -0500
Message-ID: <20240711164654.1688558-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve Schrock <steve.schrock@getcruise.com>

Even when the gps variable was set, it was not actually used for
anything.
---
 plugins/udevng.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 8e116c6605ea..1c56e2ea62d3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -355,7 +355,6 @@ static gboolean setup_gobi(struct modem_info *modem)
 {
 	const struct device_info *qmi = NULL;
 	const struct device_info *net = NULL;
-	const char *gps = NULL;
 	GSList *list;
 
 	DBG("%s", modem->syspath);
@@ -373,23 +372,12 @@ static gboolean setup_gobi(struct modem_info *modem)
 			qmi = info;
 		else if (g_strcmp0(subsystem, "net") == 0) /* wwan */
 			net = info;
-		else if (g_strcmp0(subsystem, "tty") == 0) {
-			if (g_strcmp0(info->interface, "255/255/255") == 0) {
-				if (g_strcmp0(info->number, "03") == 0)
-					gps = info->devnode; /* gobi */
-			} else if (g_strcmp0(info->interface, "255/0/0") == 0) {
-				if (g_strcmp0(info->number, "01") == 0)
-					gps = info->devnode; /* ec20 */
-				/* ignore the 3rd device second AT/mdm iface */
-			}
-		}
 	}
 
 	if (qmi == NULL || net == NULL)
 		return FALSE;
 
-	DBG("qmi=%s net=%s gps=%s",
-			qmi->devnode, get_ifname(net), gps);
+	DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
 
 	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
-- 
2.45.2


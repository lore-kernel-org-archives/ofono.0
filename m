Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92451E889
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082719; cv=none; b=qSRKaoqXjulMaqayzNtEV9/YO0KY97r8mTDKBVZwCpXcZsgEkcw+Ld9nGTXf7SEcZL5cedOxIkMrQUKUZ8AsdI3Jj576AtM1rnu6oRIET2wOw2wfD/2INCZDMRlB6rjp+s/YGchqD6r1avW7s4GwCu3KO90idm9U7MvdIpLmEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082719; c=relaxed/simple;
	bh=S4Hn4878GXdPFYX+ym9FtHFg4twCjG6hOLsSQs1aQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlQfJUg5k3wGTiO2RHEm61uwrQcJJcx2FedFMj06M0IlmZfqGl9emhi6zJPAeSsi/PWAWnrlkJ6XDOuWh8UsnwIg91QTj7myC5HotvPBL+UC21vJhpunYGfPrOGOtz4YIG/GNwnzS8NnP3tTRH2JkZitHg3dsOzPg4EPIFgOGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0CnFcrV; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0CnFcrV"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1d65a471aso540626b6e.1
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717082716; x=1717687516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7rU4PBn5KoGsoX8ivWOuaA2DyVF9qew4kW6t0L816Q=;
        b=A0CnFcrVRBbLJuA68LIBkU4d5JFhVBHik8Ye5NhfF6oYCl2G7XUv6QIlM0MfjKPWp0
         oAqtNCLt6agpOC9HkKV4qBciQ7V0uS0eKqZYzcIpnifobdEmhILf9kNbCLTbev791KPi
         S37iv13XTOBd98jZKO5dlkfc3+y7TpdG58JTyg3N02TmMiBw3ODZATF/WI/eIJJZ4YQE
         4rg7/Wd5mC0uheUiNJsnFxUDA/zJ7/8PjZoNPyBalXvpo/yl6+DOMdOqzZTFK7/ylQMG
         i2yrMuwdnwwwVhMh8nErld+YzuXr1nlTueZzZcQy3PLfuThBa1l3Xc/86WS8sxJvv1i+
         PHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082716; x=1717687516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7rU4PBn5KoGsoX8ivWOuaA2DyVF9qew4kW6t0L816Q=;
        b=PRFc65l6FH6U/+VFlQ+1OWAXYZz48WO4rxEIY85wdYjtBr3zIFPposGI6hutP386o/
         22Gc13ezYNlHPvA1Kw/T45tsrftIKtyhpbwuG/0FOwfZsyHpZBn+VZUZF8DkamD7TMAJ
         3vi7/lrHnXC0ZpgcTRwiwH4Xh1qaUr8AfKn5weAjVEFw2arA7Wb1rcjEOy9v9UazeUFb
         TMvt0IXocGg1hI3c3hs7WAkMN/+vtrpX/7nNpXjXcvQyEbDwq+Q/F84JlfEtAM0H19ZB
         JHsARKWf+3d1XMBFxrMMmS9FjhOfDHgqI6P8+uCnFgy5+GpXYEUFvgy1m7Id+0amK0C4
         Ztvw==
X-Gm-Message-State: AOJu0Yxf1dR9r5yNUL+cfHrshQvOcJlIPjHLznkrCBn7iiQ3dn8M+qBU
	78Z7Yp0uMHk0k140xeo3UmSjfe6Ah8GSZPicZqAg7qmAARKeOxHvZJNi/g==
X-Google-Smtp-Source: AGHT+IHeCyTmHEkzrAS644GMFiq1FhqAF3wgJC6z5SZO7A4peFCYxNY3lMRY5E9GfxaixbBBAzcWWA==
X-Received: by 2002:a05:6808:6246:b0:3c9:c4a3:41a0 with SMTP id 5614622812f47-3d1dccb9ab7mr2433954b6e.33.1717082716544;
        Thu, 30 May 2024 08:25:16 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1b36c1eeesm2017889b6e.23.2024.05.30.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:25:16 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] udevng: Don't crash for non-QMI devices
Date: Thu, 30 May 2024 10:25:02 -0500
Message-ID: <20240530152513.279243-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases where the modem detected isn't QMI, do not crash when trying to
print the qmi devnode.

ofonod[278551]: Aborting (signal 11) [src/ofonod]
ofonod[278551]: ++++++++ backtrace ++++++++
ofonod[278551]: #0  0x7a779c5cbe20 in /usr/lib/libc.so.6
ofonod[278551]: #1  0x413470 in setup_sierra() at plugins/udevng.c:497
ofonod[278551]: #2  0x410a67 in create_modem() at plugins/udevng.c:2557
ofonod[278551]: #3  0x7a779c80b551 in /usr/lib/libglib-2.0.so.0
ofonod[278551]: #4  0x41955f in check_modem_list() at plugins/udevng.c:2626
ofonod[278551]: #5  0x7a779c81f43e in /usr/lib/libglib-2.0.so.0
ofonod[278551]: #6  0x7a779c81e199 in /usr/lib/libglib-2.0.so.0
ofonod[278551]: #7  0x7a779c87d3bf in /usr/lib/libglib-2.0.so.0
ofonod[278551]: #8  0x7a779c81edc7 in /usr/lib/libglib-2.0.so.0
ofonod[278551]: #9  0x5291e6 in main() at src/main.c:316
ofonod[278551]: #10 0x7a779c5b4d4a in /usr/lib/libc.so.6
ofonod[278551]: #11 0x7a779c5b4e0c in /usr/lib/libc.so.6
ofonod[278551]: +++++++++++++++++++++++++++
---
 plugins/udevng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d3ce3d5b3f7c..07c87eb8aa08 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -495,7 +495,8 @@ static gboolean setup_sierra(struct modem_info *modem)
 					get_ifname(net));
 done:
 	DBG("modem=%s app=%s net=%s diag=%s qmi=%s",
-			mdm, app, get_ifname(net), diag, qmi->devnode);
+			mdm, app, get_ifname(net), diag,
+			qmi ? qmi->devnode : NULL);
 
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "App", app);
@@ -574,7 +575,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 					get_ifname(net));
 done:
 	DBG("mdm=%s pcui=%s diag=%s qmi=%s net=%s",
-		mdm, pcui, diag, qmi->devnode, get_ifname(net));
+		mdm, pcui, diag, qmi ? qmi->devnode : NULL, get_ifname(net));
 
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Pcui", pcui);
-- 
2.45.0


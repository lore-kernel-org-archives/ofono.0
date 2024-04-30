Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB191802B8
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498704; cv=none; b=OrchG5a+GGfbr35tiNWaSCFYWwYDrOqevPRDkTxjaE0NwCvpMvYipdGWfKCV8qkyFMje9rkjl5RRDv4H6WadFSpxIYk8MmSDt8CXw1OwwQB6b6Z6mMT5Aqd7RNWYqe+Nlp28EX/lkgHBS0kYTfOT+Zbm15CCk5Mwa1frjVPXTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498704; c=relaxed/simple;
	bh=a/lYLfb03jVFDSoT1v8f0QUwtMOTWE6AIqEK9CUp6AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3SSzeSrXOb++iZzOVi/7VysylsKpyBbQws2v5CEuRE83SfkiRhUTfQhiN5JHPLve21t7+AltpL0xvA0I7L59aDiJIhMsnb8A1dch/DcbwD2c6zpI4d/7067iJYv3ObD5EJBrbQgs2pPtfAwfMByN7wMnLhYQrdBvZ/Sm+41zoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBuDlQDf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBuDlQDf"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c86560e96eso1358080b6e.0
        for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498702; x=1715103502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Fj7ipuTHRC0aCmoVlOtN5Lw7wZvySBJnbPzd9nyjI=;
        b=aBuDlQDf9uF6ZlFZDPBbK/B8p3PsD5+y3CRvMZFjmqfiTJeWUvuh8Ci6CroQyYLc/H
         SPZ8mrX5P37mNGeG6PmUiBANEWFXiD8qSKD2MVeoNhh/l7ZKjxEQ5qDMxYI6lLnxrca3
         HTJQvqAj0Q4SShMTNzr4NkwDYGuuiNXvYm0D4eqPFGthQQG/BQGfEX6QwXcF4gPpZg3o
         uyn/9dnyPcBKMvr6uJEvvLOqAVM89mCzW+JLNbTc6BVNe2rYS0KQpFzWVfP+6cad51yK
         /bGvDce8PBydA5g2B6E71gzMUiBB1eJ6lnjaQXczQzC0+u6g+DMMiaBPiLxvKTZMblOL
         DOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498702; x=1715103502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5Fj7ipuTHRC0aCmoVlOtN5Lw7wZvySBJnbPzd9nyjI=;
        b=a7QiJKB/Zu5CYdJtxfxwKw2KpQigQgW1wZ2jJ9H4fHbqDJyAjTi7kMjIeK/vjm0Ncv
         R3DWHB/+FWpRucHZyscmKL9TeXZsvH8rsMG3xcmhnj4k2zHEMV4or5UQnzqF+ye949+o
         DIBiCW4V+mbNabcq4UBVtUT0aEknXl8yrsz8LCmlPnv/REx0x0xXmM9WjboNcP+aPCWI
         JJFCaB2rXSGWu+6kpL5U3XEfFJRx7u+KFvhzn6goPGz8P5cwUDTMW2v0nCcqMQexyysL
         IIP28KyPohhiqnMwPKBA1l57rCOS6xKsi/TamOQlKddShN8OQxLWueXUkiCZLry5vyxt
         F44A==
X-Gm-Message-State: AOJu0YwR7PP3GZZNoCILxhwFDAEuAFTa+0LE0b0gy3pWIxGnRYOHAZwt
	D9UsGxP6MBEkrNZaSOl6RmW0WeRUPUJTzZ1hnj1ejD7EtbSv/h4ejgmpCw==
X-Google-Smtp-Source: AGHT+IGv5moDAK/m0cQv5tNQP7auVKZe31Bca/xCcfwSjHRdlFgGO9L4HM5v8fM3Jy1OTkY7sjqh6w==
X-Received: by 2002:a05:6870:f29a:b0:22e:d572:271b with SMTP id u26-20020a056870f29a00b0022ed572271bmr145791oap.58.1714498701969;
        Tue, 30 Apr 2024 10:38:21 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dy25-20020a056830211900b006ef91c025d3sm77440otb.33.2024.04.30.10.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:38:21 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] udevng: Add support for Telit FN990
Date: Tue, 30 Apr 2024 12:37:35 -0500
Message-ID: <20240430173817.3044-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430173817.3044-1-denkenz@gmail.com>
References: <20240430173817.3044-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/udevng.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 243dcd6e91ec..83e8f3e98a22 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -834,7 +834,8 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, subsystem);
 
-		if (g_strcmp0(info->interface, "255/255/255") == 0 &&
+		if ((!g_strcmp0(info->interface, "255/255/255") ||
+				!g_strcmp0(info->interface, "255/255/80")) &&
 				g_strcmp0(info->number, "02") == 0) {
 			if (g_strcmp0(subsystem, "net") == 0)
 				net = info;
@@ -849,7 +850,8 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 	if (setup_qmi(modem, qmi, net) < 0)
 		return FALSE;
 
-	ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
+	if (g_strcmp0(modem->model, "1070"))
+		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
 
 	return TRUE;
 }
@@ -2037,6 +2039,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "telitqmi",	"qmi_wwan",	"1bc7", "1070"	},
+	{ "telitqmi",	"option",	"1bc7", "1070"	},
 	{ "droid",	"qmi_wwan",	"22b8", "2a70"	},
 	{ "droid",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
-- 
2.44.0


Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB25B697
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914498; cv=none; b=W+mo+D4uhDHea971+mpSibGNs1h6R5zTcsQ55hAsL9N1hwqFRv6ha8TZ3exWTaBX6BV4YMuBVvAuzif6MZGRJa1xERMp3Lls0b5Q1P4naOWAxTg/7xDnQvLcvNpYlwNo58VwuWaUF6035x4olstCraYKMeeRtOAjEMypeW503dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914498; c=relaxed/simple;
	bh=zYukKacgjBk5sjwZjSTp+TgvRl7rXLTUNOPT8nLntg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG//j9JgwfrmMEI4sNnoU6E3nPe03Hjhwgh4nC6Ab55GDd3osZyKOtvluICpHPdlRGKOjTc2tb1gLrxl889iSeP/PPkyRW0Yqb9bWcNCzs20EThMR242uHNtV9UiPo/O/7yoKDeaDjYXqeS417hBDMr/oSbbDkJLCAcFTX8EJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxbBQxi6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxbBQxi6"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ddf26eba3cso1951993a34.0
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914495; x=1707519295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqSTsP42ny05nEPplpfoYzMkecwWrPoMKfxMzWZWMw8=;
        b=NxbBQxi6xbxy4yUsgkjXLaMdLIir8TbulJM4rxO28HJJbNIxswEvbMjn7PMwGsm+Lo
         uM+kSZUFHTqbLXirBjszu7psTr/UCyIHKtFZhKdAoBL2pM4mFkbdJWNh/mK8XoBsjAIY
         y1u0uPS7WY7ta9gacMOVucXzjhQvOXJpbUVgfbH1QYfvTqayUPh8NlCX3oawIkaoq+Jz
         UHJmG1z0pACd3N7jmVyTcrblAc1Kojdd/KsotjersSGCaWPMgZApr0ZFoTggbqeOXB15
         3Z9dcZV3wDn0BlPthmfGl6G7Cx3l0svhTfUkAR0nTQ/0BJiI4AKS9iTCNZnb8t6LFcHK
         fZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914495; x=1707519295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqSTsP42ny05nEPplpfoYzMkecwWrPoMKfxMzWZWMw8=;
        b=sbVeqRYWGKz7mgTA+MLcSZSYrVnVV9bxaTnVyb2a2Mkx1mpOUUObclVMaUMcDjXvq1
         sVlh1ty114xhGngbKMIhcQ7h/kDpW2GcWXsShtxZYjabqeHOQWJlSZMQKriVxy8U+CUe
         /DqEh7fcfYPDsBdXbuZEGAC5GHnLRaEbkoFuwkG+SphVwHG7Ra19m8WvEoGC9Aotcdi/
         XSlNGJMeoUkGD2muKw7h3ayZo/FbPg2+qMqtw+rS0cSViWmpHSWZohAgtC8phap8JPN5
         92s0JjwVtUl1Eao0TyuoH+rbayKZZLNmn0T2cjypCCEkKzDjrRovwDpcrnw8PfGRmv73
         +F9w==
X-Gm-Message-State: AOJu0YyyWLSvoLm21Bj2ygxDYJ3vjfqdyoUIbope5Tz0RCUUrE3MpFz7
	9tZkMhwzgeuvRxb4XFVhIXA+1MdABpkZPVTduWik6NwRAQK8F5j6ZYTz00y5
X-Google-Smtp-Source: AGHT+IGZpFu5Vm3VoOs/REof/QYMI8Q5JPjTrnhF2HpJLB0SLezgU0EANtOHGeuPqn7CVpKxEDlrBw==
X-Received: by 2002:a9d:7dd0:0:b0:6dd:e530:8c12 with SMTP id k16-20020a9d7dd0000000b006dde5308c12mr7227827otn.4.1706914495638;
        Fri, 02 Feb 2024 14:54:55 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:55 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/18] build: Enable _auto_ syntax
Date: Fri,  2 Feb 2024 16:53:36 -0600
Message-ID: <20240202225405.993792-4-denkenz@gmail.com>
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

---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 551f863538ed..b866e5487443 100644
--- a/configure.ac
+++ b/configure.ac
@@ -299,4 +299,5 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 AC_CONFIG_FILES(Makefile include/version.h src/ofono.service ofono.pc \
 		dundee/dundee.service)
 
+AC_DEFINE([_auto_], [__L_AUTODESTRUCT], [autodestruct syntax])
 AC_OUTPUT
-- 
2.43.0


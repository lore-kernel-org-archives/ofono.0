Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D0381AD
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716419; cv=none; b=bU7sXOcjHm+8P1bbnG4iT3jmfOwMxlvvCWSGvyf2eHchYovSly9GyHjUqWCs57kFLTgDVzCpD5gQN8q4pXB3AjT97cGOGFwQP1mwptVdU4TAjNgZdKm2/6HBP8C+MnSzMcmNzfEU3hjKN3rO+K3ema4vMv8LUdKJGgnqay/Hn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716419; c=relaxed/simple;
	bh=9OfMbmefocTxz1r7FICxk+Xr2SRJJDI01xA41kQE6VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/UNDNICz1lbSaGq74A5GqVH3E7vwP1CQrB+CCJjHoLm/krr3kWzVLdpew53tst0Vxnjh3qLXSkZe+RS4Snzqyk0Up1GEHxxHGs4ayR/j5wEPk0WkPU/jMouV/rhoZFQD4AawT9LHeCW9wKDmTOiIP0zZF6XReHG8gizrG7KlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLKDEvH/; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLKDEvH/"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8076ef91d8eso39196239f.1
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716417; x=1721321217; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK16Ten5060hKFG+A3AC2gAnT+Mo/NguIgnK/IBd7cU=;
        b=CLKDEvH/gEhjc8jfahpQfAA0VHf50+C0g59NYrgrM5Jq1WKc5i5iCOIwA0koBjwMrx
         kn7nGO+PTy8MlqcF89RoQ6Yr8aEgQwjJVYBD9z7+4Z0kPPZvrZVuMgKrjEtAinuQBmwb
         GpFJPGRkgpE8JxwOyV6AH/6oWRl+Zy0Y29Uy50Soc838q2J/RuX9MitjArbn/Em4CZiz
         D7XF7Vqxe9zGNFlOH3IF9zH9OjiP26dlrRD/R83n/cbiy2h2y8Eg7crqqdbkUhDQJRGV
         DXej4Vu6duUeQR+VK2uT2ra3PaHddce19m7XL80ObsrpMsjhn/xJPFTigec7v1NaaW3/
         GIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716417; x=1721321217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK16Ten5060hKFG+A3AC2gAnT+Mo/NguIgnK/IBd7cU=;
        b=q8dXHxcTi1jey9D7c/3ja17+XQItKVrsU6h7hZcwBdOYSjalM5D0UIXBRIyb0uABxI
         ozgIszXeoFdu4NFPcE9cRRJgs4zdNuya3ofJeJ4sYvTnrl/hpb3mla2vAAHznkhOuzTo
         jyZMoNSpRM4Zdm3Bb9FGvkaa6vT3IZE3qK9zooKcR2wXlToLovvMWDJlEFaIlEQ3BeW9
         1y9MgN5xZYOdAWMK87ZLF9vfwC/hQfqys+nXpxO/SxozV2S7JQKfAzER3t2x+fVfQeC5
         AmpCovPTPtqw3Fn/97HT3k82nCx9Pex6I7BhA0M2x5pi9E6RACDNHYvHxnk1tRcBBogZ
         ufKw==
X-Gm-Message-State: AOJu0YwZdNoTHzB/NzmdAlaWhW1NeYizxa7+wvjrcxyH0D2082C4l0rZ
	GZyV4EwG4uSImXTyd398BqgNy7gdTxDfHwk/XdPwEQq6A5MYiuP6YduBmA==
X-Google-Smtp-Source: AGHT+IEHsEzcihbHfAyA6qn4/4OjAzwJHQmUe5sxpwo9mTYXvx3PUJIWxsGffPr6n3e2BD7aUY5uiw==
X-Received: by 2002:a5d:9f0e:0:b0:7f9:373f:7202 with SMTP id ca18e2360f4ac-8000192ce98mr1060858439f.10.1720716417322;
        Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2 03/11] Release 2.9
Date: Thu, 11 Jul 2024 11:46:20 -0500
Message-ID: <20240711164654.1688558-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcel Holtmann <marcel@holtmann.org>

---
 ChangeLog    | 3 +++
 configure.ac | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 5d4feff7d8ae..48c6bd39bca4 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,6 @@
+ver 2.9:
+	Add support for QRTR based devices (MHI bus and SoC).
+
 ver 2.8:
 	Fix issue with handling USB TTY device detection.
 	Fix issue with handling GOBI versus QRTR detection.
diff --git a/configure.ac b/configure.ac
index c0053df840ae..3550b8a3d8e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 AC_PREREQ([2.69])
-AC_INIT([ofono], [2.8])
+AC_INIT([ofono], [2.9])
 
 AC_CONFIG_HEADERS(config.h)
 AC_CONFIG_AUX_DIR(build-aux)
-- 
2.45.2


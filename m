Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E2149C48
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160364; cv=none; b=nWLDkHkQn387F8jQi0C3HOucCbH7WyXJV6uk7+7ggKq01Gm03ppM1mFEfmrJTba+GKKZAl486u2OnQYRI4OX/wA3y3WhkEbJapMVd43rgSf5SWdHhNxFIn/wAtYPJjupv/rJWVs3meyi1M/bM/Oez6Iw9i5NDxbGNgw9rEQz24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160364; c=relaxed/simple;
	bh=HKXA4XdTxGefTIGQ80/Qe1Utjgr/lo1uHDKL0Rd6KzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2mbEwqOsDY2sDSMTwZpJAGCyIJRwFLlEtiqINZ1JwHP+WADYl9IiONZSLjqoCVxgsa3L/zdW4W+/kuyLYc0vaSNMz6b+pbeTpwnoUeusQCpcYVoON6YdhRanLpLUV/k+AOY0hbUO7SxtcPwwvfiZVQxVXLiaGzSBC2xlktu6Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk7slDTL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk7slDTL"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e696ee8fa3so604136a34.1
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160362; x=1712765162; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy33ebB5lB7yt6ni9z0zmRuorlB53ZnKc680YtOSEc0=;
        b=Tk7slDTLx7rh80I7i5xdqTEa/q6xbv+fi9328kGAf0TRTnParocVszmZEOtvmY5Ibx
         ea9dRSTLlPv1ssdQb/Xf97N5FaXFqU4po888fr4SLfLSn3u39la8ou9A6Q5SByOXwqKn
         AGqNspSivhRi1l1KDiq8EK/3IelDOvkR4nnbgX9IfRxTTPWKaZ1q6T2mIZwYNpA1Xboc
         p84ilEYp8ikkQaRubkzKpN5vES4DERJuNJJgo2ldbNqkIteSPrfsrGN5DT3AzZlUogsO
         1/Z7PEtQTCt0lULJidSaMaiSAzVt4amSzUNOq92zQOCl60+8rQupVXI9nx6CgBIJq716
         Hbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160362; x=1712765162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy33ebB5lB7yt6ni9z0zmRuorlB53ZnKc680YtOSEc0=;
        b=UrOfBIhW0bAFsojMQPPgdcd69pHMvo4WYM8kGfVa8mttXZB/0+ab2jeJOOd08RXu0V
         /cHOC6+qjqmSaqp2xlGMjs7w8IM+C/ERcwRJZHgZxJEjKhv+5OarsHglIx+nEbNUsMhQ
         h141xO6eGzBRcaSx0CLsxS8x6dZuUgclunXZHUwOOYJMRoci2Mvy+Rf2thUWucNhtR0f
         PWIBg/X53RMK8Kl7abzVA3SuzO6xQ0/xzovNoU+WdwOrumyqVDFBZtcq1ID8de5ME4rK
         alEJjJJZJodRIOx0GQbAGVS1GfxLbsEXPkWQK1mMH6b2tpUaM9SQ/NrWZrSSTxq4r88d
         Pf9A==
X-Gm-Message-State: AOJu0YyCZnmXojlI7dONJ8T5wCYZ+uLcNtE7hRf8o5x4LyOFc4k1olcw
	hWlJJ6vCAsFjCGjfdZLaIcBfoI6c5Uo6sk+Ty+ig8LTJkbNqPhMjLBW06t1i
X-Google-Smtp-Source: AGHT+IG3aVwOdHCEN6MNJvF1fyg33ZyaGReYVOPCCWUshoOLKeLvoV/ORqw0tsTkf+vdJ5m0Piky6A==
X-Received: by 2002:a05:6830:18d8:b0:6e6:bc25:1503 with SMTP id v24-20020a05683018d800b006e6bc251503mr1335357ote.12.1712160362060;
        Wed, 03 Apr 2024 09:06:02 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/14] data: Mark some MVNOs via the "spn" attribute
Date: Wed,  3 Apr 2024 11:05:27 -0500
Message-ID: <20240403160557.2828145-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most likely these MVNOs use GID1/GID2 or some other magic to be
auto-detected properly.  Mark them using the SPN tag so major US
carriers can be autodetected easier.
---
 data/provision.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index 6856ce0f0eaf..e55ecc6f8d67 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14372,6 +14372,7 @@
     "ids": [
       "310240"
     ],
+    "spn": "Ting",
     "apns": [
       {
         "name": "Ting Data",
@@ -14430,6 +14431,7 @@
     "ids": [
       "310410"
     ],
+    "spn": "Tracfone",
     "apns": [
       {
         "apn": "att.mvno",
@@ -14450,6 +14452,7 @@
     "ids": [
       "310260"
     ],
+    "spn": "SpeedTalk",
     "apns": [
       {
         "name": "Cellular (MMS)",
@@ -14480,6 +14483,7 @@
     "ids": [
       "310260"
     ],
+    "spn": "Mint",
     "apns": [
       {
         "name": "mint",
@@ -14495,6 +14499,7 @@
     "ids": [
       "310260"
     ],
+    "spn": "US Mobile",
     "apns": [
       {
         "name": "US Mobile",
-- 
2.43.0


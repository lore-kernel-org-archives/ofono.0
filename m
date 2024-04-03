Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4F149C48
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160366; cv=none; b=aVZvs3IACMv2oH5H9Y+8j1MIfpTPUtK0CTEmYmuNYR+v3+JkMKu12l242zKTZk6YDH7AQeqHVOhz/lj2YZakq+BS49xBN6JNiHiKYaUnG9pWbr/hC5DI2vVqkTndqIy5o3khu0R5O0EmYhZFHebP03fHeeG0lZravxL6e1OEboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160366; c=relaxed/simple;
	bh=8A/vRDi5jAwzUJ1AgQLwUt184NvPYujph9PsMG+FPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLd423DcluvsUm7NcF0/w96SxeB0J2x17a7xH3vdMCqgjGze0oTRmvCrFTfFfF3UO0tL+rYX8Tn0zr5KAU0et3MbWHoZ1QyfuSdDGtza7rvuqYxEHE32AXNfLFqC3aLuNDKyV194/VdiJ2VKfjmAD2OqcKe4KIzWrdBH+4qaKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmsDvAu9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmsDvAu9"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e89c87a72eso13579a34.0
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160364; x=1712765164; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODeDIhWwvZpl8x9SSVdYHwsb69BrXgQE4y8wCTK2JIA=;
        b=AmsDvAu9UfV+M/eS4KQsVMAW/uAo5E2qXji3ocmCOlqgvfQWNU0PRnBuzdBsax+k5/
         y8hzY9WE9AR/hyLvgv0AbFPFcQC5Jj7coEIGgHugcHE2o3xT3tQLMMjvhCplw8h5N5Zg
         RysPrL+gTlYoNLu2b6LH5EYwEB42TPFA1HSjHZZLb6CVRAbbdWRNTF+yNp+JCue0/L9x
         QHy2K3CHbEF2GiSF3mZP+d63+RhohpuYZbdrkPbEy72gOvbITVuROQGenL657rxaAHIP
         rXY7bKpzjW4IGlVqIiBTWdNUNUC+e/Dsu5UhiBayBL8aqTJlDZWItNQ2PzhilU/X2IAe
         J3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160364; x=1712765164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODeDIhWwvZpl8x9SSVdYHwsb69BrXgQE4y8wCTK2JIA=;
        b=q0OdRZ06SDyf6EqgOp5z7hMrCJkllOxVBjnikiN2ZYfIcKV/JslxsgaIkgVPP595l3
         F+9GTsZlZm12nIdTwZvi8HEEHYsnWZn4XaCUv8ZyYTC9j+onYzY0/O0NlCWxnzIyFxaa
         xWGGFKPQMQfkzeamhVlLT2mPsoqyX2RY6oIlMv+nyag5Am7K4Ckx+kq/INc+BMZgs6Za
         scylIATZnJnzTbu4lhyC1fpEONcSxcDPq63Ey8gZI3L/fy39wXnaNhfXOtboesxg3v7u
         /LNaCZ9dvZvbmkoCfLIa6TauhIwF0yJuPV9f33WGZm/VxPt4BQw8o9MXXI6P3Vd4l3TH
         GRCw==
X-Gm-Message-State: AOJu0Yz+ZKvTNzL3U6TYAcq9Y5fiLmdpCoSKOAEUECpVQhTHFTQpnzBc
	TY5r3bx39vU1JYbSzWP60HzhkoSyn1s8Ccv71JRhGHFqYgjI6x25ykAu+3cz
X-Google-Smtp-Source: AGHT+IHdiXThhm37bYTYTkqHnB8+eh5eQ+UbjwCxCmbOaHxwijz1KKVaojjkrMboliskuXrIzsxy3w==
X-Received: by 2002:a9d:638f:0:b0:6e7:39ab:a9df with SMTP id w15-20020a9d638f000000b006e739aba9dfmr14283650otk.36.1712160363612;
        Wed, 03 Apr 2024 09:06:03 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/14] data: Remove RESELLER settings from AT&T
Date: Wed,  3 Apr 2024 11:05:29 -0500
Message-ID: <20240403160557.2828145-6-denkenz@gmail.com>
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

This seems to be yet another MVNO, remove it for now.
---
 data/provision.json | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index 80abd78e6507..cef6e34e1ae3 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14181,16 +14181,6 @@
         "mmsc": "http://mmsc.mobile.att.net",
         "mmsproxy": "proxy.mobile.att.net:80"
       },
-      {
-        "name": "RESELLER",
-        "apn": "RESELLER",
-        "type": [
-          "internet",
-          "mms"
-        ],
-        "mmsc": "http://mmsc.mobile.att.net",
-        "mmsproxy": "proxy.mobile.att.net:80"
-      },
       {
         "name": "AT&T M2M",
         "apn": "m2m005246.attz",
-- 
2.43.0


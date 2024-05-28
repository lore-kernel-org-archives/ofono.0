Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7A175567
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926893; cv=none; b=nmCAUz7CEirkDkPfKyiqeOPj002iDgTHpn9PpTx5nR7sc+NhEWbQBqPVjUj/T3DM/S4oFBAI+OK40nW0jaibBC2yK0DE0rdqcIaxoL9UYyuEvXAHdhDBVhtLf5oMMFiOmLKTcc0/MQex8O6DOyXBFhgLUFyGRqdW7VhVdf2pqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926893; c=relaxed/simple;
	bh=EjIbwBw+sUaBzE0w6i9ZtL09Z0hvJ29LLetZU+XiGSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBbpSZW/VqcdbqnzoLX09wS2bJrapmYwdZhcRL+BxKviXnGV+MgrFOeHo2Gpcu+6oJA4GdDmyvdGJ7/CghCuQDunIKrOgdwtJdADBhwayslbZlyUZCUCPrQGd98W+/k/jPaok86Gd6FEA9qUWFwYvMuz4CU10JQtV/gQks92kqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLHSv2SV; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLHSv2SV"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b96a95c5e8so804159eaf.3
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716926890; x=1717531690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPFxlL+0bKaYxHYNOAbRHPZp20ZtxpOAnIQhqhSg0rs=;
        b=DLHSv2SV+03JsqLdwWQTjN+gvqRevtmrCArKnf9w7MXXisw2/T7w8PJBord6xHUKFZ
         GIkQpDqSviGYx40cUxNkNJBS0iqMb6BewZmK+7ScktPoEqnvApJncoaAHNDHeSDcYl+u
         dlaCvkWfjWG/Dj/C9i76XZr9W7e0GX3/bteZyJ2I+pqg0sRjmQHDdDmVeqH/JHHs3mPO
         kqqqzb3mEnkWus5z1jnED/d/v8bwFwZHh4ACLtyZwoRLib1vRgvyChSr7mTcva5NjmE6
         LAlr/A7nLg/GpwLHyvOBevpzSfYiv6m3DpChb42Mtk2P6x7m9cOXpKkDHlzxeQB1jebx
         uU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716926890; x=1717531690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPFxlL+0bKaYxHYNOAbRHPZp20ZtxpOAnIQhqhSg0rs=;
        b=rm1boJ5ImIiVbbdQpJf50LtHbtegZ1hUlFiK/NjUAnJEvzixeeJWOwLMIutRlGQv/O
         3ltQOhV2TfuMZqklCBFAqkXOFapRWo8CSknE0yeMpw/6/9SUxGPLs/YP6UHGT1rfzog4
         xpR4cN5I9EQAxJ0bTyvDYD+h1n+cb+0Sca3kGi3MEPzLM/lUb5BOvaEQsZzGyr3t/wGh
         uII12bwl5Db+R8Qg+VWslLCVgqHo6Bxmky1fxFinMQvQTNlblH/CGak6Pp1m8auMos3J
         Smax9uRq7DQX8RY8KjfTk9fXfXV3lUliqiUBtyOyKiZsxib0WgkmPq+0obLYZkocn0Wp
         EkZQ==
X-Gm-Message-State: AOJu0YzEAQFD1+DSSkpTy0ZSr352TwRIsOGm4G+TgM9P2DlgvsfRNAj+
	6Uf2b6MC+vj7EWU0fB1qjCvZORO9quzDIYBvZ4AOC4ETQY4jz64bb3E+9A==
X-Google-Smtp-Source: AGHT+IF64JyY7VAzYO/ydzrlQENAm+HfH5h3Qu9axYp9t80KFnFURH2sbb1TZd5C34meognGqLcBRA==
X-Received: by 2002:a05:6820:1ac5:b0:5b2:811f:4d71 with SMTP id 006d021491bc7-5b95fbac070mr12666577eaf.2.1716926890461;
        Tue, 28 May 2024 13:08:10 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c4dd7e8sm2317688eaf.28.2024.05.28.13.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:08:10 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] atmodem: sim: Fix CRSM result handling
Date: Tue, 28 May 2024 15:07:54 -0500
Message-ID: <20240528200808.239108-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit tries to parse all CRSM lines until sw1 and sw2
parameters are found.  Unfortunately the current logic does not break
out of the loop once a valid result line is detected, and the iterator
is modified once again, becoming invalid.  This results in subsequent
operations (g_at_result_iter_next_hexstring) failing.  Fix that by
breaking out of the loop as soon as sw1 and sw2 parameters are read
successfully.

Fixes: 7802d80a9619 ("atmodem: sim: when reading sim files, avoid incomplete result lines")
---
 drivers/atmodem/sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index cbf87fb4c095..5aa89da38905 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -126,6 +126,7 @@ static void get_response_common_cb(gboolean ok, GAtResult *result,
 		if (!g_at_result_iter_next_number(&iter, &sw2))
 			continue;
 		result_found = TRUE;
+		break;
 	}
 
 	if (!result_found)
-- 
2.45.0


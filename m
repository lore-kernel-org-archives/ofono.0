Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D014659D
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606951; cv=none; b=hSr9ibCJwYLwIw/6AGCEIcOoHo+VaRk3NcoDDWIOd342UyddV4ajW84V6GPwqv9dB+PzHN3obBTG5RHdXxqE0D8bY5Hx0YSE2VD7AsNBm66Q6aWWyJ//0/Q7UVbTy/0QSfq9RYC24w/WyMILH8Apg7g6CdxiI6GY/ffuZIQDg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606951; c=relaxed/simple;
	bh=yHiDLBHtvMpZ/R2e80y0ydxYr4avIdzFXNUzPfPA34k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NV0iQdlKyqeznjL6svxe4JCQLMB7nLwKZJIrLKWnrPgjBiB6wAc0Knnlq12EmFdGepxaMK9DEfj9kqMrXEpPhXQqaubxrVXQKm3HhNMwdy56lO8udQkULa8/tEbvBdkmEXBv1IVpYeilm1ui1wFvFAT1QaUxuuTsIzYd6CWRL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0C+HLa9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0C+HLa9"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22edec341c2so1815885fac.0
        for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712606949; x=1713211749; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wskq8zQ6gSjG2zSE3fWILIIBF8rjMFQguuhur1w7YA=;
        b=V0C+HLa9iRo6ZkKtilGD1dmIK8E7xASqTvkxjIGVFjTUMgrWPNGyRYe1gYSE1baFtu
         4XprstmE8BoKZXl6ZzWsd/Kx3xZV/wARfVSiPi1iR2uAFLs7ebRqwiG54edlviAb71qt
         hqAw+Ww+LFmiH1CG9KdSgMg/PDDOlmg0pyBEyKNAruvTgWiQbVJb7K5nRduJVxvcXcQh
         SYdWS2H9FGoUnR2YnnJsbtWSz+Zyub9zNt3yI8Vbd/XMzShhcOFuSk/918hFxsV6eyRW
         Arp2p40Jtcb+W4fneVZefn1l27tRnU3SSGA6SSHZCBpals0nxZ/+X1cQMqoVQZAQjR0w
         3heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712606949; x=1713211749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wskq8zQ6gSjG2zSE3fWILIIBF8rjMFQguuhur1w7YA=;
        b=gYNRuZk1vr/Hon9ZM3Scw5lghc3KtZLr+mcFRCq5kwc9HkL6CJtCB+U0fofL+xGrIV
         bH/n7QeBT52r9Efimy8HSHNeIvskKDxL/mPaCL0xiw0PLlDiqIPlA5KPL+zGetzBNK+M
         LUsANN15aFZ+xwhljz3qYULmX4uuX08VQPCmcrdeLSr72PzrdAVPzSRxYUejCNvpSGm9
         wUCtnX/r/6RB6N86hmynrcimuvjog7kt2dNr99z3rh9exTb5IKOZTDppKyGCr8nbroto
         tSRaRG8hIJhcIrQaJiaYZL0AAYPBoojcM9egd2S3u6t5srKmwCCRWMpdrc33JS04S4Kj
         HtgA==
X-Gm-Message-State: AOJu0YyXEyVXbQFvM0MRD4SN1vxRJ4x7pmS/7rqdYO3IxujetvW1uD/J
	CSOrY3L3F9OLjFO8nnn9rRAfpGk3iqsGFyXcXktOYlKrm6L0bAdXVTFgrNdO
X-Google-Smtp-Source: AGHT+IGvWmOCgFFFB7cHG1tW/behL+NL2Mh9UaqFZir/hwzANtyn9FuJBNOt9IhPo1tDW17tqJiCmg==
X-Received: by 2002:a05:6870:2109:b0:22a:4f07:13cc with SMTP id f9-20020a056870210900b0022a4f0713ccmr11023975oae.33.1712606949094;
        Mon, 08 Apr 2024 13:09:09 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id na17-20020a0568706c1100b0022e1856d6dasm2286461oab.0.2024.04.08.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 13:09:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] modem: remove atom entry prior to invoking the watch callback
Date: Mon,  8 Apr 2024 15:09:03 -0500
Message-ID: <20240408200905.2983892-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __ofono_atom_free, the atom is removed from the list prior to
invoking __ofono_atom_unregister.  This ensures that any invocation of
__ofono_atom_find or __ofono_modem_find_atom() will fail to find the
just-removed object when invoked from the atom watch.

The above does not hold in flush_atoms() implementation, which can lead
to surprising results.  Make sure that the atom is removed from the
modem's atom list prior to invoking __ofono_atom_unregister in all
cases.
---
 src/modem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index bfd5d7a81c45..7d93c3234e83 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -480,13 +480,6 @@ static void flush_atoms(struct ofono_modem *modem, enum modem_state new_state)
 			continue;
 		}
 
-		__ofono_atom_unregister(atom);
-
-		if (atom->destruct)
-			atom->destruct(atom);
-
-		g_free(atom);
-
 		if (prev)
 			prev->next = cur->next;
 		else
@@ -495,6 +488,13 @@ static void flush_atoms(struct ofono_modem *modem, enum modem_state new_state)
 		tmp = cur;
 		cur = cur->next;
 		g_slist_free_1(tmp);
+
+		__ofono_atom_unregister(atom);
+
+		if (atom->destruct)
+			atom->destruct(atom);
+
+		g_free(atom);
 	}
 }
 
-- 
2.43.0


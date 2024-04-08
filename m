Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3247E8
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613435; cv=none; b=BwcpWlJZhleSunnHU+rg09v9/OHFv6k4Bt+lUdMOWHlj/mwelNcj+OTRTQnqtjZCV8Lp/QdTRcdDMj6+V5r1VEUZPu0pmLeCC3EoEXaC4J56pbTVfo20uSNSPjAilwWyGZD1Zrq/kBv9QZcQTL55bL0fVbd/UDw0bgwfwwJKuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613435; c=relaxed/simple;
	bh=yHiDLBHtvMpZ/R2e80y0ydxYr4avIdzFXNUzPfPA34k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4LG5Lw1DWj+MbpuE24P96n9qQTlYEI73gq3jzt12qChYzXPnRPMDcH0NqXu4E35PkCUDfV045I+v6n8hn1VeGuWOCqyaPJJYgh+c/tZ6BzpzgsJIcBd73rmyD7sJyxp32o1VLkRgGx+OCGBHCaulKN6cVeaKhGZCQ1qx5ReZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRIkfLV+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRIkfLV+"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea0f0ba3a5so809544a34.3
        for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712613432; x=1713218232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wskq8zQ6gSjG2zSE3fWILIIBF8rjMFQguuhur1w7YA=;
        b=cRIkfLV+kqaGVuurgRS7SL68vRiY76pqb1vzwh2Wynz6CHdQMh8xQ7K8EbSc/z0uJk
         DryRFyfW4eKs9uhb3UBqHWBrs4LQJ7pr4jjJojfciwzTLl8uyOq18uwsCztZvq4xKgc2
         z2Jtn0ZXJWEs8Q9FYWchrC5OKjWbAllx/11NkU9bRujuw1O8OE8n0RzSDJKVOVrrs+ms
         93neznDu5Rjg89ocpW+EudLF/0akS2Dnu271k0NJ62Uj0vUKOnccpCcEWCHdSbYwJ0k7
         8XMVReBjyPNBgsrXpJkb6O0P6ENIg25KL2ZF3UScpGB3PT2X0xnAk33DHpZ+HBlqozZE
         ERTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613432; x=1713218232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wskq8zQ6gSjG2zSE3fWILIIBF8rjMFQguuhur1w7YA=;
        b=D0wDDTD4qLR8aMaPhXk1vigCLPKbIOFa/kU1i92+CVzj4IGXDDQWGtRFiLfV5Xd8mP
         dCdz9INps0SGHvx21MOmCJME0ZrnAjqF++oshvL1HyGMIS8dsP1KDqQTgqYec1lBNH8w
         csm4Pz+kaftv/EV8XYbOPHiAQdKquJalJ8EvBkiFHJ/21P5Gvs66VwUS07FStu7W0gQL
         RtfVstlkOnFoMNY/Jl/qu4NxoWUC8ozrwhwZmRH+izmxFgvqfVBjxFiccwaUuYbIn0pF
         w8YKkbRtUOkXVQVJHd7tsRj89lmoveUIA3XOzBg90LkbXABFmMDQtFtEE0PAnRt4T18N
         63vg==
X-Gm-Message-State: AOJu0YwwqKRGOjEk7l4pDBE7i1s/5TMx7IaqnPy2B85c0t5gLZZsGWHr
	nloESINCE7s7sqQBalN0Nr9gY6XY47SaeDxC/+RiVKm2tAwnkGL9Xd2uC3qY
X-Google-Smtp-Source: AGHT+IEPFOfd7r9yZ8vArK5vUoCsV82DjAtvc3BVx6WXs/0cfX/ckQfMkBFsB7bWoNDa8QO4AE6cig==
X-Received: by 2002:a9d:62d6:0:b0:6ea:1aa0:3e42 with SMTP id z22-20020a9d62d6000000b006ea1aa03e42mr3438633otk.21.1712613432450;
        Mon, 08 Apr 2024 14:57:12 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id i22-20020a9d68d6000000b006ea190267e5sm512321oto.43.2024.04.08.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:57:12 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/2] modem: remove atom entry prior to invoking the watch callback
Date: Mon,  8 Apr 2024 16:56:56 -0500
Message-ID: <20240408215710.2984399-1-denkenz@gmail.com>
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


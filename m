Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A861836DC
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426006; cv=none; b=UhUIO3g8RKvdu4Imx5pxT53lglaHFUYcrfO4CPurRSDWrxHImr0wmMZVE7ItOKrNtRI9+h0JsoXW3kPl0GK6C9O2UJmArCjz0dWCF+QCKDcGQigrGMd+1Ul8QQlqtruBB+/6aMNTtVyCnUPT6sMnOLrDe5XM6EY2t8mPRBSjMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426006; c=relaxed/simple;
	bh=pe+QEzz8OK/9Wg0KPjxC6gyXwi+poJD6bjPYioMCEtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK/iGzA4KB2a0scpMxHkvky2wOU5x48xDsKvIIduLPRLmrAq8TWzY5mBXI+IraxznOq7PZHlAFHAb5rb4iEAY9VX/me+1LsCVV/44y2Hiu34GctMsIzlFm+GpwpsUwv50BRIx9fwv8Bo4dxA53WRVSO9JvSVb1UHEafHcbuSoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acel6pob; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acel6pob"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c862c613fcso1456927b6e.3
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426004; x=1715030804; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALRYObSApKqoZoRkZmkAor85fwDFhQieUsF5HwIfAqQ=;
        b=acel6pobJJBNnlqPtbRvT7P1wiB7Ovn6W7mx55dbjcXdB5lW8Zs1EUf47rfNY+dlm4
         ZsRUpFgl15IHlAq/Yn+nJ4ykw86rpIJaod7lkmJXNqyysuA+gi6ULTa58v7l+yHf3f3q
         WnVJMdRBTzhpTnwYnUzXN4CQ8mqZj2XaPcS8kOSpvPv5IIpFEUv25zYhD5kBQii3kP68
         0YfK2GXKMuvhmyerCoA42We3lpesqFBpqtN2z6go4b4T2jd3nii85kbAb96BvM+JljcF
         9s5UzD9kE4UQhcqd5UMjmIxnSyb3tkW/5EnABQQmA7Djr6ZQiMNjIM+jh92nBPcsnzSK
         4zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426004; x=1715030804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALRYObSApKqoZoRkZmkAor85fwDFhQieUsF5HwIfAqQ=;
        b=uJ2ReXl6LHui/HF/1/l0jWzIu5LR/zhkqICooO1WyFZqbXjESVQvTWnQZzIkeaIQfD
         Pq+/1RYFEwLi6fPpP1aF4h55yNUeYrIOkNfZmlvPRFB8dg6w6DlOenalM3nOOYG+6HzG
         WsF1YOEz57vVLqcE4xFuyWiCEJs7axfk4X//ctBG3qqGitVtFvaCzmy6LGWVKrBh3sSU
         2g6zwywhW8xXiAu4mLtq+kwGR3TIYCnuxTdg4Sfwfhk45id0mv9+ywXUlRLd0jck6i8S
         bQ1fBs6+Af2DX3VLC3e7CFLritLuujP9AarycPhok6C1fJEXe82VORmOzDJa7gW4GNWn
         9ZxQ==
X-Gm-Message-State: AOJu0YzOGwChHoHm/yeHoWt8Ccy+ec7N+4Drlsgsae4O8WMzzEMFvFdd
	Uvn4rfAb3rn0utxLnxFnWt9Ya9/PJ9rWaL7pcWzlTB47WsanseK92GCHZQ==
X-Google-Smtp-Source: AGHT+IGtlk/de405W0FzsBRf7ilW+yEntw/sUoA6USTgKsciq4sffUnA+TWuzGN6JUSwcZ4tFv2/pA==
X-Received: by 2002:a05:6808:1924:b0:3c5:ec0a:caef with SMTP id bf36-20020a056808192400b003c5ec0acaefmr16120031oib.21.1714426004157;
        Mon, 29 Apr 2024 14:26:44 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e19-20020a056808111300b003c6f5b8a5dasm3466183oih.6.2024.04.29.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:26:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev,
	adam@piggz.co.uk
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] qmi: voicecall: Add free on the error path
Date: Mon, 29 Apr 2024 16:26:16 -0500
Message-ID: <20240429212640.11474-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429212640.11474-1-denkenz@gmail.com>
References: <20240429212640.11474-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

send_one_dtmf() allocates cb_data, but does not properly clean it up on
the (rather unlikely) error path.
---
 drivers/qmimodem/voicecall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index bb4c4c2ce204..c6383a563b6e 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -682,6 +682,7 @@ static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
 error:
 	CALLBACK_WITH_FAILURE(cb, data);
 	l_free(param);
+	cb_data_unref(cbd);
 }
 
 static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
-- 
2.44.0


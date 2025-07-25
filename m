Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A419343B
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446023; cv=none; b=QyrUXceVnb4jO3baPypVKkok6SFYb1h5tZ4LPR0+alTy5JGQokz6NrY5GKOsXFkvlq5cCI+vus+U60uONaQ8oqYDHWPxXoy8/4TVnKj+NTFoiF8wgZqqVXUiVhUmSp4j9AtLyce/BV77Hep4j00r1oe884w1/DMA9X1AY7roG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446023; c=relaxed/simple;
	bh=lyBQhMq4GEDmj5mWWUgwiMs7Wu/bB5y0uvSOLbDVB/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6TNgIv1q+2VB1swI7TKKCUhULCvxMgPhDgWxMxJC9VErmlZlrWCuTpDQprum9S0rTVZ1XPTgCOUiTpxWuJ9oiqWPMLua32xoDC4q/Yy0HgevkV31QvmFD4ww05p3ntRlC0DiEJIjdP+InttWTQtFwVxinWgNysqw4U2NliqeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTxTMSFI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTxTMSFI"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aef575ad59eso353020466b.2
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446019; x=1754050819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFtT9RPGSBRqd3Ig9fKQ5PlMtCYd7IUvAmvxooRSz18=;
        b=cTxTMSFIxZnis4N/O/D+wN+5235rMhyPmjzRXxlO/Sai/i+CDxyeIrc+TTmeazAnVJ
         D1WtFEGlHa9si3/StUw4Jdt3bFEkgRCiyajGvZ4hEAD43YQshWF2gko1aATKtRoDgN0Z
         37A1vsEuFZHnhQ2zgjTpoi5pZ2PmejZlspwK/GBzPQygA+zVnl6oqia3Zp2wxoomADFO
         oCVTJnDChqGVVgvw7WMFhboCzMIVCpdjjtiSOa4WiloErhBpR2ZMy5BnyTeBR3tjuwFX
         g3yeZOQ1hRZaqNAGXcWZYuzDikPPnSAcT3HWBC4jF33DFM1yw6gATk9rhkxp+Bh6s4Kj
         GZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446019; x=1754050819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFtT9RPGSBRqd3Ig9fKQ5PlMtCYd7IUvAmvxooRSz18=;
        b=oigKjD9tgWuJCUvdUCJreKFJUdBINgYvkKLccded0c8spLv9nOPFCw+zifJj1pyl+o
         hZv+sPIvQeNZWIsARq3Y17madt0SjC7Fq3jHwgJKXDblJ4DFvhW9tESOxUMreoqsmgm7
         pthmUzM42evz4EQk6j6ih0r3tuC0lJ0vbuRGCqNPaV5RuljPSqmVYmisMovtM46wnjhq
         sogKm2bAZkp1Nr5ushKwrm1lFaDQh7IsQdyHpu3ojHISKUtdCJAeH6xaLl4Tgwf6ZZPn
         arv+d0B08d57X8v29B9lsFw8BBdwR07xLkfA2ln6toikTh15gJjEyAC7TmPAvZivtaac
         hwmA==
X-Gm-Message-State: AOJu0YzMsUUZqgH3nufScQWZMHXIa7qkO6/OsQlAeSwfiyWqafs4xxtx
	HIBj72I5/gcU+8i3Cr7V1AAfte134UBNHbw6+vSaYMw+T3byw8fQ1FIcPtmQQg==
X-Gm-Gg: ASbGnctKp8TOZGS0KaEX5yOKLRBud46DokA35oVsTIRUHzykvifGmUsd1/NtsF16AT2
	bhutz0BL3p8pgVAbgcGS22+IEflo+hMCchW++8RCprSHrczDFZ6FFtHQshYI9VShQokJ/MdXJVw
	wKmvltCoVIqbFAUv7qoYrD0G8xUcFdabBKWsJpfmONpb4Qknf7XBf66TR/SvMBiXs2YhDefLGqu
	cz0EWqUBzkkGyCoL0d5hHmKD3e4FcG9zqm9uDR5/LWdjLcuT6UQgO/eP8sCeqQnNQ/py/f88xuT
	njoCypsZ79lTBb8qs/VB370SzqJmsp5GoTvFeOVujAILsge4Fcm7Fzg0PYzo5vYgquqLL6TZrGH
	+w1pCFqnpKpQc35P6WuN1OPK8lR2YHH8qYoKQ2sXw8Xub
X-Google-Smtp-Source: AGHT+IEyTnQD5sDK6n3ot+zbFAaJ1PSfW8cWg766lIQ1TsjSf4zezRdxRRNc6aweXqW5TZfVU0aXfg==
X-Received: by 2002:a17:906:9fcd:b0:ae3:f3ce:3269 with SMTP id a640c23a62f3a-af61b6dd0f5mr195999366b.20.1753446019192;
        Fri, 25 Jul 2025 05:20:19 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:18 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/6] gobi: request PDS service if supported
Date: Fri, 25 Jul 2025 15:19:51 +0300
Message-Id: <20250725121954.650668-4-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gobi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 24c68fde..8af449ae 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -792,6 +792,8 @@ static void discover_cb(void *user_data)
 		add_service_request(data, &data->wms, QMI_SERVICE_WMS);
 	if (data->features & GOBI_VOICE)
 		add_service_request(data, &data->voice, QMI_SERVICE_VOICE);
+	if (data->features & GOBI_PDS)
+		add_service_request(data, &data->pds, QMI_SERVICE_PDS);
 	if (data->features & GOBI_UIM)
 		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
 
-- 
2.25.1


Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB878268
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230073; cv=none; b=rf5uV61RAABHoaKlK/U51j/I/ZFTVbmK+OXYYYhwv/JAqPfIspufzsSi20CPUWrrIgfcq2hLqVYPg1DKkjziJgPVbKzVq26kDYzRMG3QVyvnAPARSoM40rTyunonumrV2tkxsIGYymj0tofFw+sd2Z84RBvKSTnk+UFBoXzMEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230073; c=relaxed/simple;
	bh=9OSneFP5Ti/ZShVTGtd7Q+Jw7isyd6AqS6ldLbrQz9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAhwggyHJlaTM8XrZE8cesgID9eg8lwZbwjFPftNFTfOwdojkNd5hJt0ZC9L+BOlnxZ83yUH66LNJXAjU3C9x/6SjZQRMomGiEmdJo5Cvjz1Z96FNfKDqLTXPMP/XqVtdWeoeJYRmMuvdAGnmcoGHToDjor21R5QIrrQAAPek/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX7rbgbt; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX7rbgbt"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21e6be74db4so607125fac.2
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230070; x=1709834870; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PusAo9SRqPkuh2CLA9jf1bxtFNnKiT9zBOKfWEWvnHw=;
        b=XX7rbgbtVJBICrknLmAsroumI4jBH3gmVJ55IZSEDAfCpDblqct7cjdp2WUNbvkdPz
         3s21BcVZrhnaKocXeVDE8Yz7tQ+UtDfjXafr33mjAJ+jdaipJVNhpxPHFbJ7qc2ppd7Z
         bcYxxQA98VXj5YrGdXMr+REq7sxJCGNpKUSDWrOMUlpDs8fL+v4iSrSR2Ki3V6qH/8Te
         j/w3ZHpluGtn4HoKchNTj9V7kUCOd9sTnff5+TKRlemujM+YJgfb7rL0/tmNNq1CMAs2
         STDyp2yOqFb5pjy3bu+fTjUd3SQLk3TjRSRis0LC9VECpEEKNu0pkOpB4qgpQ0+Ydu6C
         F83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230070; x=1709834870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PusAo9SRqPkuh2CLA9jf1bxtFNnKiT9zBOKfWEWvnHw=;
        b=WN/nHX56iW3ibOr5DChznTTgdR/sRUDJ+B04px3uaddbrkOfZz+Bp2/lKj7+AG64Z9
         opYx0J//MPj2FOnCsMehUrzAlI5kSK3PKmBj4PNXWjbS21mR5NM3f0dHH5WOQyPFTe0o
         LAd+FLwazhWhcJZav0mkOzQqdMYtiQbZo9Li4DJb1KQxZUBjQPFIR0InHx9PzGYMwxD8
         1dMtSyASMaBxpDRQf1laNUizsVCRr2c3U9CtOVwWnyYQPZC44xf61k4/JD+bXrrQsN4I
         zzMCAGePNf+CRK/bmljO2LsIfvpvDNwiv/ApqaPI20KN35haFezhKEF5A3soFkw1A+/D
         cNoQ==
X-Gm-Message-State: AOJu0YxxMA3UH9oaJ5ZWU+B4Ophb0ViMXEefpSwCIfnQoSaAM7dskvfG
	oJy40/aHYl+W2V0r1hKYpqHzSUDUpNaheWmurdc9p4WtnF/Mw2entOKQXDJi
X-Google-Smtp-Source: AGHT+IE8K0S8ENaaA5UTBM4IjlEMELT+T4L4QcwCBRv0wzmwy6nvyi1HNd+TvUk+KlCUsN8azeMVPg==
X-Received: by 2002:a05:6870:f219:b0:220:8d66:3fdb with SMTP id t25-20020a056870f21900b002208d663fdbmr3008569oao.36.1709230070756;
        Thu, 29 Feb 2024 10:07:50 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gz14-20020a056870280e00b0022008c33ee0sm549899oab.36.2024.02.29.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:07:50 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] smsutil: Check cbs_dcs_decode return value
Date: Thu, 29 Feb 2024 12:07:35 -0600
Message-ID: <20240229180746.1671015-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229180746.1671015-1-denkenz@gmail.com>
References: <20240229180746.1671015-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is better to explicitly check the return value of cbs_dcs_decode
instead of relying on udhi not being changed due to side-effects.
---
 src/smsutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index e89b4567f9f4..6fe2bcb4477f 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1765,7 +1765,8 @@ gboolean sms_udh_iter_init_from_cbs(const struct cbs *cbs,
 	const guint8 *hdr;
 	guint8 max_ud_len;
 
-	cbs_dcs_decode(cbs->dcs, &udhi, NULL, NULL, NULL, NULL, NULL);
+	if (!cbs_dcs_decode(cbs->dcs, &udhi, NULL, NULL, NULL, NULL, NULL))
+		return FALSE;
 
 	if (!udhi)
 		return FALSE;
-- 
2.43.0


Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DC27269
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032688; cv=none; b=facyJR1D7AhQBKhrfb8jeSZSf/ubCW1D3VTYQRnqWfA3481KMIsfaWeAQH0qleXea4UNi+HC99WVzfvn2MlWy2aCznm39PbDSxNlorbpefsqvYi4SOgkAc7miDd/CHc2dxQIim5SET0vgzA3Jy3YAUie5jTd3GVrDnu8VuT06ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032688; c=relaxed/simple;
	bh=mWSCYtO2kXP1iew/GPMYRO3MMHdMvoVoDzDEgPSQcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwPvqRtYNr3mmlUu5tSyLobo2DnDZi+w/F5yk4rRN5HHGP2sA+T7mNg7REWgWVA7R37veH7uG2IiDHxQoHGgFmiZXviXCGCKvRtprLuCFYGAPvB44PBjJxYpp1PuteCVG5R2V1CiPCmG4iDZ8xn2m7nVgf0oKAy5AvJNZsMdIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y06d5owB; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y06d5owB"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ac90ad396dso1508223eaf.3
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032686; x=1715637486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+6WUjHPVlhw/U9dfcyIm8mVKlaCvLZeH63jCeDW7Z4=;
        b=Y06d5owBe4rQKfFBEwmyAsoowg1t334FyKn8CjZZC8c3ymYxvEd/0DzFqR1XGqfXrl
         +4L6QJYbKp9A04/IsJ3hgzW/M+96A8Q2fItSq7Jcn84SofaJPGIHO6aXvmVFl0X1hUuw
         SepVfEFJR+t0Y6tKpnl0i4ERXntH0lOsllftdVX52gh7qUxQmgxZnEMn6Ls+Uz/splRr
         Z0CzgEuymg5uDW6WUxh5+Rz9LZrBPD9WE/+pldvsF55oZHtoUvflEpgIrMVui9aCc8kt
         9ZOQNHWhhEUH8Y5nBaQjYBVUeUoD8X9Z3KD8DkHHObT1A8sGU2aNG84cyNONmd1Mc3Wd
         IUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032686; x=1715637486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+6WUjHPVlhw/U9dfcyIm8mVKlaCvLZeH63jCeDW7Z4=;
        b=ORvvtks1qtHhpfkIguzA4wfDXSXom6JJTpKbdj34yjFj10h0L1seaDJRRkRGkcakzv
         vCzKAu+DRSchxuMv6COzPOv1jKijwQ+QBQz9CV2YxLH+d5fWItvKN+N301HgrD/3QxM1
         mom9FfDDW1meKWTLrNm0CnJsQS2ibHWsvaCy6yP0QmfWVH9OsQLKthGYlQ/aCvDSRlFt
         gvQbRGBfwPNkZyVbHPiIX7pB2i9yv6fj/d42+aUDSGSWyt7NaJRxLnKD8a8J2RqGp6LJ
         I5p3NtVcTBBcCBKeWIpBIUM/Wks2P7wXCAu8nUWRDb2wABYu2AXTByM7kRdcKWBsZHkV
         I2KA==
X-Gm-Message-State: AOJu0Yx+6H0/+c2AFsPalf/2jPwnEQivNNUYKlil3ngTOm31Dils5Ehu
	RijOhF7HjXqJoUZESWV33SEHLoGZ0Oag+KufGGkGPvv62NESI42p0uw2fw==
X-Google-Smtp-Source: AGHT+IETOgdZ/tWz/QAIQVMA94TI4KQUC6G8F/OobpugR0bXQu996jn1pX+Q9QqrB9D/OAUANes1Mg==
X-Received: by 2002:a4a:d07:0:b0:5af:739f:1b83 with SMTP id 7-20020a4a0d07000000b005af739f1b83mr11554341oob.0.1715032685959;
        Mon, 06 May 2024 14:58:05 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/8] qmi: wds: Fix up enum naming
Date: Mon,  6 May 2024 16:57:55 -0500
Message-ID: <20240506215804.57124-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: e075175baff2 ("qmi: wds: add utility to parse Data System Status tlv")
---
 drivers/qmimodem/wds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 94f1c028bd81..218587c3e437 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -68,8 +68,8 @@ enum qmi_wds_profile_family {
 	QMI_WDS_PROFILE_FAMILY_TETHERED =	0x01,
 };
 
-enum qmi_wds_3gpp_rat {
-	QMI_WDS_3GPP_RAT_WCDMA			= 0x01,
+enum qmi_wds_rat_3gpp {
+	QMI_WDS_RAT_3GPP_WCDMA			= 0x01,
 	QMI_WDS_RAT_3GPP_GPRS			= 0x02,
 	QMI_WDS_RAT_3GPP_HSDPA			= 0x04,
 	QMI_WDS_RAT_3GPP_HSUPA			= 0x08,
-- 
2.45.0


Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233283A29B
	for <ofono@lists.linux.dev>; Sat, 23 Mar 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233984; cv=none; b=ViaBrjJ5lW6vGJoKbIXgIR8ol0e+8ZAyjc2Cs5VbvzQfO0Oh8Py/Letu7wTEfU5fi1Wrk5wVXRjcZ2LJBVoMDWgcDGLbFiM35s33g+AZV50dU+7nkSqhR01GpIr0CF+wy7dUSUgQTmK1pLl5XEr+1sXQj3XZgsfIdw8hfjX5p/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233984; c=relaxed/simple;
	bh=vTjdDuMgiBVHHmLXdT5+k05n+YH3lT6ni+PoSCzdMYQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ov3otkB1zhTeXgfzWRxhmNS/R12Ho44lckZfUB5DqgyrS/JeZFUUtUfdWa3tdbSrMA6J7+WV1KBINg4n4P0+dOGGVKayN90eby7MHrCGz+8i5/ulsoyCQS1cPZi9rk8dePrSUNhgPiOsbYmUz10j8r2XpD0IBUGW5fRybeFQTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+WjbcAd; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+WjbcAd"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22a1e72f683so154278fac.0
        for <ofono@lists.linux.dev>; Sat, 23 Mar 2024 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233982; x=1711838782; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTjdDuMgiBVHHmLXdT5+k05n+YH3lT6ni+PoSCzdMYQ=;
        b=E+WjbcAdCpxSDlHdXEEqf++a4i2RxqtabzanGpDGLutx0X9rZa/hp/NPNN6aoaBXOi
         4AnvhNol7VLGbxFllA2N32leNM0BaESs6iu4XZ0+G1icK1bQTEW3G09YqQMsv5WxhGyx
         xqtSwf+FQj1o3h9taDJBIxhRzjZWu+twZMqx5zrgRX5jWDE6ziq5DBZQdXB7aNEcJcbM
         VBiufzur/AiSxx4bzwOWmmiQFB3P+cao8AsuZXGvqxWiVkSdyzIjqUv5Kx11FfgqkocD
         z2najKKpxGg7RJjJ144hu5SLXGih6pDJzwO3/ZwL8QQJ4PqOsK9BVl1xpHgo1tvIu1bm
         Z2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233982; x=1711838782;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTjdDuMgiBVHHmLXdT5+k05n+YH3lT6ni+PoSCzdMYQ=;
        b=uOkEZcvblYNb4XTp3gD6CCDlKOAqtggTIl6Y14qRZX+aQQ/+Ee9c+LG12nXJK4d5bL
         Hjsv/yNZLIVHF3sZM7M8ICBjYcEFfGvIclNCBX73fmyVLgJh3VtPswAM3RqrdrP/BM+T
         FBL2g+APcgQa3eg+KGnB4zItT00VnytbyqMvu+eu9VHnYLC3bQBIgA/e9abfq0W58A65
         jvPiREzUBnB4i+v9uYQZvAlErN2eznSjMI632d8p8i22rKA4s05qTcrDbSUPr/i52eFM
         rGAJg5cWujfTEganUKZvT5rzphY9b65lRxmNIKKXPTIEP9m3KIMQY6VGEHsVfNa7dyTu
         zDIQ==
X-Gm-Message-State: AOJu0Yy71M6GeJbeAV7EGvQ+ujnN9ARlJ5lsknl+pizp2BnFBaOOvgE2
	/AK+8k5r6sB0dvOGttHKgIpSJZav82gpXIDNbUflM+aR/a0kXeo0VLfQVuAeo/opDHP4SiBP8r+
	TBiaD08p2Q/PHI2EbHKQSCTnCdTHJKhqZ/Kg=
X-Google-Smtp-Source: AGHT+IEBMu42R6R2N/Pn6YDUshpA/f/+es25VIQ32m/nYr7Vccyryk+d1dmm8uuXre8lBMhWxO3U4C5+CND2Pgl8eQo=
X-Received: by 2002:a05:6870:2009:b0:220:bb3b:c762 with SMTP id
 o9-20020a056870200900b00220bb3bc762mr3994272oab.33.1711233982078; Sat, 23 Mar
 2024 15:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>
Date: Sat, 23 Mar 2024 23:46:11 +0100
Message-ID: <CAAcv5+45oEz_ychyuPunbjLbdXU7PK3yVZLeuBGvr2qsEzEksQ@mail.gmail.com>
Subject: Receive DTMF
To: ofono@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

Is there a way to receive DTMF using ofono 1.32?
I can find SendTones but no one for the reception, any idea please?

Best regards,
Mohamed Ali

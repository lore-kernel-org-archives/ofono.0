Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5E1C173C
	for <ofono@lists.linux.dev>; Thu, 28 Nov 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815717; cv=none; b=huOvaild6oVyqOMCKQnZwUdGeUEZq02ySUJr/gJkc49qAzMHOK3sjBgWxIlY9zwsVnrLB/5fr0v34yoYIjoK0CgDZoIKWugACfMiWnAdd0WkKpoUGkM0WFaBY1W9DjQflAoRiSxQtN8rIAcH/UYHALFDRPIBySnFAJe4kUTOnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815717; c=relaxed/simple;
	bh=x5rVScwtsOYYQFnQQLhsE0LKFzZJz6HnuvEtCv84QCw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQjjm1Cbv36H6GoQ9PgVvG02U5bYIS4OLDM48/GABOz7H72RgORGIJ/FgCVgFcg5ksqJKgS1E07/ovEhttkJ0g/9lkF35OjZPnBjuE3DexOT7yj2gJ1DJodnae+r1/yHk8W5pJrSn6mWzo+IvSQvdEgJHfcVnEaNjQIcPw3Ytlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LATp1AjH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LATp1AjH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so9496665e9.2
        for <ofono@lists.linux.dev>; Thu, 28 Nov 2024 09:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732815713; x=1733420513; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YbBCUd/aRsgi20b38DvUJRNnDzTa6LBjJrARWR9CYUo=;
        b=LATp1AjH+4tkzNfzEPwQhqyiz44jZcaaiIWUQh/jO+BsvxyP33yQZ+iMax1g0H/CRu
         gDUrBlEi0+q/tq6uoxzf1XPA18NvjDMYxRNKle8/t3T3R3MWl99qgRHON5Mu3WN4x3He
         TzdMS4ERgo7CKTQCsyLnVUolIV9PIy/qy1lWUIMc4uWyRJSb/p7wDkdDvVKn3FOk+Uy5
         Q3hTBdo5QPBguniGjw7ai7tr17Tja0OaeqSYKtqkEXWDqN/6Y2IGBeA8OglL5nCvOjer
         JxgqaRO9UQtfxDUik4uYjujwvbS3FcgN11oXLr4rnDQckcRJ8FfOlIdiV0SuPUeLlspm
         Cv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732815713; x=1733420513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbBCUd/aRsgi20b38DvUJRNnDzTa6LBjJrARWR9CYUo=;
        b=EsOkEZt3trgp4cHc9mDOz9dhuA+1jU7+wVQQnP7pmozK/3T4y4kt5D0Zo1Yg3yfQVi
         XCRcs154oQY3nJr4wa2f188EF9veY9CRYG7nSIfD9POr+6WPGTNCn6X/uLwXNsopbhFS
         nlA7NPro7gDoTb6lCsprpdfcnZvRZCoTbkCzBUIO5VSQQ7mQAR0TsErdqBes/kw2m72X
         v1ltA1dj1is4Hl7y+O3JixjAea5T8aY2dsKQN1u0wQeFrLxZkoKTv7BuFNy4tSU1NR4r
         QVeGZJE9cwZoeewR4qRBq3GOnJ89lHFnTV0+G1Ufwl5ypye9AltaQI387MijuS/4S6NI
         yDNQ==
X-Gm-Message-State: AOJu0YzbJI3ykgGUMY08dHYhaHr+caVf9yMHJPjhlNOBCQN4fKKqmVZh
	LD/0fxoBgTNB0jeLBxpFt+gxyjynyH4we8JZiy8TeZsWnpezI+EaX+Am8w==
X-Gm-Gg: ASbGncs2KRkAyaSYdPHWhjiyz9sysNFKx3TBPsesWWv7u05rPhk3WoMOyFbhGjq5Q4k
	92Knm89jBJnLIow+C8BxEk3droNUc+Gz7cpSsWpYb67NHhULXj/Do1AAL3XwlP1Xb/LLPN2CZW1
	hF82tzdNOGR4g5BNaXD4SomNI/HS/O0BNynD4b+7VNg5KmZcVW4eO1EIPwrUo4gSoFgjRjNZ/Di
	fv0IgvK0DIIjRn9U0RhbkVWaWY9Dxp4Jt0ge6EVAm0oFfsNtYKX3D0USoVQ7Q==
X-Google-Smtp-Source: AGHT+IEWhdG3689g5NVFTIW1tjOs4qyySvfABHHeE8yXQ8JoAHBb5piyVe8rVi+uiFJ81muov1UPUA==
X-Received: by 2002:a05:600c:3b1d:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-434a9dbc43dmr72906015e9.5.1732815712578;
        Thu, 28 Nov 2024 09:41:52 -0800 (PST)
Received: from adam-laptop-hp.localnet ([2a0a:ef40:c2f:5c01:9ed2:c18c:329:f12e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4fe1sm59238945e9.38.2024.11.28.09.41.51
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 09:41:51 -0800 (PST)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Subject: Pinephone Issue in 2.13
Date: Thu, 28 Nov 2024 17:41:48 +0000
Message-ID: <2830691.vuYhMxLoTh@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

Myself and some users have an issue since upgrading from 2.12 to 2.13.

The logs on my own PP and PPP, and from another users PPP show the following 
code path, with the device being shut down:
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:discover_cb()
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:create_wda_cb()
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb() 
Trying next data format
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb() 
Trying next data format
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:shutdown_device() 
0x2088ba20
Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:shutdown_cb()

I think this would point to this commit in the 2.13 series:
https://git.kernel.org/pub/scm/network/ofono/ofono.git/commit/?
id=1b4d985787795414319fe6170c4600c84bac6746

Issue happens with or without a SIM installed.  

Is there any advice you can give, or can I provide anything to aid debugging?

Kind Regards

Adam




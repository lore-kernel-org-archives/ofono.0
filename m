Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACC7494
	for <ofono@lists.linux.dev>; Fri, 26 Jul 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013404; cv=none; b=LVkjyS09w7dN2xcYGOcK9BC/AeBpasW2Xqjvzhmzi09b1MoLN7iutH+zXkHY65FqmXnOfAwEKEov1hXXBS1f9EihO7P53wc2BiwNjuDA9kHvGgeq8tDsRAJ4UpWVlhxlyhSaMe9Lbeq0AfDf3UQ8FLQee+HG3PzGyhe2GL9c3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013404; c=relaxed/simple;
	bh=TqPI0pCTvRx0Gz9Y8CpNeJVqC7poyapn0SVnEtIyAx8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZsSX7P/PBPkippbP5heHyljYJd3skO/z7IoR/LcwLkbfPBAcmxj0gg6kLKLFZukb+yZBKGMrOpbkUjzvY+a0t+TJ+GaNgLXxX1ohAh3aCXLTqCv5X8bi+NIe9E8eoP8Fwm98uJwJJ1R6ktiLHL9Ynj0zdY9Q5xkN98r0I3Quzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK0ARTEA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK0ARTEA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280c493719so6946995e9.3
        for <ofono@lists.linux.dev>; Fri, 26 Jul 2024 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722013401; x=1722618201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7EgeGu3DGonGiydwmAB/JHulv1UxDKtr92qixUb6UE=;
        b=hK0ARTEAz7zWltABcckCW/XVrBlc9Dk5iuX1OXjVVC0lETsu5AZL9fJzKc3XT6Sccj
         DXG+hgdJxCZrKMKAOV5KJatApiPyr+KTEcqQjHVLmA4yIwH6Q5blLlSl9ap7orIew11M
         8/kDejwf0e0e2ysOYsFYqC/bSZIqVCV/wyEukhOAi6e9CnrG4D0mAB+S5yCfC7o2pswd
         LbjheiedvSPZBfYl5c/IEtURecn8zvHofR4UZBvQSKsFshtQ9AJ/7xKYA0ML1nTA79lb
         +vJ+NGle3UfN9n4KM8cpRCnst2NVf0YwAaat/XHHuR8iS9C7zjdNG9RYVdh7Qf7SsXlq
         x8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722013401; x=1722618201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7EgeGu3DGonGiydwmAB/JHulv1UxDKtr92qixUb6UE=;
        b=eVKzG0DQLDOV1BEE3dorhKfrNm4UBVVsd0S5fHWhqrEgYvlnvEET1pTe/eRubxpm1a
         wicG8NboXDpF7oczmAP8JRsmUWIZikQE39k4dVSoMIZrqqZ2IPnQGLfVh+Z4dxRuCjjg
         0fV9jA3Z/DSkiKleFB3zBygyoqCUN2YD8YIEvYUNkTDO5iz2Unbk0yzwL/Am5g+vFTpq
         oEzn6JWTwKc0BPBqGsScqGZhToh7mQpRjHLIY2BE+Kbnd7gKjisIjBBvQpFkt0AMv4bD
         82cdgbxv7/Yg7HrQicHADDkJva/iGpWZAUH9NCxjoLfoEydishPDeEwgoz4bQ9Z0dwrx
         ulwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHhK77uueUqz9yGfZl0hZh5viNex+Jv3WigREIe9wY4T7Prg3atMw4MhhqWjjotIVQYds73kKBqh7o3E8iEShb+bSguUc=
X-Gm-Message-State: AOJu0Yz2EKkHgfPRUg8CAKU+4c75d0p5Xp8ZQSxxMZ7J5SwLrI7XYZeL
	7qxFBJ2ZR8b5ny0sl+hfTeghGMK/Djsi0gMezyXH1CQ0ihwKC93YVAzIGw==
X-Google-Smtp-Source: AGHT+IFaIvyiiwqv42ZO9fEX6MpoSyiOFBJzmfnlnoeexhaDozw3/m4/e9DFki6GPtkIHRg314MkYg==
X-Received: by 2002:a05:600c:354a:b0:426:6c70:dd9c with SMTP id 5b1f17b1804b1-42811e0b770mr1468245e9.31.1722013400585;
        Fri, 26 Jul 2024 10:03:20 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.116.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f935954fsm129482605e9.9.2024.07.26.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:03:19 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Subject: Idle Loop
Date: Fri, 26 Jul 2024 18:03:16 +0100
Message-ID: <4939268.OV4Wx5bFTl@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

Wondered if I could pick your brain about a new issue I have.

In the patches I apply ontop of stock Ofono for Sailfish, there is a plugin 
called the Slot Manager.

On 2.7 all is fine.

On 2.9 not so.

The code in the slot manager, after its creation waits for 5 iterations of the 
event loop before disallowing any more drivers to register, and it seems that 
in 2.9, this is much more likely to happen, though its a bit inconsistent.

I wondered if it could be related to https://git.kernel.org/pub/scm/network/
ofono/ofono.git/commit/?id=063856a2ba9308e1776a3f906bd2ed9a9f760744 and what a 
correct solution might look like (I understand this is my issue as the code 
isnt upstream!)

Potentially the check for 5 iterations of the loop isnt even necessary (and 
seems very arbitrary!) so Ill test without it.

Is there a reason that the gobi plugin/qmimodem driver combination now takes 
an indeterminate amount of event loop time to appear?

Any thoughts welcome, 
Kind Regards

Adam 



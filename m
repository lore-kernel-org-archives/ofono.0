Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7602253E3
	for <ofono@lists.linux.dev>; Thu, 19 Dec 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616041; cv=none; b=XVh3d3eOfg2sAjr6dqJAW6ufhHI6zGfU78qWLzmbbvbCvQ8fcXvjf+ZhKfhmO0RkG5ugtNYOpbn4hz/4i9k2zkLCAkxoSRfCII+sHCnx3jytMvgj4E3HN4S4wosIheX89K72gytAwliDQIEZIj80Y00cIxZGfri9t+dPyLSDKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616041; c=relaxed/simple;
	bh=pNGTjK/ZFoAHRv72MIg2CyHPrzK+M3M1U69Ae95pq50=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=k/ABpaF6TR2UyBIxJahb3ddRukyJD/B3z7xPnUbCwKy1yKZ5yBTjP1lRgpJM8JBEazn/GPrZV563Z5wg6tVdznj43OFPdMZ59/N2qk+PTTayw0Lsa5kluv+KFpmEe/QknYd/LJ1KXIJddQO5nmLWXKOB2TimCls1cXlWSxTnQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcE50XJZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcE50XJZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d161947so381217f8f.3
        for <ofono@lists.linux.dev>; Thu, 19 Dec 2024 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734616037; x=1735220837; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aIJIBCEOA+bGNjZs8O7I2BfeT2rDAebO3vUogmQBAe8=;
        b=YcE50XJZJw0+IoqhxIQNSCkTSQ1wv7+sXV5pPriyBBDYXsaqQ+SThS2+VXCYfU0Q/o
         cP7r5K+qptNXlMEQNNe8z0UrbYC9c+DY3+OfeQciWyIssTdZ1AKUJS3I8D3OPY2+6JAO
         EcQuYMGc1b9hIPv6RXaBP1gs4WqazhBbteYAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616037; x=1735220837;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIJIBCEOA+bGNjZs8O7I2BfeT2rDAebO3vUogmQBAe8=;
        b=E5bV4Dy3j/HaJI1sCsRxJBCqLkwVdP34RNhxLKORu4BRFfE9QDL3SOspayFNzBUEQQ
         xd2b2mR4TWuVgzGFsO7vmimCQrIrOq2kHmnWhGNZq7RuB5ziHHNTfO4v61wSdtMj1KCe
         C2QDxgTA2AMh+UMjtY5dbrbKVPQ4ZQZ/QFJT2iT/chScu8lmHNRVfXtDNWjwOjtHhpXC
         fLjJjoOJOnGOBqwUHFNhUj3mihLutaQvlnYJ3WE3bW4+aDGqHrS9O5r135VROdqgV+P0
         XIksGDpiS2GMIhuZMeZieavWTy6W7b5YwXcUsfzJJtBZ+GZNotsxUrapN0kBqgPuNYJV
         a9Mw==
X-Gm-Message-State: AOJu0YxoPLk0N1tVtQ8ehI6UA154hjBh5p1DOQsJvr1GpQwo/CEofFOd
	9eGqCBoi6MN1tNDhOfl2hVjm40IxWmqKfbdQmcY3knI5LYLy4VqjNm9zSViya/tcyEIoiL9Bma/
	t
X-Gm-Gg: ASbGncu2VJ8m0LOCKlgVjASNrHpBB46brdMUaizI8RT4w1f08Qbv9ZBw7vFIIPepLso
	7/TYg6nihLxTl80sZPQ1pZZEMOX8qTOHOuLB9PI75fFDM5DMxggvUwRiXW2dxiBsTD650SqcpFU
	odqT5OnwTnTtpjAHjvneSSU436EWlB1Cw5XeD78vqP/0lbJkGrzkBg9pg2EMs7vjV8DfzHwV/Rf
	bd06xM/c9NxxfokZ668uvaRO27ero5KHpLuV+zcnlQJZN4W4PLoHFHN8aMXbDjkIxs5oMDNk8us
	IA7JoHrAz/EwIsrNk7fKn0WOb+pCb1M3OQ5nvoX8JU4=
X-Google-Smtp-Source: AGHT+IEdsA3MTgUR3qMAbLjScFrUuEPh7/KLMFSVhDWjT4eOg2E9i9fJO22++CkGqPDGgptLUB9SQw==
X-Received: by 2002:a5d:5846:0:b0:385:f417:ee3d with SMTP id ffacd0b85a97d-388e4d86e8amr6413293f8f.35.1734616037020;
        Thu, 19 Dec 2024 05:47:17 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e613:4b33:d5d1:f47? ([2001:8b0:aba:5f3c:e613:4b33:d5d1:f47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3e0sm19021235e9.7.2024.12.19.05.47.15
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 05:47:16 -0800 (PST)
Message-ID: <e2b6a94dd9a3789e31dafadfc70c53b565d1db04.camel@linuxfoundation.org>
Subject: [PATCH] rmnet: Handle toolchains with old kernel headers
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ofono@lists.linux.dev
Date: Thu, 19 Dec 2024 13:47:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

The RMNET_FLAGS_*GRESS_MAP_CKSUMV5 defines were added to the kernel in
5.14[1] and some toolchains use older headers, so add fallback defines
in case they are needed.

[1] linux b6e5d27e32ef6089d316ce7e1ecaf595584d4b84
---
 src/rmnet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 42b03249..9a7f52fb 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -27,6 +27,16 @@
 #define MAX_MUX_IDS 254U
 #define DEFAULT_MTU 1400U
=20
+/*
+ * These were added in 5.14 so define them here if the toolchain's kernel =
headers are old.
+ */
+#ifndef RMNET_FLAGS_INGRESS_MAP_CKSUMV5
+#define RMNET_FLAGS_INGRESS_MAP_CKSUMV5 (1U << 4)
+#endif
+#ifndef RMNET_FLAGS_EGRESS_MAP_CKSUMV5
+#define RMNET_FLAGS_EGRESS_MAP_CKSUMV5 (1U << 5)
+#endif
+
 struct rmnet_request {
 	uint32_t parent_ifindex;
 	rmnet_new_interfaces_func_t new_cb;
--=20
2.43.0


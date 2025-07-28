Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1D1F1517
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713995; cv=none; b=tmifgv9ef8qttPMQz9bAsQF8FRPJxqezbhF3r/fjSw15wAj5h8Aiu/Jf5fcKzblL/WRYAclUvseV4qMFDq29APijmRHZVwTuqhC1y+/BTv1uodaIYid2PrdxX9tYifJdVO9JjsGLrn2naIItIabFTWPrVjs9ZOqPKJTJdw6Fm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713995; c=relaxed/simple;
	bh=qI8ULceHsD+uAa8MUauLjzkmFvJPdQeBbxP2e7S67GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqdQW6waV7Kdv5M6cKvXa/1UL07UbgdcZYOjpHUV2gwf1S+2svtLD5DpfFw7wChrTZf21foEoGWjrl5SXwfNyI0cv0eklDh5/OuQGOqAUjGwVhaTfj+6DG4uNom9ysrZUI+7stAbCydbd42mSg5WOmXXctFy5S3AZ0C1oWHQbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic85mrdW; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic85mrdW"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e88bc3776so1696797a34.1
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753713993; x=1754318793; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6y6kXDHlmZydaCRh4YNgMYucKfAfLtzZ8UlUHwGCbxQ=;
        b=Ic85mrdWwF5B8HgKK9oykaZciEIdx0W0Ldu+uzkjQcHoDmp8cNAS3/xOmqebkNoi3p
         YOUEVsGnUz0QF0HL6Ms2PiyBn/5knjZEFwdrhA17FVg+TK/3nW9AWSWnARV4ixcM9/y3
         9LbpysT+g3EPGrSWd5EWBY97tj8OG/vKF+u4jC6Aqcc97kFQXdrPJNHLPIGtHxt/rP3r
         pnwI6Xt14quFRiDh1IK+0kClvCZCqD4F7I8SqUcSK7ere1uXMsH1riQ1SaDMv6gRtES+
         vb7QPmMJiV9lEp4rTsullWXXYcZJMir/AIswqAGOGS0XNJc8MHuRoqK7JvGk4PkLDAAO
         SJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713993; x=1754318793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y6kXDHlmZydaCRh4YNgMYucKfAfLtzZ8UlUHwGCbxQ=;
        b=OcWZp/Ot/RNkb+b9sCArthr9/auHCRgNuPeGTfZkDQD/KSksIhRaa8CSOPRcT0oMMR
         xFrLCdlKZ4NDz0vlKBJUbT+jcu2qlSTsr94LNHHjZmXEwzjqBP5W774Sxd7tV14xn4ZY
         y16Moi08B3EqPuyhI7VjFmgYVolna+9Vh/IJ2POCel0zp3XLe/rPfigBQrOP76zf8ViJ
         K/XGiO0c83pPZLKYb/ykDJTSyTJAAZTwvIjSi8Ib/K3QACu1lzXmNHsRAnF/92AtD0Xc
         ams5P6ECo43bVMxMC3O8qGlSsSQJSK7vAslq/DWGoJNkJKU1q6i3w075Tgk6YDJ98IYW
         UU4w==
X-Forwarded-Encrypted: i=1; AJvYcCUltiQazD6hxHw1rhFj7rXgqIhbA+kQC01eCTEYLnc+eWkP+P9LwC8Me83M+/hpLsPoHBmlgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/Q8VJ4mtR59EQcOZDpp3rZZs4LAbN8UIy3Gq3l7f8DCuFkNk9
	6txuj3ZfLQPCwkRAw0KdmEq2kuKYtDv8eJ9KJbu6R0FeD3jJjdC8V3T5
X-Gm-Gg: ASbGncsRptKoFDxu2q0tsLhM2+6hxCMPgjX11om72pK5T5PrQkKxLfhk57LIFwMN3T8
	XpZQO3VAERJIs3nb6nTQ7RJJv1yaJBqb+O4cpk51QB76rTNHgW6kXQqFWkZ85TkEN/vYWwct5QU
	tmdbNtNkYHfap4qEXv6Jwl7nbvwkgLUux3QiT6S9b6FT2xt/n6QH0V2A1ya+bI8X4ByFUXhyQ09
	Luj5rLIfrWXnldiXDE2k3vS/3yVJCjlITc06WYXWWJPVHc29g4y3ecHyVXCdxdWURH1TqWsLFpu
	4+GGVzHv7CWwYOxxQYLnhWBJin+ezQMdDQ/CwKn+0/K56XtXOZKC2d+Q2KTS4WXvMrwZwtAx7l9
	7WD/d10AudhBhPcNlx6nzGM2+QGlZRaWFqj/jMjFTYx+5LxUJO7w3VR0OwaslTdDOHdgSE5KYpx
	E=
X-Google-Smtp-Source: AGHT+IFCtMWihrikksNlM5H5XmILj4UKhoF4aBflOib0MUEOXb3ISmHiH2zf0vLe58HMd/9ZJehfVg==
X-Received: by 2002:a05:6830:3494:b0:73c:c494:a032 with SMTP id 46e09a7af769-7413dd31412mr6474268a34.2.1753713993050;
        Mon, 28 Jul 2025 07:46:33 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7414827b569sm1092753a34.58.2025.07.28.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:46:32 -0700 (PDT)
Message-ID: <948f9442-1211-4a47-b1fe-a6b83a5fa500@gmail.com>
Date: Mon, 28 Jul 2025 09:46:31 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] gobi: Introduce "LTE" modem property
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
 <20250725121954.650668-6-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250725121954.650668-6-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 7/25/25 7:19 AM, Ivaylo Dimitrov wrote:
> There are modems that are not LTE capable, allow them to announce that
> ---
>   plugins/gobi.c   | 10 ++++++++--
>   plugins/udevng.c |  1 +
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 

<snip>

Can't we use QMI_DMS_GET_OPER_MODE to find the modem radio interfaces supported?

Regards,
-Denis

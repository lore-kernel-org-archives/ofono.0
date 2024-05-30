Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CB182D2D
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083543; cv=none; b=ZDovQK431HkprX1T1pYc3sqljopcKZToaicu6m40Mk4CNWjzHOeVJmVWtteKdRIrWvKhS95tQ+EWrqFNGonzsRDZeZVOL8uCxICxriRC90imtKTuPpIB8xLomLPaacV7FyysdPYJ6s5TQaYgyL5bz+djOB7BssmbziTzrSiTw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083543; c=relaxed/simple;
	bh=MZGhq6YY/+xANBzjIn0Eriq799yxKT/dVs2YyS/u3rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NGGsno+1gOrerA8ZT+F0hB+ySfd6lY/rY37MdQQp3KQadYskWuMX1Szis95OA9mcB41DXr/VxyJMOFf16KSF0paRQJE3yTjudCnV2FdKVGzWVDJPk0p1A3i0PEBYJIZj8AgsxTpYJXad5juS8xtDsDbx6bv8W3RKFeIwRPaVzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8oynSj1; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8oynSj1"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8e5115cfbso653517a34.0
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717083541; x=1717688341; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7M8a4SLTR18HeMuBJ/x+ZIcT0Wq1j0Fv2/LMyLaJVw=;
        b=O8oynSj1E7M1VHRv5L3epvDLTyDo3j4IpTxi8fOqlZ1u0tMhJkJ8KKvVCDJlW70x/u
         PUCk5NlaIWzXv9CBptv3vCgN0teiutbcCPL6CkLv1vhL6KZ+Mej2uFvC6f+goH6wn7uG
         sw97RBG8MUreCP0xCEnRbAsBSEIf0MTjTe43xDOf1DEYHTqAotnJNWOrsvbUJnvtYZgQ
         H3Jj5Qj6XYvXS9xwUsamgWC0H1AQzdp8r/A4M08yuG+nXsvKjJeqXeyK451zH17nhPJb
         ykwQ2+WaLYff5BdDqX8tSUaxeNr2qgDCi2nWVZXUWUDg6evMhEbAvrSzmidEhrZPKpge
         DWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083541; x=1717688341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7M8a4SLTR18HeMuBJ/x+ZIcT0Wq1j0Fv2/LMyLaJVw=;
        b=rmeOyZbfwiN4RwL8jc8EZMB8h0g7sDA9Nv4/OOSAPekBxGvT+X5GlxdE0IBrT3Tu+o
         40Lik+9ZmboJY/RwPWyrR4y2ZzbbjJYZ+7f3PYbFvrghV9D53SKp02vAQD9xp+6AeFNZ
         LlMnRzsFwCCubyBaviOpCLQhCkibZcfEoNdAYn88PfdbNXixtsc2R585coR57aRNYgT3
         AN4/+Tvz4RMzFKXJIp1ngO/q06YkTIEL+GA7VF9fZMLdqhQ//PVh9LcAb65a/bxjc2Tz
         Xr9YJu5qlLJFHaLnZLXT9VB2sXFZ6joSEDPCD6yNMyIycwrNm+Zwgox65iC9cxn5IXx+
         5ouA==
X-Forwarded-Encrypted: i=1; AJvYcCWPve2yhbgBBoRV7yiDHnO+9F6f2pGlyS34sSPtwg4c8ykMj3WqznK37YKGTxwL7diwvqSBF1E5oTQt1xyLz9/HoR/SSxQ=
X-Gm-Message-State: AOJu0YxDqvPZURL4uVDTj2K1vSsV5Ft8W59YTvlqKDMQOAdtqgHz8NnP
	wakVOMs+oCTq2jy41rrF+Uq15EosuaRRHaWpMYFyqg8UpPX2TzmIsO4KRQ==
X-Google-Smtp-Source: AGHT+IHT1du2/D3ZlfsT3OPsh6ru8D+hNfjrDs0445RtB6UsI+5KLEpfxd+Lb9GQDR7XUuuN9xAbbw==
X-Received: by 2002:a05:6830:18f8:b0:6ee:1642:e26e with SMTP id 46e09a7af769-6f90af10216mr2773993a34.26.1717083540742;
        Thu, 30 May 2024 08:39:00 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-6f91054f672sm137a34.46.2024.05.30.08.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:39:00 -0700 (PDT)
Message-ID: <e67f4a99-2b4a-4915-bbb2-6d2253b3bebd@gmail.com>
Date: Thu, 30 May 2024 10:38:59 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] udevng: fix tty subsystem device on usb bus detection
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
References: <1717054451-3185-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1717054451-3185-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 5/30/24 2:34 AM, Ivaylo Dimitrov wrote:
> Fixes: cdd58360140a ("udevng: Add mhi subsystem detection")
> ---
>   plugins/udevng.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Would this be better? 
https://patchwork.kernel.org/project/ofono/patch/20240530152513.279243-2-denkenz@gmail.com/

Regards,
-Denis


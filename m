Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6602E635
	for <ofono@lists.linux.dev>; Fri, 22 Dec 2023 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcIJWnmr"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b7fdde8b54so84197439f.1
        for <ofono@lists.linux.dev>; Fri, 22 Dec 2023 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703273898; x=1703878698; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW2XZH0h3dZ8VdMV+Nz4EzrSpp2aoS5Haoowv6NnxH4=;
        b=EcIJWnmronrdZshHbG1WmZFZjImorErISWQXk0dZfdBJKSZ7Z4xHTr78ez8cQ+JHHK
         djQTfrfc11E4ReKRptn5HJKCESyBHoRBSrctqmgwyc+dFxg57OHFgOgPwNBgNoiYrjoS
         Ujbhbu9HixQe6yl1OtyFUU+x2IsVL7wxauEhmCUNuUVaXwsZKcb2+OYdyD3q+lM43pMd
         vVYsGXxeRTbb5Kalt1uJ3s7rlQeCr95XRNi0WQ2guCe6P3HpYc1IhXaUF81Og5fzSujl
         O00fnNZfYtrigpX47vB67RznQ324ORKPhLmgjF1+9FepZn1q+jwHlgnXdRo5+BdZthhg
         GI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703273898; x=1703878698;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2XZH0h3dZ8VdMV+Nz4EzrSpp2aoS5Haoowv6NnxH4=;
        b=jm+OXmeIajKzPXE5DpVQiQZr0OiawPdJD/cNif/u34C4YTPmDseywIicvdDC1KOMqs
         KLjocMTcXwBrFDDvSwJ8/YwRK6Jq20/StjJvOtsWer6NwXwVP93xlvwT47Yql8GMOcfk
         cTfMBW8+IC+OB0V238tXK4QxPc8LUI03dFTYYMr6jFRFlTYerxocxL5D8KP4dJhBaFHt
         ybhU+1I0Zq/H2ZsaUGVfDR4tHgb8xXbW6+l9hsQODkHnsuaNHeQH83hZgtHhPRl4JNvv
         MN9wfzcpT9XvZkh/B8huPaihGxEA64Vl8ng0oA9oZ9HT+M+N0z2Krq/Rv8HCuXBfZJuo
         FBvQ==
X-Gm-Message-State: AOJu0Yy6SY/XymvvKYCYnE3HsLJbmbqQizc0eq1cW86L9kWi2cpxGuq1
	cl+z/GIGnD46TJpk7VBG2XGHUc+6WzM=
X-Google-Smtp-Source: AGHT+IGZZsCf/Ze0NxfMJlHSEyIsv4QpwJtfmAW5q4B4aHpAsKMFClaIJKFyEt8vtEifxV61DIJ5Yg==
X-Received: by 2002:a6b:ea17:0:b0:7ba:74d6:a70 with SMTP id m23-20020a6bea17000000b007ba74d60a70mr2279448ioc.1.1703273898609;
        Fri, 22 Dec 2023 11:38:18 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id x17-20020a056638035100b0046923df89easm1181071jap.158.2023.12.22.11.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 11:38:18 -0800 (PST)
Message-ID: <ae503a8d-3798-46fd-b733-d75cf9b8b242@gmail.com>
Date: Fri, 22 Dec 2023 13:38:17 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] smsutil: Check that submit report fits in memory
Content-Language: en-US
To: Denis Grigorev <d.grigorev@omp.ru>, ofono@lists.linux.dev
References: <20231221141638.19774-1-d.grigorev@omp.ru>
 <20231221141638.19774-3-d.grigorev@omp.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231221141638.19774-3-d.grigorev@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 12/21/23 08:16, Denis Grigorev wrote:
> This addresses CVE-2023-4234.
> ---
>   src/smsutil.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Applied, thanks.

Regards,
-Denis


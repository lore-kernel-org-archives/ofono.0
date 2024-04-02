Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64A15E209
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712096522; cv=none; b=djFwJmsuM09apFyORQXflaPFiLzXo55/3XuL4T479hJz5AGA+LjsOM9DmGHPLKVi4xSmWTwxSUC/duLUvrceUQhqf1z7DudEmfApMKv5Zs9hdoatKHvllInZ3B52HBjNNpyHdPxQ/gHJbHNMTwwaX1Ze6D8jnTUP2XTXp0taI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712096522; c=relaxed/simple;
	bh=dQ+DZ5WAcC7Xq1huKnsW+1yG6ijw/D5L5srzkiBfjyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMVnh9AiOyCQX1+WBpJVAXjs7VXuCv4x4c+QZ5YqveEJ+sXE+uRDwFTlSQH8s5JaMEjPQGKV5OmFvkmBGOnuXs1ZbZdhDZQP5OYntDAzXpe3D2xQwhF0P37jCSdJbOSAaXVvq+5f6EtqXQmOSPS+vGW6DuEFvlG3nZ9Qn+iDSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXuJRX3q; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXuJRX3q"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22a1e72f683so4214398fac.0
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712096520; x=1712701320; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbR91ETfWbSdUm5ZTjJuUBvnc+lhaoLl8BdfJRkwum8=;
        b=TXuJRX3qvlAb2PU5pxyITBMN//iRQn77NYlatFsdgk4G/upb2DNYq3Ehb92l3YruQS
         t33+HU5S+drV4RHy8i14+tMlRC00gybaLmcgCG77OAEhJp9JGwNimpoUW0+wQGx7Iz7m
         OjzwTBtvcZBe6k8Cichun7F+6v2y3ZQJDlmPFdGNLytVkX1ovTa2wrnO7aAVdSeCsqsF
         1g0+TPC8kpQCbECvrNGF152M7ApZZG9uG+OhB/6FhVcnedH/jrxhM6XzAHZC17dquF+E
         4o3V7nJk7T36zz6qMxH1r/DAesDWECzzsK9CYJ5kjRg4/j49JUsRy+lz+ItC2da5Uru6
         GuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712096520; x=1712701320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbR91ETfWbSdUm5ZTjJuUBvnc+lhaoLl8BdfJRkwum8=;
        b=eAzawEl7kq5zP8C+oD/RsdeCxpMFy0wwE6zrma8tB+MTmbRV2LEc2aDVqFZseOVMm5
         9xtwwvB1uPZfRklEkpZnBJc47Dl8pGIM/CO/8UUQ2kQ0Tv+DyjfoEuKr2fy3LwFf5vdz
         p6M9mCeq8MDJAx8yK/NFR9nzfxNvRK8vxNipwCa6PU9tkB/SET/W6qP4KslnLkuzU2xh
         69rxkZ6cpS3iFyF4pmfibekP0MEqkcoTiNrqIHRA2dGy5VSid7j9zli3VMpwvHc9Yakn
         8R5XHwzPi3DeXmZligbP/8drToeKbr/vovilhg296qrgQYnw6eUHiycYWC5qLReAu0xP
         SFEA==
X-Gm-Message-State: AOJu0Yx154L2JO2HZYEx2Hx09DjhP0Qbifqri9MCqOBHbgn5RiiRMxrG
	96ho/Brg0jgsAFvr+ENUaXFNLYWYZ0gtIKEYuhRryuhr4jlya+i4
X-Google-Smtp-Source: AGHT+IFnNzg1I2JFyQiNGAYiHZeu2qjzShKXu4GO9z6RbClagEBhQ6NT/YCvkcY4OvOYVz7lNfNS4w==
X-Received: by 2002:a05:6870:2421:b0:229:6d0e:203b with SMTP id n33-20020a056870242100b002296d0e203bmr16022558oap.50.1712096520356;
        Tue, 02 Apr 2024 15:22:00 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm3671983oab.2.2024.04.02.15.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 15:22:00 -0700 (PDT)
Message-ID: <0db2c6db-13b6-4837-a944-057a7fe349ec@gmail.com>
Date: Tue, 2 Apr 2024 17:21:59 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udevng: Detect embedded qmi qrtr modems
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>,
 Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev
References: <20240402212013.39038-1-steve.schrock@getcruise.com>
 <6C7DEA43-2E90-488B-91A2-9868638F4301@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6C7DEA43-2E90-488B-91A2-9868638F4301@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcel,

On 4/2/24 16:59, Marcel Holtmann wrote:
> Hi Steve,
> 
>> Embedded qmi qrtr modems are identified by the existence of
>> rmnet_ipaX and rmnet_dataX devices. Add a new "embedded" modem type
>> so that these devices can be collected during enumeration and then
>> configured for use by the gobi plugin. Modems of this type will be
>> exposed as /gobiqrtr_X.
>>
>> Retrieving the endpoint ID is the main complication. It requires
>> using an interface IOCTL and extended structure that is declared
>> in msm_rmnet.h. This header is available many different places on
>> the internet including in Android sources, but it is not available
>> in popular Linux distributions. The minimum set of declarations is
>> provided here so that the IOCTL may be used.
> 
> can’t this be integrated into the WWAN subsystem? And then we just
> add support for WWAN subsystem to oFono.

We'll need to support WWAN subsystem eventually, yes.  Unfortunately this is 
coming from Qualcomm proprietary drivers.  Upstream WWAN subsystem does 
something similar, but in a completely different way.  Suggestions are welcome.

Regards,
-Denis

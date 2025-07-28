Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CF237163
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714238; cv=none; b=F9/lf5d7lONoc8/PWcwHvwbl1jzkrr+9b0w5OAqVEkSr+eJJglfWTPRcRE8KDzgnrFIyW5mzw5PW4WWx++/dQDt9+M8avnmbDRR6aC3JRdFh+Jw7Pp2V+3A9LBn9JO82/oS5Z9SgnyXdpb5FXIkVzJERpzKdw12lzYFl/UX/5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714238; c=relaxed/simple;
	bh=dnFVwHdNO2voA9sCCO29ttoaSzNNmtUBkMiGyTvvEps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9sgkUFrVxtdRtTeIWPOio3GK8oxXHdwv9ZyUO5RyqaxgHg9s3ib4PuBB1fZX4AwzT8u2iE5UVZio+tm2+WbABjF9+qSmfZulRCndVRZe8tF39q5ZZh8N1wVxNEDz+lsHq55d8A8AVFFz69+ua4pwrSOaym/h0ekP6xh/JU1uZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JID2p8uM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JID2p8uM"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e7bb65255so2909806a34.0
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714233; x=1754319033; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtrppG+pylIhw61jdub9t9V8+lylcZxSEch4Ag1ucN0=;
        b=JID2p8uMSBDosAetNqjoRsZKP4PprS9As1g4T0n9IYEszwl5qDloInUskKTmUw7kcK
         aKhl+E9SFfCGEn6tzq4PmU1xdQNPHz/U4i26gzgIa4p0A3Z+hzwjc1+eiY7q+OkcPzXK
         Vb+qMXluV8Wy1WnyU5yBM9/VztTk+o2+SF1FGzXweQ4OD77rCCri1r55lqjLnjLZOiia
         O1GvpaxBrAEUKc1mQIkzg/YqyLHJeSpDh/cRQuGyLaVb4UaBd8zFNNnyBnbweNNKCw3S
         ODgRBeB4lyEbskNQVDXRbJUceNGPRySKewPlDTnmIv7zjE3KbxbELuV4v9QmCs5JNrpT
         NlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714233; x=1754319033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtrppG+pylIhw61jdub9t9V8+lylcZxSEch4Ag1ucN0=;
        b=JZyw9VKzMbRLrcMI6H4HoITxNiWKSvN3yOz99aUfPaTOp53dKRUYxOanUsk5m6HZpV
         h9UsORBXv1YLbqElTVaiOj3LpiGw3qLrUiYtpDcIOIDjFNasr6x3KyThBWZlQ1TUUgmj
         tKpuQRG2XKTHqCy8NCiWzBzgd176zx+Y9udFQYlivv/cFLJTN4zz3brfIMOStN/1Qw9N
         l5pi5qMI0maQwbMk4oYd62SfmSlJ7UlPqj4arko2IETLb6u+2aUa9Ca2EkDtqhXKKoVJ
         umsZ7/vUeQXFt3Dm0HQq5fgHmTp/RQWDyzhgZlaFpUc0pQ3CTucGpH8HHOJcZ6uNVdIV
         puIA==
X-Forwarded-Encrypted: i=1; AJvYcCVB75dt4ioHonNNt06/mvFZckdGpTaVlbYSjojGhOpMgEJWDq/wT5C8k12Ha2hBWS2mq2aCzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxEGV5wFoUQDMGwYXdd8INUy2BTbz3QQHBL9Hm9u0xMXExTWk1
	DYvwZu9/UhqOnXDHJ1xc7+grhTn4vkCygSG++zd0QtEO2+Q1F8jpfIbw
X-Gm-Gg: ASbGnctH24PHgcAS5vNiGCaUUKTWUmZave4wYR7jBGPNsLCobgVagi8u2qvmqaw+pry
	poEGkUUEQTuyhopbxlK2aIDS5xXU89TTzowY6eredhaSk4SoWBf+dJNTebgJenw2A8I7MkxGZqG
	rlMRl6YnnnKv1HWQohFbr4UDpWVGmJO/jHMmw+FYomq0l0BXHmz2uoINXntBuMEfuUd+3acFQsK
	4HkGJF29Gz1cQamQ/N+dqmOn7R87XSrRDZagAzFfd7yVJ6CqfMqMEQs7mDAS3keZYMowRZXG1x8
	FDf7dKVYwOoHIW7TOaB/4b+k43WaeVNPyUOJGVY35rJBqnkA51L+ztB+psJth9oxtYn1VGhibH1
	Sb1Kh1UWyQoU7KMVS9uOzNFsR3OL689ONvTsjnBjuQPyX9nGw+t3doLcOUvgOB1Zc8MrOEgFC8m
	c=
X-Google-Smtp-Source: AGHT+IEXdcU0GogudWfE+nCTZ0QfOLjo2sNGaGyHo1uU7Kw+Xgem8ACjHkYLRWmik07D8dNMlqwNyQ==
X-Received: by 2002:a05:6830:608a:b0:73e:b257:8b91 with SMTP id 46e09a7af769-7413dda900dmr9961507a34.21.1753714233458;
        Mon, 28 Jul 2025 07:50:33 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-74148271308sm1084040a34.55.2025.07.28.07.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:50:33 -0700 (PDT)
Message-ID: <db7e1d14-ccf6-4dab-a3de-f6755a732d84@gmail.com>
Date: Mon, 28 Jul 2025 09:50:31 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ofono : enable proper D-Bus connection with PipeWire
 via ofono.conf rule for Yocto builds
To: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>, ofono@lists.linux.dev
Cc: quic_mohamull@quicinc.com
References: <20250728060806.932-1-quic_rbujala@quicinc.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250728060806.932-1-quic_rbujala@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Raghavender,

On 7/28/25 1:08 AM, Raghavender Reddy Bujala wrote:
> - Added configuration rule in ofono.conf to establish
>    correct D-Bus communication with PipeWire, when
>    pipewire running as a systemd service.
> 
> Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>

No Signed-off-by used by ofono.  Applied with some rewording of the commit 
description.  Thanks!

> ---
>   src/ofono.conf | 4 ++++
>   1 file changed, 4 insertions(+)
> 

Regards,
-Denis

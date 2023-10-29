Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10305D26A
	for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrw8AaGn"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2d9ac9926so2562536b6e.2
        for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698613560; x=1699218360; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LA7d2i0kiNjyKGNxIVO0AleNYF6FYDHNaxb8FvaIpuA=;
        b=hrw8AaGnJio4DKpPtHi6752i47PyPdhmVbDwo3DEKevZ2SgLbRggv5S9J5NCmeJxO6
         KLXf3cbsdVQzVNh2Pvxj8/vCp7HdUKiSKIGoOrZrumUR25BT9LhgBIqpUtPqcRzADM4r
         XVRkXQEB8OJSMABgMAEKiKHV/gCTGu7uNTc+mQDOn9XNdp99YkGfW4JNZvdjOyvNZtiX
         doBHwbAKpJt9fWQPftFCnIcT1GAo1aTaXyLLVUEO6x3WzivRYvFBNw7oyrq/q/BTevW5
         1rY01bKDNsybvS+fEcmUxh9Hjv7cosExg58h9BHaacqTIAyhRcEjOBCGQo662vp9Aj9k
         REmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698613560; x=1699218360;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA7d2i0kiNjyKGNxIVO0AleNYF6FYDHNaxb8FvaIpuA=;
        b=nuSyZhwyQ/j6v3HdKR8fmkT4XrekjXm+AQUSiEPN4Zq1CbY7OCBLLvJiUNpSVZNZ/m
         V4nVDgcO6uUgiBcwZNe8RhWr9rAwc4fzYKoV95iEPZ6dq5idherwhLXF+rlDFifZaS9X
         Qy28DN5eRx44QZhHzn3f/D5GCC4rXoqfBMbZJunWIBHu5eZCj8Hp87KQAMIDfoMB9Jfx
         h0HUwtyPdwaD1APzkqC8xOVgDjZ89lzkOCAFDusnDmL0be7vl2oZ9MJB+La7hb/MBHQW
         C1BiqHYP6BgXz0YyvTkCYk62ZRCyQJ8KKdYMK76fkjT9twIkEUApUJLs1E687ZoeeWYf
         /I3g==
X-Gm-Message-State: AOJu0YztmkvakJ9MHuPkrlnKAUl2uyYPEy4tYRKHMjApAJ8a81TduYDs
	tNAMG+v22XsMOAP5uqhK97joHyKK3/g=
X-Google-Smtp-Source: AGHT+IE2qZLmRmiXe9vwbSfAxBF5lDdtzqHEeBgebyL12dU7fvvoKdtbKoghiyRrI+dDbqL+pnt7WA==
X-Received: by 2002:a05:6808:1149:b0:3a7:2570:dcfc with SMTP id u9-20020a056808114900b003a72570dcfcmr10769898oiu.43.1698613560128;
        Sun, 29 Oct 2023 14:06:00 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k5-20020a0568301be500b006cd2c236b8csm1176687otb.3.2023.10.29.14.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 14:05:59 -0700 (PDT)
Message-ID: <6226eae5-8091-46af-b6c4-36a0578f4b00@gmail.com>
Date: Sun, 29 Oct 2023 16:05:58 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] ppp: message tracing
Content-Language: en-US
To: =?UTF-8?B?0JvRjtCx0LjQvNC+0LIg0JzQsNC60YHQuNC8?= <m.lyubimov@aqsi.ru>,
 ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-15-m.lyubimov@aqsi.ru>
 <4a3b8f95-1c7a-4f37-9a99-8d1928d24635@gmail.com>
 <6d2992cc5acf2e72f831a7dc30274afed4995424.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6d2992cc5acf2e72f831a7dc30274afed4995424.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

>>
>> Hmm, this is better off in drivers/atmodem/gprs-context.c since you
>> have an
>> OFONO_ prefix for the environment variable.
> 
> I had to call the g_at_ppp_set_recording function here, because if you
> call it before g_at_ppp_open, then the ppp->hdlc variable is not
> defined and the function does nothing, and if you call it after
> g_at_ppp_open, then there is a possibility of losing events in the log,
> because g_at_ppp_open calls functions

Okay, so that looks like an implementation problem in GAtPPP.  One possible fix 
is to store the recording filename until g_at_hdlc_new* is called, and call 
g_at_hdlc_set_recording at the right moment.

> 
> pppcp_signal_up(ppp->lcp);
> pppcp_signal_open(ppp->lcp);
> ppp_enter_phase(ppp, PPP_PHASE_ESTABLISHMENT);
> 
> What prefix should I choose for this environment variable?

The original comment is still applicable.  Our pattern is not to invoke getenv() 
inside the libraries themselves.  The clients of the libraries are responsible 
for that as well as setting up the library accordingly.

Regards,
-Denis

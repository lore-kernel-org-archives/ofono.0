Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E597F0
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOlU8NzH"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e9fbb7d88eso3828979fac.3
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 19:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697682171; x=1698286971; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amyk7WIrcV9x8QumMjlam+czuzYqp+UF4L83CFfMZAM=;
        b=FOlU8NzH1gHj+OzcJQ+83DjjhdfMsfWDOJfnbO94qnIbd8tbewN/J4z3+/RemQZD8C
         Cgwsf5Sj0oEcYakvTsGGBqSWSvnhfoc1U1DGHlWKCr4eA3bxdQYm5kIbnEmBiPVW76HF
         qTHXKdlvEAUt4N7j0qJ9N3hQD+wxbTknAq6cNDB3duqXgqYnAgMFeMxnkpGyDZCXJZOI
         rm3N3cp3eDc39HBN3X/v6OCPTMUv3njkVLVDzZH/B6gzVtp6p9g821/1W8xi1KUdcle2
         J7TA7Sp0nbG45vpGvFm6J78suvEvr7cOrAaVzDPXdZUXp8jUuyuzIE+TgscSN+emIi/Q
         VxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697682171; x=1698286971;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amyk7WIrcV9x8QumMjlam+czuzYqp+UF4L83CFfMZAM=;
        b=iwNDUzjGr/ltbHgb1M5dbasTopWPG4PZpRUxeEdI+kRZ/lOZlMMHSJchlQNZRhBhAr
         YG3VtwEnazJS9qpQpeeH0CqcF2xDVf49imwqXBMZu1ZozFtpRMZhsWwjmShOdj6GGpa9
         uSYAboG4xvNp7/cJYy7+dxDZTefvAO+mxzlmC3ThTWAZQhljlusFV0rHQvKin1ymul+4
         X4mq4yDj6X2wZpUWZdOpW5WZpxupHyW+0/wIzFmetR2VZU3v5PpFYrnk7SrGYJTzEOHG
         o+wZ5BfJsu1F+6NMp78T/a8SjNVWrPsKbjNgYY8jHU6UNfdIAiyYdqcGOCjajiPimiqP
         7Rrg==
X-Gm-Message-State: AOJu0Yxwr7nnAZIBb8tFZBeLOIBx+DpXvQ+xJ5Zn4xN1fWzn1yINQvi5
	HBLQBZ6ayrvhjYI0ym8gWBngoFzz4TU=
X-Google-Smtp-Source: AGHT+IFU+AaQpNnSQYiujZ3ffcUlQ7rxWN1L7q843fTR0GrsD6KLnotqYN1AMx0dXodSVDd/rTFHag==
X-Received: by 2002:a05:6870:fba3:b0:1ea:15e6:9420 with SMTP id kv35-20020a056870fba300b001ea15e69420mr1132174oab.52.1697682171708;
        Wed, 18 Oct 2023 19:22:51 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eg48-20020a05687098b000b001e9a253afa3sm958435oab.49.2023.10.18.19.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 19:22:51 -0700 (PDT)
Message-ID: <4a3b8f95-1c7a-4f37-9a99-8d1928d24635@gmail.com>
Date: Wed, 18 Oct 2023 21:22:50 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] ppp: message tracing
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-15-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-15-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:49, MaxLyubimov wrote:
> Added OFONO_PPP_RECORDING_PATH environment variable handling to enable PPP message tracing
> ---
>   gatchat/gatppp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 259e6d5c..a655b35c 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -561,10 +561,16 @@ gboolean g_at_ppp_listen(GAtPPP *ppp, GAtIO *io)
>   /* Administrative Open */
>   gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
>   {
> +	char* recording_path;
> +
>   	ppp->hdlc = g_at_hdlc_new_from_io(io);
>   	if (ppp->hdlc == NULL)
>   		return FALSE;
>   
> +	recording_path = getenv("OFONO_PPP_RECORDING_PATH");
> +	if (recording_path)
> +		g_at_ppp_set_recording(ppp, recording_path);
> +

Hmm, this is better off in drivers/atmodem/gprs-context.c since you have an 
OFONO_ prefix for the environment variable.

>   	ppp->suspended = FALSE;
>   	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
>   	g_at_hdlc_set_suspend_function(ppp->hdlc,

Regards,
-Denis

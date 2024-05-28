Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44217BB08
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932225; cv=none; b=uXjvYG1AnIQXIVW2Vh7/9s2rz23UtC6rhj/ZQbskQe980dsGseMS72ac1UUFxEHIEEmEKfbYNRtHAkz19caiRhZJk+xT0L8Tp9iZZOKBOxOA+DMRQOvDHhSi0kakxPytVssYNCjl7r0hJW93mXZZFO/+OU28a+hyTGxIOt9wupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932225; c=relaxed/simple;
	bh=i2iplcN7WspzdDK0yQ0ZSFcAo3Nt6sLd7gyMuQA466s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddcSvR1aHIgHz1O9krSh4ewCvKSqvSebZwBXMTFo/OljV5IK/YUUFa3QZKBw9H4iDMaVIr8RCghk77NeEO8KffpEQoG1GFjl5ug05jhCu79JhEThq0Z6qNsOebwvcfmtWgidudGyZs5N/ZRQc9Zx6bsUChuq6Vs32ixZnELjNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwjS1KHP; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwjS1KHP"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b96a95c5e8so852378eaf.3
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716932223; x=1717537023; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhkyKlaW2SaISTDaoa3h5Yqj7hWNyiThyAwDIRmeEVM=;
        b=dwjS1KHPeBqPsIGPfBAsXskzReE9+Dh2Oqo26ScnXw3uxJVFuFXt+jICLZGTyriZIN
         byjv537Y6MagYsSOlkTuS1oW4CDneIB/9hdng6APVUSR6VMjhgFiPORb6I4Rozy4JdQY
         5Gi1CzSAV3mZZkpFePhvYV1FjjETnM4TDOhCtevTEqMdPOiGtxWBNIy5c/wINAtHp2gC
         8tHMy5l1lVaqmahNTFHSOpyZPImdnGj3bXkh6LkO/mzrwssP64S+bpROT7TKFFa649/S
         y5KZnNkxo3qOK1a+nb8Xf4Rm/otqLw5I1IGi270exhlUJC/aR4tNazVN/VPkbctLcP3h
         mHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716932223; x=1717537023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhkyKlaW2SaISTDaoa3h5Yqj7hWNyiThyAwDIRmeEVM=;
        b=aJSKVe/dRMYesyJVp6TkytTKOAgkK9E2DtbRd9JAwTnyOUGBdIaBgWB2opYhUeILXA
         pGZ3KeKtxPsId+9et7ZG2z4VaT2GIGqdpviPmX2GVYT2LwSKo/QDiSNNmstWWQyst/gj
         IWfjEiBmiE5H7D+r4yM8Ev2QoXfFXeVtWRU5Wx33uV/iGguya7u2WkTLl6IR+oYfgWvz
         StN5fnm+jtvdr9MxRxp2K/tJu1FmYj1XQ+APaMIA2NnEU1j9ZtG6fEZuJxMiKFyLcSDb
         T0l/2hGuCzK+bM1BCzU6lGfTXrf7gWk8j+opS+xwsRxQi7Yfn5sbGehPjhVV+cpB9XUe
         wlgA==
X-Forwarded-Encrypted: i=1; AJvYcCXBROECBX7simcPKnjp+OjfqmfC7E9TL2Br77wiSO0JQLRp8PGebA0zs2rd/Tp/qt/6BP0LKIf+mTug6qB2K8Nww/KRVtI=
X-Gm-Message-State: AOJu0YycMuxpxPmlZrSz/tgM7Yet+P5W3XvPmLdf7qVbRyvp5ApguOk5
	RHXUrTEhvffyEkvYbfRXHtJgyMkg+8s72qoFbD8VropmGz91S11p
X-Google-Smtp-Source: AGHT+IGby7gBuNaI4Rc1g9Hu//oh973XtUaN5unKgeUlzmIRdl/GNAvY3GYo72MpRNmszS4QZLHzBw==
X-Received: by 2002:a05:6820:61d:b0:5b5:3d56:5847 with SMTP id 006d021491bc7-5b96278a602mr14449809eaf.7.1716932222673;
        Tue, 28 May 2024 14:37:02 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5b96c6db63bsm2437673eaf.40.2024.05.28.14.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:37:02 -0700 (PDT)
Message-ID: <672fabe4-4c72-4443-b7ee-5b8d3c75da50@gmail.com>
Date: Tue, 28 May 2024 16:37:01 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atmodem: gprs-context: use default PPP ACCM for Quectel
 serial modems
To: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
 ofono@lists.linux.dev
Cc: Sergei Golubtsov <s.e.golubtsov@gmail.com>
References: <20240527105915.637532-1-martin@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240527105915.637532-1-martin@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 5/27/24 5:59 AM, Martin Hundebøll wrote:
> Since commit c8ed7162 ("ppp: using RX ACCM = 0 by default"), the Quectel
> M95 modem has failed to establish a PPP context. Instead, it
> continuously logs this:
>      PPP: event: 9 (RCN), action: 1028, new_state: 8 (ACKSENT)
>      PPP: lcp: pppcp_initialize_restart_count: current state 8:ACKSENT
>      PPP: lcp: pppcp_send_configure_request: current state 8:ACKSENT
>      PPP: lcp: pppcp_process_configure_nak: current state 8:ACKSENT
>      PPP: lcp: pppcp_generate_event: current state 8:ACKSENT
> 
> Restore PPP functionality by configuring the (protocol) default ACCM
> value of 0x000a0000.
> ---
>   drivers/atmodem/gprs-context.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

Could you please add:

[core]
         abbrev = 12

to your .git/config?  Otherwise CI complains:
0001-atmodem-gprs-context-use-default-PPP-ACCM-for-Quecte.patch:7: ERROR: Please 
use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - 
ie: 'commit 0123456789ab ("ppp: using RX ACCM = 0 by default")'


> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
> index bfe6ae56..0baea4a1 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -163,6 +163,11 @@ static gboolean setup_ppp(struct ofono_gprs_context *gc)
>   		g_at_ppp_set_credentials(gcd->ppp, gcd->username,
>   								gcd->password);
>   
> +	/* Quectel M95 fails to configure RCN when using ACCM = 0, so set it to
> +	 * the protocol default of 0x000a0000. */

Multi-line comments should look like this:

/*
  * Line 1
  * Line 2
  */

> +	if (gcd->vendor == OFONO_VENDOR_QUECTEL_SERIAL)
> +		g_at_ppp_set_accm(gcd->ppp, 0x000a0000);
> +
>   	/* set connect and disconnect callbacks */
>   	g_at_ppp_set_connect_function(gcd->ppp, ppp_connect, gc);
>   	g_at_ppp_set_disconnect_function(gcd->ppp, ppp_disconnect, gc);

I fixed both issues and applied, thanks.

Regards,
-Denis

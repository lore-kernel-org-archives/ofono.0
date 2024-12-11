Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E27246345
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932594; cv=none; b=uCWHlTbAC8twSFCk3KMVC+60FU0k6QqgCfim4u5Wjf9QM8oDA0eG6G2hLnSHDjbHhRTNkCzJcBEKutZvyrvjq978/faf+EoLviTMBjGBLNiSR0ZWylDcbrKA8WCMeQGc73/LDCcYpg281pE0PcrQBGJR//f1e4mWwSf6zSKex3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932594; c=relaxed/simple;
	bh=O/ybLVfkwfWVsuqa9Wdj8HyPisJpkmybYnjTrkRkY3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVB6ByPjn2r2QrwIg3G4ivP38Jzm9umiseNn/RYAv91d6/stY5/HdP0W3CdLOQN1bjhOYMRqHOPy/l7k2VfXoUik+cGdQvGW2Lx5Wh7SOLZ03c8vdF6brKTCStR1rHAqBJj1BKeayWZZso2fRVN3H8rNI6mmCTsf6aC2fjfBSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDCTcZZD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDCTcZZD"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea68fc1a7cso2957870b6e.0
        for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932592; x=1734537392; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntzQs5UWGWiGULe9v2nA8uKtcKIMDPBpsQl/iYNMNVc=;
        b=QDCTcZZDZtCjri8vl2EZyy4XRPYde2nyQdDlNaaYdA/O2J5UN5bDQHaGib9pc14yaK
         Rzk2LU3cvXkIMB07RuBeMEVJmxPxkFlZO6l8IXLbdBMeYDRS44Ph54OsKEqTq309h40Y
         rbfDilbVJxS3mVQ5XXL8Hm8HeVsLBqpokcWDB0qNLhasE4K5cZe/tbZchFLyRrOHb8Bb
         y1U8Lxrd6wkkV4kXQgYY23h7kznWtfmYzOA2c0lD3u6srXF/ltKC1jRQjBkeWxP3m2gC
         PdBv0SWbepf678pBy4vFHRSpuPGstsWV+lrRre7CJKlSoVHpEpQ1wZ/mehXh4xuRCf21
         laHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932592; x=1734537392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntzQs5UWGWiGULe9v2nA8uKtcKIMDPBpsQl/iYNMNVc=;
        b=SPCokQkClo6Nd/kTwqf26HXUQxmBRunxrtabKVYNcjzyEnQ2vzI5x241qR+flXnQHs
         Sd0DJBew0TUDM9IBfMDv3i9+z9SjsgXRaht6njML6onRcplUZAWRyR7OeQ87axg8qCmN
         8sIINJxBUvaCBF2v1EcvTr9XKnZXP4wlIoMriuPuhUQJ9aeBj/BgH8jZkFFJB4Owj4ug
         9i3pIIbSnPH/gvgiOIHbTeI/3bQncmpwNPHvmj8LwJDMHERisxSDgJXpSKM8suTPM2eJ
         aIx2N7QMp+oPaalPtiaMFL77lZcSsyQwIOMwgTyUT6+GCF1Q/GJizUKFDv522NzfrdHA
         xuSA==
X-Forwarded-Encrypted: i=1; AJvYcCWlULkwXuCGlMcPyob28jInedh7SPqpiOSOU4G0Y54WMFVIWdr9aabJmwwmMQroCyXENOyvHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL9VdUGxIY+UldtqZiuc0hwkm6/amw45TtW7n5n1/ZP2VAbe8f
	2IJEt3Ki9U7JngIygbukUJKbQcdDjq1e0Ke+4A3+oQIACqe+nq3H
X-Gm-Gg: ASbGncvqYbyVbnUD9G1+s4D0MwxEamTG1W3ly3t4EGrGY9FL9/0win+wd+cJm5+PAo5
	cs6vO26AdPMsTPCTpM2YJtvwoXbvTZP4WLEJPhdlLqtIvSPW9aNPVyFXWUBWiDgU0KLZRFGbKFN
	uvcSpvHuUZoihXNtCOz1cZ9Tcpyntx+1zRsL4n40jbWZ/AMAgPxXnh9zFmsI38iak66jIVrUYt4
	XiEEIqzy/gPQhilciV7gI/5JyKgMAGYjUbaIsfUqoFrstLZKaIcLJzIXdskLgp51OVYAsVkTQfq
	z/grAktWNyEzcf+UgMk=
X-Google-Smtp-Source: AGHT+IGxooJYgXbw4b7XHl1F0hPQKRnlfIfo35n2kBoImSyxRjpFc/69eF5HzHB9Od1052lbqKcwVQ==
X-Received: by 2002:a05:6808:3c4c:b0:3ea:5be6:a68a with SMTP id 5614622812f47-3eb85b505bamr2106183b6e.15.1733932592261;
        Wed, 11 Dec 2024 07:56:32 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3eb4b26c93asm1752406b6e.34.2024.12.11.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:56:31 -0800 (PST)
Message-ID: <c1a078e9-82dc-4908-a8d1-53954dd40b9d@gmail.com>
Date: Wed, 11 Dec 2024 09:56:30 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qmi: call-forwarding: fallback to basic forwarding
 info if no extended
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20241208113410.251171-1-ivo.g.dimitrov.75@gmail.com>
 <20241208123946.255405-1-ivo.g.dimitrov.75@gmail.com>
 <f7e7e80b-84e8-4873-8cf4-3e66ad4760bd@gmail.com>
 <713dbce1-cac3-4cfe-9848-af2582592e36@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <713dbce1-cac3-4cfe-9848-af2582592e36@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

 >
> void * arithmetic, UB last time I checked, unless you are absolutely sure 

Yes, it is UB in a strict sense.  However, on Linux, the only two compilers we 
care about (or likely will care about for a very long time) are pretty clear in 
void pointer arithmetic semantics.

If the Linux kernel does it and can rely on this behavior, so can we.

> compilers will do the right thing we'd better keep it like that. p is used all 
> over the place as const uint8_t *, I am not sure there is elegant way of 
> converting it to void * without casts.

Regards,
-Denis

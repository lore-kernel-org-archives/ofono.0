Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA731865E3
	for <ofono@lists.linux.dev>; Mon,  5 May 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462573; cv=none; b=GE1frGsFjVVPnFOipmwnVQr2nMmjznSHOtu84Z2eUcYUUC9asK2iqvphBLzkNyMA02wVEmUna9Rx70Ri/YZJFxykEZKOFbArGFPBFwa4EBN/7lxPJa/73eYapNPquGpJdlHHwxBe+cNygokJnGXt56+exseHpxJIWks1NUQQn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462573; c=relaxed/simple;
	bh=sttQM+cARnP5YdllxPPwC1LDgavkMu8DTZlBJztYLJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HdD5Ukl4nHn4zbq5lyB/p29ZPh7IEkn+89GKs0AX9q+bZxYl44GG4w+hkLn3ici7rhJPnA6Iv+5yPZDYvJZbL9kiZl/PhpfKOv1/zWrcURWo+e/j8uebESHe5T4V5p40gsERyKScKEz5qetclf7sNY9WANgMZxB8MrE54BJBYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvltUqw2; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvltUqw2"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c47631b4cso2737643a34.1
        for <ofono@lists.linux.dev>; Mon, 05 May 2025 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746462570; x=1747067370; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S8669w2+3IJe1ekK8osqhHaSP2zMLTH1IRgPj0wezc4=;
        b=HvltUqw2AN6cwfJE3/bC8HBB4MhSxf/eAjNZbK/YSIs1AFrtA4j1LeoxxtzOI41fvD
         wLYsMD92EbePdis7XXxe1S43qmP9o2OC9dnsSliwayk77abl0/PJr8QebvmsfDY7l3tB
         Vvvca/8pZ9SezrYsvjKnDujPAPbmz05YmPVfCEwahXKMn3Jkm/I8dsrTekrqBbOXaPHO
         d4hp457/C2Qy+RK1Qe/q22KDbuFib2SoB+ehZ7rqrrEwUC3kOaCQCrJqhECMp4AmIB5B
         k5TBSbQYJA+VMs8p3fUTtdu6EpzSXD43iV3Zcp0o/SW1TqCkVhcH2KZD7vOMy/gkXtsN
         eZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462570; x=1747067370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8669w2+3IJe1ekK8osqhHaSP2zMLTH1IRgPj0wezc4=;
        b=wcdnGKAgMyUuJdFsuREM9kpebDiR6eJND2vGtgCmXcYLT21g6hrxFvrrOSXz29F+Ju
         emnIs7moo4i16woAvb7F/gjVbCNMl+F1o6kNdeCV/sakN91ooJqMPsDnJ/Trjrwo9Hx6
         6bMYziKhLJAzxe3fNGXYkP9iL0NHlj/AngiowefxrbVgCh64JUO9XbQbUBiHOMpuU4l8
         njUUUeWpoJo1in9AL9vyYDNX+Ldjf99gbc6hMl57Y/wrlAolDW8Rk/e/okUAHbNxdZXM
         tsehUIVTk6aZvgNEJAnjLUDS8SlfEEOz3X7De+uEfnuyj2/QtZM4leXkvLIfxfgVRhxQ
         750g==
X-Forwarded-Encrypted: i=1; AJvYcCVnIhX4IclrxFluqalXMic+jN+nKGwD2LLtw5i3/uuJiuQYy9EsQpvWe/y8C+Xlu+dfuPvKlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHX82n5uMJWGg/0zdP5gdJ7xd9lInLOaIaP4c/Bvron4Bni94v
	qt+YvQ6ct89VzC+Lds6IpnstzgukfWqFVd9AUUuC+6a2j17tfYuz
X-Gm-Gg: ASbGnctsyZCb1ysiUFlnCyB50t5xpx/JI4Aa3od99tUSO7NFI0Barm2BSoEQqU/gR0s
	KbKd5JdoYjR2Wp6FxHmlKea8WN5pd6EOJN59vJCA8deMlnIt7IBHUCi5q2OAsbZ2gHzoUi6ld2L
	AzFVCn8P0zLaqiHcljNMB1H6TAXYelCJ+tLnzmmansiPM6Rs83Iry4ISZLQAISR/pPOLvwWqx3X
	QBcL9HNvKTIrobCbnuJFuyKED3yqIUnzKpftYX1dFnedZ2r0gn2N4/MO1Gv3UZ2zqtgZuFzrDfC
	yHmjovX64OK0rLbpKbJo27l1zz50iEaUl+8wQaioWBJLIveYXFaEftfXfJA1xX0PSIT793nW9Kh
	kilwvLw==
X-Google-Smtp-Source: AGHT+IHQWRxRk6R3lAW3TYrQyJbX0Tn55DtRi01M72yH0eudj6Nkuzwe0e0Ev/+rZKEpYpkjFIfygg==
X-Received: by 2002:a05:6830:d86:b0:72b:7d52:85b with SMTP id 46e09a7af769-731eadbccd0mr5838198a34.16.1746462570276;
        Mon, 05 May 2025 09:29:30 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1596363a34.51.2025.05.05.09.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 09:29:29 -0700 (PDT)
Message-ID: <61998d0f-822a-4f4f-9b7e-46b400721a8e@gmail.com>
Date: Mon, 5 May 2025 11:29:28 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mbimmodem: sim: add support for querying ICCID
 This implements the required functions to query file info and read file info
 from the modem. Currently the other file IDs haven't been implemented, but
 they will be tackled later.
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>,
 ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-7-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250504191931.7078-7-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 5/4/25 2:19 PM, Muhammad Asif wrote:
> ---
>   drivers/mbimmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 

<snip>

> +static void mbim_read_file_transparent(struct ofono_sim *sim,
> +					int fileid,	int start, int length,
> +					const unsigned char *path, unsigned int path_len,
> +					ofono_sim_read_cb_t cb, void *user_data)
> +{
> +	struct sim_data *sd = ofono_sim_get_data(sim);
> +	unsigned char iccid[10];
> +	int iccid_len, len = strlen(sd->imsi);
> +
> +	sim_encode_bcd_number(sd->iccid, iccid);
> +	iccid_len = len / 2;

Hmm, len is based on the IMSI, not iccid?  Also, the number will be truncated, 
not rounded up.  Do you mean something like:

sim_encode_bcd_number(sd->iccid, iccid);
iccid_len = (strlen(sd->iccid) + 1) / 2;

?

> +
> +	switch (fileid) {
> +		case SIM_EF_ICCID_FILEID:
> +			CALLBACK_WITH_SUCCESS(cb, iccid, iccid_len, user_data);
> +			break;
> +		default:
> +			CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
> +			break;
> +	}
> +}
> +
>   static enum ofono_sim_password_type mbim_pin_type_to_sim_password(
>   							uint32_t pin_type)
>   {

Regards,
-Denis

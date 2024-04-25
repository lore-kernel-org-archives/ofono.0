Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0944377
	for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077010; cv=none; b=H5oOLp2IcrL+5UNUe3gfaSx1N8omU/3mQ+XCGuNcmJcBaZsgM5vlocUi8sKWlciwwVO9Lzo6ic0KTcq07hYR6LJrXnmUkXbt/FGmnNF0rrhBksMFBz2iskryDilzk/2EcKHPj8XqdiFD3aVLXV96gSekvroDPCbzfvCeFlqi2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077010; c=relaxed/simple;
	bh=gM+vSBfnneKMGQriGzaebh6P0xix1d7IK9aiV+iG6EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1I3St6t9zjRS0u4Q5zPcH8EYqZTpH3GSz9Eb6Q05IFQ6TUbPEcT5xwVUQJks0EUgv/UH19ZmQ/gAN0HnGVb5gvHWTgfsdkC0WvaiPe1SfyQdWof8igEubEG1l9ytMoT3zI94YXkns1pjHO6CfrEQUhuJJEThc0cq79jdomPczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bis9DvB5; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bis9DvB5"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c75075ad30so960750b6e.3
        for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077008; x=1714681808; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmwdokmdPhUqZn4B8zPJ0SCWDlgacGOw1ZIls+pBMno=;
        b=bis9DvB5ICcj75kz89IX5VeXKwb8TgRMrCAiBdz1tpbFDyYRV+jzadZFf3cxgaKeO4
         ijflLiCZEqtZdcs2xxGSknLR4HrYmHb6E7S9LJWqQrBfSP9nFqDVtcUwO9rtfNxZibi2
         lgs95CFC80e9d5s3bcUTkM2bbf2fvjSOVjinIkOq9V38lJUbGKk8ceZTVICGTo16VEAX
         1wEf2hgX1Xd78heFalxGWfV4xMpEFgfJugMaL41/qWT7zVKcUuzWbeuhMMl/gcZRNrBI
         zb/nxzDyMQP123/zkPGim+4S5b1g6o+9fcDzlCe2GeBFs1k0m/BolJeHqMDvEzfdYGtp
         WS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077008; x=1714681808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmwdokmdPhUqZn4B8zPJ0SCWDlgacGOw1ZIls+pBMno=;
        b=WrvpJeYQApIE1GD6yBDH3oLGDDrDd0njCMT96UhxxwqEqIjd0y5t13CLbS4U3VBHSy
         K8EAzRGfsbBmyYJzBHl5pdxk6/oh/th/fEGODbUhsuiZv5fXURrpvlLgG/yM6eQVFskn
         P49/5Er1zmxiv8zPcYJIyttm2d/LHOfa3oZpU56iX9jVk5YcI1wpYpfEnXlQ/0RKfLkA
         1R4Iew/1eNtd0kOBtjiZArtnkz2I5LiwhFkngAk1ihg5+1eaCgD2+g3oOxBXlq4FMSup
         yONwXJE1Pi5JnoNMfF3dvHcs+RHPfENnXxXxubrHFCK+pzpKXjAYL8WNMx7TfZIzIFn0
         bqJA==
X-Forwarded-Encrypted: i=1; AJvYcCXn4FcFP/SD2EjlE125r52Kh33JBX2hEcmlGfymWKO43E1bRh1okNVfuM6fe2f0XdX8TEFICFz42PDV2skJAeNEcQHHZD8=
X-Gm-Message-State: AOJu0YwItq5dl73FRDgNRNksxNO+jOlXPKAagwE5SSy4TLQC33CvbBQF
	rDf1WPnCkZxhazoplZmESHWMQBdcexQv4YVLcMc5ctBIORFLm1n/WXrUPg==
X-Google-Smtp-Source: AGHT+IHDI3jBBAwhPSgUVr9471sxBBzLYvtYKSDEzo8nSZhroVdiQ+w5I83RaK6rYffHqZDH1h+iWg==
X-Received: by 2002:a05:6808:99b:b0:3c8:48e4:619 with SMTP id a27-20020a056808099b00b003c848e40619mr1020689oic.28.1714077008709;
        Thu, 25 Apr 2024 13:30:08 -0700 (PDT)
Received: from [192.168.1.15] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e15-20020aca230f000000b003c60d30f1afsm2287039oie.25.2024.04.25.13.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 13:30:08 -0700 (PDT)
Message-ID: <9a55c6dc-597f-4601-b9cc-3962c47dcca9@gmail.com>
Date: Thu, 25 Apr 2024 15:30:07 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
To: adam@piggz.co.uk, ofono@lists.linux.dev
References: <20240421194926.13149-1-adam@piggz.co.uk>
 <81f70af9-4659-495b-9928-14d4286ea80e@gmail.com>
 <26374076.1r3eYUQgxm@adam-laptop-hp> <2684478.lGaqSPkdTl@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2684478.lGaqSPkdTl@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/25/24 2:07 PM, adam@piggz.co.uk wrote:
> On Tuesday 23 April 2024 22:54:57 BST Adam Pigg wrote:
>> So, I decided to have  a re-think and try the burst dtmf method, which
>> accepts a string of chars, and should be simpler....
>>

Yeah, that's what I was wondering as well, whether this Burst DTMF command was 
an easier approach.

>> I created a packet struct for the parameter data:
>> struct qmi_dtmf_burst_info {
>> 	uint8_t call_id;
>> 	uint8_t length;
>> 	char digits[0];
>> } __attribute__((__packed__));
>>
>> and set it up as follows
>> 	struct qmi_dtmf_burst_info *di;
>> 	di = alloca(2 + strlen(dtmf));
>> 	di->call_id = 0xff;
>> 	di->length = strlen(dtmf);
>> 	l_strlcpy(di->digits, dtmf, strlen(dtmf));
>> 	param = qmi_param_new();
>> 	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, di->length + 2,
>> 			di))
>> 		goto error;
>> 	if (qmi_service_send(vd->voice, QMI_VOICE_BURST_DTMF, param,
>> 			send_dtmf_cb, cbd, l_free) > 0)
>> 		return;

Looks reasonable.

>> But,  in the callback, in a call to qmi_result_set_error, i get back error
>> 24, which is QMI_PROTOCOL_ERROR_NETWORK_UNSUPPORTED right?
>> > Some further research suggested burst dtmf is only supported on 3gpp2
> (cdma2000?) .. so maybe the original implementation is more suitable.
> 

Yeah, ERROR_NETWORK_UNSUPPORTED would seem to support this conclusion.  I think 
your v4 version was pretty close to being ready to be upstreamed.

Regards,
-Denis

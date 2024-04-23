Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A77E101
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884473; cv=none; b=Y3KmsP/SKhx4GQ4zJ8IK338llceMAE83Z/BRuhuRdOA9NVgGIq5yaBwquGAV3zXkFR5ouzjyGPbG8leMcHU8iD8aSViYVg9JvGqBRQ46naBlgM29gPpRWIF1vrSIF3/yVeh6nCz4hWUWCbzAH5FLymVGqDEtNpjOP1A3ZmZXZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884473; c=relaxed/simple;
	bh=+SToBHZTUJBGv9l1jsBDeOpDyhh4xapCQ5NhCBt0ELs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VVJr8VfRY1T4CUTzuHxo4CURUNvlgPv3WSFaRb0wWcLSuJvihLsCAAcfBqQ7vOHnVLOsnX5uWFM4gGR2KPyKmc5c71MF5jO2fXKBRpC2+xMnu1APZHIiAMRMif79tYBIVAC+sxlxdpDpupAfrjYhdxH9F05p5LCN165+38Pv0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XciiHiyR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XciiHiyR"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb6b9e1808so3114133a34.3
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884472; x=1714489272; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlRFUMXjiISxg7z2mCd7uAhRICWOoXEp9+RAKIXHtSQ=;
        b=XciiHiyRdlCDK7E9bBWRaNu2id4i32GCVGd+9yfuFK6YePvvXyPCd47l4NRIv8HlLX
         tXB7hhT0dN1D9hW2SrjBumfeW0l23ToON7Xci9SimeHfK6ZLAp53nipG7lUbbsOI3ofj
         Fy+zgFlM1WlMs1iv6urGRXVNrVFdOSW1TfZcBvFU0mat3LrsPlE4RLjJqMezdyO9SW3r
         FET42Cd/7xdpxv5ZSry1x4iMzgP86qOuSp2ocwslfODGmav5WcLaoWWYROwIAAFKeg7m
         I7Za031Z5WM4mJ8UIP/a34jGLn9k3F5OlvZ1grvON8Nmk6lsGpH+5V/Uickj7JUhLv7D
         QotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884472; x=1714489272;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlRFUMXjiISxg7z2mCd7uAhRICWOoXEp9+RAKIXHtSQ=;
        b=sp825UUcYnGRNrhn0kPLQLCAhdrGxl4BsMCuVrRkABwFwaBHsALoEfLnYxj5olw1+5
         4ep5ay6TxtNr1ERmvdI473XTe49rRT0MkT7EFwdYIJtQyfqL9hN8PE03rqpCOR7xNZqI
         eoLw0VUyqjC12neus3Umls53b3XdB0TkRVTimPGfQu9z/vaRu5H5RU7Bm1rjEbxzOccL
         uGUQli3Vv/xVPnCRpOrjQHm2qJLnqC7Eg/OF47JqgILv/l2bNus5HsPh/NjkOMK0WQVR
         SbxZmLZZtdKym2E6nAjFqio+WufyyMVEatM9Z8QWtmtNJPAv/4HV+QTe09tqFDR5C1Nz
         hMnA==
X-Forwarded-Encrypted: i=1; AJvYcCUYeVEc2Q5VcfcGobHim++NBlvLQ8FYb1HmL73WxKbp785+hWxMshE5lyaLCAzt54NZvVxhJSYNCZRxKsvvxU3+Zw9i8Wg=
X-Gm-Message-State: AOJu0YwTjiTsTsNnvZ54HcZZqEhU7eyNJBmyx89dGiXCna4vVlbY+UmD
	N8g0cGcLylo+4UEgz1j9MQ0RhZ8oBs+XsV/SbuoWga9DcX9eRVoO
X-Google-Smtp-Source: AGHT+IEibUueKnJtl4MiIPW2EMMTYUVrLCzec6BVEpGswxpz2KOHpRi6C5atsnomKsmYghYZt1kC2A==
X-Received: by 2002:a9d:4f1a:0:b0:6eb:e1ba:6646 with SMTP id d26-20020a9d4f1a000000b006ebe1ba6646mr9220376otl.16.1713884471725;
        Tue, 23 Apr 2024 08:01:11 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q22-20020a9d6316000000b006ea25570de4sm2075529otk.56.2024.04.23.08.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:01:11 -0700 (PDT)
Message-ID: <81f70af9-4659-495b-9928-14d4286ea80e@gmail.com>
Date: Tue, 23 Apr 2024 10:01:10 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Content-Language: en-US
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <20240421194926.13149-1-adam@piggz.co.uk>
 <20240421194926.13149-4-adam@piggz.co.uk>
 <159a23ff-bd7d-44bc-b723-6dbb08aef6d9@gmail.com>
 <1934099.7Z3S40VBb9@adam-laptop-hp>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1934099.7Z3S40VBb9@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/23/24 05:10, Adam Pigg wrote:
> Hi Dennis
> 
> Thanks for the thorough review and merging the others....
> 

And thanks for doing all the hard work :)

<snip>

>>> +
>>> +	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
>>
>> This calls back into oFono core unconditionally.  Doesn't this imply that
>> you're handling only a single DTMF character?
>>
> Currently, ive only been able to test using single character invocations,
> using the num-pad on the phone app.  Do you have any suggestions on how to
> trigger multiple characters?

Take a look at doc/voicecallmanager-api.txt.  The SendTones() method takes a 
string of tones, so there can be multiple tones per request.  If your phone 
dialer UI does not support sending multiple tones, then the easiest way is to 
use a command line utility like 'dbus-send' (from dbus-1) or 'busctl' (from 
systemd), or a graphical one like d-feet or qdbus.

Something like:

dbus-send --print-reply --system --dest=org.ofono /phonesim 
org.ofono.VoicecallManager.SendTones string:"1234"

Replace /phonesim with the path of your modem device.

<snip>

>>
>> This function doesn't seem to be invoked?
> This function is passed into send_one_dtmf but yes, potentially goes unused,
> unless it gets invoked in the macro call?  Ill double-check the original
> implementation to see if i messed anything up, but open to suggestions :)

  I think your v4 implementation handled multiple characters correctly, just 
FYI.  Just the memory free paths were not completely correct.

Regards,
-Denis

Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BE1DFD0
	for <ofono@lists.linux.dev>; Tue, 31 Oct 2023 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnNJyJFf"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-581edcde26cso3534387eaf.1
        for <ofono@lists.linux.dev>; Tue, 31 Oct 2023 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766968; x=1699371768; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddNDgrA7zsG9CNcufyQpobk+eyH/wuPX2BI8gtxyxqc=;
        b=HnNJyJFf1tCjCz9otfSFnlffb07Gkhvb/QM7OcVzW7avwTNhGbFlrWOdk/XvRgDrQI
         xKVufCrHP1pjYuQ2ZkLsX/PEGbGSVVlboSBcqT0c2vMI4dtTtOLeLwSkXt1ykItR4sd2
         ZxoCw3iUF+0oxSfgrATS7xAUmlheAjCzR0J+/JjLbc8Xuj7pcZqtvJtLUyQnFxfOw+9l
         xHdAkduG0Ao9Gwzr2jc4DIUHUbR1/aQ1d6bHeXn+82pZdKkrX9sXMwTS+NAJ8pvUkXI9
         yhLXjpjsrkGQ5MyhToRWQfrCiJZAfeblBOyzpO9py71YPVSrmhf+peXMjJTCeUceGttY
         910Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766968; x=1699371768;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddNDgrA7zsG9CNcufyQpobk+eyH/wuPX2BI8gtxyxqc=;
        b=cTpNNTGIfUoEPaw/OENluoJWjUGXvlMR88iJkJk8qze3a8rQR5tlmecITUQILVu8I6
         Vde+67ZBJZfPPEMjCndAd8OeVJgBptje83+nnSQ5Q5JO/vWypFyzvMBk/tz1gASf5fC+
         ocrGPglw3SQs2XFjRfGyeiT/9/3wcsQ8MNTFTqCbguQnb2CYhP+vKWQV+a6gV7jFQnyh
         P7pxx0nuN9Er//fxeba6ZMWPUXT/mImBP9rrfV/YmYEifTzyVWI0V8s2qz73CjDOjwcS
         oULNyPPmM3DGF2hWA2tUNVRINbPWnM9GsdfN0VCX49i7VzpbaGKt/JSk0xR3ktywXbmU
         ql/g==
X-Gm-Message-State: AOJu0Yx47Et2fU6ZLIisTFe1ru3l2xyiN3nA/Us/cWidELj/G6su9ga8
	CvzloyAX2/8hR/TwYflcp3mpmO92N0U=
X-Google-Smtp-Source: AGHT+IGcaEFK4sSX7M2g4pV0A//+m6t2bZLgHYWDGFjU6gNjy6L1oeo4YCGigTkF5gLvToLcrSDZ4A==
X-Received: by 2002:a05:6871:7503:b0:1e9:dfcd:6752 with SMTP id ny3-20020a056871750300b001e9dfcd6752mr15932891oac.20.1698766967801;
        Tue, 31 Oct 2023 08:42:47 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eb52-20020a056870a8b400b001dd5857e243sm314329oab.14.2023.10.31.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 08:42:47 -0700 (PDT)
Message-ID: <d68602a8-c3ca-48db-96a5-fc72fc0ce403@gmail.com>
Date: Tue, 31 Oct 2023 10:42:46 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modem: Add Reboot and SwitchOff methods
Content-Language: en-US
To: Lyubimov Maxim <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <043f75988608c0ca35b862dea5c92c1e0c6f8f51.camel@aqsi.ru>
 <272f2080-8c0a-4016-b6a5-1e95cf3811cc@gmail.com>
 <2e5311edd0a8f307352b925466f0778041b7a707.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2e5311edd0a8f307352b925466f0778041b7a707.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

>> Note that Shutdown should already be covered by Modem.Powered =
>> False.  Drivers
>> are free to implement this in a way they best see fit.  See for
>> example the
>> really old calypso.c driver for the Neo Freerunner.  It writes to the
>> GPIO port
>> to physically shut down the modem.
> 
> There are several problems. On different devices, the on or off signal
> can be implemented differently, so it is difficult to take this into
> account in the driver. Some devices may not have hardware turn-on
> signals at all, therefore, after turning off the AT modem with a

Yes, I'm aware.  Which is why some drivers leave the modem in a 'low power' 
state.  It isn't ideal, but life almost never is.

> command, it will be impossible to turn it on. I think that using the
> Modem.Powered property the modem should be both turned on and off. If
> the driver cannot turn on the modem after turning it off, then it
> should, for example, not turn it off, but put it into a mode with
> minimal functionality, from which it can then be released after issuing

Right.

> a turn-on command. And using the SwitchOff method, you can simply turn
> off the modem without the ability to turn it on when it is definitely
> no longer needed, for example, before turning off the device.

Okay, I think I understand the use case now.  My opinion is that this gets 
really into the low level platform details.  For example, are you sure you 
wouldn't want to shut down oFono before sending the magic command to make the 
modem disappear?  Why have oFono running at that point?

Another question would be the modem detection method.  Right now serial modems 
are essentially static.  They're detected at oFono startup and that's pretty 
much it.  If you send this shutdown command to the modem and the modem shuts 
down, the Modem object still exists, but becomes completely non-functional.  You 
could forcefully remove it from oFono via ofono_modem_remove, but what if oFono 
is restarted?  The serial device would be re-discovered.

And then there are some nasty details to consider as well.  For example, when 
.disable() is called, the driver is assumed to relinquish control over any 
devices associated with the modem.  If you maintain these devices in the open 
state for Shutdown / Reset purposes it might break some applications which 
assume the device can now be accessed.  This might be a problem for devices 
where explicit control over the device is required (QMI, non-multiplexed modems, 
etc).  But this may not be that much of a worry for the use case you have in mind...

I'm not sure oFono is the right place for something like this, but I don't feel 
strongly either way.  If you think you can make this work and can come up with 
some sort of proposal, please go ahead.

Regards,
-Denis

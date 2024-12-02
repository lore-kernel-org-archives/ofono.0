Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CD1DBB03
	for <ofono@lists.linux.dev>; Mon,  2 Dec 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162122; cv=none; b=QZ744NXiMraF08KdPHhAPadEGHQ5vgRRLEexgOI8TjmJoH3lScSRS/zxZ3WnojWQgD6ITNTe6Wm87aYOgmpESKIRLXWtHFKRZMdNu+UQb2zkxJ5xcFRTbfTYBuWVRs1iFUCwweJ5iOVJK3Thlu06FiK2nmviCrQ3ZXcfCmVsaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162122; c=relaxed/simple;
	bh=gWXhxG0Vwo0OxjCenXVzmeoqP6bBJ6//2Gs4eRA5A7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sixEJR6FLwl3z1fLwA5jSi2/jN5saHSsh8BFqwmOpKMJ5/tUOvWV+Y0zq8v+5sbh5NBpkp+09xnmGR3RnMD4Qlz3CgwsCWVfd4d7pLho/qIbP5WBaBNyaYMrOi/6DxWW4HvI0OuIx/x92MrSfEDlEv8lHjEzPZwq6maHffiiGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWDCEOKy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWDCEOKy"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e644b3f6fso639468fac.2
        for <ofono@lists.linux.dev>; Mon, 02 Dec 2024 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733162120; x=1733766920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQdccAkRoCzKxKEku+JCDTRuvAwwgZvhn+3NOYT9pTU=;
        b=gWDCEOKyoCvvWFJcow9faya1qf7ix9MWUOA42yVPWnmJggh2dlgRdHIF3gN6SxuwZW
         yewoqKsh8jXQD9HB0OgkzVTmystZT0pYQAo8/2MqE7Re44fOgdwwiN4607qn1TK8uadb
         GUyp4cCbjW8iQyx5rQSwzEdQwc/ccM71qcaCAm5tH91fBUVYR0oxz7Ra530FI4mKHE0Q
         bmEJZTNd9P6Em9Sis24nJ07SpSPSHEt+HA6qJVlkVFQ+hI5WlYytOKccHbuhtEwIRvNq
         ujIxVvVurqOX54/kE22kRXB+Q3Hz5eKYggwy1hNuHqECqczYqB3uors3Jpy7DBnAZ5I0
         13/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733162120; x=1733766920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQdccAkRoCzKxKEku+JCDTRuvAwwgZvhn+3NOYT9pTU=;
        b=lf+1/ZdE2VjuqoF43kVDfmjH94AVTN2zvnYZdIxvzZTAC8T+/90vD82q4euoPqgnau
         1C9EyKMj+M+pL2cIjiDkZEZajwOFlCuR0+Koxq7ELBykBXGr07dhfP4XDJs/+BuqktOY
         hbPPPqEQIVcNfJ1LA8VqbJM6meXhDRHiGgde0muO2POJ9itnNtVuLJ3+fwMyppDVYuh2
         9dDYGyIKZCZ0O8T/ba5dEccPe8kv/j44E+PhBGFYXGx2gSVraAOCtHwVgJXuNBk/V/Jd
         rMD4SyLJjyAU0W3WS20Ybe4BDGZQGkuKcRkI1R3z6VKMcKzOBGP/NewADXZkkJgbGN+w
         WLyA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ETJvZLnqY+mZv4VXtR/h8pLZtBbZI0P8qQf961LKWrdyMlNUlsO9hdIeNy7X/X59D5FsDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN5LwtS2W7Tljfl3e62ed9vDPO2WsaKpBLv+Qu+URWWrCgb3PI
	gh7jkTGUWl18CA4GJYDxc6k3xDprsH5q1RXp56V3zEw6vwenxqeO
X-Gm-Gg: ASbGncvWOPD1OAPdFgFR0G71VgJHqdTKJqBH8+hq8+l1E/95cuvH5r0/dZt4X9KpGN4
	0xLt2EqKZC4EIplhHGMBA0/0vbsUlAxLExU/Z6QNHSa365bxzLIbQSvC3eWYIHGjQR+H9xN6ZGo
	8QqMIw0Cb2CBG/XbqEvBLIPukKauCru+tBIB0nBMpVZCk6lBxpQ8NNoBMBLlQIuFkULEm94GHxs
	7FMY77rn96GFMspSP5jiIthQNeIhr8W7ghuIwp+/bbZAt5Xh9erPkm49fEzdlSuakxW7/6pl+S7
	4LO0ElWar3qG0qc=
X-Google-Smtp-Source: AGHT+IGtjI0GnVH67TajCgSrlTixgZv0ruG9+pSHZNBnWVxdaD8Y9kElnr4sgmmyMpfuhj9S8wecwQ==
X-Received: by 2002:a05:6870:fbab:b0:29e:532d:8f3d with SMTP id 586e51a60fabf-29e532defe2mr6410685fac.10.1733162120212;
        Mon, 02 Dec 2024 09:55:20 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71d7254adadsm2424790a34.29.2024.12.02.09.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:55:19 -0800 (PST)
Message-ID: <d9fdd0f1-3231-4f0e-9775-270ca31d71ce@gmail.com>
Date: Mon, 2 Dec 2024 11:55:18 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pinephone Issue in 2.13
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <2830691.vuYhMxLoTh@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2830691.vuYhMxLoTh@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 11/28/24 11:41 AM, Adam Pigg wrote:
> Hi Dennis
> 
> Myself and some users have an issue since upgrading from 2.12 to 2.13.
> 

2.13 added multiple simultaneous data bearer support, but they should have been 
backwards compatible with those devices that don't support them.  Guess I broke 
something :)  Sorry about that.

> The logs on my own PP and PPP, and from another users PPP show the following
> code path, with the device being shut down:
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:discover_cb()
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:create_wda_cb()
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
> Trying next data format
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
> Trying next data format
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:set_data_format_cb()
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:shutdown_device()
> 0x2088ba20
> Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:shutdown_cb()

What oFono tries to do is to cycle through three currently supported data formats:

- RAW_IP + QMAPv5 -> this enables multiple simultaneous bearer support.  There's 
also in theory RAW_IP + QMAPv4, but I don't have any devices that only support 
this format.
- RAW_IP -> Single context, no 802.3 framing overhead
- 802.3 -> Supported by really old Qualcomm devices.

Looks like the firmware is rejecting every single format we try to set it into. 
Do you know what format PinePhone uses?  Do you have libqmi / qmicli installed 
on the PinePhone to run some commands?  Something like:

qmicli --device=/dev/cdc-wdm0 
--wda-get-data-format=ep-type=hsusb,ep-iface-number=<InterfaceNumber>

where InterfaceNumber is what is being passed to gobi plugin from udevng inside 
the "InterfaceNumber" modem property.

For oFono 2.12, what do the contents of
/sys/class/net/<netif>/qmi/raw_ip
and
/sys/class/net/<netif>/qmi/pass_through

look like?  <netif> in this case is the QMI wwan network device, something like 
wwan0.

Regards,
-Denis

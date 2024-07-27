Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C561822F8
	for <ofono@lists.linux.dev>; Sat, 27 Jul 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095892; cv=none; b=I2AShvV0tob6a4yk1VSJWdigcTViCapjP/TH9qBMglZCKgkt9QNuQ7iOM7KpLEtdnCc9vHfN6rzMnfD5Fr8XbPIkN1vQrUUJGJAeMNGtIErNCgI2Om7sP0gEYz7xnQot0CQg/irsi++sE4WNh1ikB0M/Bs9cH95zhtr8S4k4oU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095892; c=relaxed/simple;
	bh=bbxFYOt466CQH6hkxjlMSs5uHidQurMf8wDYoi7RAaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UOVazcDcwS9w5KpWQ44P2qjgoRYW4lbv6FrdajAcqZ1gEFBCtGtPgQgMMcvpNVfZAuDPv0zPHsiVqdU10Lao0Xmi7gplVtGrl9LfkhLJ7SMuUNQd5w3m5uPkxzTKqdHZtAVzVX1PedBUHvQmZeB2oXAC7EJHfEGKnWa/9Chsd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGGYMheU; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGGYMheU"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5bd1b79cfso1179812eaf.2
        for <ofono@lists.linux.dev>; Sat, 27 Jul 2024 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722095890; x=1722700690; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPMv5g9moiDHAqPX6EodsMdsoDjEOX9q1srn3MwF7/s=;
        b=kGGYMheUqedYnN457lfTOTfEJ9oSe7jBXfycXt3z8hSryoPRjuuOi8ssiU/544ykzw
         +OySzmFV8lcsq7pdmZaTCGcbwnYrjsXAFABWpO627WGkJJ3eWNe3viQSPZWKPxHa07G5
         534kY2WZutX89x3aQxRPqPU5TYZkUOYfxtsObMR/Z/VZH7mGKPKDeFLtU3MTLoQWlTsI
         46oZm6XC7WxVvSzU3qmZpt0zKhBTAafPIp1/me2Ck8G3TqDk0N681a8B98WKC5mYxxHP
         YRPuFcCjsGS2znKjstJOF3N6HtDRvAL7Ek6rUBaJLzjeRoaF3s3BxVurU9ajkjob/tem
         5jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722095890; x=1722700690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPMv5g9moiDHAqPX6EodsMdsoDjEOX9q1srn3MwF7/s=;
        b=hXStA2Hl/RNnafP+ZbGbQ5EriDAtv5inYMcloX0idM9yXFeV1bf8L3ogtRl9+QVutB
         VKrXB1DcPoQb++Q02iGU0puXOtEKWqK3+WJbPlDwP4y9GZza58nGsx8davXYKs2JD0QC
         rOvo5mmtXLmXMeNDs0tu5w0jRePtCAuDh5iW3Yp+9e+cOX6QGgmvOddls/13ZNPxanrx
         XKIwKJUB269hwHofASgKfny9KH3x4LHUbpz3VSFZzbzNH2XucW5rpFK+xIlOMPCxMwbF
         V2b9dIrhW9CPuxDgt8Xn8gsUBbIyzeEePsfzh51pKA7GhW8slOZfWJhVVQhATZ8r1grf
         WYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAeIECCcfRY5aCIYF2zSjOvsWjBJndV7QYRN3R3BZ0hAdUnZMlmY3HSURoLp1YMSpAiFQblkozGogo/UvDxkJMwx/Jm04=
X-Gm-Message-State: AOJu0Yw73ZjG/XZlej2/b8SrpgNCzbNNNXsyQgp8JQr6cbi1NqcNOBCC
	hETv5YBTu1N5MG19k9r8NbWt4u0UXLWEagSKvxecvCZDyaoFq/I8
X-Google-Smtp-Source: AGHT+IGqcPpmotfi0FQ8t55/DBukpQmBOvr0whXfrkCDopn0wCmVeqLxEpnKlDqgM/35N7THy8SCVw==
X-Received: by 2002:a05:6820:2290:b0:5c4:144b:1ff9 with SMTP id 006d021491bc7-5d5d0ec253dmr3170037eaf.5.1722095890527;
        Sat, 27 Jul 2024 08:58:10 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5d5b35dc2eesm677697eaf.25.2024.07.27.08.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:58:10 -0700 (PDT)
Message-ID: <1f7fc554-43a1-49f3-aa3e-f2b51bafeb5a@gmail.com>
Date: Sat, 27 Jul 2024 10:58:09 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Idle Loop
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <4939268.OV4Wx5bFTl@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4939268.OV4Wx5bFTl@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 7/26/24 12:03 PM, Adam Pigg wrote:
> Hi Dennis
> 
> Wondered if I could pick your brain about a new issue I have.
> 
> In the patches I apply ontop of stock Ofono for Sailfish, there is a plugin
> called the Slot Manager.
> 
> On 2.7 all is fine.
> 
> On 2.9 not so.
> 
> The code in the slot manager, after its creation waits for 5 iterations of the
> event loop before disallowing any more drivers to register, and it seems that
> in 2.9, this is much more likely to happen, though its a bit inconsistent.

Why would it be doing that?

> 
> I wondered if it could be related to https://git.kernel.org/pub/scm/network/
> ofono/ofono.git/commit/?id=063856a2ba9308e1776a3f906bd2ed9a9f760744 and what a
> correct solution might look like (I understand this is my issue as the code
> isnt upstream!)

This commit makes drivers register on probe such that no main loop iterations 
are needed between probe() and register().

I assume we are talking about atom drivers here (everything in drivers/*).  Atom 
drivers when probed (probe() is invoked) start their initialization process. 
This process can take as much time as these drivers need.  Putting a cap of the 
number of iterations doesn't make any sense.

> 
> Potentially the check for 5 iterations of the loop isnt even necessary (and
> seems very arbitrary!) so Ill test without it.
> 
> Is there a reason that the gobi plugin/qmimodem driver combination now takes
> an indeterminate amount of event loop time to appear?

See above.  gobi / qmimodem now perform more steps after probe() and before 
register().

> 
> Any thoughts welcome,
> Kind Regards
> 
> Adam
> 
> 

Regards,
-Denis

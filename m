Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A19BE5D
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311429; cv=none; b=iH/9w4B1WGNATIArokF8/Pbc/UVfU/yBT7CddAg0n3u6KJ+dx21tuLV68x9RDC9JStBFf42JZpxlfgb+g/huWbuIU5ZCYxx3Pnw835/WBm+ZVOcOBBTOxpaZXBfMAY1SLOj0Z2tHixLwCRfwopsqkQMtJP1YBRiHIstHscK1O0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311429; c=relaxed/simple;
	bh=uG3aZN+o7xd920BrsM6gtf1bFUNn/CwU4RVoY5yUmyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iBdFzC0Yi7YFJa/eVh2o3SBpRI2vg9wVtRHlPCxtIuZC0veWHCYX6bmq7qcSIJq1KL5hoW7czlbAzEoJ55HM1pU2Bu3o3v/Eejewd6ZKxrjUX0IwYouAnX48HrZC7ERCEe8tGJOBzE9zTzvrryNArq9JQ+P6QOtbKK9BWv0K/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkpYUfkv; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkpYUfkv"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093705c708so4197719a34.1
        for <ofono@lists.linux.dev>; Mon, 29 Jul 2024 20:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722311427; x=1722916227; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buMlYig8Y60VNtm+DUlgnWA9ZFf8hWnpc9PTVaZuU38=;
        b=CkpYUfkvfDwGuC//hVjFc9bV18MIsKCvxSHutC+1h7NiGM1G+Y6U/f1G3wJOop4WbW
         wxpnDpLqjw+4I3a2/+ffTH46xHB0OBKivzlUrMyWbPtw+GMPaVSAA3XJwUBzupJ07ukY
         POXhGsCg/UNew4zgsEtfgzCIvlcmZpoZLyeHUmw66rNA0sRmQh5+jbGDVjnHZAL1LvKp
         mRanh1TO/LWi/YIDM6b3kJOMAj9Z+ZD06vAfch7TZ/ItACUzQPqFV4SMDRVX/H1sbVU6
         aogGcAz6CXpbKNCZ3+IQKrd1AztZPnAmKvDRafL7uAT9EglLgZe3RSBVJFBmK3EAfi3k
         BQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722311427; x=1722916227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buMlYig8Y60VNtm+DUlgnWA9ZFf8hWnpc9PTVaZuU38=;
        b=iRfuRYI28cgZej0H+jUns8ZTOThfRjTgNyucCVQRJQtA7dz53mf2Ty9zi3iTKisv12
         xkJOs/AJN23utLvDPpUWrM4tp0GaHmtxWscbBoNy6266O4Osf+RFsZ9uJOFCpwYPkyx+
         nKrIwjO6Ziev+9Y55e7vRf8qK8pXrSXGISe/tT4u7KTPTWrrLiuDVG0dTwl3qvMs5Jhr
         tobYcn+cIxC/GmBj0f2mTInrTm9DsiWQZ5qx1soTqjINU5rtnujDWmKg3NK1X0fKo5pq
         ycJS5cJJqNxkrhs/axdEWZC03j6nZ6JY7YkLetepheF97rNL5LeZgd376awQANQRGh5h
         WA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFNCi7iHgBggAoCeOLxWh4Fh9nUIe5k3qSXM+r8HjKH2kLhmDFZ85AxKiFandBwOsCGVLaBtUpaYiMi/szRX/DgRdjI5Y=
X-Gm-Message-State: AOJu0YzxyDq4pD/oTeewZ9kgkQpHbD8EmgZAte8SXfsXPXQCn9/IRVaD
	m4FTXLNELdCnNrXliNHI9pcDVkT3PzogcPwYFzvvFIcLFneBtK4j
X-Google-Smtp-Source: AGHT+IGv8F5UR+ETiq2PZAo2Hh3OPpn7uxOZP63c4YdDPDBS1cOH9BEbtk674w30u/oTBIW0tOX35g==
X-Received: by 2002:a05:6830:18ed:b0:703:7051:4018 with SMTP id 46e09a7af769-70940c70bbamr10394733a34.28.1722311427129;
        Mon, 29 Jul 2024 20:50:27 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7095ad81928sm232535a34.33.2024.07.29.20.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 20:50:26 -0700 (PDT)
Message-ID: <b817df74-5f2a-4a53-bfb0-116e5bb5c1a6@gmail.com>
Date: Mon, 29 Jul 2024 22:50:25 -0500
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
 <1f7fc554-43a1-49f3-aa3e-f2b51bafeb5a@gmail.com>
 <2131096.YKUYFuaPT4@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2131096.YKUYFuaPT4@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

> However, ive now hit a different 2.9 issue.
> 
> On boot, ofono is started via the system service.  Looking at the log output,
> at the disocver_cb stage, instead of creating all the services, it instead
> goes to the shutdown stage.  If I restart ofono after this is works fine.  Ive
> attached the failing log to the end of this email.

Hmm, I might have caused a regression.  Can you test the patch I just sent to 
you and the list?

Regards,
-Denis

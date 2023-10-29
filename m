Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22210957
	for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rigrrg8q"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso1946885fac.0
        for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698614450; x=1699219250; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TW5x0wLdf6mGA4kiOeWTia7DWm7yMvYnpnZiIb1dwcI=;
        b=Rigrrg8qajZ5ygebZMnzQZGwVEuzdjPRrbn+nK/4j9jUNjvPZAvNIgMoT83bgYER1q
         J1wnr7xRifAb7kDtsrYNG4ml+NcxfA70Q0g+fiCJ17PWbTvOvgs6KJ2APmPZqdfwKGpF
         3aMik9ROoW6u3bRikGXOPJZL8tp+AFPhueGL+HJDkbC3y80K43gI99+Q9sxuDCOxnXec
         9vKmRTcU8hT4ovvd0cN305pUvbJrRkhIrbjiGBDnldI7mdbmYStft5Sd5rCZlbRKGoBq
         Kh5Vwm0QFZpZIDHm4u8+P+LSs3YdGW1VlKhyqFVzUy2sAmnHgFrEwIQGWZpdN+/eFNB9
         GclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698614450; x=1699219250;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW5x0wLdf6mGA4kiOeWTia7DWm7yMvYnpnZiIb1dwcI=;
        b=GNh37DJnlh2Y6iCNMhuodU5t4bjylaR/NTxYX0ZPA+TAAVJE3ix2BlBesDQkpBk74C
         ut5hctjboW2semNzn5IFdzJXa4E8+oIC5ROzcehdxTib4iEzBaiiCo3HHRlF+ujM524l
         eZ4MzsDb6W6QVAeb4Tf0aRFOSMZo3FSfXiJMbo3uYDVIGm06EPmTGw2/IsEizFBualbO
         JbGvamSugLA0uc04VJqVMubtUDFtHceyXbPpOPAqJKOqlUaldilWe9YsJ6Se47T8voym
         AJXeJvHcldeKc0PFbnMxhEDbIujLI68591yF+79xIdyW+PRVR2VVNlDJ/iHFROFQXlrr
         nVBw==
X-Gm-Message-State: AOJu0YynWCPJx+B0kHvnIlD4aO+KI3qh0jHJRDe+wQg5ZZznzy0xM28U
	iHUHUIewXWH6/FqBWMtOILs=
X-Google-Smtp-Source: AGHT+IE9NYLVXVPbZ4ArUYdZ4pCSEUXzukBDoiJk5M079qWqc7Gvl4+J2DGkSVEkIR5NrXjJW7RZtg==
X-Received: by 2002:a05:6870:9895:b0:1e1:8aa8:4561 with SMTP id eg21-20020a056870989500b001e18aa84561mr6849693oab.16.1698614449830;
        Sun, 29 Oct 2023 14:20:49 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056870954200b001eae28db525sm1325727oal.23.2023.10.29.14.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 14:20:49 -0700 (PDT)
Message-ID: <bd4b1289-231f-45c1-9550-53c8f2e68b96@gmail.com>
Date: Sun, 29 Oct 2023 16:20:48 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: isimodem/n900: CLIP and list-operators not working under Alpine
 Linux
Content-Language: en-US
To: Sicelo <absicsz@gmail.com>, ofono@lists.linux.dev
References: <ZS0fnIsQP9t8V-kY@tp440p.steeds.sam>
 <ZTypfrSeWHBxtRnM@tp440p.steeds.sam>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZTypfrSeWHBxtRnM@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sicelo,

>>
>> The major difference between Maemo Leste and PostmarketOS is that the
>> former is a glibc distro, while the latter uses musl. I am mentioning
>> this in case it is useful, otherwise I have not yet found anything
>> specific between the two libraries that could cause the observed
>> differences.

Yes, most likely musl doesn't provide iconv functionality.  See man 3 iconv.

> 
> The patch below fixes both issues (tested against ofono 1.34).
> Should I submit it as a real patch, or there is a possibility that it
> would negatively affect other systems?

Please submit against upstream and use git-send-email.

> 
> The documentation for `g_convert` states "Using extensions such as
> “//TRANSLIT” may not work (or may not work well) on many platforms.
> Consider using g_str_to_ascii() instead."

Please use l_utf8_from_ucs2be instead.

Regards,
-Denis

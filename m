Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17345182C5
	for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwZByPtT"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso3077413fac.3
        for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676242; x=1699281042; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOEzHYPU7twSCWC+YG4VQ4wNXe+lVCp0hKAUjCiTPGA=;
        b=HwZByPtTZdN5BZlcmRDHrwUXqFYj+jPwFXzh2VYd1mgOhfkc6tG1e6TG1o00iOFqOP
         /1gbLittH3kVNrhjclsHlZPaGLOjUblWsERhS+Y4ai1o+BNmPDKVkSPVHMIBbNqeNMCo
         qyL0huFmB/sdyP2QSdFRmmwuqYbLYLJBAKli0EYeEhfDkIGBxX5ykq6Vs4F/3f3p6vWE
         wXaWtlSdVTnUaNE2+UUsB/3LXt7gwNhcf12S5TxZsfbK08xs3at4nfoCaahVzTj+OSHa
         5WP9s2hvlBtCETadVKz9L9s/i1UKQw0WUUdXaI/1caelLY09cH6YlvH2YQxswlvs0DAJ
         UdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676242; x=1699281042;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOEzHYPU7twSCWC+YG4VQ4wNXe+lVCp0hKAUjCiTPGA=;
        b=o5P3yTx0nEOgBMox4kwQL/y/Aq36smbw2adKDgthq5N4N4HU87hv2sQ9jI0L+CZKXB
         gICrjzHS2AIMX7Q8jzweMMY+PoxhYQTekfS5rdV0Fyd/q1S70v3jy+BvXbIbV9Xk3mq4
         W7aawN5Irzh8JXCWDFcElBGPfBUIo4muI4H1/tPPdtOEq7d4xIiHG6LXpq9fJfMPu77d
         U+1Epgzi54A2Eo9LMmXUqacUO3B5Mgjxe6aKDKkyOcMoPPWczb2Fts1Q3QOmirEoBfD8
         Wu3PY4J1E3RQnJ1feVX/EvPu4FEAmVKc9kEEBzhM9pVyBeWLzG9dvBWsclLO7BlzUHWg
         qtdg==
X-Gm-Message-State: AOJu0Yw5vNmzBKnxgLKx9Xuev6Fy+4NO+YPC7B2+IJuCrE+AeWypFBdd
	oZEUIziPU+cbw+IOVO8UT/4=
X-Google-Smtp-Source: AGHT+IECpo2N3zo2a24yRVLRITc9cFUjSPDKlHBxFnmpVcaoTYVJGpx2d9qa0rLR2ulix8qV1mcD5g==
X-Received: by 2002:a05:6870:6193:b0:1ea:3746:b7d6 with SMTP id a19-20020a056870619300b001ea3746b7d6mr11496855oah.28.1698676242229;
        Mon, 30 Oct 2023 07:30:42 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id jq1-20020a05687c30c100b001c02f12abd0sm1598863oac.38.2023.10.30.07.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:30:41 -0700 (PDT)
Message-ID: <1d8232dc-9006-4934-ab3b-8aefb9efdd6a@gmail.com>
Date: Mon, 30 Oct 2023 09:30:41 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] ppp: message tracing
Content-Language: en-US
To: =?UTF-8?B?0JvRjtCx0LjQvNC+0LIg0JzQsNC60YHQuNC8?= <m.lyubimov@aqsi.ru>,
 ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-15-m.lyubimov@aqsi.ru>
 <4a3b8f95-1c7a-4f37-9a99-8d1928d24635@gmail.com>
 <6d2992cc5acf2e72f831a7dc30274afed4995424.camel@aqsi.ru>
 <6226eae5-8091-46af-b6c4-36a0578f4b00@gmail.com>
 <280acbd30ead25b673141806764ffa7b629ab27a.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <280acbd30ead25b673141806764ffa7b629ab27a.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

>>
>> Okay, so that looks like an implementation problem in GAtPPP.  One
>> possible fix
>> is to store the recording filename until g_at_hdlc_new* is called,
>> and call
>> g_at_hdlc_set_recording at the right moment.
> 
> Can I fix this and redo this patch?

Yes, please.

Regards,
-Denis


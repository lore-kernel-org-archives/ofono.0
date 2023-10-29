Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28702F2E
	for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEHJqLhE"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b5220ea82cso2579039b6e.0
        for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698614207; x=1699219007; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GdL1XzGTfNguU6TyCBPlsJ11qIF7sVhIouXck0EOUw=;
        b=KEHJqLhEyBrjcr1VuGkuhUSmxeGfMg1En18AIqk3H132EKHl2egrLhV1rrRKaHUfdh
         W7ha2Ez3dtSsH9faGU1LAf3Wqvt0P/SCD8vla2cMNF/R0ND6g6Mjxv9M3MbW/bjZCF8C
         avuUyzVUOaWsHIMzBSxK6VPpXezAeHbxEOhWQaIXaSeVR2ClB7mj/OUa4Xg97BK9iU0V
         Bhk4TajGggeWWmghecZXq0I4fbjiSAkhMzmugddSSxwifV7rQlpBSfPsJZsLsRjMPBo3
         E3nMzUWXvOZD2rUDrFE79bL3tspr7vR4zQZoUYr94eaQT3sr+GMfHqSwdaJ6Gs7tRSRL
         Vi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698614207; x=1699219007;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GdL1XzGTfNguU6TyCBPlsJ11qIF7sVhIouXck0EOUw=;
        b=bRP2NAdwxbDGi5R13HnVEFkorPGs6pn0s4dAhuVVP+WyFJjrauV6P1dcqRYN048NV9
         niVOuNUQDJNuqxDdd4Bl3BNvSgjdJsGTzmPgrSCX8Q9kfSu/tZ+pXDXXJtFBFj4h699k
         nto8xEEnYMwjSlVRPPfr/NUUdMdtyj8Uz0WBsPI5S4M6wqn/tusWDo1N2Iyfl0xLDPD0
         ivAZ3WUp5TdHXi8vxaPyZR1LGI5pcMjDm+9PzV23vtGKFcuZtBsRjHY9hmMz3+ljj04I
         vFCORFqaFqVt3Vzs7URuaFbAtPhI/u5fciKuvCZisQF67e7Dh2vewSTpbrn84/hIIIiZ
         XoZw==
X-Gm-Message-State: AOJu0Yz/D79aBwV/4jh1vFhZEzxcWerfIsohYkqCfBJQP8uxlWV35ZKG
	XHfIAcVcVAXNqBXmfMN+eMhytWVOFTo=
X-Google-Smtp-Source: AGHT+IEsM1lRfZ0gNd2BJs0rDK4+t24QJlJMK/NhR8KqpNkWJudFqS178mKv8+h5NWjm4GYwLnX8BQ==
X-Received: by 2002:a05:6808:f15:b0:3b2:e519:192c with SMTP id m21-20020a0568080f1500b003b2e519192cmr10856170oiw.9.1698614206924;
        Sun, 29 Oct 2023 14:16:46 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l18-20020a056808021200b003ae165739bbsm1156202oie.7.2023.10.29.14.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 14:16:46 -0700 (PDT)
Message-ID: <d614327c-0981-4c26-8fe2-012c319e03ad@gmail.com>
Date: Sun, 29 Oct 2023 16:16:45 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] drivers: adding support for the SIMCom A7605E-H
Content-Language: en-US
To: =?UTF-8?B?0JvRjtCx0LjQvNC+0LIg0JzQsNC60YHQuNC8?= <m.lyubimov@aqsi.ru>,
 ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-2-m.lyubimov@aqsi.ru>
 <bf40fdd6-e09a-4151-b5c8-24e5553c147f@gmail.com>
 <8e90fa7e7ae4a3a80efc5daeff1f0fd470235432.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8e90fa7e7ae4a3a80efc5daeff1f0fd470235432.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

> 
> I checked, there is no drivers/simcommodem/radio-settings.c file in the
> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/drivers
> repository, how can I fix this problem?
> 

Okay, this was a problem on my side.  I went ahead and applied this patch now 
with some style modifications.  Please double check that I didn't screw anything up.

Regards,
-Denis


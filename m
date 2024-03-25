Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D013D299
	for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375087; cv=none; b=QUGcqZsSWm0U9IxMb8i2NvLt1N6d3o9NM03nrGZe0R2h0XCoGE/we8TJMWFJMvFoaCeZjdIZIYwEjLdpHrFVgBO0u66B6gt1WCZWrZiFjaH3J2JpoxQTJaZVc1mmMjV1XASalVomR152IRc1eIixHzr+/w9IO06x8ayakR/BfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375087; c=relaxed/simple;
	bh=7JPzoTh/SzjWe8T1Ma2xLIUL256yoO5dafCjfiJ718o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tl0t2SRU6jlVwKJmgkROtvO1r81FCzgKZxzeZ62AYt1qW2GQfiFki2uiYVmk1u4OD93R5aqX46X034NjezkKZsVufK5kgAidqTDXiu7/bGMOwk9hUquPW7cF6xCeONmJ8h4pxppcjhl8vLUO2o0O8I1r9SHAN0IsXiXDUaLP4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PusfvIJC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PusfvIJC"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a49261093cso2175738eaf.3
        for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711375084; x=1711979884; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhwKlSh+VILP6mjvRyqK03lc+LuXEDP/G87g5+hoX1k=;
        b=PusfvIJC2rHOioh5jvy5+Ds2DKYb+6Rh5arF/ozpCzSnsY4k9FPWwyR1mwNcsY98My
         c4bqFgC89rh5N0Ya1NQYv8Fiv5+W1tTmHOUy1qtDy2V5WhIi30Qwty93wkccG7G4w1oB
         ZYhgLMKlpbPAgG5rmGaJlfSS+pRQ6LQQ8byqIYYWVG6u3Nv9h2G63QN3f2d9il8EecSF
         V7/f69IvJhjQWreU+vk+vkxWsRiKdm2FI8SITaAi7AA/R1+SLLFmD49+DOADPocTrVZ/
         dB/VbgIvpjMBfAtSNtOd3FMv2pSHTp+sfrMcKblN4JOF8oeIH1fooX03Po14hb6a9DCc
         1X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375084; x=1711979884;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhwKlSh+VILP6mjvRyqK03lc+LuXEDP/G87g5+hoX1k=;
        b=dHBOnXar9ZKqJbL3k7LS+WhKls34GZE1UoQWSKrPCMieSEnzS+KiW5zCCULacbu0v3
         XYv09ofiK0wIQjnOzKw3aIyyVt+EShN1+NZgqx167UpKYHwmcnsfrKTwAyfgX2HMsMvi
         1WGqUvODVnrESRyBKH04ipb1A3eAMVkuuIo/tmQsNaWPxmMbbhiRmgsQw6qOZXD0Qgss
         Ce2cw2ozbmdW6BQIGQI+r/6BFot10rQjLZqRrrvTfffjpbHFeyQQeC4QjfYLAHYZjHz0
         Q6mvrQZJeK7SP01pkRX3YgtoBQFwZ3cnJtUa+tQ01kIihdkDoeQuTnmMETyVSSiQq1FG
         ReeA==
X-Forwarded-Encrypted: i=1; AJvYcCW4x6k8psEZFzC6tBHI0QPlSRHG5hP9/Ljca0XlQ0sK453g/DOseaIE4wNkI/Eagg1VQmJuDl6+RePey30gLjHY8iy9MCg=
X-Gm-Message-State: AOJu0YwvL48WRPk0feUvWlR8a0RAOO9CxaCjbyIQGiM0WCxsX21oiTQC
	V6TH2Q9SNRLUwJkfeta5GqDpXZIe29bN+xHgL8xn6LgT2c7doEtj
X-Google-Smtp-Source: AGHT+IE7B3DvM3ZGhzTVURqLPknmMxZw/SaTey1nGtjcsn3eq7h4wIBxzpvBKKWcCSrRl6mGyS4kIQ==
X-Received: by 2002:a05:6820:2611:b0:5a1:78c0:4327 with SMTP id cy17-20020a056820261100b005a178c04327mr6281055oob.4.1711375084420;
        Mon, 25 Mar 2024 06:58:04 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dk23-20020a4aee97000000b005a5521a2c0dsm443302oob.44.2024.03.25.06.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 06:58:03 -0700 (PDT)
Message-ID: <aeb6e3b6-1662-4d58-9937-dedcd5f7af10@gmail.com>
Date: Mon, 25 Mar 2024 08:58:02 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Receive DTMF
Content-Language: en-US
To: Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>, ofono@lists.linux.dev
References: <CAAcv5+45oEz_ychyuPunbjLbdXU7PK3yVZLeuBGvr2qsEzEksQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAAcv5+45oEz_ychyuPunbjLbdXU7PK3yVZLeuBGvr2qsEzEksQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mohamed,

On 3/23/24 17:46, Mohamed Ali Fodha wrote:
> Hi,
> 
> Is there a way to receive DTMF using ofono 1.32?
> I can find SendTones but no one for the reception, any idea please?
> 

This isn't possible on the protocol level.  Not in 3GPP 27.007, MBIM, HFP.  (or 
QMI AFAIK).

Regards,
-Denis

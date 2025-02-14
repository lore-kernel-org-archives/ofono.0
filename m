Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216191F92A
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546603; cv=none; b=N5eYsla6qwx8J1QQUe9XU1dLgiNJ7hwF2eGe1chkVFrCQfwkjjJy4n9GT9AkJwuhdohTnW1Db2cJRHKHu5NYRdodWaS9A/LaYMguuZhMJ+LsIyU21uZpqVHAXipo5h7XlZxqeYiczIG2DeoSzKcEHWYwS63sG+9hsAvWCkemVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546603; c=relaxed/simple;
	bh=gYmm0eX0u2UCmzZtIsEtNGdRsrG2qQ5O3i/NWrjvLRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ds4Bj2cD3lY7mgKWpVrq/brWDtuvFE/x+iD0wELsSr5ePIFKVdEItRRevdfO34xeoDK0iBYMX1872Ps2sFNMkWY0n3ZsI+yrmmiufsVT25WZFpX/XnDyQCJIq+wAwzoBZVXHc1W2YWpQorFXpS4ToAiAllQkqmpZuQTbJ7j0q7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4OaQ0Ym; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4OaQ0Ym"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2bc79a81e6bso297502fac.0
        for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 07:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739546601; x=1740151401; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsJKu91cjgHgm2NgdpPnszXcq6//OFET0lJKmpBMA7E=;
        b=c4OaQ0YmY5jrRfifc+aXEHB4VyeHVwAdwCJ4yMtR/sJyj2MYXBe8eB26IqDSuzLIB1
         FpgDwEuIJ8iNSAI58mWDx5gn8/2XZ4EpQ2jVdeD/GojDmDpkC/xTmH1gLJ8guaZikquX
         qq5kibvIU0BCfCmN0nQN8cmKi3OpkJm/17UUE6aA2luodiv05aLX1gyXao0U4kr2gXRk
         HaZt13ZW642SAAJE8HtYuwwJcpgo5PqNYQzO8GnbI049V+GCoppl009NTjtdzsTdtxmO
         kfqlnK5JOFSu0J4Q4cXf/kR+w4tZRf2Smx/C00dYS/J+A/0agbxcXnkjCqLi6t5N5ySn
         sBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546601; x=1740151401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsJKu91cjgHgm2NgdpPnszXcq6//OFET0lJKmpBMA7E=;
        b=tfNnV9J6lo+B2Xh2ZvVvlspnMR7A8pziZElCx5NpdrcsBn2QviTuwEzHx49Svl6Bo+
         H7loZ3zP7ConLOD33SKPR41o29OgqRdB7PFAuWhd1BGNtJb1skz+Tja1PYfoEcyEJxgs
         aJjkrkwasAzyd7w2jE4aOc9Qj+x2XHTwg8JB62R9Q7R0buanjSvVFwz9atzkQlgKXkgb
         10aT8fBrxshCZ6rcBxEduftwWS05nEHsE9XMD1YulDOn+Ko7JQdccknr9L10rH6pNorP
         1vbE34xXMXPHCpG+9VIr28RmVcjio26/t/7JjQZ5kp24xqD/3/fdehYDvogqj2IhAd6G
         DT8g==
X-Gm-Message-State: AOJu0YwyWgw4iGNpgOGLdF7fgDi+ojHdjeTSip6Zh+PDxTxyFVNbs9UX
	1pulpfAlDWX2PKkuRjI42AWqldArywcK3QlC2rAr3sSY2LguPc00
X-Gm-Gg: ASbGncuhXYuL/eN9TXxin0eRWF/lc6qTpLnslVLCYTTlWFycbtCXnf7l4BzbB8eKc+5
	i6/CkeNoLgoi3rUleC6GOtrMLy6OdjBkvoJCF+kVYKP6OXtvrr6nMVPugrP0AQTOzI9+GYcxArl
	jBNwzOrfOWGG7t6mgisVqPX36smgRR5CBqU6Olc+6pvgU5IDfKZa4hTErdWHZHvVNTCMDuksbrr
	oFtmUe7q0Rr6LcRz8Dyea7acezuTkxrit1PGJUTWPbdxufp0dbwdk+GoFVnGvuBHdmZRPcCLsF8
	Zza9UVlKieN2ZHn2ybK212hRDiAK9uu758BYB3eDLiDYnfSHSJMrBS28
X-Google-Smtp-Source: AGHT+IHs+b+XGlnckdI8T2gewMAfxF/mPJVmSVK6TI8YHu6ocGzZ4ZkMOtJHmPcZv8YMrulcWUeFFQ==
X-Received: by 2002:a05:6870:b28b:b0:29f:97af:a1a0 with SMTP id 586e51a60fabf-2b8f8df6844mr4497750fac.24.1739546600987;
        Fri, 14 Feb 2025 07:23:20 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2b9548df81esm1657147fac.29.2025.02.14.07.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:23:20 -0800 (PST)
Message-ID: <7dc06a7b-482f-4ea5-93ec-d645e046257e@gmail.com>
Date: Fri, 14 Feb 2025 09:23:19 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
To: Grant Erickson <gerickson@nuovations.com>
Cc: ofono@lists.linux.dev
References: <cover.1739406657.git.gerickson@nuovations.com>
 <d2b56b2248111502169c4639329ad8f2fa5715dd.1739406657.git.gerickson@nuovations.com>
 <5e8f1d1d-01d3-4577-b17d-c565e93f9e0d@gmail.com>
 <500BF5FA-3998-40EA-BE10-EEB6955D8328@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <500BF5FA-3998-40EA-BE10-EEB6955D8328@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

 >
> There are two separate actions to be taken:
> 
> 1. Performing the rate limit check before the request is dequeued and sent.
> 2. Setting the last sent time after the request is dequeued and successfully sent.

I'd rearrange the whole thing such that 2 isn't needed.  If you update the last 
sent time in 1, the worst that can happen is that the write() will fail.  Which 
will probably trigger a socket close shortly afterward anyway.

> 
> So, there need to be two, separate conditional blocks for each.
> 

Only if you want to deal with compiler warnings ;)

>> Also, don't you need last_req_sent_time_us to be initialized to be non-zero somehow?  Otherwise it is dumb luck that last_req_sent_time_us is set to anything the first time (probably garbage data)
> 
> I thought about zero-initializing it in ‘qmi_qmux_device_new’; however, diving into the 

That is not what I'm talking about.  l_new does indeed zero-initialize 
everything.  Explicit init to 0 is not needed (or wanted).  See my reply to v3.

implementation of ‘l_new’, it appears as though all memory is zeroed out, so the 
zero-initialization seemed redundant.
> 

Regards,
-Denis

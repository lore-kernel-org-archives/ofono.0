Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F1376E5
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716653; cv=none; b=N6oa3i26DQBoZeAuUUcITGwRiVbaeKiAvkMGhayHdZHvw9z32Xq1lIqOsV/u0eU872CdPyifFdXaCh7aIy3JOYqzHr/bdrKnPi7DrVP4jecJFWibPADUDAoJHhj14Uty0CywNSefWLIQWdICnWQfTKjRvz/Ph0wOXWyCB7Px9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716653; c=relaxed/simple;
	bh=iLl46RxygGB3wfk3JGKuDWBDgcbjDLkX7FS3oIl+dvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=etM+9YegdQlNa603eawWA9MRen5rcQMlsikmPY2k436KdFUcPcnkaBaeo7zBlz2OEfzX05k9MDRvgVAwVbxyyLZZL7kSZpXLc3njbXbr1lc+UZj5R9JvBjjlnbhcJVYz+8ZpRPf10+9muHtDwoOk9JdHcqvIZAMat74Yoq44tv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyZGVyGD; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyZGVyGD"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9de9f8c8dso631916b6e.1
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716650; x=1721321450; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EViV5ZfcDKiICBaGqc7WgqmoE3CqVEwVrdghgkD1c7s=;
        b=UyZGVyGDTDgc3c38Fy19EOUjJXlaLRV9R5bJ6SMyipU+LQ2hccBekHiLfUB98+C+hS
         kssTvPz/JdSwAL0Q9QeVikSok5BJHnlLq9Ta4Aq1HWt/Q1xXUWSllIMVkkD39vN8TWxi
         Cqd8+scPZImVSCA9Hm52OqhTzguJgd+tjltHEGsmUMkFK4SiB/0j/ZUJDBUUM5NFkrJb
         af6fzYkXQERBYEd9917msOXTq5ccpq6Xob8aSLBkodRa5cT9AVvbrbeL82V6TK1K0oxu
         FMneGRAewOi5DNhzqJMJofoYaxpc81RkZzAuTvOVP8YQG4gExLr+k0fDqR0Yj3+Kt75r
         HWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716650; x=1721321450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EViV5ZfcDKiICBaGqc7WgqmoE3CqVEwVrdghgkD1c7s=;
        b=eSUlj0XGaspcfA1qXTLA47zB3AcIcsA0rr9BZJsj1IpPQnYPdlTV6nsGZw5ppLTq77
         VBIMN5en0Q3utOR1I/cLoTJdjwL6TNtfchG+evGLpzYWAih1qCC2kH1sO9pzhvscnCLu
         Y9OdqCuTA0DOQD8qX3Pn1MRggNMYnjE+unpDFvNQicCo0shHx+pPHEieuyGlCuuaUzKo
         RrEyrGLovuz+cSxMi0aR7ewMZGvI01ufgvn+/Krwd7vi3Eziw86W/idNdniXNEtlzagR
         b4Af6Z0A5unvPuF+18sE8JBALd5Zh7LT8+Q7iFYOG8UouPcOYfjddEICIUv6+2I4AVel
         xe0w==
X-Gm-Message-State: AOJu0YyfvqusIJ4HYZLuNzxIYpo0O98bQY+T3Ls+aRRxagXNheHWS6Sh
	3b0ssa46XgeAcMwvCMi3FZUUCkGvEFn8S/a5/dlbdBkgqnLR9wMAaA2Zmw==
X-Google-Smtp-Source: AGHT+IHxztAoubeOO+84L0ZtBiG7rYC778L87x2WkdAi8XDld1gnzckY2CjlIPhRyxPQKlYKKWkjDA==
X-Received: by 2002:a05:6808:189e:b0:3d9:e22a:8f9e with SMTP id 5614622812f47-3d9e22a949amr4532832b6e.39.1720716650653;
        Thu, 11 Jul 2024 09:50:50 -0700 (PDT)
Received: from ?IPV6:2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3? ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3d93acff4d9sm1140232b6e.5.2024.07.11.09.50.50
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 09:50:50 -0700 (PDT)
Message-ID: <3edf8280-cc48-414c-aa90-d8f4b110d85b@gmail.com>
Date: Thu, 11 Jul 2024 11:50:49 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gobi: Limit number of premultiplexed contexts to
 4
To: ofono@lists.linux.dev
References: <20240711164654.1688558-1-denkenz@gmail.com>
 <20240711164654.1688558-4-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240711164654.1688558-4-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 11:46 AM, Denis Kenzior wrote:
> 4 was chosen somewhat arbitrarily, but it is the maximum that the
> qmi_wwan_q driver can support out of the box.  The only limit is the
> number of clients under QMI.  Two WDS clients are typically required for
> each active context, one for IPv4 and one for IPv6.  The total number of
> clients cannot exceed 255 (uint8).
> ---
>   plugins/gobi.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 

This set should be ignored.  Sorry for the noise.


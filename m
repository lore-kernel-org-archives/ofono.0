Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F51AED31
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895605; cv=none; b=gqQhR8kZITP7oDFwPmBVNrfdbgVmprs4YTOJmSSCnzr5uQaU3t6zdAQehVEhDuDplRPtRqUDL5YUnDSP4u5533DlummRIUREf1a8sB+FAYZjISfLJrisv7cB0JBGrRLDjiFw++Dd3B1NL6+GDdoDoTGR0g2AZ6Ctzwuhe2oxM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895605; c=relaxed/simple;
	bh=c3AHCQca4pp7M2HwVeDH3RAxPq8XD2iiSQiogXEMZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvgyehhytcKyPsYLhJNcvNTLj3nvGl3uHUP/A5G9bU6FgJVFLBTfcOk/jvZCwzpnzdLFZxU94h+JAEccqu/ykwzllbE9xOwfSDSQkOhJYyKUdEI0niLxsoXeNrXo71fE3xnUGwPJqqDfW9k7HuykBFQ0v8cEN/Gh6Zl2sVdQ0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH3d6fDM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH3d6fDM"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cc6962c24so270054fac.3
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895603; x=1719500403; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIybiqT5LKyvIkW64B96fUNjoTEI0kIgO832q7IZFAI=;
        b=PH3d6fDMdSQCZbv2TVxNkemiRXCeOUQBJ+yS+JJoqwcg8YOBFds+gvDfS1LT0Kyy3Z
         cvYb7/QvojSILtkXUmThVEITwuSYBtj1uXe0jA/P7hqESr+GVWecPvd+c9UFjWMNO62g
         XxyNNImvOJvfM8WTZRb9PNjmNBJB3leHipTKPUECidw1A5OTvioy6qiy2JsAzeFdo11z
         e/+QJsK63kQVZHw4JErJ2A6BiT75YxY8BHA5Kytpq83QBlniN0iloxag0EqKxo1SXh1g
         LMkEmIqdZf4s6ZxOeenXa/dB8zR/eEoGFGYOVilhbgHAQcjDVw2HBy2m8pbH3GGuwA9o
         vZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895603; x=1719500403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIybiqT5LKyvIkW64B96fUNjoTEI0kIgO832q7IZFAI=;
        b=Xb3MAtxqA+7EOI3arcg2oFEVF1H0EfWOuNctLwmclgKXveUkbyZzvR6r6GA2BWr2A8
         3F7cilV7Bfs0SZN0BsGnGVHUyzkU9JobraWJkRPRUrl2YP9RQ/2o4vB+P2p6Dy1WYgc/
         8Ewd1fEPJWL3FAMvtNYfjaYVao9MibZSxWiEzzafWlUME5O8GU7lidiEIvZwpBu9SpwS
         AKdM7OF6J0dHR8eZk6OWpkw2BBDIBxBf9adInxLo01Bd9nrA7RupID++AduOYyUcZMNg
         iuCQfbWpox19vStSaMvHYjzSspVV71EVNIhdB/f6hFrk8dAXoKksuEvC5iM6hfm1ECs5
         EQdQ==
X-Gm-Message-State: AOJu0YzlSa4StdYOzKe187lyT975c74YS0nMfXrUv6DdOH9gBxowiaby
	mkep/k8DWrvNfshgroPSAnMgCgQqDpztQIemjDFMWdRN+sb4SA6Bj9nkZA==
X-Google-Smtp-Source: AGHT+IFLbnCGUS7zUwmEBaJ2KdDTJslSu9BRmpTtGk9IhMSag2hGxBKMSBzLZg4bc50tf8cJzYaKqA==
X-Received: by 2002:a05:6871:10b:b0:259:89fc:db65 with SMTP id 586e51a60fabf-25c94d70a63mr5727480fac.50.1718895603091;
        Thu, 20 Jun 2024 08:00:03 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-25cce10bc22sm29599fac.38.2024.06.20.08.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:00:02 -0700 (PDT)
Message-ID: <1218dd9c-7d11-4024-9beb-dd72dc6d8e69@gmail.com>
Date: Thu, 20 Jun 2024 10:00:01 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qmi: differentiate between lte-cat-m1 and lte-cat-nb1
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, =?UTF-8?Q?Martin_Hundeb=C3=B8ll?=
 <martin@geanix.com>
References: <13BA976A-5959-4708-97F2-77285400EFB1@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <13BA976A-5959-4708-97F2-77285400EFB1@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

On 6/20/24 2:28 AM, Sean Nyekjaer wrote:
> Hi Denis,
> 
> We are using the Quectel BG96, when online Technology comes up as “lte”.
> We would like to see if it’s connected via “lte-cat-m1” or “lte-cat-nb1”.

I don't think oFono even supports this yet?  I remember someone added the enums, 
but I don't think any driver actually reports this?

> It doesn’t look like the QMI standard is supporting this differentiation,
> I have also looked in libqmi and uqmi. Is this the correct assumption?

No idea.  I assume it is supported, but may not have been exposed by libqmi.

> 
> Via AT commands, we can get the info:
> AT+QCSQ
> +QCSQ: "CAT-M1",-62,-88,168,-11
> AT+QNWINFO
> +QNWINFO: "CAT-M1","23801","LTE BAND 20",6350
> 
> Guess we are in the same boat as the folks from "RFC - Add AT interface to qmi device” thread.
> We need to add the AT interface in the modem driver and in some way prefer the technology from the AT interface.

There's nothing stopping the modem driver from initializing an AT port.  You can 
do that today.  It can then report things like network registration state on 
behalf of the netreg atom.  At least in theory.

How is M1/NB state reported?  Is there an unsolicited notification?

Regards,
-Denis

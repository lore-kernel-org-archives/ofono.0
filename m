Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB8274B24
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722830; cv=none; b=uosuO2s3CY/QniuL/yk1EYW4Np56sQsBNunjHqFw+jbpl02SCYpMqEr2MlvtILO6Xa0K6EZ/CQKlFdilw7RJhcnNKiNVOC2xeTkf67oQc6pfWTF2C2eaBlGNCXIMNDOOZElDl4unsEBm1OEL301RSpj+oh9EXn1G7P5a+pelk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722830; c=relaxed/simple;
	bh=1HPQ9JJRD+eabaMTlsUZYIfXEhxDQvrplBmCrvIfys8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwUQZy5X3EtWg1gohQzkoaxdOMLBUs8p7aJez8ZFJ8X+rMIyBjKpo4U67NfMH/PQOZjYpfYkHCEr+6MR4Hos1ZKCW8DHQanBO2zyupl2hQC1WF75gQX3bRX9tj0xxb7gk3HFt+s9In8opePI5H2U30SEydy9pugNdrE252f7EV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxDPxvcH; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxDPxvcH"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40a4de1753fso76831b6e.1
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753722828; x=1754327628; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNWnkw5PiLN8RCwFZVoOoONC5sFvi3SfmenTJM7OTKE=;
        b=bxDPxvcH3N5qAbeO1+LFT7j0sJbwbSoGbPeouboycj4k3hVHCTSGpK2pKIld6sZ8KW
         /yNGBRRUFUJ7hQZeX/mUFfcdJro3A42egI12ye99BNbEuCymzOk3qxiU05KV7aqxn0Dw
         +unmj0M5jXXKl8YkcQkBFf9mdKmBHDKFqiHlYiDcV3TcYyVOTDsWu0cD+kOrz6hlyBn5
         pI6OG38QhtdRPRmQgB5nyhz+juaJ4GPU9OBBgqVGfTOZUjrEUs1wEd1ufUmi3YFkJrW/
         EKaJK9cJBEuAUa7JZ+f0CfARpblq5/H6plKTwblk0DQ7L4SMoMwctXcWgB7QcHYBNHrp
         y3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722828; x=1754327628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNWnkw5PiLN8RCwFZVoOoONC5sFvi3SfmenTJM7OTKE=;
        b=ITHnorRtQ8d9bpn/y3nA5rlscgmRjtBkxJOMCh8fgsepPl1J59VsqzPHQs20xmZIO8
         rzDmYqB8byf3YOQ268kpbVuKFvXEP5WErhufItQsxED5LSiIgmE6UpeOZ4iqNuzSUhj0
         rNoiwkZfS7uUYYrdNUa2WtgXnFYcTjsKzAOkmA6+Wdjv67g0kzD648SicX9BiU8/1iQX
         K+u1edyTiorBiBrd1YTVVByumE4HdQy75u9SYq1zOslMAXAW/+iUfyxQ2R7Iqd1Dt2Sp
         iwgwpd9vGjsKTmP7J5xy2RNEGopXq72Yy4PWzBOK48KtBPjP9Qgw3LfN95FbZC0eM053
         AXDw==
X-Forwarded-Encrypted: i=1; AJvYcCUmhcxUUTy9OdYQ0KVEAgN2KiCkrEdyEwg0QWRZpaIg7UgvvTdsgnBaxH0+NnuswIEbXoNArg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5v9KGU0T/XnzD5Ug/Ta3x+5KuxLAcQI6qBrjXmtzUCxht/yBX
	EPsXo65BU6y5HX2heIH6CvRYCkBMrW5apEq959JTT8vCzWj2wo5n8ogT
X-Gm-Gg: ASbGnct37q0Quj0Xr9wtb5Gc1d5O8mA0Jrz/P1hj8nNotaY0k8+AiP2vLRDAlBXDBos
	7szksRFNeCNMO2xGrMG12u/4FW0a/fpRMexIcdw5+6jmxjmqxxNoTN06Jh+l/uRwR20h+iNazUC
	NyvoSD9bK3iHgj7zev/i+S1L4y+OQBq0MioprNJiaTj1l9Sf1hg2NMz4tvvwrvGcoQfN5iRkXJp
	IBDaroWtkmGugadXJtMn9pLRZi95pwQc+a08OXoCxknNxpcAJ0NW46zBe5LCteIRpkVU6V7jV5G
	rnYJocKOIk0dxD5ySgFvIHfO7W854eqlQvOkNVQzFiiwp53EIZtHONHh46W96lW2MMrIBkSeO5+
	w6TSjl6fQRx3hQGz5s13IN/A7RIfcruU67fxtrjz+ZWO2Z9Z3BnOHguPi22tEUYyPhTPnSe7JU0
	c=
X-Google-Smtp-Source: AGHT+IFtsrze/kpv2vVbPnUWudZuqumdH/Ztv0d6fqKUHHuV4R7Kjhn5c/Nv2jw8p2YL3JUw9FCy6Q==
X-Received: by 2002:a05:6808:218e:b0:404:dbf3:5b0d with SMTP id 5614622812f47-430588a414cmr267985b6e.3.1753722827856;
        Mon, 28 Jul 2025 10:13:47 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-42c7d3c3aefsm1199358b6e.22.2025.07.28.10.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 10:13:47 -0700 (PDT)
Message-ID: <6a96ee1f-e151-4338-b6c5-036d4be36994@gmail.com>
Date: Mon, 28 Jul 2025 12:13:46 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] gobi: Introduce "LTE" modem property
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
 <20250725121954.650668-6-ivo.g.dimitrov.75@gmail.com>
 <948f9442-1211-4a47-b1fe-a6b83a5fa500@gmail.com>
 <b386277c-da11-4c7a-88b6-d619de6dc991@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <b386277c-da11-4c7a-88b6-d619de6dc991@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

 >>
>> Can't we use QMI_DMS_GET_OPER_MODE to find the modem radio interfaces supported?
>>
> 
> Perhaps you meant QMI_DMS_GET_CAPS? That could work, will try and (hopefully) 
> send a patch

Whoops.  Indeed that is what I meant.  Was looking at get_caps_cb() and got my 
wires crossed :)

Regards,
-Denis

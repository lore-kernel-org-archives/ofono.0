Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8226FDB2
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721102; cv=none; b=MECwxQo3A6uzkzVmw2ZNtUFdxdOb12h4/5pkSFZgcBbJi5tyd8xn2mWp4szjlSwxXco0HVbnJ8zOSJh9SPg4mnQE4O8UyESxUffwC0GyRGShA+MLsGJkOYcbHSXstDyGZrzxK9vvYuCCZz0KeqzKu87kXXyBLeko1rX1p1fBg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721102; c=relaxed/simple;
	bh=ZJu3PxUs1IkpwFNF7UkoO4e8C1V3O56Ku6hX/Gh9DS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyPLOT2KEN74M1dGYNusUc4F8HfeIQliys+bPioSGNgafVr0PMG316r8BekxMoHByD6u/svDUngsNDmCER27as7zITTTmxZdGCVQ0gmzSM4ghibNg3YGo+18iG0hkjQjGG2MgzQNLhqeasx/RnjkoVvbNiWC4L8acNEX9KJDC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqRojwWQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqRojwWQ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0df6f5758so776608166b.0
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753721099; x=1754325899; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQqN16jmfajxooTiN3kUdAFbplg7qeqlh1nWM/6ChNc=;
        b=RqRojwWQs1tUeKR0C463QL92zZ1m7nK2k2Ld3DYXtfCkdMsSHfG1avXZu1eaJoAoAp
         jzWXUiiGN1bHC19/Xt0JS+CAzKbDIoJNkDr3/ISGvwMtbHUINelVLVIsjrkrKSPB24HN
         w85wTkAI7+RPK21QOM+rnuKdd/GFg4Xj2QlRlO9+oTtJGO6gL7gTwP7sCGunVSXdL9Fs
         9JB3LpDAxWNZCw8uK56o6NPaUDksFZnDettnREl+dU1T9Ee91E3x87g091JExJJFnjG9
         mF37/gP1aSxM+C8xhFLPRQ6xZfnZt7nIIyE7NYQUGqThg2kb5GaXZI84dofOH6tk1wFc
         7GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753721099; x=1754325899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQqN16jmfajxooTiN3kUdAFbplg7qeqlh1nWM/6ChNc=;
        b=DO0r0pKJ8SfNl13RwpP9edPV8lzdLThEes87C9Nz6Du6W6STYQKyybO2zPOyBQsauV
         D4CYDQi9P4+9O4oShMKLQ6IQKSHliiETXv1CrUjnsiUlpCZiyz72HeR16ynGv3TiUqAl
         uqCacPQBmkMOMd2F1QoJ8RsFi2GuLQQEf3MFRTFYwK5xoA1yAlj4sg0bbgP8LYkasqBF
         v1E5c8B+lGsCk54xgnTMcGY/0Ijgy0zhrSHYv49PzobmlZU+d7BB8knwXkPS5BlvCEu2
         LTK1JCPrkG/gUrgo7prgeQ1mL1dyVnlq1E78293KCMuMNQEEavjqOi+E/wmMVrDE3khh
         8Gzg==
X-Forwarded-Encrypted: i=1; AJvYcCVf9qUaFZx5f3XzKhZtbOw2aZx2/n6ukJUIXG2GRIcefA1L4npBFvkMUElvnAmyG+hAWOE7Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH4WqleJtiU3TnDhxp4lWK6G8eMWs9WCELfag2x1ITrurkMhNI
	NWAAcYEUrOCB3XTWhh9AzyskZSuqA27rUv6vhQybtF2iJHgm6L7y+k8dwzVrUw==
X-Gm-Gg: ASbGnctWLPJNNHIXZtAc6ZqPd2npy/naqooQ4CeJIGqBIA+WdjiofWRCmKuFLYFIQS4
	UwoOGy62LXDk33p6uFOtDfPC6wtnrqzDhE2HFztndZJNjooB5HAXRRPhqGd0PTcIucGLG6R303N
	ksWzTtN9EVAu6WlYk631ddcCL38Kv3vUcEF5DwZwGzGYnxI+YnNVZt+jOyGS0MsT+aFNhYIy0tp
	S9ErRbbE6612NpYAH1LrO0G3vyz2YjCy4zPlmdZm1OWSg1s7GazW7VpBm1tkvOMEU4wItH7oIgi
	FO38Fd1uJMtVhhGkjSdGobO8w2cdPYDHVjAFa2NaW2Qcvm0qrPFJDoHqvNGj4vMy4BZuWAmsf8n
	MNsxR8F7y+dNQeLwy6rfI+cUbqP9yRRBvWpc=
X-Google-Smtp-Source: AGHT+IG3MWJDPeq9hdjHTzsi58wTOjCNluUbRzAr5uyjurgWJbYngqK6u1kF9koQ3IzbxGnMaR8nMg==
X-Received: by 2002:a17:907:f818:b0:ade:79c5:21dc with SMTP id a640c23a62f3a-af617f3c06fmr1560311766b.25.1753721098259;
        Mon, 28 Jul 2025 09:44:58 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af635aea689sm446872366b.125.2025.07.28.09.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 09:44:57 -0700 (PDT)
Message-ID: <b386277c-da11-4c7a-88b6-d619de6dc991@gmail.com>
Date: Mon, 28 Jul 2025 19:44:56 +0300
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] gobi: Introduce "LTE" modem property
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
 <20250725121954.650668-6-ivo.g.dimitrov.75@gmail.com>
 <948f9442-1211-4a47-b1fe-a6b83a5fa500@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <948f9442-1211-4a47-b1fe-a6b83a5fa500@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,


On 28.07.25 г. 17:46 ч., Denis Kenzior wrote:
> Hi Ivo,
> 
> On 7/25/25 7:19 AM, Ivaylo Dimitrov wrote:
>> There are modems that are not LTE capable, allow them to announce that
>> ---
>>   plugins/gobi.c   | 10 ++++++++--
>>   plugins/udevng.c |  1 +
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
> 
> <snip>
> 
> Can't we use QMI_DMS_GET_OPER_MODE to find the modem radio interfaces 
> supported?
> 

Perhaps you meant QMI_DMS_GET_CAPS? That could work, will try and 
(hopefully) send a patch

Regards,
Ivo

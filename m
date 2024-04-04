Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2813BC04
	for <ofono@lists.linux.dev>; Thu,  4 Apr 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266733; cv=none; b=eHbzWNHCkwBanmESkmcfcK72xP0UDJuaWokLdBwUq5fBMb1taC7WfRAZdpdk0I9j3/9cTpRRRqKhGpUEOVSVOjafoFPl4sLTX3b+OVyt/2oV5wYe4QCEgXkqiqU+71Fs/q3huAJn/t7d8zeWQs0Iz/72tCdhflKFagcHx5VDsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266733; c=relaxed/simple;
	bh=OPNEKv7F9W8gY1dYKl95EhFnI4IIM+hSq5D35rA8dJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hKtFFD2Tm82PtrCDXNEYwm/3aMWaCYJSloCnRtXZq9CO1kY6yB7uMVYKsmBIVb0OgOp9UDYesTBc+gh5wikY2FHZVR6XUIDUji+XWGVOW6kGcWU05+hEg7uh2VB2GzlIJHxiQZDe2oYviWQNRyOa8TF9wqAzfFEmAUnzM8nyCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2JG2RwG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2JG2RwG"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e69a9c0eaeso1006072a34.3
        for <ofono@lists.linux.dev>; Thu, 04 Apr 2024 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712266731; x=1712871531; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ag5qsTLXhsO57kwaeYKyEcpQaDgB8wTspggEm1eiW6M=;
        b=Y2JG2RwGl0LfmrxT3+HDroLa+ys8aEOGhmpChabA/kO7r6gvhTRwi1ajeSE7oa4N41
         a2SZqNmqIsIKtfIAQ3poeXbxkd99/5xLb6hEp7NYHPqEMwkC7BHFD61aY7eCmgHeimkp
         /rMZm14DjvfuBKcFYMf3z5o/1AXs7BYjXHjiXYCC3v60L1iKZaNbm9ClgTIweP2rpXQv
         p8dfKhklAdgq7Lwh6qMaV8IxXbR7WUruqRYdRURNyYj4LfdxfvCiLUDkgeO/oCslWoGo
         eUeD8UoK3IZbzhF7a6ymkRqasLvMaMMKUdscEGdD11Lp5LmPnA9DRpn0LvVQousrGhiC
         jtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712266731; x=1712871531;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag5qsTLXhsO57kwaeYKyEcpQaDgB8wTspggEm1eiW6M=;
        b=rr9m9gLw/tp7+yqi1ZsDEC15SsTTcWl3SO4ruRJSnUs+TArF4I0lOkq+gxOK96v9Bu
         93hskfr2ZNki/B9MbVsaawtJCx8AwdwHAOwqjidWRwVsYn6s0+nShj2X/AqLFXx6hhzE
         Aa7KCKcNEeKI5c6dzOe8eWi+c2/KxWTqNEE9WElfIdNG2vI93XsnJ4P0dFXnZn0IsO/s
         epqKOCViaQWREaMMj67NhCy7QqgaUCiAH9tqu913nwexO1JVbWBd1DQBQWxImPBUV+Zw
         ZvTIcsrPPT6YB9pZIA1NklzgS0IRs3oK6wNKyrO+Q/TGYKZKBmpbDkN6MJ9IZMheZHYh
         odMg==
X-Forwarded-Encrypted: i=1; AJvYcCVK3xOEl3AkXpgN3lTOkYxVPStsPJxBiPJrG5Ht+9v7ieU7zuNVCuvF12lVt5HQ14tsyeSpQxBF5KKpQvDDbZlDa4SUrSU=
X-Gm-Message-State: AOJu0YxU+8BjH3zSYyO1mD2y/Mvb/WGlvGTUsafoEld1S6idlnrrDQjY
	yoz3lEg59UBzHyQcckZ2Xc52dz9LHgWpOIlUm3L5lc/RZiixWhb2
X-Google-Smtp-Source: AGHT+IFOR+PcCaPw4zIzd4m3BVIiyjCzLe6Yf5gqgZMy7Bdsg2QfpCi9pRnw5i7s9jlnJVtLnZB1NQ==
X-Received: by 2002:a9d:6a14:0:b0:6e7:c80a:3b2c with SMTP id g20-20020a9d6a14000000b006e7c80a3b2cmr999209otn.18.1712266731245;
        Thu, 04 Apr 2024 14:38:51 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y2-20020a056830208200b006e9e7c28850sm49582otq.44.2024.04.04.14.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 14:38:50 -0700 (PDT)
Message-ID: <7870afed-c3e5-4089-9b53-03808a02f0e2@gmail.com>
Date: Thu, 4 Apr 2024 16:38:49 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] qmimodem: voicecall: Implement call dialing
Content-Language: en-US
To: piggz1@gmail.com, adam@piggz.co.uk, ofono@lists.linux.dev
References: <20240402212625.5348-1-adam@piggz.co.uk>
 <d79f7d16-9c77-4359-833f-0d6b3c1f1b36@gmail.com>
 <a28170.sbfspn.2v2btf-qmf@smtp.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a28170.sbfspn.2v2btf-qmf@smtp.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

> 
> Thanks for this, i think the issue might be compiler differences. It all builds ok for me, but sailfish is using gcc 8 atm, so i guess defaults have changed.
> 
> 

No worries.  There are indeed differences between compiler warnings.  Also, 
non-maintainer builds do not treat warnings as errors.

The CI will do a good job about pointing out how the project compiles on 
different compilers.  Right now it runs clang and gcc in several configurations.

Still, unused variable and function warnings should be pretty ubiquitous.  What 
you can do pro-actively on your side is to 'git clone' oFono on a regular 
desktop/laptop, run ./bootstrap-configure and try compiling after applying your 
patches.

Regards,
-Denis

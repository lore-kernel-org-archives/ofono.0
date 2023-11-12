Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E57154AB
	for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cep6yqGG"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2fc858feso2024693a34.3
        for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 10:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699814071; x=1700418871; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=032i3iLyPfpfP6tdmm7iEVtdTwy+cEwyfmuqacPhR30=;
        b=Cep6yqGGWUu2LewBmGJgAJe2C5c7KfajFJtpQ+/XrUNQsgCTLhq40aQwGSnokHTkke
         65IXpcT+mZAzgiAV3eIqanz1Fvvb7wrXGtv96CFc7vbgvkPgW4EY+fmtOlkW3qhBgEpA
         YJKISLLx9C8oyVfv1VTbN5hTkNuVmN8xMMSLoO9EFKHP9tMJgkRZtHCRU5FAmkLSqVrQ
         JeNHq4b8v491AOZ/VCKuOvb4SplC6kLnVO2izcfY4ifFlIF9mMwd0fw0vhJ7Xqn0r7We
         b6wLrWX/CNycS9+6+5BfktnDRlj7bOr0ge24QvSVw7RPLyHcoYiwNo6RBZp8fV44M8Fy
         soPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814071; x=1700418871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=032i3iLyPfpfP6tdmm7iEVtdTwy+cEwyfmuqacPhR30=;
        b=lcyeXJut+mm56pl3AC+G8xMeMQL72dIV8pHlUkVo8k0Npg6X5E6FObdkWUmhakFC4K
         8u1nQzPIMYAzDZYW6qdTl7ZmxUn1Lw0R6kP47F1dJlo6IY+987yZoXtqvdSs/kH9VwgV
         L1/hj4UkaGQf5RR4tEqPSozI5KDsBq8DhTVdgozntH775wf4FA1VEWL+OuNnR8jf4PrB
         xOPDTaF1n2Ztqo2aZ54rWIYc/X6J6R3wb+uH6kEz87R9CIPn04eWfSKH3fiGYWkF74gI
         xDqBuJgNig+Vzy2NVQYQKhVGg+6gTE1BubZEIHWcwYdiAYH1Sx2vtHlv2z6tokw4qTew
         NjaQ==
X-Gm-Message-State: AOJu0YyL+iA8fuNtG2p181Aaj9bXtGY8IjslCjJlJKh10QlcllCDhuGk
	/dtc5hhz866DQcuYKGrkGE4=
X-Google-Smtp-Source: AGHT+IEANTLwNu9ilFcNkod1DNhDopE6a7wq5EmVp576xs6T9AioFuzQERGnz8kRmT6Wswa3Li8+ig==
X-Received: by 2002:a05:6870:5494:b0:1ea:ce71:dd13 with SMTP id f20-20020a056870549400b001eace71dd13mr4611633oan.28.1699814071435;
        Sun, 12 Nov 2023 10:34:31 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o5-20020a9d6d05000000b006ce28044207sm578419otp.58.2023.11.12.10.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 10:34:30 -0800 (PST)
Message-ID: <e48fe212-7a30-4bae-a892-f22d3495e169@gmail.com>
Date: Sun, 12 Nov 2023 12:34:29 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Improper Handling for Messages That Do Not Specify Source/Address
 Port
Content-Language: en-US
To: Sicelo <absicsz@gmail.com>, ofono@lists.linux.dev
References: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

On 11/10/23 04:20, Sicelo wrote:
> Hi
> 
> While running ofono in debug mode, I discovered that there are certain
> types of sms-like messages that arrive in ofono core, but are discarded
> without being sent to the client. For these, the ofono log shows a lot
> of:
> 
>    ofonod[3424627]: Got an 8-bit encoded message, however no valid src/address port, ignore
> 

When that code was written, this was what the spec wanted.  There was no way to 
identify the 8-bit character set of SMS messages, any 8-bit messages had to be a 
binary SMS with port/destination provided.

Maybe this has changed since, but I'd need some link / document to refer to ...

> These messages are valid, and ofono should not discard them. In my case,
> for example, the messages come in while connected to mobile data. They
> are sent by the carrier periodically to notify me about the credit that
> has been deducted from my prepaid plan.

Sure, so how does oFono interpret these? ASCII? Latin1? UTF8?

Regards,
-Denis

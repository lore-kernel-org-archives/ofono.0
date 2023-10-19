Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB84656
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEgbGCbZ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ce2b6cb933so2264a34.0
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697681298; x=1698286098; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yx+PbtH9yYPZ6xooElAdA//s1YlHWyrmnO/UUCophg=;
        b=QEgbGCbZIcBuGeMGggXxCpBod3tQuMPTdmIAGz5wTX+059poFYkIpmYF7Ee3C43pV4
         IafyqRLi2TjKbIiezKWbYsMDImJ5upVlw5B2N8uhCc3fWRviIAaMdDhxnLOLadCyVXNs
         axJtWsYXg3NEkY5u0IfuEiXvf9mtkI8GrtO1Mt70jdqIXyEq2Pe1BTJlwcpFORlxz8Zc
         95Up3Yolb8dYKRjpMHZBrFa8sBAT1b0AG0lqGf24yrZvEMV6DtLnmhEMCGfqfQsG6z0M
         +QUDqJxh2D+RAu2nay/NEr+eolLbtvJio7zrqMGom7a/lsLPjtzfGBKvNbfk5Tw8Psc7
         FTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697681298; x=1698286098;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yx+PbtH9yYPZ6xooElAdA//s1YlHWyrmnO/UUCophg=;
        b=bdnDfmhtRyBgwDXV+AMf1L1asxpXFbsDK3IRBswL5M4hzkOqT+R/5CRenKkLFvG5kA
         sFCrXrwWq86fJMyjJvULFzIp+eUaZWEPYKLUhK1cZESv4RHq+Uw3maFGj++iqh3PhUJT
         ASLpu69gzXHU5y/kLUqg9QaQ7QeJFJ0wCmMZ94nd71bCaFuYZhArfzAgmI7XHQba4Urj
         JslGnA58r/TQM809FwuxGdbPmING1U7hZhLX4W7EUim15/PaLGhugf16N00Q5OuINVW7
         AYR8rh+oTFLZb/sIOJxET/DqE6GWr/wc4SQDJgnhy2+A8qBkYzyJmuY20MJbEDD7gWjI
         i1sA==
X-Gm-Message-State: AOJu0Yxq5/m0dhDp1nYvWToMuORes/J8A32SOUsh4goYH8hn993dnIhd
	1U8EuIsWEB6sDQ97L68dzc3GG9uL9zE=
X-Google-Smtp-Source: AGHT+IG73RwKz9kBeE4a0Mo138s7S7lZfLNHT2bPZhJdgwdwQ8+CuwMGLAZ52qrDb0yyC2uiyJtM/g==
X-Received: by 2002:a05:6830:1a:b0:6b8:6f94:d3a2 with SMTP id c26-20020a056830001a00b006b86f94d3a2mr982074otp.25.1697681297887;
        Wed, 18 Oct 2023 19:08:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d21-20020a9d5e15000000b006c4edf462d7sm897703oti.43.2023.10.18.19.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 19:08:17 -0700 (PDT)
Message-ID: <1542d6ef-2ff2-408f-bbd8-3902bf929bba@gmail.com>
Date: Wed, 18 Oct 2023 21:08:16 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] Fix PPP LCP Configure-Reject
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-12-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-12-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:48, MaxLyubimov wrote:
> According to RFC 1661 5.4
> 
> If some Configuration Options received in a Configure-Request are
> not recognizable or are not acceptable for negotiation (as
> configured by a network administrator), then the implementation
> MUST transmit a Configure-Reject.  The Options field is filled
> with only the unacceptable Configuration Options from the
> Configure-Request.  All recognizable and negotiable Configuration
> Options are filtered out of the Configure-Reject, but otherwise
> the Configuration Options MUST NOT be reordered or modified in any
> way.
> 
> Therefore, if the authorization type is NONE, then the authorization
> type must be added to the list of not acceptable options.
> ---
>   gatchat/ppp_lcp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Applied after a minor style fix and rewording of the git commit heading.

Regards,
-Denis


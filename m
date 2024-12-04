Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0A23918C
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335596; cv=none; b=L8cSWlLP9MkGxS8pHBGK2pAqS0AchLuv/EVx7ZYbmDPTW2VcgGSmMBKdGJJ9hMlWUVduBZNFzIkEz48ju/c4rviex4CdcHBRuORPLJP9s6/iTjim056TK/f0HBRt3vnaPYVCdJ0qkevlq7T8f21rHvvE8obH2oSQV+ufniXu3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335596; c=relaxed/simple;
	bh=A6RRZLiyCx7U99sPLpdouAQQIgTS8ho5geCED71Ulnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfXdHZrA0MdyIVjrsz0/zaPYOpzdGfBrrZ5MaUnIe7MbnN6IznSdPQd0G1BANjPv+6KKjsbENBbzwtot6VNMd4EjKE36M9tJPg9DgdPsmjmNZte1RCbG9VH1zEJfbQ72V29kJ6fGKPtddgJ5Z+ODBfu2fEVQk4JqtAkjRlUrwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7o729xn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7o729xn"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ea60f074c3so66234b6e.1
        for <ofono@lists.linux.dev>; Wed, 04 Dec 2024 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335594; x=1733940394; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCb2GP2GSKD06o/NEvTOltxxdamX+JfdyJdvb6GN9ts=;
        b=K7o729xnIFdD7knT/utdqzYGWUevVTSPmoxmXXKJyiPZK6bjly8umXVQnQ9LZUUJqg
         Noj7fa3SPrk0x56kogHgIhlTOr8QOPkyMS5UVwZh1oyee13Pl0j/4+gpDKVyO0Tg5lev
         bldt8EKnLZHJml1JQ1ZGSa8zlhuZMeGtcT81QWnYKfTJHLU4tj9Ryn5x1GKkdrdhZgWX
         7yR6fIajQBPTkZiF9nAkCFZq4Xm241Zt6EDnHYhfTBVCOhSIcK6mNmRFhL7JS/CcLfx8
         AXbP7iMCVQY7Ws2NIS22l2uWOS0UOqSVU0n/DDgBG3Y7BZ5+79SfEvYC+92hFH6bSR0T
         hTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335594; x=1733940394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCb2GP2GSKD06o/NEvTOltxxdamX+JfdyJdvb6GN9ts=;
        b=jWOnqZdJnlQJ+5HXM/d5qhXRKWnL4/zT5Wr9bKZRiCBy6PjKdw////jWyg4TvLgbDW
         VU8rCMmpMLRnmSwUooc3q5T1jlW3W9Kzhusj/Jash/uZIAw/nTEl6L6Y5jYOMkk0AIhc
         Z1V4jnu93oPTgZDyFUNlM68zcxLqLBYtnB+DrxgReTDVxPnCobLWNoWPK+SIXnGj3h35
         YODKWO4YsOUbvbXTlNyUW9ZmU0fs9bJCEDysnhlj7blhQSqWrCqhz+p9iP3VBPjCCdNX
         Wuj0LpzFx/CdIsZz3ONUGg8QelqNKzT0heJEodfN7B5Xc6pIikxaAVJZ3EXfux7tu6Re
         Kw4Q==
X-Gm-Message-State: AOJu0YwwV3r4aynrDQBjh1qXhaQp1amCdrgzDEi2fLMumh8ig045iDQa
	+0W0EGuW6coPD+K3NdLippV73VXSLkpl8tFulXhZtUdzHqO4797w
X-Gm-Gg: ASbGncuASJbL8rVCLa3C3nVCU+NwTGrS0oyM9b9Wf49WTkYv8PtsgexvQMRjSxFC6H8
	weXvG9QjWAbNgatpwrOcJYL8VVUZvSzNpDneSXwmgh9w5W2E5gPqWEjIe7Fh1oB9KxKZzT6cQg0
	XuODDNNc2V/YsfEgxLf2NSmG8ztZKCfXpEeGPiZ0ImT2IfPtJ5TRHak/Y2GTdXeMMKo0dUBCgSo
	g8+7wS/WaNQFBUY8OKicSg7BjYqxEpd7lp3tTDNqaTC2hA2j3YC3G5Cac0lM9LlmOjmyKaS7VwV
	42FATDD5OtU7kg==
X-Google-Smtp-Source: AGHT+IHT7sShwIkU7H6Lh5/MRq2tuRs9kHnVml1and7BSTwRnrpYbsrhFQAinsjfIXqDidCKcOZsig==
X-Received: by 2002:a05:6808:bcf:b0:3e6:5f3:f0d8 with SMTP id 5614622812f47-3eae4f91887mr9361774b6e.24.1733335593921;
        Wed, 04 Dec 2024 10:06:33 -0800 (PST)
Received: from [192.168.1.8] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-29de9946df9sm4458885fac.40.2024.12.04.10.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:06:33 -0800 (PST)
Message-ID: <a5339dc5-5ce1-4b41-bf7d-6d04df7b0308@gmail.com>
Date: Wed, 4 Dec 2024 12:06:32 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] smsutil: check status report fits in buffer
To: Marcel Holtmann <marcel@holtmann.org>,
 "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: ofono@lists.linux.dev
References: <20241204082207.24692-1-absicsz@gmail.com>
 <20241204082207.24692-2-absicsz@gmail.com>
 <4B63F8F5-BC10-4D95-8204-552823D06A1B@holtmann.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4B63F8F5-BC10-4D95-8204-552823D06A1B@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 12/4/24 3:55 AM, Marcel Holtmann wrote:
> Hi Sicelo,
> 
>> Fixes CVE-2023-4232
>> ---
>> src/smsutil.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/src/smsutil.c b/src/smsutil.c
>> index bdb1d04f..8c1aaad3 100644
>> --- a/src/smsutil.c
>> +++ b/src/smsutil.c
>> @@ -1077,6 +1077,9 @@ static gboolean decode_status_report(const unsigned char *pdu, int len,
>> if ((len - offset) < expected)
>> return FALSE;
>>
>> + if (expected > (int)sizeof(out->status_report.ud))
>> + return FALSE;
>> +
> 
> every time we do casting, I would asked myself if the variable really has the right type and if casting could be avoided.
> 
> For example, what is the reason that sms_udl_in_bytes() returns int instead of size_t or unsigned int? Denis?
> 

No good reason.  It should be returning a size_t.

Regards,
-Denis


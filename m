Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF211DEFDD
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388550; cv=none; b=aAoKWcyvkwrsiiPQRmYidwjofhwWLYfwjhrtFjHPiQUr4mn02ezzyLyXUYTmuSZSMmf0ymcjd4BBLFF0BMRoZTT6/rWiuJACmJXpEusXe4Cg4J54Vht8NXzWQz01Ft0jW25O2F39OTFjrrJ2cg9sshRM/IFNXmECo056KANzC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388550; c=relaxed/simple;
	bh=gbeL2j1APelLw4lNF4TLFH3zz9q1OUnULs7EhTlt8Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QKY8v9O9aSemjGzjzAVp2dWldjDNL/Ibzwirw9TgA4TEPiNXVPHBi9PC+sQQPHxLpODgxt15rX+73vcp1kWN/WFY+moixkQcKple8pCigt5IoP1eVvaF0mvgh3G4rYetH2fBp4Ch0A2INLOPUcvHhXD99BVh+aZ2VylyJyZpLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAYRDt+E; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAYRDt+E"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3d9348251so11357b6e.0
        for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388548; x=1739993348; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90xtQXplDDgqic1zh5pyCIzS9FtMHu4PKiM5yadzq3s=;
        b=lAYRDt+Ey86DFzuNosJvSFHD7sHt0x3FoYqI9DFi0s+OfYYdOgcX9k1srz6muthmUt
         Xw9D5cuwqQgmLrVOJxtmnyufy/IA8n0wlCuPaFjt7aWSUhI6weS66sIkphEsrXUOwFek
         ad7FmoNU6qebvB879P5AbU/fVrmrT/81J8hd5I10L4mKPyqedcLz2o0QvTxnUsiSonGu
         tk0FE5Ob/YUfj63uCYxzSJOj6HuGHxxfwdOP3TwP6eHK4gx++AUUs8BbTFYT9182knGe
         oE/q4GavVoSe+qzqSeceYtyDIvi0yZmP/LGqGvKnWa5yKFoOey3w0ql8t4ynnOG9QUsB
         PiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388548; x=1739993348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90xtQXplDDgqic1zh5pyCIzS9FtMHu4PKiM5yadzq3s=;
        b=DBUjP8vS2y3ZDoqqj+gM+Xq9Gf0j4JolrWrpu8FimsXh1DuNPpQ4TQIoPZBARQIuGy
         H4aXJ6OamGu0PjaaK4HW+1AlGpCAPhQt5pbnMAf6HXXhR16OYfUcjQV8tS+2RzqvEZTq
         zOXOq+NaX5ysYEcOlRR4rfmamnOkHrWQYUg26S2zhFc/awdqBhy7DKIQ3TGRKqkoMQoe
         G0A7kGjI+EkdYyTiAKgSMP+y3sUek2nUzM27sKjZM3k6l5Tqqei8/qD04nCQoNXa1Cex
         duFmaLIIE0EA/WjrJigC1eKMrTSpZ7oi3O/RMnFyh39KlFNQBBHm2JQWh/aqaRwmHkuC
         gJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGSTvI1PIp4x/h/MuR1FgI3nKOUyFLDVXOSBq796lnySkyOi9NtjELNgQiph9lSiKuJrkZVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGBDlmD5h+dYLGzUrR4gnmGkssQoHmyNW5zVQqv1M1Pz9G1A1t
	99oeUfOmuXWxwKJ6SsFzcWLvOiDTGMpqW4jU5FrGDDfsk2f0daWONhF85Q==
X-Gm-Gg: ASbGncvDQ5rhhCBfLAKqqydvsbTnNmJ9gvBAQUl+YXb3dCAdup9dw7TBAVqsYUebKbj
	HDbBp0XbpN5kE5EPyQb2rjiQeZ3UZU/6Knifl1Or3qPlmSXI8gHLJn+QH0Kv2GQ3QxKBaVKHY3K
	DpnRUOaybaSFQol1oD4tMMFnOEA6F6Xrk3mecQ7t9B8BvNsMsDjVkcMcLLSqYXVFusaYjfxe8Ae
	z5LizVym3mChoRelcwQJK6LHEKS9y6TEJuh0RlBw62hEVEjkFHm6MMcI7Kk9uP142xz9hkMSCYf
	+d6/efqkNAhZkZVgh2vIZBSa4jlHMWXjuCRYkr2qPkss8dmi+K7ao1oZ
X-Google-Smtp-Source: AGHT+IHLfOezdk5BSn4+DFX2gVHMThu18rsQ+rxEHfP0x3VtBtAvbY97jbS5iuQnq+XvRfVJV33ciw==
X-Received: by 2002:a05:6808:2447:b0:3f3:4128:42ce with SMTP id 5614622812f47-3f3cf220ab0mr2601984b6e.35.1739388548309;
        Wed, 12 Feb 2025 11:29:08 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f389fda9b4sm4534277b6e.49.2025.02.12.11.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:29:08 -0800 (PST)
Message-ID: <382fba22-d60b-4f46-9897-7f674221dec0@gmail.com>
Date: Wed, 12 Feb 2025 13:29:07 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] qmi: Implement QMI service request rate limiting in
 'can_write_data'.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739339173.git.gerickson@nuovations.com>
 <1cf82d1527078e71d7a64b4f8caa7c5adad680c7.1739339173.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1cf82d1527078e71d7a64b4f8caa7c5adad680c7.1739339173.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/11/25 11:52 PM, Grant Erickson wrote:
> Determine if we need to rate-limit QMI services requests to a
> transport-specific minimum request period. If so, return true so that
> the queue can be retried again later.
> ---
>   drivers/qmimodem/qmi.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 

Patches 5, 6 and 8 should belong in the same commit.  Prefer to group new member 
definitions with their first use.

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 00086578da10..591129c252e3 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -665,8 +665,23 @@ static bool can_write_data(struct l_io *io, void *user_data)
>   {
>   	struct qmi_transport *transport = user_data;
>   	struct qmi_request *req;
> +	const uint64_t now = l_time_now();
> +	uint64_t delta = 0;
>   	int r;
>   
> +	/*
> +	 * Determine if we need to rate-limit commands to a
> +	 * transport-specific minimum request period. If so,
> +	 * return true so that the queue can be retried again
> +	 * later.
> +	 */
> +	if (transport->last_req_sent_time_us != 0) {

Shouldn't this check min_req_period_us first, before incurring l_time_now overhead?

> +		delta = l_time_diff(now, transport->last_req_sent_time_us);
> +
> +		if (delta < transport->min_req_period_us)
> +			return true;
> +	}
> +

Something like:
if (throttling_enabled) {
	now = l_time_now();
	delta = l_time_diff(now, transport->last_req_sent_time_us);

	if (delta < min_req_period_us)
		return true;
^^^^ Note, that this is a poor approach since it just busy-loops the event-loop 
until the throttle time gate expires.  Much better would be to use some sort of 
timeout.

	transport->last_req_sent_time_us = now;
}

>   	req = l_queue_pop_head(transport->req_queue);
>   	if (!req)
>   		return false;

Regards,
-Denis

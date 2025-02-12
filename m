Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDF271813
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388652; cv=none; b=a8vSwOdVpzvkoZGsX1CBgheU+Xj0R6FSWifZ8Ujkom3ebjpLzrQNlNKH3CzkgwYJzEdMd9ck9rB9BkKV5hTbi+LSjT/zh6TrNoRQvvs7rEQTDTAWoKP7SQFkhL5+uPu855OYjxHMPu89DJOOiL2SOwXXUv8fNgsTWLL0H/EOk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388652; c=relaxed/simple;
	bh=1O1bTHcBOPpn4q6xaWxgPGL+9/0yb4MCG1OK8mi2CbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GbPu/h7upmslEYydrygZbesnotogXpvluwPGDDYMx0sCV1YZGozfmY0IgYlsNfcbJY1KuvSM54JTiKJMXHZsA6T6khw2TOhUgB+7J9mDskIHDAdjr9uPRA5YG1ldfx+SOmHJCkPln/qY/hkswpyce8SxnFpEdLWwfpswWya014Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqwHTHto; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqwHTHto"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-726ef4cba96so33337a34.2
        for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388650; x=1739993450; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fx0PkMsUCr+B7ubj6/0XaRyoIME1olhKdpGSWf9cRo=;
        b=jqwHTHtoJ0uMCr6ms6fscn9vZ19PUByxiFfYNLj9Jmnb35Ek6SZ1QYcYuWt8MSWnuT
         rxS9VCw5lkHLGKtlIioFfrjKLjryuyhqwyt/9Sux6hlBSd4Oc4TZoT3cu0J5YpNWVESB
         jxG3nH3PHCIYLaAaQJFosfB2XPxtkyg2yORu6wkUzfm5K8RzNjPZU5wWdhpQkqTznhIN
         3m+HMvhcTGsLqWAeyqFfT58o8xwqkEzYIt/QfgD7umGKgo8KzhI4hSptA3QHGLjsqtBN
         nSp9oe+l8YkXRksrb32togPZjiz950FcAOLjJiUN4hlHaoz5HOaITxz+iQs5JLLmOPKv
         JA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388650; x=1739993450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fx0PkMsUCr+B7ubj6/0XaRyoIME1olhKdpGSWf9cRo=;
        b=MSiZkhsv/8JZCMQbBm05gpNE4f/VkKrik4t0vt40gQywu0gao7Yaup8TjVItSUO71a
         2GMSEWnhduSX12Xadg8V+3Lt/6G34WjBRWVaK269onIYARbeaEnKy9YmCZBZ+z2pi+Va
         6oEX4UduLcmty9KXWUpUlrwNhMLDSzR4qvbgChK/l1iVTimQ0sU/neBiazwQ32NHBNnG
         zppo8KdXse0SJbIl9auP3rNSdehhEHFGnml+dTZreHVny+GZVVfxDb7cwCFTIbqVM7Bs
         /7xqIzA2tPvRqtk6ihy+DW32+zsjTnZ6l6k07dy+aEt3K3RmOKFeIx8EgJl9Sirpct8R
         q7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWuj9FwdYpPM42uFGNnS4jZJS6Mm6VdtR3YTtyA1g4i/7I6n+kLGbBPh4X7pyrue5Zzj3gp3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YybsAG+Nm6hrGvbpcGn830j4bQHvHpRAUZxjKmxg44xqAFcpvPe
	CECEnLFICK1cKST4sBsDgDC/XBzx2k4UuYH+NUa0BovnDqy9+EHJ
X-Gm-Gg: ASbGncs5W25gu99aaVh7nGkrsnlZZbq2pbDdjPTj1zJKijNmlbR67IAP9+KA5nyMtn/
	YPn0e06ce2J8qiWuDPzkCTi2+bfE/gYgYey94k2KATOlldz9pXztGNig7qV5p6bdR2mJZcXgcND
	LAnezUuqKffjeXWYb+WuA7kfrJj0/PksJw5cTu2mT8Y4IJB7N5pL6Z70DiXBicCitBshX7aX4Xx
	vAs7aeUM2GiTCCNqSK3p5ye8W6HtRHrqCQiSsqHQi45KNWjQZyt2dOo8rnfZOPsQIuaYvy0SS4O
	zNocrlaIfaE43KvuQTMwt/hZTsx+cgo2nL8iy2OByR+Z2da4XromDxu2
X-Google-Smtp-Source: AGHT+IEd7405PMPvyQdiModRRXdhWqMMENIyK4zDCDcWq0QRzHXDv+jcbZsP2hM9UGYropnQ0aGfEQ==
X-Received: by 2002:a05:6830:6f07:b0:718:1163:ef8f with SMTP id 46e09a7af769-726f1c35d7amr2827921a34.2.1739388650274;
        Wed, 12 Feb 2025 11:30:50 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5fcacd2606asm427410eaf.24.2025.02.12.11.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:30:49 -0800 (PST)
Message-ID: <c4f049bc-12ad-40dd-ac1a-7886e8fb7acc@gmail.com>
Date: Wed, 12 Feb 2025 13:30:48 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] udevng: Set the QMI minimum service request period
 for Quectel BG96 modems.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739339173.git.gerickson@nuovations.com>
 <5f9277b84477f13890620d4dbda3804881142946.1739339173.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5f9277b84477f13890620d4dbda3804881142946.1739339173.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/11/25 11:52 PM, Grant Erickson wrote:
> The Quectel Wireless Solutions Co., Ltd. (2c7c) BG96 CAT-M1/NB-IoT
> modem (0296) has a firmware issue where it can lock up and hang (not
> responding to subsequent commands) due to high QMI service request
> arrival rates. If the vendor and model match those, then rate limit
> QMI service requests to no more than one every 2,000 us.
> ---
>   plugins/udevng.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 64875a47752b..e7cf494a70ff 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1118,6 +1118,20 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
>   
>   	DBG("%s", modem->syspath);
>   
> +	/*
> +	 * The Quectel Wireless Solutions Co., Ltd. (2c7c) BG96
> +	 * CAT-M1/NB-IoT modem (0296) has a firmware issue where it can
> +	 * lock up and hang (not responding to subsequent commands) due to
> +	 * high QMI service request arrival rates. If the vendor and model
> +	 * match those, then rate limit QMI service requests to no more
> +	 * than one every 2,000 us.
> +	 */
> +	if (g_strcmp0(modem->vendor, "2c7c") == 0) {

Please use ell for all new code.  l_streq0 or so.

> +		if (g_strcmp0(modem->model, "0296") == 0) {
> +			ofono_modem_set_integer(modem->modem, "QMIMinReqPeriodUs", 2000);
> +		}
> +	}

The {} are unnecessary.

> +
>   	for (list = modem->devices; list; list = g_slist_next(list)) {
>   		const struct device_info *info = list->data;
>   		const char *subsystem =

Regards,
-Denis

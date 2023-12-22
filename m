Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD62C849
	for <ofono@lists.linux.dev>; Fri, 22 Dec 2023 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dylq2nRK"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ba9f24acf8so28886239f.2
        for <ofono@lists.linux.dev>; Fri, 22 Dec 2023 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703273166; x=1703877966; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjOY/h9di1AwQQDvTvXd+FRUHJQ4u+QgtT6LUgMUiVM=;
        b=Dylq2nRKSrge/P5YiXUUiE3H2j76BVJO/FTbvkcaDKm258ObChJRBSp9SIbYbkjiEe
         B7AUA8zv4Y8ZFDReo2d3ruaMUzOtzraHQOxUSNUEfnhA6ul1499yJn85J/jOzc0JcZxy
         bDBPJdD6F5qSfdBlH9avdEldhdIMdGdjlqumXUGc79pmmrCq+zT9BPElBdiUQUwmAPHB
         tFygNXeTFZRaeoKx3SzVVb7AgWzF8Kfn7+yjjIFGaodwEaN4cYWSmbbHzEQ06mpwb8lK
         Yy7xdv7TY/HEHNHS+4YLiD1T87yenEhcwwQMpfGVweT1ct43dzh2dKeGzu4F+PjJiLrg
         cNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703273166; x=1703877966;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjOY/h9di1AwQQDvTvXd+FRUHJQ4u+QgtT6LUgMUiVM=;
        b=SD0FnkG9M6NQH4VLEiULMHhwI+7l7i7uDzX/rGjwClyGbec2/fNqzODe9MCfYOPD2O
         KQuc9V7OCR6TxavpQOC84PDaPaxkRSuPCUGjO7aZbun3U0LN9vqf5/F40mXLdwSBHZf9
         usuTBwm58ltjTb1ibc+GYt/u/9H4tknTLUEXHO1rLkk88i4UtXJqr5ZELZ4nCkfq87WV
         DnUp/8XLB2fbPD3gY49tH/6IoKDYfD0oJSWlhYUAQliZPTSHn/rWK9/kqgKZdzm4vwX4
         0zG0L/kqaH16p+iCa178cOLYyZC60uJiRNOuCMqHSBIKmDFa3mkIVDtdkFiPXQROYYrI
         C1GQ==
X-Gm-Message-State: AOJu0Yyy563Du3/hCq8aVH23AByq658AMhkSfHdcQeJk+B9mDmPivRAA
	PMZxNxwOQpY/XDwy8N/o2L5JjTsnnns=
X-Google-Smtp-Source: AGHT+IHFyzN2LDt1jAoFucVMWnDzn29C5G+tN/LQVZi4avzGyc9pYeK263lM2PrRqEGokcBVoaL5AQ==
X-Received: by 2002:a05:6602:2a53:b0:7b3:ebe2:a89f with SMTP id k19-20020a0566022a5300b007b3ebe2a89fmr2745078iov.21.1703273166404;
        Fri, 22 Dec 2023 11:26:06 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id bq15-20020a056638468f00b0046922414bd3sm1188327jab.87.2023.12.22.11.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 11:26:06 -0800 (PST)
Message-ID: <aa3428d5-1611-4b40-953a-273b2b9b84f8@gmail.com>
Date: Fri, 22 Dec 2023 13:26:05 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] smsutil: Check that address fits in memory
Content-Language: en-US
To: Denis Grigorev <d.grigorev@omp.ru>, ofono@lists.linux.dev
References: <20231221141638.19774-1-d.grigorev@omp.ru>
 <20231221141638.19774-2-d.grigorev@omp.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231221141638.19774-2-d.grigorev@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 12/21/23 08:16, Denis Grigorev wrote:
> This addresses CVE-2023-4233.
> ---
>   src/smsutil.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/src/smsutil.c b/src/smsutil.c
> index 8e57a065..e9551b0d 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -647,6 +647,10 @@ gboolean sms_decode_address_field(const unsigned char *pdu, int len,
>   	out->numbering_plan = bit_field(addr_type, 0, 4);
>   
>   	if (out->number_type != SMS_NUMBER_TYPE_ALPHANUMERIC) {
> +		/* BCD number consumes half as much memory */
> +		if (byte_len * 2 >= (int) sizeof(out->address))

Unfortunately this is not precise enough.  The AddressValue field is limited to 
10 bytes, or 20 bcd characters.  sizeof(out->address) is 23 due to UTF8 
representation of certain GSM characters.  It might be better to check addr_len 
above instead.

> +			return FALSE;
> +
>   		extract_bcd_number(pdu + *offset, byte_len, out->address);
>   		*offset += byte_len;
>   	} else {

Regards,
-Denis

Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06582627F5
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387720; cv=none; b=YrBj0SOz2y8KAWtC6a/8LKV/O8d91jF2BVCLYq6x0I+MW/KTnocVnHazH2lmO9VP8Z1nJ/0+XPAnz5sDmwPHm35FnJGwz0WOYR2HcMI2RTWITH2yn7gLytz9wt2EwH7r5YPdVcqoZsshdBtIrhxT2Ezd6FbWiqxCshLUZOkvOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387720; c=relaxed/simple;
	bh=wMLCkRYGmZYnjhrqqqRoUnG/AFYLDuIYQms0v8A32O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k0ZsLi6RzgigV3vfiYwN/lyafhXAECNRZtj5Zx3EPbDXZivjJUf5hoioUklWnwA3tgBw9j5BGLAXwEJfByH53mwlA8eCHhW4ttcAMYjbJtQreVDbFWTBcgFi/f9fcSCXbBytKIvx8G9wsR/+lxC0ndes20ncrDolz3CpljCEgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH8w0n9r; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH8w0n9r"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-726ed359c56so65870a34.3
        for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387718; x=1739992518; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANPtbXwzrHB3ugeL0U9mj11yFgswKilxRXWdtFD04ks=;
        b=lH8w0n9rYw6ZJ6q7zotFXvNjHp3OcBlrL4j5AlhUcL8S3EAucqUNNyvg7P74pYUG0L
         WpwRXtCt6gtRqGpfjxQhZ0AJdy+GYPdw3FRaSw6L5ubRwgZJZ0INMg76aAfvDQ9rH7Zf
         IPYzrufWsJREtleX11hFe37ifLjl0XwoJZOgCHnzexBVVMyZpaIzXxxy711W1L1W1G2t
         7MWmLh/kL4J1x91LwxmGflx1UmQ/M6W+3hqNzODxILNeTzbVpPb25/RFPqA1+AW6U932
         TeH0sn7Uri61MV9ox3jILkbbb8ExMHxlK/LXKpIW4SVN0nyRV3AdRG5Z18P3/eeI4tOT
         Ibow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387718; x=1739992518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANPtbXwzrHB3ugeL0U9mj11yFgswKilxRXWdtFD04ks=;
        b=VG69Oei1GPRy1Fk7PqjRV4geXItuQulxDhs4M7ro6K/a7NT6VOl9QaBzQMh1opHpQ1
         /38GITBd2F5L1TvyGbgYCsWYrZoOYVyGsdZix7zaOiYimvJC+Y+UAjAippRum63z/7yq
         OxMJR9Ej2ENF7+r5UnGfbon9zof1aA27LoGcKYKsI0z7boI5pP4W4rG6/5+jsOvDGBuo
         QBtkw1hETkTqdAhpIBL2Qzzkorctuw+mArDUPQJzwP6OMS2Wh2A1jRibrvRXdJuyEZRZ
         BPkqePM93oYMe2KlbOwj4AuZIY9ULhuDgaj8ujFjGinNTJ9aMrvEbm0bj/YPCBEAtHkn
         p63w==
X-Forwarded-Encrypted: i=1; AJvYcCXbQjQHjLdEDZl2Go0TLbVtqP2KounvsUTAGWvGf5ogxtbaFpEumLvw+w7W5ZhMavz2knTikQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLKJnYI6qwFgUM+dFKT1rM6H61oGKeDrOaq8JgTzFjp5G/3zHK
	nQuf25rC3Et3UjxM56aum6ZaaQDrR1K/U7MhrLj1JzinqNkuv1++BPXi+Q==
X-Gm-Gg: ASbGncsx5NIXWQdor08zCAK92i8DsJSxIt99x6HQ+aj0yUlzZteiek0YhRM0q+yptIg
	8bWAYf9AxM7Vdn7merXaMLyfursZPJl6B6ztL7vi/ZT7rKArJDdO6Qrz/a/esR5clPyRue27sbj
	QJBrMuZCtLLUyJPh9cObNTMGP112GsubZmGelCuqjEgJJbU4Vv3acV5yMV5ehpKqOSJ41XSuAx9
	FbVVSqXH8110JwNpqqz3bmY7EczCaAZ4qwzGUvL4Cmxac0l2DWk87MYOWxSpmoY0mnzFv/3Guj/
	/fO/0JZwj7dPZlLPucJ2+oz3o/VPWObRk0QLcMQlQfolUUW9He1jhNss
X-Google-Smtp-Source: AGHT+IHntunfOl+AbxE/DknDb2LNOdWnLIYGH81+YLJ5jUDVVcGeLCpw1Q74EVxhwFSzfkQ0caCBYQ==
X-Received: by 2002:a05:6830:2107:b0:71d:f3be:43a0 with SMTP id 46e09a7af769-726f1c358c1mr3052454a34.5.1739387717735;
        Wed, 12 Feb 2025 11:15:17 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5fc76f744fesm3346549eaf.21.2025.02.12.11.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:15:16 -0800 (PST)
Message-ID: <d2b9a654-790e-4629-b1c3-53409ca694e8@gmail.com>
Date: Wed, 12 Feb 2025 13:15:15 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] qmi: Added minimum service request period property
 string.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739339173.git.gerickson@nuovations.com>
 <78fcde63abae5551db9893dbfbaca842e4d38b32.1739339173.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <78fcde63abae5551db9893dbfbaca842e4d38b32.1739339173.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/11/25 11:52 PM, Grant Erickson wrote:
> This may be used by ofono_modem_{g,s}et_integer to get or set the QMI
> minimum service request period, in microseconds, modem property.
> ---
>   drivers/qmimodem/qmi.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
> index 69698ee049c6..0c786ed065a3 100644
> --- a/drivers/qmimodem/qmi.h
> +++ b/drivers/qmimodem/qmi.h
> @@ -43,6 +43,8 @@
>   #define QMI_SERVICE_RMS		225	/* Remote management service */
>   #define QMI_SERVICE_OMA		226	/* OMA device management service */
>   
> +#define QMI_PROP_MIN_REQ_PERIOD_US "QMIMinReqPeriodUs"
> +

This doesn't really belong here.  Properties that are communicated between 
udevng and gobi/qrtrqmi are documented above the probe() method implementation. 
Also, maybe 'RequestThrottleTimeUs'?

>   enum qmi_data_endpoint_type {
>   	QMI_DATA_ENDPOINT_TYPE_UNKNOWN   = 0x00,
>   	QMI_DATA_ENDPOINT_TYPE_HSIC      = 0x01,

Regards,
-Denis

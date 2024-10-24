Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68B8614E
	for <ofono@lists.linux.dev>; Thu, 24 Oct 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779839; cv=none; b=sR7pM/lNTkY6HZIxCrW+y3id7I+y6QC5hao6b/Hggem3K0M0o/yDtbNdL1slPwf6XEoS3I2w8GC5yJpGPFjPznS9axax3VeVUc/+bo4cbIeXTLydS0PAQepdK2uydZg7WfG4jha5vF1MC/ggfQ9alAkraFSBEoQERAQKeva+dcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779839; c=relaxed/simple;
	bh=oYTPWzmZscJmhSDyRbblr3uHV9BRF+EFG+mBljbyS/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bftW33KC0YAj3/rDLkEPIWTeJTQrvQxTE7GPrVOqgbNYqCTfoCFDM6KlCGpoLjCERt5wPmskH+dHHYcMtHWG7OyWgSDV/k6EaJYU5wKQfX7Cjz0ZTi0et+UkKayKGInP5r13uTd/6Nyudu/+FdqIO3VG4NQiIIKRf3j4zY/QgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A68nWvcq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A68nWvcq"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288661760d3so589663fac.3
        for <ofono@lists.linux.dev>; Thu, 24 Oct 2024 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729779836; x=1730384636; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k81yBzc9JBIX7lOASh/7AxEQ/06PIhl7fcSZYZKdOlU=;
        b=A68nWvcq+Y/mC7YITqkayvZEkviaO0RIrzNu2n8vN01XZ0jlx1xRbDTfU8eKk+Uu68
         ovYqTDqWZyURlPosJMutwquwbw0WGzhXOHjVzkcaS8aUFGsnMKxwYWO1WLgCz0wJIHbY
         /n2uzrvXHyd3FL5qvqUgRJEuVDZbw7IH8jiJzO+4fvrw4vOp+GBmQFmNWg+tBTZQ9Eia
         DbUhCwv8JHl5YYcU0HcHTR+h3RRgutbB1CYVvJsFdbyieqTTmsMmWJ9ehszDYvNaCtGG
         f+Fo4hFWE22H51Iv4oJGkaXJGSspxdKkDNBTgewJXyCMbV9LdyL1wj+4q2Mj0VfadNoJ
         jxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779836; x=1730384636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k81yBzc9JBIX7lOASh/7AxEQ/06PIhl7fcSZYZKdOlU=;
        b=lx6EXvxc3BT88uzzO/6Yrj5xXRHYq4wQNUU01b1EcHOe6OXAhvZog5U1cVW9SWU3Yx
         Z4CZk90KkEvOYGmqJlSGaFF73pzr7BSBldkf0Mi0BPnXiN1RY7cdUWIDVGFb6Ly9TaqE
         sbvhHHRgd2fgdnqNKPORUr1fZf2K2Kzcoh/GZbaOCLct2SJLtFooQfa/hHDbmcYtUeWf
         Nfnj+BPMo2fSJmv1niV1xozY9eMJaWYJtQ3E4Lr+s/JQHeZua5O6SAKFdZ0QFXEzzaCx
         IrBsJuY22HwrVf9kp3G7CwfX9twZ3ZvBG33Scl7bciICXPxb0T2ywCnPISi5wgCVRsXA
         9zvA==
X-Forwarded-Encrypted: i=1; AJvYcCVmMNVoYmyfzaKxTy6/0SVgn7PPEIB0S6GBBtXLkSTQzrtFFVbrDL4ffo8y6GO0cMlQ3J/QJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAAMV8kzCveQlR0hRkUl1qs5OnM+Mi/H0gXjpeHrfioTVKU0dx
	/7rDM/zIZqeDGsKCfo8/FbExhkD59OAjdmMVsX6qf3uM245mNsdF5D457Q==
X-Google-Smtp-Source: AGHT+IEQI2x7915HKkJDB3uqwazQ1fSffA1XeJKAzGrnJJW1Lmk1yjIl/+2FSAjBJPMxApep1sn9Tw==
X-Received: by 2002:a05:6870:15d0:b0:288:3d43:8aa2 with SMTP id 586e51a60fabf-28ced2ee5aamr2080395fac.26.1729779836394;
        Thu, 24 Oct 2024 07:23:56 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-28c7925cf54sm3068864fac.18.2024.10.24.07.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:23:55 -0700 (PDT)
Message-ID: <631ae11f-5267-402e-bcf4-1d968e15250c@gmail.com>
Date: Thu, 24 Oct 2024 09:23:54 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atmodem: let +COPS: report access technology for SIMCom
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20241018072737.1343332-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241018072737.1343332-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 10/18/24 2:27 AM, Sean Nyekjaer wrote:
> When using the SIMCom A7672E-FASE in gsm mode, gsm is never reported as
> access technology.
> SIMCom modems is showing the current technology via +COPS.
> ---
>   drivers/atmodem/network-registration.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
> index 46b8512a..c841bbf7 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -353,6 +353,11 @@ static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   	op.status = 2;
>   	op.tech = tech;
>   
> +	/* SIMCom modems shows the current tech via the +COPS
> +	 * not like other modems where it's shown via +CREG */

doc/coding-style.txt item M2.  I fixed this up for you and applied.

> +	if (nd->vendor == OFONO_VENDOR_SIMCOM_A76XX)
> +		nd->tech = tech;
> +
>   	DBG("cops_cb: %s, %s %s %d", name, nd->mcc, nd->mnc, tech);
>   
>   	cb(&error, &op, cbd->data);

Regards,
-Denis

Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE442A91
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379384; cv=none; b=iq2kJdbqhpIayuaYACXo3oyCIJWwFzXLNBK14ecnsaGljQFYODflDf+I28kd54FoySuZZmnOvxsdjX7cV1f82Nw4LlR5eiVHfBz1DpBeFgd6WJy3sdz8+M0zq3C5Oka5M9MtwkuguYEPopSn4VoEuTG/HwlncQ+S5oG1BoETRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379384; c=relaxed/simple;
	bh=EOBmQ2+Wa2uLJo+WJLBmXY0d11LQrarlxWlnahftY48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxrsWvyFN33dLtjohSsuXrGbNLehiJD6U976nFJhZfXp1dpvG4mf21W40gmnTp5nXXmP/hrot7PuhjBKp2IB6cq65xvfZi2KWKgKIX6MqBv2HzYFo2AqzH1YKV+l/s32wqA81CCszXR8QK+o1RpQzucVmfqJmRNF9s4zfP/+Zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9gilw0k; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9gilw0k"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f1d1068451so43166eaf.1
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732379382; x=1732984182; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sW4z/ayJzbvlyaVcve5v4mqovlouWZAwsh6URFzk4s=;
        b=V9gilw0k5aAHhObOeNBqnAcBALwYbfZCjjpvTRnXeYGVj1x9QkzM2vEAyh2Q2o2RMQ
         rj8QNz71zZuAH/pVpSrpFbL1crIIrq57VBEVH+cWfMdh9Cy/Tm4I4UuQeB7gR/DfFbKp
         E3/BDM0WdjnMopB1vqD6FccaMs9OZNYqbqb1+TJTOTKVMZaqM0D7QzfxEGtUKEU0xj+y
         7bpMgjq8KGLFX2RQ2YL5mN0FdV0PKA7A0hhNPth1Su0gqlH79n1AYyByz1Hbhe4LX6Nf
         XNKKWYp3yAuh3AG6MiEdbbWSK5A3dRWGRmtOxiNrvaz1QPIht9r5IBhpppEQzIucErJh
         tlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732379382; x=1732984182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sW4z/ayJzbvlyaVcve5v4mqovlouWZAwsh6URFzk4s=;
        b=RpIPOdW0Z8Mff04bqbEXcFQDHiQAv1bcUvl/9absXKmFd6zH/xdxTbqVyAAdmHutIm
         DyHQzV6gWjWzbsM9V/5YWBtksXkrTbrg+KNspXBnYVBTaOw3FEsZpKx5rma/sU+qR6N/
         JaknOzt94h6bllMlMH8mbCHO0ycaujNxFa0+XKlQgX86/KMCv6TlFCEpI70TlEByCTa7
         6Y2/1ABSjdSVqe+gd7fctuDsuhp04iLodNdyXICunOH1/VzBel4CG3LyWcjDKc5v8WyT
         kyuvKnBV3n6OQnfhvOfX1pKA7RIdo/UDUt7IIq86wBRZOVcnKtSKVRRqbMQrxyptsZkQ
         eZqA==
X-Forwarded-Encrypted: i=1; AJvYcCXUvH2T17XYYoUhdCh5KioyJ3mR0uwU4EdSSIRIeWkIhYmD6d2yIBaAitf4t09heFxfZSsXpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1NTF69HVGr3gVlBG3err04bVkZGlNIMtYOrNlTJSLHs78irme
	nmOzxRT2TV6J62iqKPlv/pbgLrWnM8Z6HaZbextEKksW8CWq8w1h
X-Gm-Gg: ASbGncubh2EBMsYd0+Kj/LOFsFgUW5FawFXrJJF494F0MWZByVBvdj2FbgKHNHBwQsG
	5fwpJrNS92ClREIwpYebmd0cecy8FDPmMHggIVm5YoqFBPzbGyK4u5KbDJNdY0WYLN9oz5lQsqj
	UdA+a8UoR+i2R+nKoC1AXyENfts95eyimjZW7CtnpgKAusC+3AMNb9+MmM7xAw1eSeiDOol7MTD
	46ekhPq9FmyJsxHH56q0x172GgWboEMrvmM6RX+lNfBWgcXEnroJDsAwM+jkxrG7vGttcAxdITv
	RlXYck94QRLEiXo=
X-Google-Smtp-Source: AGHT+IHUnQqcew1GTa6ytEqoR2KFtOiuh0KJd5rIbItTH8g+li2jC81mDUCuiDf2/qEkv2sL7YpcZg==
X-Received: by 2002:a05:6830:1297:b0:718:a89:496b with SMTP id 46e09a7af769-71c04ce40c8mr6240009a34.30.1732379382445;
        Sat, 23 Nov 2024 08:29:42 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5f1d1ea74cesm78495eaf.24.2024.11.23.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 08:29:41 -0800 (PST)
Message-ID: <933bae93-52ea-4a01-8814-ed487d46777f@gmail.com>
Date: Sat, 23 Nov 2024 10:29:40 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qmi: sim: implement change_passwd(ChangePin method)
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1732352735-31944-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1732352735-31944-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 11/23/24 3:05 AM, Ivaylo Dimitrov wrote:
> ---
>   drivers/qmimodem/sim.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/uim.h |  1 +
>   2 files changed, 77 insertions(+)
> 

<snip>

>   
> +static void qmi_change_passwd(struct ofono_sim *sim,
> +				enum ofono_sim_password_type passwd_type,
> +				const char *old_pwd, const char *new_pwd,
> +				ofono_sim_lock_unlock_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data = ofono_sim_get_data(sim);
> +	struct cb_data *cbd = cb_data_new(cb, user_data);
> +	int old_pwd_len;
> +	int new_pwd_len;

I changed these to uint8_t since strlen returns a 'size_t'

<snip>

> +	switch (passwd_type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +		pin_id = 0x01;
> +		break;
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +		pin_id = 0x02;
> +		break;
> +	default:
> +		CALLBACK_WITH_CME_ERROR(cb, 4, cbd->data);

Added l_free(cbd) here

> +		return;
> +	}
> +
> +	old_pwd_len = strlen(old_pwd);
> +	new_pwd_len = strlen(new_pwd);
> +
> +	/* info */
> +	info1_len = sizeof(*info1) + old_pwd_len;
> +	info2_len = sizeof(*info2) + new_pwd_len;
> +	info_len = info1_len + info2_len;
> +
> +	info1 = alloca(info_len);
> +	info1->id = pin_id;
> +	info1->length = (uint8_t) old_pwd_len;

Dropped the cast

> +	memcpy(info1->pin, old_pwd, old_pwd_len);
> +
> +	info2 = (void *)&info1->pin[old_pwd_len];
> +	info2->length = (uint8_t) new_pwd_len;

Ditto

> +	memcpy(info2->pin, new_pwd, new_pwd_len);
> +
> +	param = qmi_param_new();
> +	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, info_len, info1);
> +

Applied.

Regards,
-Denis

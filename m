Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CB26E16C
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526312; cv=none; b=uOtQmnkm9LOEFe1eVh9tRUlrfijHlVNazTcRTP+MSNUqId6XgykzzYOeBzsvgg+5aQWJ9LGZcttpHKj63xIIsjmQvGLQ3huJTweUa0MXj2A7vt9VXINabkMwXlez/5RtboCG3NMQmgc6MVgD9hskOkTx1LIJfbFvGTapCzz5wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526312; c=relaxed/simple;
	bh=WPfjDvV7KpNkE5tvPCB4q7Id5WZrWNM1AiV9viKlkNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRxQVL7ympIQuiIzYLQ7PJvW7MXqUfVA7NptU5HUtM121gmlHWx7AU8MGkh4bffjzyuIml0H8/hpnMGJL4eyebLLrBQNiCdASl7QUCJUPkUeYKq14XpbsfgahhrevesX/MtVe4cXOiNChzTAUaShA7W1YSNzCoDCto45lr4pYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im4pekBL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im4pekBL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de1084868so22648475e9.2
        for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757526309; x=1758131109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNmmMII56h0DNvakbBl+Q3Sfu+s7QksxNjelyxKXA8A=;
        b=im4pekBLdGddGJ20g8HeqZzefG2YfKtxOkFOgjJxlIKqvZH23j+8fOEB4mAPzVxNXW
         uWijum9ncTjQuRDjn5EOR2e4bdLhgO+81TWo+1zxmOOd6XGeyJgs4MjXJMmmFOPZnrqE
         myDk2cnzqbQs6mZ/ZOsz0XZ+cQ1LkjNDe8VKwyfFNjO2yuynK4SJezoUy2p+yzjmkTK+
         77Q0BC8fFc2fA7X907xpuaVQUvuw1iOo48IaxIissfezqMqv3R3A2skbfIv1wXauRK7g
         jaA1UuHVw1TZcnM/m54AuxSXFAiCEbF3bIfKLFbSM0AxoxihlWoSKEFDoEAQUlMTwyhH
         hJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757526309; x=1758131109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KNmmMII56h0DNvakbBl+Q3Sfu+s7QksxNjelyxKXA8A=;
        b=ArroL5vmW8wYud8CBFUC3JGlt3JG+xlEY0cw1lNSY91QhhND7DshWzP+IxhBsOHX4T
         i7P7s3Ow7qY3NwVys3h5u0CeUaJZxrlVQMPqrGXd+xZknwMJF+6IrSO8PeebUfrRfuLO
         Xnik4U6URqOVvYdQ5Z1uS6mlTKqhMLfg74O2XI9sayeSVdMLWk3PJYzbEDR9TtXsHdTe
         pycnwWPOKSXG1iYMJHBvmFn/Xv1RysdaZC5tZwglwXuJgtKwmOrnL3xpLWGiP4OS6X6+
         TSAGOfZNVAmnxH8sKV5jh0Tkf4JuT0AS5oWHX8HdsyHmi+JBxSbP4IF6NiannWC060+g
         pCmw==
X-Forwarded-Encrypted: i=1; AJvYcCXsH2wt4nvCWmjJ0tn+jU5mYSIzxj5rN8A8x1O7TqSp99w4CXLF97yzUC2Dg4+ciPPqOVExRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/V4EMfCi3hYtsj79aPhZ0JNb8SKOFBlDO0owk9yjsTVuJIiz4
	1iirolbNAV0uZzvSZFy0j4uSB+71BuTulhQ0oFRlUaB/zj4e4HxeiXa+
X-Gm-Gg: ASbGncv6wSD17+PewbVEh2TXu6cDiCYn93iPrq1orsEb4w+c3hyTFLJKap/mpRCw842
	xv2NmeHFbeqLjHR0RPE5AHwCK9U0g+oB8gUlIAf4inU0gl89Y6pje9PNCf9z/wI8mRwxnjxliOT
	EbNWIVX45j5qO8FxbQF1t9Y9KXBDG1L96MbGr1KhtirAqWQpeOatYhJZVkyBU7QOojNFBbGM8i5
	LNmj+QC3ar+JsIICjMcwDQfegpQrvNCrQCoWaPbUFJ7kDK/T7KUmk/Ueh6cdmWgSEC2YN+l8pXG
	BkH0aiIFTeeD/1jKSpIaYNfXJ4Z2MoiZEIY7l0RV5BDBmejYyCb0T0z7IZstzRt9D+r5hY3FI4P
	bOsVign1kIxVIAo7Nfvj99ZSHjTc2eXDL
X-Google-Smtp-Source: AGHT+IHza8fiTk9Lo6eJ/Hh2o0I9rD/c76vnMalG1BM0HSOu/Nlne84Jvt4cdK4eK6HmnjWAXQxliw==
X-Received: by 2002:a05:6000:2186:b0:3e7:4071:186e with SMTP id ffacd0b85a97d-3e740711d5bmr8567678f8f.4.1757526308323;
        Wed, 10 Sep 2025 10:45:08 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.242.93.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9cdbsm8143021f8f.16.2025.09.10.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:45:07 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: adam@piggz.co.uk
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel modem ceases working
Date: Wed, 10 Sep 2025 18:45:04 +0100
Message-ID: <2221614.9o76ZdvQCi@adam-laptop-hp>
In-Reply-To: <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
References:
 <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
 <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

Is this the same/similar issue I reported in Dec 24, where the pinephone modem 
stopped working between 2.12 and 2.13?

Thanks

Adam

On Wednesday, 10 September 2025 16:31:05 British Summer Time Denis Kenzior 
wrote:
> Hi Timo,
> 
> On 9/10/25 5:59 AM, Timo Ketola wrote:
> > Hi Denis,
> > 
> > Thanks for looking at this!
> > 
> > My further testing unsurprisingly shows that my hack does not really
> > work. list-modems looks better and the IF gets IP address but actual
> > traffic does not work.
> 
> Yeah, looks like the raw_ip setting isn't being reset back to what is
> expected.
> >> What kernel are you running?
> > 
> > 5.4.78 with RT patch.
> 
> Ugh.  I really have no desire to support kernels pre-5.15 when the
> passthrough capability was introduced.  I also have no hardware that is not
> 802.3 mode capable.  You can try the following patch though and see if
> things work again.
> 
> Regards,
> -Denis
> 
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 52ead377de7f..1b77e5e32ed6 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -665,10 +665,21 @@ static void set_data_format_cb(struct qmi_result
> *result, void *user_data)
>   	DBG("");
> 
>   	if (!qmi_result_set_error(result, NULL)) {
> +		struct qmi_wda_data_format actual;
> +
>   		if (!compare_data_format(data, result))
>   			goto done;
> 
>   		ofono_error("Setting Data Format had no effect");
> +
> +		if (!qmi_wda_parse_data_format(result, &actual) &&
> +				data->data_format == 
WDA_DATA_FORMAT_802_3 &&
> +				actual.ll_protocol ==
> +				QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP) 
{
> +			ofono_warn("Modem seems to only work in raw-
ip mode");
> +			data->data_format = WDA_DATA_FORMAT_RAW_IP;
> +			goto done;
> +		}
>   	}
> 
>   	if (data->data_format == WDA_DATA_FORMAT_802_3)





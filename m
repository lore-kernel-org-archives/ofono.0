Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493A1BEF73
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894842; cv=none; b=A92ssSk1Qq7hXdKgY0md+PD9e/3Pug0J9Z4LOM72mnQp1GMBWpMmyT5vCSZQdBqcDrir+oK1VOrTsNtmUDOCVtd1yDKiryORDGWq1USP7qUzJYV5Ey2y/GRaVYnaeQq6gI130BQDErgu9i6hAARBsd0+UStX2Rk3NJ+ufDnPxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894842; c=relaxed/simple;
	bh=oCYFSX8PmyO9YocjYhLdZNIcXTHwBKhJgI31LEgjnT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ajj5tCdM3DcNotCSdZKFeOI8mpgiKLWjcdPIb1oNhTFx+1KHDOZfQrJ6C7iaJRrsgh4TSPWfWq5a4l3vSl+s2ff7mVql7ceUG00cG+tAXxeeRMsAsndrpT9R6xXmYBfb3g2QFO2q3pnfhnVGqUpVcoPVPwIvLUzy/Gn8PgOrBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Naniya8O; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Naniya8O"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e181fb288so320670a34.2
        for <ofono@lists.linux.dev>; Tue, 10 Dec 2024 21:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733894840; x=1734499640; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjlC1rkc+oRx7LPBjgc41zWOjiXvwCqQ1IdnkG/Ayk8=;
        b=Naniya8OPboHNL9c96rdfQjKttbKfwnMt/rxVe3J6bfex//rows3gyrT29qNZstpId
         vSWQCfUY+0/bPKGOW0HXj2m0yDw/eNL7gv69NVEXiNlWafUD4UVksrxbBkGGj/CwtqQe
         4iUCb+Nm+bAPQNaggfNsiQgb6v1bg/skg7p4GW6JC1OPEVZEJXtc/72YILtxP3DOoP6e
         Y3WPZ87bgtVLgv5n42XMcQdqq/WAa8i1LoouI3W4VYnapwYKTDyZQlA6Vz8BJrI0aLJj
         SOAD6umjpvAsW+qUFyFWKGMmp5wdUmYDqIBODlBVsr80KeTzkO2jKmwTEWHrhFLtJh6t
         cWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894840; x=1734499640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjlC1rkc+oRx7LPBjgc41zWOjiXvwCqQ1IdnkG/Ayk8=;
        b=Kxzv2VarMJQSlzfd4ArfMrUhk+4PJtu3FU+XnNLBtTaz5KHqj3h/2SK+jvdGPF0Ij8
         hA1l4mxmJn9LjxjKeABJEorD9FlE/8sbU8324X8pouGN05JxMMnzbpQEHhnv/dLI6YqR
         QgIDaTB6DOjvsySfcW7v21ap1/q+LTdQjkJWk6b/7mWT31tjuN5LXdbDAsVMMfBhiTX8
         g6I5CKIHYMubUsdH8fRz3QyaQRfYhdmU824eTAtvWg1g2gNqdYMwBOmVWFrK0n/PLF/R
         tSxYg84a3k7WD8R7DZA2nvApaIraga9GXIZGMr23+9oKqPaZkqiQrpQX9UZU1WJiSvcg
         1NNA==
X-Forwarded-Encrypted: i=1; AJvYcCXfgfyDhivornlk8gu/g4NWBv5LK5aCOet1rNQ78o9JsaijkO0lsNat/mG+qs1pX0NKqCjWMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP6dssEkNIX6BWRthv1/+TCVuNr0dIAjOHr2FvhH57sAQgFy8+
	tIRi3RGA194Cun/Da8s38NVCE3OFW8mbkk0b/eDwP9bpvvJWY0OC
X-Gm-Gg: ASbGncvjyIuiEDf2V0CnUUKoE70uU3fKxQeeuNUGiqenCT5gUmteeyMvgsWy7Mafg1Y
	k9q13xtEjdftKIGVtczz3DCiPt+7RJUufECRY9HCcEkQ2iyYJ+uoPyZ86BZpxBySOd1G9OPE3yW
	BxpcZ5uxjlb5pYjinUvqEQGX6osaEsr1F1i0OeB1am6xo5jKyQGKflOv4uHugZnGHE60ouF/gYX
	LRc7lln//vZVyB75YC0rmLpyxVqa96XWl7Kf2K8X0BITFeDcJ7/RUhP8GQHdC8EyPns8pGil/1o
	sVbuZmFvtE25S4pQftU=
X-Google-Smtp-Source: AGHT+IE6JyU0ZmyJCnmG1McrWzf3dIBZTFi61iZKGLbJUz73CLoLkVwwfR3LuRMzc5fsUTUvvtqkwA==
X-Received: by 2002:a05:6830:6e97:b0:71d:eb02:bad6 with SMTP id 46e09a7af769-71e197d536cmr759859a34.13.1733894840055;
        Tue, 10 Dec 2024 21:27:20 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5f2a9d525f2sm1848785eaf.4.2024.12.10.21.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 21:27:19 -0800 (PST)
Message-ID: <f7e7e80b-84e8-4873-8cf4-3e66ad4760bd@gmail.com>
Date: Tue, 10 Dec 2024 23:27:18 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qmi: call-forwarding: fallback to basic forwarding
 info if no extended
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20241208113410.251171-1-ivo.g.dimitrov.75@gmail.com>
 <20241208123946.255405-1-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241208123946.255405-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 12/8/24 6:39 AM, Ivaylo Dimitrov wrote:
> At least Motorola Droid 4 does not support extended call forward info, so
> fallback to basic
> ---
>   drivers/qmimodem/call-forwarding.c | 81 +++++++++++++++++++-----------
>   1 file changed, 52 insertions(+), 29 deletions(-)
> 

CI complains this fails under clang:

Fedora (glibc) clang debug+sanitizers
=====================================
Configure: PASS
Build: FAIL
     drivers/qmimodem/call-forwarding.c:30:4: error: field 'i' with variable 
sized type 'struct (unnamed struct at drivers/qmimodem/call-forwarding.c:25:2)' 
not at the end of a struct or class is a GNU extension 
[-Werror,-Wgnu-variable-sized-type-not-at-end]
        30 |         } i;
           |           ^
     1 error generated.
     make[1]: *** [Makefile:4083: drivers/qmimodem/call-forwarding.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2388: all] Error 2

> diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
> index e7ae3515..fb9bb4e1 100644
> --- a/drivers/qmimodem/call-forwarding.c
> +++ b/drivers/qmimodem/call-forwarding.c
> @@ -21,6 +21,16 @@ struct call_forwarding_data {
>   	struct qmi_service *voice;
>   };
>   
> +struct call_forwarding_info {
> +	struct {
> +		int8_t active;
> +		uint8_t cls;
> +		uint8_t len;
> +		uint8_t number[];
> +	} i;
> +	uint8_t time;
> +} __attribute__((__packed__));
> +
>   struct call_forwarding_info_ext {
>   	uint8_t active;
>   	uint8_t cls;
> @@ -31,7 +41,7 @@ struct call_forwarding_info_ext {
>   	uint8_t plan;
>   	uint8_t len;
>   	uint8_t number[];
> -};
> +} __attribute__((__packed__));
>   
>   static int forw_type_to_reason(int type)
>   {
> @@ -78,55 +88,68 @@ static void query_cb(struct qmi_result *result, void *user_data)
>   	ofono_call_forwarding_query_cb_t cb = cbd->cb;
>   	const uint8_t *p;

const void *p;

>   	uint8_t num;
> +	const uint8_t *end;
>   	uint16_t length;
> -
> +	struct ofono_call_forwarding_condition *list = NULL;

A nicer way might be:
_auto_(l_free) struct ofono_call_forwarding_condition *list = NULL;

> +	int i;
> +	bool extended = false;
>   	DBG("");
>   
>   	if (qmi_result_set_error(result, NULL))
>   		goto error;
>   
>   	/*
> -	 * we want extended info, because of the number type.
> -	 * FIXME - shall we fallback to 0x10 if there is no extended info?
> +	 * we want extended info if any, because of the number type.
>   	 */
>   	p = qmi_result_get(result, 0x16, &length);
> -	if (p && length) {
> -		struct ofono_call_forwarding_condition *list;
> -		const uint8_t *end = p + length;
> -		int i;
> +	if (p && length)
> +		extended = true;
> +	else
> +		p = qmi_result_get(result, 0x10, &length);
>   
> -		num = *p++;
> +	if (!extended && (!p || !length))
> +		goto error;
>   
> -		list = l_new(struct ofono_call_forwarding_condition, num);
> +	end = p + length;
> +	num = *p++;

num = l_get_u8(p);

> +	list = l_new(struct ofono_call_forwarding_condition, num);
>   
> -		for (i = 0; i < num; i++) {
> -			struct call_forwarding_info_ext *info = (void *)p;
> +	for (i = 0; i < num; i++) {
> +		if (extended) {
> +			struct call_forwarding_info_ext *fi = (void *)p;

No need for cast if p is void *

> +			const uint8_t *iend = p + sizeof(*fi);
>   			int type;
>   
> -			/* do not try to access beyond buffer end */
> -			if (p + sizeof(*info) > end ||
> -					p + sizeof(*info) + info->len > end) {
> -				l_free(list);
> +			if (iend > end || iend + fi->len > end)
>   				goto error;
> -			}
>   
> -			if (info->type == 1)
> -				type = OFONO_NUMBER_TYPE_INTERNATIONAL;
> -			else
> -				type = OFONO_NUMBER_TYPE_UNKNOWN;
> +			type = fi->type == 1 ?
> +					OFONO_NUMBER_TYPE_INTERNATIONAL :
> +					OFONO_NUMBER_TYPE_UNKNOWN;
> +			set_fwd_cond(&list[i], fi->active, fi->cls,
> +					fi->time, type, fi->number, fi->len);
>   
> -			set_fwd_cond(&list[i], info->active, info->cls,
> -					info->time, type, info->number,
> -					info->len);
> -			p += sizeof(*info) + info->len;
> -		}
> +			p += sizeof(*fi) + fi->len;
> +		} else {
> +			struct call_forwarding_info *fi = (void *)p;
> +			const uint8_t *iend = p + sizeof(*fi);
>   
> -		CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
> -		l_free(list);
> -		return;
> +			if (iend > end || iend + fi->i.len > end)
> +				goto error;
> +
> +			set_fwd_cond(&list[i], fi->i.active, fi->i.cls,
> +					fi->time, OFONO_NUMBER_TYPE_UNKNOWN,
> +					fi->i.number, fi->i.len);
> +			p += sizeof(*fi) + fi->i.len;
> +		}
>   	}
>   
> +	CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
> +	l_free(list);

No need for l_free here

> +	return;
> +
>   error:
> +	l_free(list);

or here if using _auto_

>   	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
>   }
>   

Regards,
-Denis

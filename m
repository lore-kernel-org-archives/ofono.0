Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522C1292F6
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705261; cv=none; b=jIRBPdSHrpfRMK0wn+Zyp01hLZvG+PwawP+qepi6RfitEizXMqdFxbVLMRqw28Rly+nQLYi+YkX9feLQqN55TCKf1Hgv+0LYJtaIbwWA9MsEI0vaBZjYlE3YqeFKQRZzvEzntDhx+8UKGYGC3Z+KyQmBIhj5eo4gJG4MFXH0F1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705261; c=relaxed/simple;
	bh=TTCSHoKt4gPwhnF6cTWkdjxB6PuHRHe0+ZnDa7d5A2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YQKTGPRFGYhjQudijPoEXxZWTBdWYmx520kPPawtmD2bTmAzzVszDGrA3JqeoDfodtnSfdKHcwF9zyaNJ+gQYw0b5XAaF1Rqy9t1upMoqyVGOzxbdC9pPm0VenBeHhT75tDMvJv+EgVmI+r8wzUsnk4lz2aE65ghapwhM9JsTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhGB87NU; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhGB87NU"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2d83d2568so674622a34.3
        for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708705258; x=1709310058; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=On8tr9Znan2ABJhDDGSEc2dmua94p6SsuZ8O2QsXfAE=;
        b=IhGB87NU4Upq4lwZfV9adoEepnbfaQvvwzUQYlKLoJrDt5mLxOmqprfiifbwfzBwlq
         PXbwrXt10C9yg/FkmCVnqmxNlbnRLQ6bu+aRzaWu36V7vENpSl3Fb0evPKjQiuOX2CZ8
         P9RQF8g/JGk4FZmxtZl+e5a5X9DXBJ8ffdEJXIHJVlsheNpkyfxUTlRz3C/xXNXnJfE6
         UtXHUca0cNJpouASE9FxHGGPdvGT0aFkBPDbN5wesBA/Ro1m8ywzT/wmV3k1DhA6I+kb
         L1zWC6VswPda47xVjwRavXwe7XUgbzWz+LeoYopTFu28J1x1L+cOU2tOcZS+1J2wi7uU
         I3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705258; x=1709310058;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=On8tr9Znan2ABJhDDGSEc2dmua94p6SsuZ8O2QsXfAE=;
        b=bcTYCmkOMLoI3hdRSmREI3gT1VI1mVRpWbK0isNZrzOMqmhb8fwlK9yaaPCwG0t2VR
         nI1sMFUh3Wd7mqxbSGoZg9aLpnkt/+XN/1jIyH+WCvx6ucmZ+CTu+yrJqjCg0Fita0fX
         CccIbHGTVN5xFG+6AoYOuC4WApC31JjPq0mL70G1fTNztOs2L7VUK2q0sv/o+jU8MSuH
         fEDbKmEEH/RmqbTHEiRYlCyMWSymGr8/L7ebKli6gMeXpSf77wxnv/+RkiEZ+WU7XO41
         tNu0sRo/VaYgso5go3gC8qHxSnuyuy36LStUq9AuSmc7zIAtQ8wrIubtozX2rTo9QJkG
         MTLw==
X-Forwarded-Encrypted: i=1; AJvYcCXKgDPtLgl6SujAxnNTtxf8/0fbJMr93Gim9sMLuSEqBMIbv7Ljav211oHTOKn6rcUJn3c1JV44b4oSN/Ddfa0n21xGCsM=
X-Gm-Message-State: AOJu0YzEf2PVJ2Z4qukljLlbX18JFi8TINZXto9tpf1Spu4AfhkR7ztl
	JmNeR9PH8Hkv4KxUmnuyoMCqwWlePNX0+nLh756VnmvxF/Ljk4vQ
X-Google-Smtp-Source: AGHT+IHHJhGkioH0B0hTdClAvJhdFNj84c2Jpdn0K6BgcxNfUkg12qFYy7zIbN+sOJ0PjpuRgRAD1w==
X-Received: by 2002:a05:6830:1da1:b0:6e1:29f3:6fbd with SMTP id z1-20020a0568301da100b006e129f36fbdmr284376oti.22.1708705258286;
        Fri, 23 Feb 2024 08:20:58 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o10-20020a9d764a000000b006e2dd7bea5bsm2606679otl.48.2024.02.23.08.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:20:58 -0800 (PST)
Message-ID: <d813fdc1-d528-4648-a92f-a06103c2afdb@gmail.com>
Date: Fri, 23 Feb 2024 10:20:57 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qmimodem: Use l_queue instead of GList for pending
 service creation
Content-Language: en-US
To: Steve Schrock <steve.schrock@getcruise.com>, ofono@lists.linux.dev
References: <20240222235356.32485-1-steve.schrock@getcruise.com>
 <20240222235356.32485-2-steve.schrock@getcruise.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240222235356.32485-2-steve.schrock@getcruise.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 2/22/24 17:53, Steve Schrock wrote:
> ---
>   drivers/qmimodem/qmi.c | 43 ++++++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 168dee1a..99b3d84d 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1382,24 +1382,27 @@ static void service_create_shared_reply(struct l_idle *idle, void *user_data)
>   	__qmi_device_discovery_complete(data->device, &data->super);
>   }
>   
> +static void service_create_shared_schedule_callback(void *data, void *user_data)
> +{
> +	struct service_create_shared_data *shared_data = data;
> +	struct qmi_service *service = user_data;
> +
> +	shared_data->service = qmi_service_ref(service);
> +	shared_data->idle = l_idle_create(service_create_shared_reply,
> +						shared_data, NULL);
> +

nit: empty line at end of function

> +}
> +
>   static void service_create_shared_pending_reply(struct qmi_device *device,
>   						unsigned int type,
>   						struct qmi_service *service)
>   {
> -	gpointer key = L_UINT_TO_PTR(type | 0x80000000);
> -	GList **shared = l_hashmap_remove(device->service_list, key);
> -	GList *l;
> -
> -	for (l = *shared; l; l = l->next) {
> -		struct service_create_shared_data *shared_data = l->data;
> -
> -		shared_data->service = qmi_service_ref(service);
> -		shared_data->idle = l_idle_create(service_create_shared_reply,
> -							shared_data, NULL);
> -	}
> +	void *key = L_UINT_TO_PTR(type | 0x80000000);
> +	struct l_queue *shared = l_hashmap_remove(device->service_list, key);
>   
> -	g_list_free(*shared);
> -	l_free(shared);
> +	l_queue_foreach(shared, service_create_shared_schedule_callback,
> +						service);

You could use l_queue_get_entries() here to avoid a foreach / creating a new 
function if you think that will look better.  Something like:

const struct l_queue_entry *entry;

for (entry = l_queue_get_entries(q); entry; entry = entry->next)
...

It looks like this function is always called from two places:

- qmux_client_create_reply()
This call site seems to be invoked on a timeout with a NULL service.  Don't 
think that makes sense?  Should this invocation just be dropped?

- qmux_client_create_callback()
This call site happens when we receive a reply, which should be on a different 
iteration of the event loop compared to qmi_device_qmux_client_create().  Can we 
invoke the callbacks directly here instead of scheduling another l_idle callback?

> +	l_queue_destroy(shared, NULL);
>   }
>   
>   static void service_create_shared_data_free(gpointer user_data)

<snip>

> @@ -2148,7 +2151,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
>   			qmi_create_func_t func, void *user_data,
>   			qmi_destroy_func_t destroy)
>   {
> -	GList **l = NULL;
> +	struct l_queue *shared = NULL;

nit: This doesn't need to be initialized.  Let the compiler warn us in case 
uninitiated variables are used.

>   	struct qmi_service *service = NULL;
>   	unsigned int type_val = type;
>   	int r;

Regards,
-Denis


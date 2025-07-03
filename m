Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FC2DE716
	for <ofono@lists.linux.dev>; Thu,  3 Jul 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565066; cv=none; b=LteQTjmPg/+LbpGL/jgau1j0TWKwgNSguYHrlYxhf/6tolVEEbQYYNgObqnE9gV1sKB0AbQk9wsVKqTeSaUzsvRBZdp7YaA2hEsuKu8pTtAF6ptdMxBaz+HqtZiand9+14eQ+IIQ7/aNJMyy7rC4Xt5UZyyZTVtyLUOPwBK93do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565066; c=relaxed/simple;
	bh=lYmkVicRN2BjaIA2qRpOE/0jYaj4SCbvb+FwAwngyCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VAYs3AE6yfC6a8a/Qb7eeIo8kZuvfYPNeRnuRtZR/mHq7LcHT5Ob18CB4VUMH3K4JfLxxQTHlNMIOKR1gn78bueYBH8WvF3kkqG+Kefpcvj85WK9doFUlYl60hzK/2P1vaEKlxCKxcgrfYwPRxduKI4XzdeYert5LTVON9EOiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY5L8Vet; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY5L8Vet"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea58f008e9so219409fac.0
        for <ofono@lists.linux.dev>; Thu, 03 Jul 2025 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751565064; x=1752169864; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxeXzmBj2EJN87+Ym17HS0UuzxRgZjchOuXC7YseUZI=;
        b=VY5L8Vet3Z98Sj36InMnh7P3t/katMWHwgZIxbdkwhaJRNpqoqyJR3GfnJiiguffXP
         d0vMIuGeK5pMVx/suFoAeBZDfMHWT4plcYyboqWr1MGlsB7nAf+xg1iUqmWcHm4kU3tf
         TE0/K10x2/2PsEqW3FQlLdlbhXfCGFTqe5xY9ORZypjhQklvDsawyEc4t0StpEXThLs9
         5ew1ZTzti172a6NGEfhLTxdae9QX0GdwXuMYWhZ3WJKE5sIgdTPR6peKyFqSGkwcddWW
         t4XOQyuL1MW6K4nDnb5ImVxaX0Q9PvAwz8R65X+iKGtLZEjDynAWfxnE+Y2Ej8FF3iKX
         dn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751565064; x=1752169864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxeXzmBj2EJN87+Ym17HS0UuzxRgZjchOuXC7YseUZI=;
        b=OvO/liHSPHZD1Gp34ufM2o7W0/Y3wea3ahLcZFFe55y8t6E6LKJrF7H0QNhlKPcvBu
         cC3aShlRr7iPZuusfs6VL1J1CV3uB6ykuFRgRXqL6lyJmSVdL/7C4i3f4dYBy229pall
         njgnt5ALN9DiE6e05kLR+sEP5+G0VjjI9DNTJJu3aiEmjku/3Quth7o809p/bGWpLcVu
         /7pDvqWo9NwyYUL+aYWR5o+bZnzEI+45rJuNrtZSn9EGctvJUK54g9WqdHfz8ZIVIXm+
         3e5V9JVqdk9M35cnxM2noGGvSqXu4Lp5dKOsRg8VpKCmLGBkGrNOlVzy59ogEmS1DIJw
         mcJA==
X-Forwarded-Encrypted: i=1; AJvYcCV3QOxSwaDOGI04AiAjw/JbmBz26D4tphoCg4Jov3ytsHpiGQqM2IO/dhPvC4OI5MRRxIGFbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhCo/0hLk9qbI64ayT4+mZDEkJp8xPRROMEJ9Ys9KiZPh9i/yn
	5nXKNvdqp2CBYiH68qSFji7E9+8CJc6DuliOeDtg09nwdXLPhhiNW6so
X-Gm-Gg: ASbGnct5nAtHI3lgVWYe386Z3loU6VtOMtkze0dKcBCZGFUZ0BzEwjMaGx+UGrwDz0N
	5sskezIN9UhbnEoqpvQdvPDNGcY4149FVpDdO7QsGVujOY4W77R5uR4TPEfjhDeNsIYWmoJ+54J
	/SEay1b4fHQ6NUIwEpq0qm44KfPL4PUJU7CInYobsJCFd91rYETBqdwOvKaCacoAKHAHZ/yfS/R
	lEvMiTrw9jSZE+QCsEI1Gg1NBzOOV/gZbOsg1S23lfjCB9UdCg78NAkujzSn1cZFO1coJkmHzPT
	mEU6xtTuUoSxI2COVe/zSo2ORR0MVYwamzyzppIWb/TFiLJQW/y4460xFeOh
X-Google-Smtp-Source: AGHT+IG3P9fEduUycaE8uHEMgohjI+FP79hikYsfNJSIyhkTUb39CFNhZyBZByPIUF/PStlxf38o4w==
X-Received: by 2002:a05:6871:7a02:b0:2ea:765f:da78 with SMTP id 586e51a60fabf-2f5a8b93c1emr4914571fac.21.1751565061922;
        Thu, 03 Jul 2025 10:51:01 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2f78ff48685sm23851fac.16.2025.07.03.10.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 10:51:01 -0700 (PDT)
Message-ID: <8684b672-f8f9-42ca-a35a-455fb05f041c@gmail.com>
Date: Thu, 3 Jul 2025 12:51:00 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sim: Create new dbus method to clear the forbidden
 network operator list
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
 <20250703-fplmn-v2-2-6eb6335a7b8c@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250703-fplmn-v2-2-6eb6335a7b8c@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 7/3/25 6:48 AM, Sean Nyekjaer wrote:
> To clear the list:
> busctl call org.ofono /sim76xx_0 org.ofono.SimManager
> ClearForbiddenNetworkOperators
> ---
>   src/sim.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/src/sim.c b/src/sim.c
> index 7d9a180abd0c5b7adedebfe7026125dbada9752e..4f72bd9ac1abf484fed77008c03cae9186b63c9e 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -143,6 +143,11 @@ struct msisdn_set_request {
>   	DBusMessage *msg;
>   };
>   
> +struct fplmn_set_request {
> +	struct ofono_sim *sim;
> +	DBusMessage *msg;
> +};
> +

I don't think this is used?

>   struct service_number {
>   	char *id;
>   	struct ofono_phone_number ph;
> @@ -649,6 +654,41 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
>   	return TRUE;
>   }
>   
> +static void sim_efplmn_cb(const struct ofono_error *error, void *data)
> +{
> +	struct ofono_sim *sim = data;
> +	DBusMessage *reply;
> +
> +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
> +		ofono_error("Unable to clear Forbidden PLMN");
> +		reply = __ofono_error_failed(sim->pending);
> +	} else {
> +		reply = dbus_message_new_method_return(sim->pending);
> +	}
> +
> +	__ofono_dbus_pending_reply(&sim->pending, reply);
> +}
> +
> +static DBusMessage *sim_clear_forbidden_plmn(DBusConnection *conn, DBusMessage *msg,
> +					void *data)
> +{
> +	struct ofono_sim *sim = data;
> +	DBusMessageIter iter;
> +	DBusMessageIter var;
> +	static uint8_t plmn_list[12] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
> +					0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

What if FPLMN isn't 12 bytes long?  Have you tried with a few different SIMs?

A safer approach would be to use something like sim_fs_read_info to obtain the 
FPLMN length, then write the entire file's contents as FFs.

> +
> +	if (sim->pending)
> +		return __ofono_error_busy(msg);
> +
> +	sim->pending = dbus_message_ref(msg);
> +
> +	sim->driver->write_file_transparent(sim, SIM_EF_PLMN_FILEID, 0, 12,
> +					plmn_list, NULL, 0, sim_efplmn_cb, sim);

Careful, there might not be an actual implementation of 'write_file_transparent' 
provided.

> +
> +	return NULL;
> +}
> +
>   static void sim_set_slot_callback(const struct ofono_error *error, void *data)
>   {
>   	struct ofono_sim *sim = data;
> @@ -687,6 +727,7 @@ static DBusMessage *sim_set_property(DBusConnection *conn, DBusMessage *msg,
>   	DBusMessageIter var;
>   	DBusMessageIter var_elem;
>   	const char *name, *value;
> +	ofono_bool_t clear_fplmn;

What's this for?

>   
>   	if (!dbus_message_iter_init(msg, &iter))
>   		return __ofono_error_invalid_args(msg);
> @@ -1297,6 +1338,8 @@ static const GDBusMethodTable sim_methods[] = {
>   	{ GDBUS_ASYNC_METHOD("SetProperty",
>   			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
>   			NULL, sim_set_property) },
> +	{ GDBUS_ASYNC_METHOD("ClearForbiddenNetworkOperators",
> +			NULL, NULL, sim_clear_forbidden_plmn) },
>   	{ GDBUS_ASYNC_METHOD("ChangePin",
>   			GDBUS_ARGS({ "type", "s" }, { "oldpin", "s" },
>   						{ "newpin", "s" }), NULL,
> 

Regards,
-Denis

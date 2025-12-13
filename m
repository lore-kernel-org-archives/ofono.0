Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50723817F
	for <ofono@lists.linux.dev>; Sat, 13 Dec 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765616286; cv=none; b=lSO6LrlTKARMujvsvJRUIbN+VXGNVLYioPQPNM+SXEaGcVaweC+gsMSz8FA/eJ+92gzpZB6smDblj2m5hk9hpJ2lj9Mn0XW7IpzMzVrvHplHN78ckfRP9iF1nieB8mVCxL5vnwsETZW1PY9DKPi2nMTZow6OWQU881xm4YyQKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765616286; c=relaxed/simple;
	bh=/XaiEyl4tRzqXMiiwtjwZGdpwrBczfdq/k+yEG8Bcd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RL0k+F4dqNWe+oxchD9BbI4l0XvsNy5Tkst8uGclPg28ZA4Vyz7QIXtQJVFjViXAFRfb4yMzxGfbs4E0BRWOG4SAzvaS0NyQvbztZDO43+64ZqSmfAvlDvLGp5kXK+X9CtuVgvC0k7HAkQx/u7JWUdAT0PELrHy5wtvgOM5mxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 0AB37114D91; Sat, 13 Dec 2025 03:58:04 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.164.103])
	by spindle.queued.net (Postfix) with ESMTPSA id A3FCF114D84;
	Sat, 13 Dec 2025 03:58:03 -0500 (EST)
Message-ID: <22fbbf08-85bc-4060-902d-06d605064119@queued.net>
Date: Sat, 13 Dec 2025 03:58:02 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] mbim/network-registration: add support for manual
 registration
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
 <20251212210249.95597-9-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
Cc: ofono <ofono@lists.linux.dev>
From: Andres Salomon <dilinger@queued.net>
Autocrypt: addr=dilinger@queued.net; keydata=
 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
In-Reply-To: <20251212210249.95597-9-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 12/12/25 16:02, Muhammad Asif wrote:
> Adds support for scanning available operators, and manually registering
> to a selected network.
[...]
> @@ -217,8 +283,8 @@ static void mbim_register_state_set_cb(struct mbim_message *message, void *user)
>   		CALLBACK_WITH_SUCCESS(cb, cbd->data);
>   }
>   
> -static void mbim_register_auto(struct ofono_netreg *netreg,
> -				ofono_netreg_register_cb_t cb, void *data)
> +static void mbim_register(struct cb_data *cbd, enum mbim_register_type reg_type,
> +				const char *provider_id)
>   {
>   	static const uint32_t data_class = MBIM_DATA_CLASS_GPRS |
>   						MBIM_DATA_CLASS_EDGE |
> @@ -226,22 +292,48 @@ static void mbim_register_auto(struct ofono_netreg *netreg,
>   						MBIM_DATA_CLASS_HSDPA |
>   						MBIM_DATA_CLASS_HSUPA |
>   						MBIM_DATA_CLASS_LTE;
> -	struct netreg_data *nd = ofono_netreg_get_data(netreg);
> -	struct cb_data *cbd = cb_data_new(cb, data);
>   	struct mbim_message *message;
>   
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_REGISTER_STATE,
>   					MBIM_COMMAND_TYPE_SET);
> -	mbim_message_set_arguments(message, "suu", NULL, 0, data_class);
>   
> -	if (mbim_device_send(nd->device, NETREG_GROUP, message,
> +	mbim_message_set_arguments(message, "suu", provider_id,
> +					reg_type, data_class);
> +
> +	if (mbim_device_send(cbd->data, NETREG_GROUP, message,

Did you mean to pass cbd->data here, instaed of nd->device?


>   				mbim_register_state_set_cb, cbd, l_free) > 0)
>   		return;
>   
>   	l_free(cbd);
>   	mbim_message_unref(message);
> -	CALLBACK_WITH_FAILURE(cb, data);
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}



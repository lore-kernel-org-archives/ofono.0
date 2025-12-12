Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B2169AD2
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535598; cv=none; b=u2kkJ5rRARlrevjTJhbZ3YvAhJUyk/cAcZweHrUP1VffaH01h0LvLbkVVhPmAeOg0Df5lolkszKDOc6BwNWpIqjLezH0/p5qvbbFHgMrUCZOMBgPTlaQ356S0sQpp7Wjcx8BeKC7j1f5GXjL4O+iJN4gv6ILIih9xY6O0FlaO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535598; c=relaxed/simple;
	bh=r6kXqX5yskC2WK9pn+7zgjrGUNF1gbWVP6o6bpgloUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ITY0BjacXgltNEHx0Zfu8hjeFr3p8aEXBYI0sxTKyJt5VgjYLXgdt2YEomuV6p2H+Dc6k8EwVn4HtvoWmHrl6/CFwQH6S1kyB+eMWpoqVNtWzrVb+MM6wP1EhoDLzCgJrPLwPhlT31KzMsVZFYR2DCbZb/5wmGFsEUIhXpMoR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 512D3114C27; Fri, 12 Dec 2025 05:33:16 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.164.103])
	by spindle.queued.net (Postfix) with ESMTPSA id EDEF3114C18;
	Fri, 12 Dec 2025 05:33:15 -0500 (EST)
Message-ID: <3c333a65-308a-417d-a966-1600eb4e5127@queued.net>
Date: Fri, 12 Dec 2025 05:33:14 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] mbim/network-registration: add support for
 manual registration
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
 <20251128173656.55692-11-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Andres Salomon <dilinger@queued.net>
Cc: ofono <ofono@lists.linux.dev>
Autocrypt: addr=dilinger@queued.net; keydata=
 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
In-Reply-To: <20251128173656.55692-11-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 11/28/25 12:36, Muhammad Asif wrote:
> Adds support for scanning available operators, and manually registering
> to a selected network.
[...]
> diff --git a/drivers/mbimmodem/network-registration.c b/drivers/mbimmodem/network-registration.c
> index ded1bf69..e95dd73a 100644
> --- a/drivers/mbimmodem/network-registration.c
> +++ b/drivers/mbimmodem/network-registration.c
> @@ -204,6 +204,70 @@ static void mbim_current_operator(struct ofono_netreg *netreg,
>   	CALLBACK_WITH_FAILURE(cb, NULL, data);
>   }
>   
> +static void mbim_list_operators_cb(struct mbim_message *message,
> +						void *user)
> +{
> +	struct cb_data *cb = user;
> +	ofono_netreg_operator_list_cb_t cb_func = cb->cb;
> +	struct ofono_network_operator *list = NULL;
> +
> +	uint32_t providers_count, provider_state, cellular_class;
> +	uint32_t rssi, error_rate;
> +	char *provider_id, *provider_name;
> +	struct mbim_message_iter iter;
> +	int i = 0;
> +
> +	if (!mbim_message_get_arguments(message, "ua(susuuu)", &providers_count, &iter)) {
> +		CALLBACK_WITH_FAILURE(cb_func, 0, NULL, cb->data);
> +		return;
> +	}
> +
> +	list = l_new(struct ofono_network_operator, providers_count);
> +
> +	while (mbim_message_iter_next_entry(&iter, &provider_id, &provider_state,
> +					&provider_name, &cellular_class, &rssi, &error_rate)) {
> +
> +		strcpy(list[i].name, provider_name);

This should probably be a strncpy using OFONO_MAX_OPERATOR_NAME_LENGTH.


> +		strncpy(list[i].mcc, provider_id, OFONO_MAX_MCC_LENGTH);
> +		list[i].mcc[OFONO_MAX_MCC_LENGTH] = '\0';
> +
> +		strncpy(list[i].mnc, provider_id + OFONO_MAX_MCC_LENGTH, OFONO_MAX_MNC_LENGTH);
> +		list[i].mnc[OFONO_MAX_MNC_LENGTH] = '\0';
> +
> +		list[i].status = mbim_provider_state_to_status(provider_state);
> +		list[i].tech = -1;
> +
> +		i++;
> +	}
> +
> +	if (list)
> +		CALLBACK_WITH_SUCCESS(cb_func, providers_count, list, cb->data);
> +	else
> +		CALLBACK_WITH_FAILURE(cb_func, 0, NULL, cb->data);
> +}
> +
> +static void mbim_list_operators(struct ofono_netreg *netreg,
> +					ofono_netreg_operator_list_cb_t cb, void *user_data)
> +{
> +	struct netreg_data *nd = ofono_netreg_get_data(netreg);
> +	struct cb_data *cbd = cb_data_new(cb, user_data);
> +	struct mbim_message *message;
> +
> +	message = mbim_message_new(mbim_uuid_basic_connect,
> +						MBIM_CID_VISIBLE_PROVIDERS,
> +						MBIM_COMMAND_TYPE_QUERY);
> +	/* "0" is a full scan, whereas "1" means a restricted scan */
> +	mbim_message_set_arguments(message, "u", 0);
> +
> +	if (mbim_device_send(nd->device, NETREG_GROUP, message,
> +						mbim_list_operators_cb, cbd, l_free) > 0)
> +		return;
> +
> +	l_free(cbd);
> +	mbim_message_unref(message);
> +	CALLBACK_WITH_FAILURE(cb, 0, NULL, user_data);
> +}
> +
>   static void mbim_register_state_set_cb(struct mbim_message *message, void *user)
>   {
>   	struct cb_data *cbd = user;
> @@ -233,7 +297,42 @@ static void mbim_register_auto(struct ofono_netreg *netreg,
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_REGISTER_STATE,
>   					MBIM_COMMAND_TYPE_SET);
> -	mbim_message_set_arguments(message, "suu", NULL, 0, data_class);
> +	mbim_message_set_arguments(message, "suu", NULL,
> +					MBIM_REGISTER_TYPE_AUTOMATIC, data_class);
> +
> +	if (mbim_device_send(nd->device, NETREG_GROUP, message,
> +				mbim_register_state_set_cb, cbd, l_free) > 0)
> +		return;
> +
> +	l_free(cbd);
> +	mbim_message_unref(message);
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void mbim_register_manual(struct ofono_netreg *netreg,
> +				const char *mcc, const char *mnc,
> +				ofono_netreg_register_cb_t cb, void *data)
> +{
> +	static const uint32_t data_class = MBIM_DATA_CLASS_GPRS |
> +						MBIM_DATA_CLASS_EDGE |
> +						MBIM_DATA_CLASS_UMTS |
> +						MBIM_DATA_CLASS_HSDPA |
> +						MBIM_DATA_CLASS_HSUPA |
> +						MBIM_DATA_CLASS_LTE;
> +	struct netreg_data *nd = ofono_netreg_get_data(netreg);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct mbim_message *message;
> +	L_AUTO_FREE_VAR(char *, provider_id) = NULL;
> +
> +	DBG("");
> +
> +	provider_id = l_strdup_printf("%s%s", mcc, mnc);
> +
> +	message = mbim_message_new(mbim_uuid_basic_connect,
> +					MBIM_CID_REGISTER_STATE,
> +					MBIM_COMMAND_TYPE_SET);
> +	mbim_message_set_arguments(message, "suu", provider_id,
> +					MBIM_REGISTER_TYPE_MANUAL, data_class);
>   

Given that mbim_register_auto and mbim_register_manual are almost the 
exact same function except for the MBIM_REGISTER_TYPE_* argument and 
provider_id (which is leaked, btw; should probably be deleted in 
mbim_register_state_set_cb?)... maybe it makes sense to have a common 
function for these two, with mbim_register_auto and mbim_register_manual 
calling it?



>   	if (mbim_device_send(nd->device, NETREG_GROUP, message,
>   				mbim_register_state_set_cb, cbd, l_free) > 0)
> @@ -385,7 +484,9 @@ static const struct ofono_netreg_driver driver = {
>   	.remove				= mbim_netreg_remove,
>   	.registration_status		= mbim_registration_status,
>   	.current_operator		= mbim_current_operator,
> +	.list_operators			= mbim_list_operators,
>   	.register_auto			= mbim_register_auto,
> +	.register_manual		= mbim_register_manual,
>   	.strength			= mbim_signal_strength,
>   };
>   
> diff --git a/drivers/mbimmodem/util.c b/drivers/mbimmodem/util.c
> index 731764fc..45b7af9b 100644
> --- a/drivers/mbimmodem/util.c
> +++ b/drivers/mbimmodem/util.c
> @@ -39,6 +39,26 @@ int mbim_data_class_to_tech(uint32_t n)
>   	return -1;

>   


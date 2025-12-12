Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91A188713
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524766; cv=none; b=ZfDqIy+THN6+41iJwU5PDosZLFFN8+FyQJJp/1jWiIc03j4uegcRJPriDgnUxhpT4HbB0ZNQ9l5b7tK6IaL8HGi8iRxnUpWBHtBsLUEfa5180ZbGULGzmIG4C99nvPtDrLQP/J/b4Azqb72eN7HOFu8epKaXH9gUjvQ8i33plXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524766; c=relaxed/simple;
	bh=X8o0fW06VXRPoeiIkIzD8md0fTAATau7zK9RoRExyZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UQ7OZWDRK1h8R2V3JG9973nsbdJtsXZmIf/5o83B+Sr7yeLmDysctRuP2qMpoKAsoBdn8/Ie1/bNHFY1nfs8la9NGZurtwo/ct3YTNgTylV7hg7lbIa3Za1Of6L4y8hKzQNLHfxUdYKmnVq9aVLaFfrcfMwz+EMYV0GKSABdRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 96E8511408C; Fri, 12 Dec 2025 02:32:38 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.164.103])
	by spindle.queued.net (Postfix) with ESMTPSA id 407B61129C9;
	Fri, 12 Dec 2025 02:32:38 -0500 (EST)
Message-ID: <40c11b5a-4988-4c89-8b79-b15c4a79fdfe@queued.net>
Date: Fri, 12 Dec 2025 02:32:36 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] mbimmodem: add support for MBIM extensions
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
 <20251128173656.55692-4-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Andres Salomon <dilinger@queued.net>
Cc: ofono <ofono@lists.linux.dev>
Autocrypt: addr=dilinger@queued.net; keydata=
 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
In-Reply-To: <20251128173656.55692-4-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 11/28/25 12:36, Muhammad Asif wrote:
> With MBIMEx 3.0, arguments for activating GPRS changed. Update as
> needed.
> ---
>   drivers/mbimmodem/gprs-context.c | 64 +++++++++++++++++++++++++-------
>   drivers/mbimmodem/mbim.c         | 13 +++++++
>   drivers/mbimmodem/mbim.h         |  6 +++
>   drivers/mbimmodem/mbimmodem.h    |  1 +
>   drivers/mbimmodem/sim.c          | 31 +++++++++++++---
>   drivers/mbimmodem/util.c         |  1 -
>   plugins/mbim.c                   | 39 +++++++++++++++++++
>   7 files changed, 134 insertions(+), 21 deletions(-)
> 
[...]
> @@ -281,6 +281,29 @@ error:
>   	mbim_device_shutdown(md->device);
>   }
>   
> +static void mbim_device_mbimex_version_cb(struct mbim_message *message,
> +								void *user)
> +{
> +	struct ofono_modem *modem = user;
> +	uint16_t mbim_version, mbimex_version;
> +
> +	if (mbim_message_get_error(message) != 0) {
> +		/* Fallback to MBIM 1.0 with no extensions */
> +		mbim_version = (1 << 8) | 0;
> +		mbimex_version = (0 << 8) | 0;
> +		goto version_set;
> +	}
> +
> +	mbim_message_get_arguments(message, "qq",
> +		&mbim_version, &mbimex_version);

mbim_message_get_arguments() can fail, and the return value should be 
checked here; I'd rework it to something like this:

if (mbim_message_get_error(message) != 0 ||
!mbim_message_get_arguments(message, "qq", &mbim_version, 
&mbimex_version)) {
	/* fallback to MBIM 1.0 with no extensions */
	mbim_version = ...
	mbimex_version = ...
}

ofono_modem_set_integer(...);

> +
> +version_set:
> +	ofono_modem_set_integer(modem, "MBIMVersion",
> +		mbim_version);
> +	ofono_modem_set_integer(modem, "MBIMExVersion",
> +		mbimex_version);
> +}
> +
>   static void mbim_device_closed(void *user_data)
>   {
>   	struct ofono_modem *modem = user_data;
> @@ -298,6 +321,22 @@ static void mbim_device_ready(void *user_data)
>   	struct mbim_data *md = ofono_modem_get_data(modem);
>   	struct mbim_message *message;
>   
> +	/* Version is formatted as (major version) << 8 | (minor version) */
> +	static const uint16_t mbim_version = (1 << 8) | 0;
> +
> +	/* Always open with MBIMEx 3, devices not supporting it will fallback to MBIMEx 2 */
> +	static const uint16_t mbimex_version = (3 << 8) | 0;
> +
> +	message = mbim_message_new(mbim_ms_basic_connect_extensions,
> +					MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION,
> +					MBIM_COMMAND_TYPE_QUERY);
> +	mbim_message_set_arguments(message, "qq",
> +					mbim_version,
> +					mbimex_version);
> +
> +	mbim_device_send(md->device, 0, message,
> +				mbim_device_mbimex_version_cb, modem, NULL);
> +
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_DEVICE_CAPS,
>   					MBIM_COMMAND_TYPE_QUERY);


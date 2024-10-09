Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCC1925A0
	for <ofono@lists.linux.dev>; Wed,  9 Oct 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488151; cv=none; b=b9nkS3ziCdsDjSr4CovrWch11GwElLxjRoy8QvwLTJ+Tl9awk0QP8UTLiVN6LyY80ZP7Vy9MdGUvwizokI75IQQhwdsCZOUNUe1uq+Jn9DHNEhD4dElVP5fM88TqaOavjCVA+rVbNWCLTkWrAxxGKPE6XBNcYKU5MLXo4VlM/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488151; c=relaxed/simple;
	bh=mIlC24DcwTQB/UwGWKWzfCGrVvwOuqO3B6JH/IuFYN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RkOE5pQHUbSbnOhHdWEzhiA9Uzb0CcEOTdmTbK+0D8NybQv4CrHtHxWJRRJhLYblSbsYC7aYa+KgiX/et17j8tc1yoR9jY+478j7jX5ZGbym1/7MoSFt7aEGd2wiYAkqe6qtsRRjch/joU7iNLwC0I9r/Z5fY5hXkIV/ZWqqAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPJdDujJ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPJdDujJ"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e5a0519d00so2607089eaf.3
        for <ofono@lists.linux.dev>; Wed, 09 Oct 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488149; x=1729092949; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vkVuNpghMv/g+ld5lNojOMXECxdCgjvcuciIqTtceI4=;
        b=mPJdDujJonlv+F8F6yj8c0r+PKebjYDJZmwko5IRPrO6ImISWx8Zq0eLDWCjsJR274
         uM9OyN6ZQtAw3XjUrKUm3Ys9DNlSWqflh9WobL76rVJZDn5bLpQf4Z+3fvH6c7cZ99Yc
         YhCvbfp7ascqn4qos0FGII+vefdSMTUwpOIC3rQDky/4qifyQ08M4lq5fgZEY/06YNiM
         +pyJ+rYqDz8r9lSn7DUIMMaMsCFzZKCUseECAbjq8rlr792l0PF4jajPBIWAGEzmlZRy
         IwA/davnlnQSlkSfUlp9E3KmtUEiJB5lPzNS8081TuXTErQpWWlTD1EsmQ38GND6QFxB
         CaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488149; x=1729092949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkVuNpghMv/g+ld5lNojOMXECxdCgjvcuciIqTtceI4=;
        b=OlkHnueRcpM4b2F4AobGRFrEkhbbxFamFHjkg/RHFVVcE8u260Mgww65e04cKmKbOq
         jeGI4fJDibHk2HBCIHfeosxBcA4/uQV2235hL8nyn6pe5LYQJ6PDbgFZ5h/ve+BJY2Ql
         MkDh2rRPRUneywI9w7KE586e6CSCPdm16giSFkCxmnnCLzbF/vVEny7g7t6Y0UgnOb/b
         ZEg+IkQxANOtjI9hNl9iNH/AF1ECm0UgAj6Q+NdoGNdaiu7SeR3LIUUXq1LwfDl7JYiG
         W91vRMRfztDf2gYSojVivVJ+FmJiZrPK218JfD/1ymzTdk+n9gDNGaI3iIM998iqJ1Hs
         5kqA==
X-Forwarded-Encrypted: i=1; AJvYcCXcsQWo6aMzErMPWomsAAKmEziSr4MUIvW6DzGzyrYf7+TwjjFGsCNQTvNKpemAmEAYDetxsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYQsjP8jS4D+ffLvAMKAMwfbSMWPL/GoC1cXdFqps/2mkGy5Jy
	5XWkbNHmvzZRMZXypkKN4xqO7FnryZUTo7GBHubQYDrg2aqNRbK6
X-Google-Smtp-Source: AGHT+IEH+XJL1j5357eQ5gr2ypsbowYB4FOLT+z5Z7AMBMsf4QHr6Kri/glMRjJQKlWhq7l7xmPXxA==
X-Received: by 2002:a05:6870:3308:b0:270:1dab:64a9 with SMTP id 586e51a60fabf-288342bdc97mr2001188fac.14.1728488148622;
        Wed, 09 Oct 2024 08:35:48 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-287d719b17asm3501818fac.30.2024.10.09.08.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:35:48 -0700 (PDT)
Message-ID: <80d58c8a-182e-4727-bf6b-4afd5e20f63e@gmail.com>
Date: Wed, 9 Oct 2024 10:35:47 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] network: allow status' and notifications on eutran
 networks
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20241008091104.1567517-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241008091104.1567517-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 10/8/24 4:11 AM, Sean Nyekjaer wrote:
> SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
> 6 registered for "SMS only", home network (applicable only when E-UTRAN)
> 7 registered for "SMS only", roaming (applicable only when <AcT> indicates E-UTRAN)
> +COPS supplies the <AcT> = EUTRAN

Do you know the distinction between registered/roaming and "SMS only" variants 
in practical terms?  Are data calls available on "SMS only"?  Voicecalls?

> ---
>   src/network.c | 58 +++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 11 deletions(-)
> 

CI complains:

Checkpatch Output
=================
0001-network-allow-status-and-notifications-on-eutran-net.patch:9: WARNING: 
Prefer a maximum 75 chars per line (possible unwrapped commit description?)
0001-network-allow-status-and-notifications-on-eutran-net.patch:36: ERROR: 
switch and case should be at the same indent
0001-network-allow-status-and-notifications-on-eutran-net.patch:63: ERROR: 
switch and case should be at the same indent
0001-network-allow-status-and-notifications-on-eutran-net.patch:92: ERROR: 
switch and case should be at the same indent
0001-network-allow-status-and-notifications-on-eutran-net.patch:114: ERROR: 
switch and case should be at the same indent
total: 4 errors, 1 warnings, 100 lines checked
0002-gprs-allow-attached-updates-and-status-on-eutran-net.patch:9: WARNING: 
Prefer a maximum 75 chars per line (possible unwrapped commit description?)
total: 0 errors, 1 warnings, 47 lines checked

> diff --git a/src/network.c b/src/network.c
> index 40626179..02853e23 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -376,7 +376,8 @@ static char *get_operator_display_name(struct ofono_netreg *netreg)
>   		return name;
>   	}
>   
> -	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED)
> +	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
> +		netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN)
>   		home_or_spdi = TRUE;
>   	else
>   		home_or_spdi = sim_spdi_lookup(netreg->spdi,
> @@ -1205,9 +1206,15 @@ static void current_operator_callback(const struct ofono_error *error,
>   	 * in which case the operator information frequently comes in bogus.
>   	 * We ignore it here
>   	 */
> -	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
> -			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
> -		current = NULL;
> +	switch (netreg->status) {
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> +			break;
> +		default:
> +			current = NULL;
> +	}
>   
>   	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
>   		DBG("Error during current operator");
> @@ -1324,6 +1331,8 @@ static void notify_emulator_status(struct ofono_atom *atom, void *data)
>   void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
>   			int lac, int ci, int tech)
>   {
> +	ofono_bool_t netreg_status;
> +
>   	if (netreg == NULL)
>   		return;
>   
> @@ -1351,8 +1360,18 @@ void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
>   	if (netreg->technology != tech)
>   		set_registration_technology(netreg, tech);
>   
> -	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
> -		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
> +	switch (netreg->status) {
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> +			netreg_status = true;
> +			break;
> +		default:
> +			netreg_status = false;
> +	}
> +
> +	if (netreg_status) {
>   		if (netreg->driver->current_operator != NULL)
>   			netreg->driver->current_operator(netreg,
>   					current_operator_callback, netreg);
> @@ -1448,6 +1467,7 @@ static void init_registration_status(const struct ofono_error *error,
>   					void *data)
>   {
>   	struct ofono_netreg *netreg = data;
> +	ofono_bool_t netreg_status;

Simple bool is fine.  The plan is to remove ofono_bool_t entirely.

>   
>   	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
>   		DBG("Error during registration status query");
> @@ -1460,8 +1480,18 @@ static void init_registration_status(const struct ofono_error *error,
>   	 * Bootstrap our signal strength value without waiting for the
>   	 * stack to report it
>   	 */
> -	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
> -		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
> +	switch (netreg->status) {
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> +			netreg_status = true;
> +			break;
> +		default:
> +			netreg_status = false;
> +	}
> +
> +	if (netreg_status) {
>   		if (netreg->driver->strength != NULL)
>   			netreg->driver->strength(netreg,
>   					signal_strength_callback, netreg);
> @@ -1516,9 +1546,15 @@ void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strength)
>   	 * Theoretically we can get signal strength even when not registered
>   	 * to any network.  However, what do we do with it in that case?
>   	 */
> -	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
> -			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
> -		return;
> +	switch (netreg->status) {
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> +			break;
> +		default:
> +			return;
> +	}

Might be nicer to do:

if (!L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
			NETWORK_REGISTRATION_STATUS_ROAMING,
			...))
	return;

>   
>   	DBG("strength %d", strength);
>   

Regards,
-Denis

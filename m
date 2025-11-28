Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887D242D97
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319589; cv=none; b=dKIjYxoVG6NdPpLcDwC6X4uEu4KTlkVWJPJMI40rsJK2+1KbyaAMf8fMf5UhsJgaAL99kFR7Ka9LuodKR2q6ui/WeaVQ6et7QBRv7k3eqyAyOnFRiOnk8b3fpwBksB24mx+wlPtIGkQ2qu1Lp0X8o4pKtG5u4a4o3JhaDvBqOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319589; c=relaxed/simple;
	bh=9NNAHmZXsCRqtJcy91AgwhV/8LG7ia2Hr9IRT8A2g6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SeBrv9CLgcAVtVkECiubISeUQqeQG3qX6/04nizHl+jU3f1sfp5Z8YvPzk+HYYBvI6TwU7aKAr0OPMJ4IctsnyuM7n1yxF6te2ILTT7Od45o6LQXECVfLYZNUGNAAENJGs7lcG2t+okydrA5ltaoMtE2o8gdRw/bdV103CWYDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 3642F112B8F; Fri, 28 Nov 2025 03:46:27 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.167.181])
	by spindle.queued.net (Postfix) with ESMTPSA id AA50B112B84;
	Fri, 28 Nov 2025 03:46:26 -0500 (EST)
Message-ID: <37f73e50-6572-4404-bd90-2e752f29c6d5@queued.net>
Date: Fri, 28 Nov 2025 03:46:25 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] mbimmodem: add support for MBIM extensions *
 With MBIMEx 3.0, arguments for activating GPRS changed. Update as needed.
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
 <20251127174946.89981-4-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
Cc: ofono@lists.linux.dev
From: Andres Salomon <dilinger@queued.net>
Autocrypt: addr=dilinger@queued.net; keydata=
 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
In-Reply-To: <20251127174946.89981-4-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 11/27/25 12:49, Muhammad Asif wrote:
> ---
>   drivers/mbimmodem/gprs-context.c | 64 +++++++++++++++++++++++++-------
>   drivers/mbimmodem/mbim.c         | 13 +++++++
>   drivers/mbimmodem/mbim.h         |  6 +++
>   drivers/mbimmodem/mbimmodem.h    |  2 +-
>   drivers/mbimmodem/sim.c          |  4 ++
>   drivers/mbimmodem/util.c         |  1 -
>   plugins/mbim.c                   | 40 ++++++++++++++++++++
>   7 files changed, 114 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-context.c
> index c420e300..4ef5e10f 100644
> --- a/drivers/mbimmodem/gprs-context.c
> +++ b/drivers/mbimmodem/gprs-context.c
> @@ -91,6 +91,8 @@ static void mbim_gprs_deactivate_primary(struct ofono_gprs_context *gc,
>   					ofono_gprs_context_cb_t cb, void *data)
>   {
>   	struct gprs_context_data *gcd = ofono_gprs_context_get_data(gc);
> +	struct ofono_modem *modem = ofono_gprs_context_get_modem(gc);
> +	uint16_t mbimex_version = ofono_modem_get_integer(modem, "MBIMExVersion");
>   	struct mbim_message *message;
>   
>   	DBG("cid %u", cid);
> @@ -102,9 +104,16 @@ static void mbim_gprs_deactivate_primary(struct ofono_gprs_context *gc,
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_CONNECT,
>   					MBIM_COMMAND_TYPE_SET);
> -	mbim_message_set_arguments(message, "uusssuuu16y",
> -					cid, 0, NULL, NULL, NULL, 0, 0, 0,
> -					mbim_context_type_internet);
> +
> +	if (mbim_device_mbimex_version_equal(mbimex_version, 3, 0)) {
> +		mbim_message_set_arguments(message, "uuuuu16yussss",
> +						cid, 0, 0, 0, 0, mbim_context_type_internet,
> +						0, NULL, NULL, NULL, NULL);
> +	} else {
> +		mbim_message_set_arguments(message, "uusssuuu16y",
> +						cid, 0, NULL, NULL, NULL, 0, 0, 0,
> +						mbim_context_type_internet);
> +	}
>   
>   	if (mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
>   				mbim_deactivate_cb, gc, NULL) > 0)
> @@ -121,6 +130,7 @@ static void mbim_ip_configuration_cb(struct mbim_message *message, void *user)
>   	struct ofono_gprs_context *gc = user;
>   	struct gprs_context_data *gcd = ofono_gprs_context_get_data(gc);
>   	struct ofono_modem *modem = ofono_gprs_context_get_modem(gc);
> +	uint16_t mbimex_version = ofono_modem_get_integer(modem, "MBIMExVersion");
>   	const char *interface;
>   	uint32_t session_id;
>   	uint32_t ipv4_config_available;
> @@ -288,10 +298,18 @@ error:
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_CONNECT,
>   					MBIM_COMMAND_TYPE_SET);
> -	mbim_message_set_arguments(message, "uusssuuu16y",
> +
> +	if (mbim_device_mbimex_version_equal(mbimex_version, 3, 0)) {
> +		mbim_message_set_arguments(message, "uuuuu16yussss",
> +					gcd->active_context, 0, 0, 0, 0,
> +					mbim_context_type_internet, 0, NULL,
> +					NULL, NULL, NULL);
> +	} else {
> +		mbim_message_set_arguments(message, "uusssuuu16y",
>   					gcd->active_context, 0,
>   					NULL, NULL, NULL, 0, 0, 0,
>   					mbim_context_type_internet);
> +	}
>   
>   	if (!mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
>   				NULL, NULL, NULL))
> @@ -331,6 +349,8 @@ static void mbim_gprs_activate_primary(struct ofono_gprs_context *gc,
>   				ofono_gprs_context_cb_t cb, void *data)
>   {
>   	struct gprs_context_data *gcd = ofono_gprs_context_get_data(gc);
> +	struct ofono_modem *modem = ofono_gprs_context_get_modem(gc);
> +	uint16_t mbimex_version = ofono_modem_get_integer(modem, "MBIMExVersion");
>   	struct mbim_message *message;
>   	const char *username = NULL;
>   	const char *password = NULL;
> @@ -352,16 +372,32 @@ static void mbim_gprs_activate_primary(struct ofono_gprs_context *gc,
>   	message = mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_CONNECT,
>   					MBIM_COMMAND_TYPE_SET);
> -	mbim_message_set_arguments(message, "uusssuuu16y",
> -				ctx->cid,
> -				1, /* MBIMActivationCommandActivate */
> -				ctx->apn,
> -				username,
> -				password,
> -				0, /*MBIMCompressionNone */
> -				auth_method_to_auth_protocol(ctx->auth_method),
> -				proto_to_context_ip_type(ctx->proto),
> -				mbim_context_type_internet);
> +./drivers/isimodem/sms.c
> +	if (mbim_device_mbimex_version_equal(mbimex_version, 3, 0)) {
> +		mbim_message_set_arguments(message, "uuuuu16yussss",
> +			ctx->cid,
> +			1, /* MBIMActivationCommandActivate */
> +			0, /* MBIMCompressionNone */
> +			auth_method_to_auth_protocol(ctx->auth_method),
> +			proto_to_context_ip_type(ctx->proto),
> +			mbim_context_type_internet,
> +			0, /* MBIMMediaTypeNone */
> +			ctx->apn,
> +			username,
> +			password,
> +			NULL);
> +	} else {
> +		mbim_message_set_arguments(message, "uusssuuu16y",
> +			ctx->cid,
> +			1, /* MBIMActivationCommandActivate */
> +			ctx->apn,
> +			username,
> +			password,
> +			0, /* MBIMCompressionNone */
> +			auth_method_to_auth_protocol(ctx->auth_method),
> +			proto_to_context_ip_type(ctx->proto),
> +			mbim_context_type_internet);
> +	}
>   
>   	if (mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
>   				mbim_activate_cb, gc, NULL) > 0)
> diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
> index c405761d..646b8055 100644
> --- a/drivers/mbimmodem/mbim.c
> +++ b/drivers/mbimmodem/mbim.c
> @@ -107,6 +107,11 @@ const uint8_t mbim_context_type_local[] = {
>   	0x03, 0x3C, 0x39, 0xF6, 0x0D, 0xB9,
>   };
>   
> +const uint8_t mbim_ms_basic_connect_extensions[] = {
> +	0x3D, 0x01, 0xDC, 0xC5, 0xFE, 0xF5, 0x4D, 0x05, 0x0D, 0x3A,
> +	0xBE, 0xF7, 0x05, 0x8E, 0x9A, 0xAF,
> +};
> +
>   struct message_assembly_node {
>   	struct mbim_message_header msg_hdr;
>   	struct mbim_fragment_header frag_hdr;
> @@ -1039,6 +1044,14 @@ bool mbim_device_set_ready_handler(struct mbim_device *device,
>   	return true;
>   }
>   
> +bool mbim_device_mbimex_version_equal(uint16_t mbimex_version,
> +					int version_major, int version_minor)

The name here implies you're checking for strict equality. Similar to 
the isi driver, I would suggest naming it 
mbim_device_mbimex_version_at_least(...).

You could also pass it an ofono_modem* instead of mbimex_version, since 
you're not using mbimex_version anywhere else.


> +{
> +	return ((mbimex_version >> 8) > version_major) ||
> +			(((mbimex_version >> 8) == version_major) &&
> +			((mbimex_version & 0xFF) >= version_minor));
> +}
> +
>   uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
>   				struct mbim_message *message,
>   				mbim_device_reply_func_t function,
> diff --git a/drivers/mbimmodem/mbim.h b/drivers/mbimmodem/mbim.h
> index 5f15d0a2..6ef7150b 100644
> --- a/drivers/mbimmodem/mbim.h
> +++ b/drivers/mbimmodem/mbim.h
> @@ -31,6 +31,8 @@ struct mbim_message;
>   #define MBIM_CID_IP_PACKET_FILTERS		23
>   #define MBIM_CID_MULTICARRIER_PROVIDERS		24
>   
> +#define MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION	15
> +
>   #define MBIM_CID_SMS_CONFIGURATION		1
>   #define MBIM_CID_SMS_READ			2
>   #define MBIM_CID_SMS_SEND			3
> @@ -87,6 +89,7 @@ extern const uint8_t mbim_uuid_phonebook[];
>   extern const uint8_t mbim_uuid_stk[];
>   extern const uint8_t mbim_uuid_auth[];
>   extern const uint8_t mbim_uuid_dss[];
> +extern const uint8_t mbim_ms_basic_connect_extensions[];
>   
>   extern const uint8_t mbim_context_type_none[];
>   extern const uint8_t mbim_context_type_internet[];
> @@ -118,6 +121,9 @@ bool mbim_device_set_ready_handler(struct mbim_device *device,
>   					void *user_data,
>   					mbim_device_destroy_func_t destroy);
>   
> +bool mbim_device_mbimex_version_equal(uint16_t mbimex_version,
> +					int version_major, int version_minor);
> +
>   uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
>   				struct mbim_message *message,
>   				mbim_device_reply_func_t function,
> diff --git a/drivers/mbimmodem/mbimmodem.h b/drivers/mbimmodem/mbimmodem.h
> index 96432738..a517877e 100644
> --- a/drivers/mbimmodem/mbimmodem.h
> +++ b/drivers/mbimmodem/mbimmodem.h
> @@ -13,4 +13,3 @@ enum MBIM_GROUP {
>   	SMS_GROUP = 3,
>   	GPRS_GROUP = 4,
>   	GPRS_CONTEXT_GROUP = 101,
> -};
> +};

What is this?


> diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
> index df8d73ce..fb23609a 100644
> --- a/drivers/mbimmodem/sim.c
> +++ b/drivers/mbimmodem/sim.c
> @@ -385,7 +385,9 @@ static void mbim_subscriber_ready_status_changed(struct mbim_message *message,
>   								void *user)
>   {
>   	struct ofono_sim *sim = user;
> +	struct ofono_modem *modem = ofono_sim_get_modem(sim);
>   	struct sim_data *sd = ofono_sim_get_data(sim);
> +	uint16_t mbimex_version = ofono_modem_get_integer(modem, "MBIMExVersion");
>   	uint32_t ready_state;
>   	char *imsi;
>   	char *iccid;
> @@ -413,7 +415,9 @@ static void mbim_subscriber_ready_status_cb(struct mbim_message *message,
>   								void *user)
>   {
>   	struct ofono_sim *sim = user;
> +	struct ofono_modem *modem = ofono_sim_get_modem(sim);
>   	struct sim_data *sd = ofono_sim_get_data(sim);
> +	uint16_t mbimex_version = ofono_modem_get_integer(modem, "MBIMExVersion");
>   	uint32_t ready_state;
>   	char *imsi;
>   	char *iccid;

And these two should probably go into patch #5?



> diff --git a/drivers/mbimmodem/util.c b/drivers/mbimmodem/util.c
> index b4e61d69..4a3d9627 100644
> --- a/drivers/mbimmodem/util.c
> +++ b/drivers/mbimmodem/util.c
> @@ -37,4 +37,3 @@ int mbim_data_class_to_tech(uint32_t n)
>   
>   	return -1;
>   }
> -
> diff --git a/plugins/mbim.c b/plugins/mbim.c
> index eeedfdac..1f82a3e4 100644
> --- a/plugins/mbim.c
> +++ b/plugins/mbim.c
> @@ -281,6 +281,30 @@ error:
>   	mbim_device_shutdown(md->device);
>   }
>   
> +static void mbim_device_mbimex_version_cb(struct mbim_message *message,
> +								void *user)
> +{
> +	struct ofono_modem *modem = user;
> +	struct mbim_data *md = ofono_modem_get_data(modem);
> +	uint16_t mbim_version, mbimex_version;

Keep in mind that mbim_message_get_arguments() below CAN fail, in which 
case you've got random memory (hopefully zeroed out, but...) in 
mbim*_version. I'd suggest initializing mbim_version to 1 and 
mbimex_version here to 0; since that's your fallback, it gets rid of 
your goto and other stuff.

Eg:
struct mbim_data *md = ofono_modem_get_data(modem);
/* Fallback to MBIM 1.0 with no extensions */
uint16_t mbim_version = (1 << 8) | 0;
uint16_t mbimex_version = 0;

if (mbim_message_get_error(message) == 0) {
	mbim_message_get_arguments(message, "qq",
			&mbim_version, &mbimex_version);
}

ofono_modem_set_integer(...);
> +
> +	if (mbim_message_get_error(message) != 0) {
> +		/* Fallback to MBIM 1.0 with no extensions */
> +		mbim_version = (1 << 8) | 0;
> +		mbimex_version = (0 << 8) | 0;
> +		goto version_set;
> +	}
> +
 > +	mbim_message_get_arguments(message, "qq",> +		&mbim_version, 
&mbimex_version);
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
> @@ -298,6 +322,22 @@ static void mbim_device_ready(void *user_data)
>   	struct mbim_data *md = ofono_modem_get_data(modem);
>   	struct mbim_message *message;
>   
> +	/* Version is formatted as (major version) << 8 | (minor version) */
> +	static const int mbim_version = 1 << 8 | 0;
> +
> +	/* Always open with MBIMEx 3, devices not supporting it will fallback to MBIMEx 2 */
> +	static const int mbimex_version = 3 << 8 | 0;

A minor nit, but 'q' in mbim_message_set_arguments() is a uint16_t, so 
these should probably also use that instead of int.


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
>   					MBIM_COMMAND_TYPE_QUERY)

I think both your code AND the existing code are missing calls to 
mbim_message_unref(). Though I just did a cursory scan, so maybe the 
messages are being unref'd and freed somewhere else?
;


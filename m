Content-Type: multipart/mixed; boundary="===============7879746622924242317=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v3 2/3] emulator: add drivers to request/release private
 network from ConnMan
Date: Thu, 05 May 2011 10:38:44 +0200
Message-ID: <4DC26214.8040400@linux.intel.com>
In-Reply-To: <4DC22361.5000906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7879746622924242317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 05/05/2011 06:11, Denis Kenzior wrote:
>> diff --git a/include/emulator.h b/include/emulator.h
>> index 5cd894b..a7fc23b 100644
>> --- a/include/emulator.h
>> +++ b/include/emulator.h
>> @@ -105,6 +105,24 @@ enum ofono_emulator_request_type ofono_emulator_req=
uest_get_type(
>>   void ofono_emulator_set_indicator(struct ofono_emulator *em,
>>   					const char *name, int value);
>>
>> +ofono_bool_t ofono_emulator_setup_ppp(struct ofono_emulator *em, int fd,
>> +				const char *server_ip, const char *peer_ip,
>> +				const char *primary_dns,
>> +				const char *secondary_dns);
>> +
>> +int ofono_emulator_get_uid(struct ofono_emulator *em);
>> +
> I'm not particularly happy with this, we should try to de-couple the
> private network provider from the emulator.  We might end up with other
> consumers later.
>
>> +struct emulator_network_provision_driver {
>> +	char *name;
>> +	int (*get_settings)(struct ofono_emulator *em);
>> +	void (*release)(int uid);
>> +};
>> +
> I'd say you're on the right track here, but modeling this even closer to
> gprs-provision might be a good idea.  Except you'll need to use a
> callback, so something like:
>
> struct ofono_private_network_settings {
> 	...
> };
>
> typedef (ofono_private_network_cb_t)(...);
>
> struct ofono_private_network_driver {
> 	char *name;
> 	int (*request)(ofono_private_network_cb_t cb, void *data);
> 	void (*release)(int id);
> };
>
>> +int ofono_emulator_network_driver_register(
>> +			const struct emulator_network_provision_driver *d);
>> +void ofono_emulator_network_driver_unregister(
>> +			const struct emulator_network_provision_driver *d);
>> +
> And then add __ofono_private_network_request / release to src/ofono.h
> for now.  Similar to how gprs_provision does things.

Should we add a new src into ofono that would implement those =

request/release functions and register the ofono_private_network_driver?
Something like private-network-provision.c?
Then we would have the driver and callback type definition into =

private-network-provision.h.

Kind regards,
Guillaume




--===============7879746622924242317==--


Content-Type: multipart/mixed; boundary="===============5080804942777748451=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 2/4] gprs: Add new external APIs to create,
 activate and remove a PDP context
Date: Thu, 05 May 2011 18:38:14 +0200
Message-ID: <4DC2D276.9020008@linux.intel.com>
In-Reply-To: <4DC21CA5.5070000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5080804942777748451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 05/05/2011 05:42 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 05/04/2011 12:26 PM, Philippe Nunes wrote:
>> ---
>>   include/gprs.h |   16 ++++
>>   src/gprs.c     |  234 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>   2 files changed, 246 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/gprs.h b/include/gprs.h
>> index 157a6f9..0bb37f7 100644
>> --- a/include/gprs.h
>> +++ b/include/gprs.h
>> @@ -36,6 +36,10 @@ typedef void (*ofono_gprs_status_cb_t)(const struct o=
fono_error *error,
>>
>>   typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void =
*data);
>>
>> +typedef void (*ofono_gprs_add_pdp_context_cb_t)(int error, char *interf=
ace,
>> +						char *ipv4, char *ipv6,
>> +						void *data);
>> +
>>   struct ofono_gprs_driver {
>>   	const char *name;
>>   	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
>> @@ -77,7 +81,19 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
>>   				unsigned int min, unsigned int max);
>>   void ofono_gprs_add_context(struct ofono_gprs *gprs,
>>   				struct ofono_gprs_context *gc);
>> +unsigned int ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
>> +					const char *type,
>> +					const char *protocol,
>> +					const char *apn,
>> +					const char *username,
>> +					const char *password,
>> +					const char *host);
>> +
>> +int ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs, unsigned int=
 id);
>>
>> +int ofono_gprs_activate_pdp_context(struct ofono_gprs *gprs, unsigned i=
nt id,
>> +					ofono_gprs_add_pdp_context_cb_t cb,
>> +					void *data);
>
> Why do you want to expose STK activated contexts over D-Bus and try to
> deal with the consequences of this decision?  Having oFono handle them
> completely internally would simplify the design quite a bit, no?

Yes, indeed. I thought that the PDP context created by and for oFono =

should be however visible from outside. But I agree,
STK PDP context should not be handled from outside. So, I will remove =

the D-BUS interface registration for this kind of context.

Should I also consider to not add this context to the gprs->contexts list?

As you can see, I'm using a callback to notify the STK atom when the =

context is activated. Since the context is no more subject to D-BUS =

handling, do you think I could map this callback directly as the =

callback for the gprs_context driver (id =

ofono_stk_activate_pdp_context_cb =3D ofono_gprs_context_cb_t)?

It implies that I need to setup the interface directly in the STK atom =

but so far, I don't know if you agree with the modifications I did in =

gprs.c regarding how this interface is updated when this is linked to a =

STK PDP context (particularly for the host route).
Perhaps, even if it duplicates some code, you would prefer to see the =

STK atom updating the interface directly?

Regards

Philippe.

--===============5080804942777748451==--


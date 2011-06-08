Content-Type: multipart/mixed; boundary="===============4105267467261696360=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/8] gprs: Add private APIs for
 adding/activating/removing hidden PDP contexts
Date: Wed, 08 Jun 2011 02:46:43 -0500
Message-ID: <4DEF28E3.3050205@gmail.com>
In-Reply-To: <4DF1E793.1050608@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4105267467261696360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>
>> As mentioned previously, I don't see the point of creating pri_context
>> structure for this.  So you can rip much of this stuff out.
> =

> =

> I don't understand why you think we don't need to create a pri_context.
> Could you clarify please?
> =

> Even if no parameters are provided by the UICC (id use default
> parameters), I still need to setup a dedicated primary context with
> defaults parameters since we can't double-activate an existing primary
> context.
> =


struct pri_context is used to store information pertinent to the D-Bus
API. Namely all the context attributes that are exposed on the
ConnectionContext interface.  You are not using any of them, and we do
not want to ever expose STK contexts over D-Bus.

In effect you're (ab)using a structure that was never meant for your
particular purpose, and moreover not using 90% of the members of that
structure.

Whenever you are faced with a situation like this you need to ask
yourself whether making a new structure would make more sense,
particularly from ease of implementation and code readability.
Generally the answer is 'yes'.

<snip>

>>> +unsigned int __ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
>>> +                    enum ofono_gprs_context_type type,
>>> +                    enum ofono_gprs_proto proto,
>>> +                    const char *apn,
>>> +                    const char *username,
>>> +                    const char *password,
>>> +                    const char *host);
>>> +
>>
>> I don't think this is needed at all.  All STK needs to do is just say
>> 'please activate a context with these params'.  You can pretty much get
>> away with __ofono_gprs_activate_context and
>> __ofono_gprs_deactivate_context.
>>
> =

> When "on link demand" mode is requested, we just need to setup the PDP
> context and return the PDP identifier. The PDP context activation is
> done only once we receive a proactive command SEND DATA with the
> qualifier "Send data immediately".
> So, I don't see how to differentiate this mode without the API
> "__ofono_gprs_add_pdp_context".
> =


There's nothing stopping you from recording the PDP context parameters
in stk.c and providing them to activate_context when some data is
actually sent.

> =

>>> +int __ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs,
>>> unsigned int id,
>>> +                    __ofono_gprs_remove_pdp_context_cb_t cb,
>>> +                    void *data);
>>> +
>>
>> Are you sure you really need the callback function here?  The spec is a
>> little fuzzy on when the terminal response is actually sent.
> =

> =

> At first sight, yes, that was also my opinion but then I saw the
> examples in annex I (TS 102 223).
> =

> For Close channel, we can see the following sequence:
> =

> UICC             Terminal                 SGSN
> =

> |--------------------->    |                |
> |    Close Channel    |                |
> |            | -------------------------->   |
> |            | Deactivate PDP context request|
> |            | <-----------------------------|
> |            | Deactivate PDP context accept |
> |<----------------------
>    Terminal response
> =

> That's why, I introduced the callback to trigger the Terminal response.
> =


Fair enough.

Regards,
-Denis

--===============4105267467261696360==--


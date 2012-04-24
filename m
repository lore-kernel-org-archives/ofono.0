Content-Type: multipart/mixed; boundary="===============8347281867665417134=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 11/13] call-forwarding: Re-run ss path queries on CFU
 unset
Date: Tue, 24 Apr 2012 15:21:18 -0500
Message-ID: <4F970B3E.6010006@gmail.com>
In-Reply-To: <4F97D900.7010701@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8347281867665417134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 04/25/2012 05:59 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 04/24/2012 12:28 AM, Denis Kenzior wrote:
>>> static void ss_set_query_cf_callback(const struct ofono_error *error,
>>> int total,
>>>
>>>       set_new_cond_list(cf, cf->query_next, l);
>>>
>>> +    if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL&&
>>> +            cf->query_next =3D=3D cf->query_end) {
>>> +        cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
>>> +        /*
>>> +         * CFU has been disabled, conditionals need to be updated
>>> +         */
>>> +        if (is_cfu_enabled(cf) =3D=3D FALSE)
>>> +            cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
>>
>> So a bit of background, the original set + query logic did not mess with
>> the CACHED flag.  The assumption was that we're modifying a single
>> property.  If the CACHED flag was already set, then the modification was
>> queried and the CACHED flag was still valid.  If the CACHED flag was not
>> set, then we'd re-query the entire thing anyway.
>>
>> Now we have a somewhat funny situation where when we clear CFU, we are
>> essentially forced into querying everything.  The immediate problem with
>> your approach is that we can't return from the method call until all
>> settings have been queried.  By convention the core can have only a
>> single outstanding call into the driver at a time.  We bend the rules
>> somewhat, but in general we need to stick to this rule.  This is why you
>> see busy error conditions everywhere.  So likely this needs a specific
>> code path ...
> =

> OK, thanks, I see. Would it make sense to return the method immediately
> and then to re-query the conditionals? Or, just to wait until anybody
> needs them?

This probably needs a bit of thought, but here's one possible strategy,
feel free to suggest any improvements:

- If unconditional is reset and conditionals are known (e.g. they were
queried before and not cleared) then we can simply signal them here

- If the unconditional is reset and the CACHED flag is not set (e.g. the
application didn't trigger a GetProperties yet) then we probably can
skip the re-query, the next GetProperties will do it for us.

- If unconditional is reset and CACHED is set but we don't know the
conditionals, then we should query all conditionals before returning
from the method call.

> =

>> Also, there is an optimization we can make here, e.g. if we queried the
>> conditional forwarding settings prior to CFU being enabled, then we can
>> keep those around.  This is why the TODO item refers to the 'conditional
>> cache.'  In the case of CFU being flipped to enabled and then disabled,
>> we do not need to query.
> =

> Thanks for the help here. Let's go for this approach too.

Okay, just remember the conditionals can be erased when CFU is active,
including through MMI codes.

Regards,
-Denis

--===============8347281867665417134==--


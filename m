Content-Type: multipart/mixed; boundary="===============3057144914362620105=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] call-forwarding: fix for showing call forwarding states
Date: Fri, 18 Mar 2011 11:39:46 -0500
Message-ID: <4D838AD2.90604@gmail.com>
In-Reply-To: <1300452832.2707.78.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3057144914362620105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 03/18/2011 07:53 AM, Jussi Kangas wrote:
> Hi,
> =

> On Thu, 2011-03-17 at 17:00 +0200, Denis Kenzior wrote:
>> Hi Jussi,
>>
>>>>
>>>> So correct me if I'm wrong, but I don't think we can do that.  the
>>>> current cf_conditions implementation stores all conditions, which could
>>>> be unrelated to voice; and if my interpretation of 22.004 is correct y=
ou
>>>> can have something like this:
>>>>
>>>> Activate CFB for all services to Number 1
>>>> Activate CFU for Data services to Number 2
>>>>
>>>> Which results in cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] not
>>>> being NULL and you reporting CFB for voice incorrectly.
>>>>
>>>> You are probably safer using is_cfu_enabled() function.
>>>
>>> As far as I know scenario you describe cannot happen with oFono. There
>>> is no data related conditions in the call forwarding API. Sure, you can
>>> set data forwarding on using SS API, but I don't see how data forwarding
>>> states could be shown in call forwarding API when all states in API
>>> start with word "voice". Also according to comments in code fax and data
>>> are not supported. =

>>>
>>
>> It can.  oFono stores _all_ conditions in its lists.  However, it
>> filters them when reporting the conditions in get_properties or signals.
>>  This is why is_cfu_enabled function looks the way it does.  So a
>> scenario like this is fully possible.  Not to mention that the CFs are
>> queried for all services by default.
> =

> All right. I have no access to network that would support data
> forwarding or my modem does not support it so I cannot verify this in
> practice. But I think problem can be avoided by changing the line =

> =

> if (cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] =3D=3D NULL) {
> =

> to =

> =

> if (!is_cfu_enabled(cf, NULL)) {
> =

> Of course little bit optimization would be good to avoid second calling
> of this method later in function. Moving the setting of status variable
> above these and using it when checked if UNCONDITIONAL is on instead of
> is_cfu_enabled seems to be working nicely.

Yes, lets do the optimization since its quite easy.

Regards,
-Denis

--===============3057144914362620105==--


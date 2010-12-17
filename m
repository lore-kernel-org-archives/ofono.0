Content-Type: multipart/mixed; boundary="===============2419992067437232664=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smsutil: do not hardcode TP-ValidityPeriod
Date: Fri, 17 Dec 2010 09:22:34 -0600
Message-ID: <4D0B803A.2080404@gmail.com>
In-Reply-To: <AANLkTi=145vZAoZwZjJYoZY9mc0_aabmYJywCTjZw0_N@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2419992067437232664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 12/17/2010 07:29 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2010/12/17 Denis Kenzior <denkenz@gmail.com>:
>> Can I get a bit more of an explanation from you as to why the 'absent'
>> validity period is better than hardcoding this to 24 hours?
> =

> If there is an explicit validity period, it overrides the default
> validity period set by operator. I'd rather let operator-set default
> validity period.
> =


Sounds good.  Can you resend this patch with the description stating the
above?

Thanks,
-Denis

--===============2419992067437232664==--


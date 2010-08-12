Content-Type: multipart/mixed; boundary="===============8186667039410702290=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Terminating emergency calls
Date: Thu, 12 Aug 2010 13:23:58 -0500
Message-ID: <4C643C3E.9080803@gmail.com>
In-Reply-To: <AANLkTik4EnzzKZi6JEk8Ai+it9C4z3YL+Rr95fG51z94@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8186667039410702290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 08/12/2010 12:39 PM, Sjur Br=C3=A6ndeland wrote:
> Hi Denis.
> =

> I thought of one more issue with voice calls.
> I don't think it is safe to to terminate emergency calls using
> release_specific, AT+CHLD=3D1X.
> At least this don't work for STE modems.
> =

> I suggest calls in state active should be terminated using hangup_all
> or hangup_active.
> What do you think?

So in the case of a single call, the emergency call will be terminated
using hangup_all / hangup_active anyway.  I have relaxed the single call
restriction for active calls when hangup_active is provided by the
driver.  Refer to c7b13ec2fe664b122216a312f2442c9ca26f5f43

For mpty calls this gets tricky.  I'd like some answers to these questions:

- Can Emergency calls participate in mpty?
- Can Emergency calls be HELD?
- How do we recognize Emergency calls?  Is simple string matching of
numbers in EmergencyNumbers of VoiceCallManager enough?

Regards,
-Denis

--===============8186667039410702290==--


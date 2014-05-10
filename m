Content-Type: multipart/mixed; boundary="===============5727766009943960716=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Network preference gsm is only working when allowing roaming?
Date: Fri, 09 May 2014 21:29:04 -0500
Message-ID: <536D8EF0.5090600@gmail.com>
In-Reply-To: <1399667297.22541.26.camel@pflykt-mobl1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5727766009943960716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrik,

>>
>> I'm not sure what the context of the question is, but RadioSettings API
>> is completely independent of the current registration status.
> =

> The context was that SIM shows home network as 08 with the current
> network being 24. The device thinks it is roaming while the user, in
> this case Niclas Karlsson, knows the device should be in its home
> network. So org.ofono.NetworkRegistration is the correct one here and
> any change in roaming status must come from the network? So this boils
> down to simply being connected to the wrong network after all?

This all depends.  The operation in question might be an MVNO, or the
operator has an agreement to "roam" on a network but all traffic be
treated as "home" for billing purposes.  There are very nasty details of
how the operator name is presented in these circumstances.  In certain
'roaming' conditions, the operator is presented just like it is a home
network.  See EFspn and EFspdi handling if you're curious.

This is what might be happening here.  The user is not connected to a
"home" network; however for all intents and purposes he is not really
roaming.  The current roaming logic uses the registration status as
reported by the modem firmware, which may not be satisfactory in this
particular situation.

Regards,
-Denis

--===============5727766009943960716==--


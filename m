Content-Type: multipart/mixed; boundary="===============4499373776090292537=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 4/4] TODO: Marking the Barred Dialing task as done
Date: Mon, 06 Dec 2010 17:48:47 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C40B3C@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTi=miVmCvvzHTA=athkJjxSRCVNJ9c21xTLxL+v0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4499373776090292537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,
 =

> Then as per your email, the support provided in Ofono seems to be
limited. If there is no enable or disable is allowed,
> I am not sure, how we can we have a card in which FDN enabled, which
will force the ofono to enter presim state. Unless there is no
> option to disable at, forever with that sim card, the phone will be in
presim state,leading to only placing of emergency calls.

Support for disabling FDN was discussed earlier. Denis/Pessi could you
confirm what was the decision made on FDN disable support?

> Thanks for confirming. Then in this case, are we not forcing the
mobile to go in a state, where if FDN is already enabled in the sim
card( may be from a different phone), =

> user allowed with no option rather than making an emergency call. =


Yes, we are forcing the mobile into presim state where only emergency
calls are allowed. We have already discussed this many times in irc and
its been agreed that only emergency calls are allowed when FDN or BDN
enabled SIM used.

Regards,
Jeevaka

--===============4499373776090292537==--


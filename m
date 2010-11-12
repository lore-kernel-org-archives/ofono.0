Content-Type: multipart/mixed; boundary="===============3097173596852918624=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Can I modify CallingLineRestriction(the Property of CallSetting)
 value to "disabled" or "enabled"
Date: Fri, 12 Nov 2010 16:19:31 +0200
Message-ID: <AANLkTi=-4hVwgoT=YmnSMhYNacz3yej1352GoXGHZfT0@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473305616E9@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3097173596852918624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/11/11 Gu, Yang <yang.gu@intel.com>:
>>What happens when you make a call? Does call get rejected or do you
>>get some CSSU indications?
>
> Thank you for the comments!
> After setting HideCallerId to "enabled", and making an outgoing call, the=
 call arrived at another phone as normal, and I didn't see any CSSU indicat=
ion. The call settings are listed below, in which the CallingLineRestrictio=
n is always disabled. I think this means the network disables this feature.=
 I also confirmed with our operator (CMCC), and they said they don't suppor=
t CLIR.

They really do not support it. Thanks for the logs.

There is a Finnish operator (Aino) which does not have CLIR
provisioned by default, they will reject the calls made with temporary
CLIR invocation.

It seems to me that the call-settings API stores the user preference
to the modem (how that is done is up to the modem). This can lead to
subtle privacy bugs if user has multiple SIM cards. I wonder if oFono
should store the CLIR settings in IMSI-specific storage. oFono should
somehow specify the interaction with the CLIR setting stored in the
modem, too.

-- =

Pekka.Pessi mail at nokia.com

--===============3097173596852918624==--


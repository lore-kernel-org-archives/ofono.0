Content-Type: multipart/mixed; boundary="===============7552124394295362934=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH] phonesim: Fix AT+CHLD=1x
Date: Wed, 14 Mar 2012 12:39:33 +0100
Message-ID: <4F608375.3040503@linux.intel.com>
In-Reply-To: <4F6004B7.8050608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7552124394295362934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 14/03/2012 03:38, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 03/13/2012 09:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> AT+CHLD=3D1x should only hangup active call
>> ---
>>   src/callmanager.cpp |   38 ++++++++++++++++++++++++--------------
>>   1 files changed, 24 insertions(+), 14 deletions(-)
>>
>
> What are you trying to fix here?  Phonesim models the behavior of an
> 'ideal' modem which can hangup any call using release_specific.  Plenty
> of modems exhibit this behavior via vendor specific AT commands, so if
> this is related to HFP emulation then we probably need to do something el=
se.
>
> Regards,
> -Denis
>

I found this during tests around AT+CHLD commands.
I just follows HFP and 3GPP specs about the AT+CHLD=3D1x command : =

"Releases a specific active call X.".
But if this is the attended behavior in phonesim, just forget my patch.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============7552124394295362934==--


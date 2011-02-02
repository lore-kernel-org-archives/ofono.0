Content-Type: multipart/mixed; boundary="===============1393296494795783602=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 2/2] voicecall: try harder to avoid Dial mismatches
Date: Wed, 02 Feb 2011 16:57:20 +0200
Message-ID: <AANLkTi===2oFMMLP-DAeyTRTdnX6anHHQ7c40KNVHO_h@mail.gmail.com>
In-Reply-To: <4D48B262.8060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1393296494795783602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/2/2 Denis Kenzior <denkenz@gmail.com>:
> On 02/01/2011 04:22 PM, Pekka.Pessi(a)nokia.com wrote:
>> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>>
>> There were some cases where Dial returned an incorrect call object,
>> e.g., after oFono crash and recover.
>> ---
>> =C2=A0src/voicecall.c | =C2=A0 15 +++++++++++++++
>> =C2=A01 files changed, 15 insertions(+), 0 deletions(-)
>
> So I'm guessing that you're restarting oFono and get
> ofono_voicecall_notify events without setting dial_result_handled properl=
y.
>
> Do you think it is a better idea to resurrect the old list_calls driver
> method and fire this off explicitly when the atom is registered? =C2=A0The
> callback can then take care of setting dial_result_handled appropriately.

That is one possibility.The belt-and-suspenders approach of
prepare_to_dial() makes oFono more robust in case there is someone
talking directly to modem behind oFono's back, however.

-- =

Pekka.Pessi mail at nokia.com

--===============1393296494795783602==--


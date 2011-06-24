Content-Type: multipart/mixed; boundary="===============9213930282418248229=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [HELP] HFP Outgoing Call Method (Dial)  Not Responding
Date: Fri, 24 Jun 2011 09:43:39 -0500
Message-ID: <4E04A29B.6010302@gmail.com>
In-Reply-To: <10D123A956DC4B4FA9D7A48B33358362150C959DA7@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9213930282418248229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On 06/24/2011 06:27 AM, milan.satpathy(a)accenture.com wrote:
> Hi,
> =

>  =

> =

> Recently I was testing a small hands free use case using Ofono(version
> 0.48).
> =

>  =

> =

> _Scenario_:
> =

>  =

> =

>    1. Make an incoming call to the remote AG phone number.
>    2. Accept the incoming call using Ofono D-BUS call.
>    3. Once the incoming call is active, create an outgoing call ( =E2=80=
=9CDial=E2=80=9D
>       ) using Ofono D-BUS call.
> =

>  =

> =

> _Problem Faced:_
> =

> The =E2=80=9CDial=E2=80=9D method does not reply in this case. Hence, the=
 outgoing call
> establishment also does not happen.
> =

>  =

> =

> _Request For Assistance_:
> =

>  =

> =

> I would like to know if Ofono supports a multiple call feature like this.
> =

>  =

> =

> If anybody could succeed in making an outgoing call in the above
> explained scenario,
> =

> please let me know the make of the handset you could test with.
> =


Placing a Dial with an active call is not always guaranteed to work,
particularly on HFP.  Many HFP AG implementations are highly buggy.  I
can't really say more without seeing the AT command trace.

Regards,
-Denis

--===============9213930282418248229==--


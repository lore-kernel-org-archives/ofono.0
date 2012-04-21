Content-Type: multipart/mixed; boundary="===============0924009939132045343=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: Re: [PATCH] voicecall: fix release and answer existing call validation
Date: Fri, 20 Apr 2012 20:34:22 -0500
Message-ID: <CAB7rCTiJru0FWihEQS82FWffA6UBdGrurZhuf-XBPWNSqKFqVw@mail.gmail.com>
In-Reply-To: <4F901641.2020104@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0924009939132045343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 19, 2012 at 8:42 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Michael,
>
> On 04/19/2012 05:10 PM, Mike Brudevold wrote:
>> From: Michael Brudevold <michael.brudevold@logicpd.com>
>>
>> Release and answer should be allowed when there are held calls as well a=
s the
>> existing check for waiting calls. =C2=A0Most implementations use AT+CHLD=
=3D1 which
>> will resume the other call, be it waiting or held. =C2=A0This follows th=
e HFP,
>> GSM 07.07 and 3GPP 27.007 specs.
>> ---
>> =C2=A0src/voicecall.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>
> This isn't really a bug, but an explicit choice we made with the API.
> See the previous discussion here:
> http://lists.ofono.org/pipermail/ofono/2011-January/008029.html.
>
> For HFP this is further made funny by the fact that CHLD=3D1X is supposed
> to retrieve the held call automatically for you by the AG according to
> section 4.32.1, making CHLD=3D1 behavior in question somewhat redundant.
>
> However, I do see that this could be useful, so I suggest we add a new
> ReleaseAndSwap method. =C2=A0I prefer this approach especially since the
> current D-Bus API is frozen and I don't want to modify the behavior of
> existing methods.
>
> Regards,
> -Denis

Sounds good to me. Clearly not having the ability to do this is
annoying to more than just me!  My first solution was as you proposed
before where the active call was hungup, but that left the held call
on hold.  Not having read the spec fully yet left me a bit confused as
to why I would want that behavior.  So, the preferred solution is
getting this all done in one step, and ReleaseAndSwap should do
nicely.

Mike

--===============0924009939132045343==--


Content-Type: multipart/mixed; boundary="===============6929133327340587778=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT channel problem
Date: Fri, 06 May 2016 10:48:46 -0500
Message-ID: <572CBCDE.5080103@gmail.com>
In-Reply-To: <CAH4ZQwtSaTT1KxR4g30oWW2TbRiRgOB-3CCWRmp9A457OP9how@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6929133327340587778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 05/06/2016 05:06 AM, Enrico Sau wrote:
> =E2=80=8BHi Denis,
>
> discard my last mail please, I went back some step and I found that in
> the modem bus there are =E2=80=8Bspare characters which may get the state
> machine confused.

Do you have a log handy?

>
> I'm thinking abut solving the problem from the plugin because this
> happens when I insert the sim.
>
> Is there a safe way to reset the modem at channel including the syntax
> from the plugin?

Not really, but you can try writing your own syntax if the garbage the =

modem sends is not random.

Regards,
-Denis

--===============6929133327340587778==--


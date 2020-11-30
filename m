Content-Type: multipart/mixed; boundary="===============4807702692745877617=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: Re: Broken ofono 4G LTE network
Date: Mon, 30 Nov 2020 12:19:15 +1100
Message-ID: <CAA=hcWQvrgiyjGY_V69QjZByf34nLhvAYJPudGR1sEYwgWTc3w@mail.gmail.com>
In-Reply-To: <CAA=hcWRMBM++xm3yCLCF2_3Fb5y7vqj4mkH9_Q5ikFC5QyxweQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4807702692745877617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My apology, please ignore it, seems that there were build issues,
clear up the whole build directory, fixed the problem.

Sorry about it.

Thank you.

Kind regards,

- j

On 11/29/20, Jupiter <jupiter.hce@gmail.com> wrote:
> Hi,
>
> While I was playing with ofono source code qmitmodem to debug LTE
> re-register issue (in my another email), for some reason, it broken
> ofono, there was not network IP address, I ran the AT manually in
> command line, I can see the LTE modem is connected to the carrier, but
> ofono could not talk to modem, there is no IP address. I reversed the
> source code to remove changes, cleared the build, and rebuild the
> image, but it is still broken, no IP, tried following command, it was
> an empty string:
>
> # dbus-send --system --print-reply --dest=3Dorg.ofono /
> org.ofono.Manager.GetModems
>
> method return time=3D1606601259.667554 sender=3D:1.2 -> destination=3D:1.=
121
> serial=3D12
> 0 reply_serial=3D2
>    array [
>    ]
>
> Sorry, what could I be missing?
>
> Thank you.
>
> Kind regards,
>
> - j
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
--===============4807702692745877617==--


Content-Type: multipart/mixed; boundary="===============4721045741198787118=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ICCID not requested when PIN is locked
Date: Tue, 28 Oct 2014 11:19:34 -0500
Message-ID: <544FC216.9060905@gmail.com>
In-Reply-To: <CAH4ZQwsXibijyOySYBo2M8SvdN2CTKUSveFNffZmmHK1jcc90Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4721045741198787118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 10/28/2014 06:50 AM, Enrico Sau wrote:
> Hi all,
> I have a problem with SimManager interface.
> When I start ofono with pin locked it starts to read the sim file
> manager but the first message fails:
>
> ofonod[29427]: Aux: > AT+CRSM=3D192,12258\r
> ofonod[29427]: Aux: < \r\n+CME ERROR: 4\r\n
>
> The callback of this message contains the following call which would
> success but it is never called because of the error.

This is a modem firmware problem.  The ICCID request should always =

succeed, even if the PIN is locked.

>
> This results in the problem that ICCID is never retried even if I enter
> the pin.
>
> How can I solve this problem?
>

You can disable the PIN, or power-cycle the modem.

You can also add code to try re-reading the ICCID when PIN is entered. =

Patches are always welcome.

Regards,
-Denis

--===============4721045741198787118==--


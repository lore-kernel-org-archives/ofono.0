Content-Type: multipart/mixed; boundary="===============7741236402020654513=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: U-Blox modem sends unprintable chars before "AT+CGMS=<seq>"
 reply: ofono (1.16) close the serial port ?
Date: Sun, 29 Nov 2015 15:47:25 -0600
Message-ID: <565B726D.4080506@gmail.com>
In-Reply-To: <CAJvjxsz6pieOW_eqy+B+vHdgSxmPxnkBpF1dyM1M8Fi7VoA48g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7741236402020654513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On 11/24/2015 03:45 AM, Fabio wrote:
> Hello,
> I'm using ofono 1.16 with some patch to add sms manager to the Ublox driv=
er.
>
> Someone could confirm that ofono close the serial port when it receives
> some unexpected/unprintable character before the "AT+CGMS=3D<seq>" reply
> from the modem?

No, oFono does not close serial ports because of garbage.  The syntax =

will generally discard / ignore AT commands that are not properly formatted.

>
> If yes, is possible to discard these characters instead of hanging-up
> the serial port? Could I have some info about the source I have to patch ?
>

Feel free to provide AT command logs to help us better understand what =

is happening.

Regards,
-Denis


--===============7741236402020654513==--


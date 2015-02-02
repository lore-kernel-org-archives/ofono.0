Content-Type: multipart/mixed; boundary="===============8070917595972513161=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofonod crashes during enable-modem.py
Date: Mon, 02 Feb 2015 09:10:41 -0600
Message-ID: <54CF9371.2090002@gmail.com>
In-Reply-To: <4DAF1732-7FA7-4211-94DB-DBD69CD04F20@long-exposure.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8070917595972513161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Norbert,

Please don't top-post on this mailing list.  That's just our convention =

here.  Anyway, see below:

On 02/01/2015 08:00 AM, Norbert Huffschmid wrote:
> Hi Denis,
>
> now I have installed ofono from the debian jessie testing branch (which
> has packaged ofono 1.15-2). Bluez is still version 4.99 and all the rest
> is debian wheezy as before. Now the list-modems.py script does not show
> any modem any more. Are there dependency issues?
>

BlueZ4 requires --with-bluez4 when configuring oFono.

> I already had tried a combination of ofono 1.15-2 and Bluez 5.23, which
> was quite promising. I could successfully establish a phone call by
> means of the dial-number.py script. But there was no voice connection
> established between the endpoints. This was quite astonishing because
> A2DP streaming from the smartphone to the Raspberry Pi worked like a
> charm. And I don't think that it was a phone issue because a HFP
> connection from the phone to a navigation device works well too.
>

oFono and BlueZ are not the only ones at play.  The audio is handled by =

PulseAudio.  So I would check on the PulseAudio mailing list which =

version of PulseAudio you need.

> I have read somewhere that Bluez5 does not support HFP at all, so I did
> not further follow this approach.

Correct, sort of.

>
> Any proposal which combination of ofono and Bluez is most promising in
> order to establish a HFP voice connection?
>

As mentioned before, BlueZ and oFono are not the problem here.  Check =

back with PulseAudio folks.

Regards,
-Denis

--===============8070917595972513161==--


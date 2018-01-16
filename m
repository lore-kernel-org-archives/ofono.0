Content-Type: multipart/mixed; boundary="===============4084624702206254625=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem with dialstring ##21#
Date: Tue, 16 Jan 2018 10:35:01 -0600
Message-ID: <f38e2506-0a5f-749e-9e32-9b0152c075db@gmail.com>
In-Reply-To: <1cbfa8b7-2a62-52e9-089a-3e10d33f274f@torremans.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4084624702206254625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Engelbert,

Please no top-posting on this mailing list.

On 01/16/2018 10:22 AM, Engelbert Torremans wrote:
> Denis,
> =

> Thanks.
> =

> The thing is that it does work when I am trying the same thing in my car =

> :-) That is probably not based on ofono (I don't know what is used =

> inside) but at least it works when having my phone connected via bluetooth
> =

> So if would like to change this behaviour where would I need to change =

> the code so these ## codes are sent to the phone acros the bluetooth =

> interface?
> I don't mind creating my "own" version.

Not sure why this is really important to you, but okay ;)  The easiest =

way would be to implement a call-forwarding atom driver for HFP, e.g. =

drivers/hfpmodem/call-forwarding.c.  You would then have to instantiate =

it inside plugins/hfp_hf_bluezN.c.

Hacking this in is the easy part.  Enabling the call forwarding atom =

only for those devices that truly support it is harder.

> =

> BTW I am using version 1.20 now because I can't get 1.21 compiled on the =

> RaspberryPi
> =


Feel free to send a gcc error log so I can look at it.

Regards,
-Denis

--===============4084624702206254625==--


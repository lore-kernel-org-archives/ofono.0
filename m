Content-Type: multipart/mixed; boundary="===============2145125910628185119=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [rfc] Motorola Droid 4 voice: integrate into atmodem or
 completely separate?
Date: Sun, 11 Aug 2019 09:31:19 -0500
Message-ID: <174aba4c-e8a4-c059-ffcb-64770aae7401@gmail.com>
In-Reply-To: <20190812082251.GA6161@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2145125910628185119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 8/12/19 3:22 AM, Pavel Machek wrote:
> Hi!
> =

> Droid 4 has ... something similar to AT commands, but not quite. For
> voice calls, I modified atmodem... but I guess there are so many
> changes that creating separate motorolamodem/voicecall.c might be
> an option? (send_clcc() changes make sense as a cleanup, and were sent
> in separate mail.)

Since it looks like the Modem does actually provide some rudimentary =

unsolicited call state notifications via CIEV, you're better off just =

writing a custom driver.  CLCC polling logic is actually quite complex =

as it is, so adding vendor branching to it just makes things worse. =

Also the driver is likely to be much simpler if you can rely on =

unsolicited call state reporting events.

The send_clcc change does sort of make sense separately.

Regards,
-Denis

--===============2145125910628185119==--


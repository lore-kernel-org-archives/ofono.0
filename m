Content-Type: multipart/mixed; boundary="===============4349844677550162484=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono with serial modem
Date: Fri, 02 Dec 2011 05:48:38 -0600
Message-ID: <4ED8BB16.4020302@gmail.com>
In-Reply-To: <CAC+thW0YjVzQ-w0FOC228d+48Ug0o2+xpO5x44XL8LhL+nP7hg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4349844677550162484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

>> See the calypso modem driver in plugins/calypso.c for an example as well
>> as doc/calypso-modem.txt for an example udev rule.
> =

> At moment I'm interested in using ofono with a Telit GPRS module with
> serial interface.
> As far as I understand, there already exist a driver for Telit UC864-G
> in plugins dir. I'm trying to figure out how much of this driver can
> be used for other modules by Telit. I'm trying to follow the code path
> from udev detection down to driver selection. I'm therefore slightly
> confused by the interaction of the two modules udev.c and udevng.c. I

udev is the old detection code, udevng is the next generation detection
code.  They work together at the moment.

> see setup and init function for different modems in both of them. Are
> they supposed to provide different functions or is "ng" a short for
> new-generation or the like? If so, and supposed I need to write a new
> driver for the modem, where should I hook it?

If you're adding a new serial modem then likely you want to put it into
udev.c for now.  udevng is limited to USB devices only at the moment.

Regards,
-Denis

--===============4349844677550162484==--


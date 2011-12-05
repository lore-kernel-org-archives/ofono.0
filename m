Content-Type: multipart/mixed; boundary="===============4405279322910549140=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: Re: ofono with serial modem
Date: Mon, 05 Dec 2011 14:52:03 +0100
Message-ID: <CAC+thW0YjVzQ-w0FOC228d+48Ug0o2+xpO5x44XL8LhL+nP7hg@mail.gmail.com>
In-Reply-To: <4ED5F444.3090401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4405279322910549140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Denis!
Thank you for clarifications. I'm getting better understanding of
ofono architecture now. See a few more comments below.

On Wed, Nov 30, 2011 at 10:15 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>> 1. Are non-hot-pluggable serial modem supported by ofono? I believe
>> they should run with the atmodem driver: is this correct?
>
> Yes they are, however they are still detected via udev and require a
> proper modem driver. 'atmodem' is a collection of atom drivers that
> implement generic 27.007 functionality. =C2=A0The difference should be
> explained nicely in the presentations posted on the site.

Just a suggestion here. It was quite difficult for me to find those
presentations: links are only available as pretty old blog posts!
It would probably be nice to link them in the Documentation section or
in the wiki.

> See the calypso modem driver in plugins/calypso.c for an example as well
> as doc/calypso-modem.txt for an example udev rule.

At moment I'm interested in using ofono with a Telit GPRS module with
serial interface.
As far as I understand, there already exist a driver for Telit UC864-G
in plugins dir. I'm trying to figure out how much of this driver can
be used for other modules by Telit. I'm trying to follow the code path
from udev detection down to driver selection. I'm therefore slightly
confused by the interaction of the two modules udev.c and udevng.c. I
see setup and init function for different modems in both of them. Are
they supposed to provide different functions or is "ng" a short for
new-generation or the like? If so, and supposed I need to write a new
driver for the modem, where should I hook it?

Thanks again for your help
Regards,
Andrea

--===============4405279322910549140==--


Content-Type: multipart/mixed; boundary="===============4986307340340400458=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit driver implementation
Date: Tue, 16 Sep 2014 08:01:00 -0500
Message-ID: <5418348C.3090602@gmail.com>
In-Reply-To: <CAH4ZQwudt7S0twGZRyMXOOZhoPcNJSjUmLo-wmniY9DrDgL4KQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4986307340340400458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

Please do not top-post on this mailing list.

On 09/16/2014 04:36 AM, Enrico Sau wrote:
> Thanx for the quick answer,
> what I don't really understand is the difference between drivers and
> plugins in ofono.

Generally drivers/ directory contains atom drivers.  e.g. =

radio_settings, gprs, netreg, etc.  plugins/ contains modem drivers. =

There are a few additional special cases, but that is essentially the =

break down.

> Let's take an example: I need radio-settings interface to get and set
> the technology preference. This interface is not implemented in atmodem
> driver.
> Is it better to extend atmodem driver or to create a new driver? If I
> can do it in plugin it would be fine, but how?

In this case it would be better to write a new atom driver. e.g. =

drivers/telitmodem/radio-settings.c.

> Plus I will need to extend the dbus interfaces to have some more method.
> Looking at the dbus code I see that it calls the driver implementations,
> so I think I have to either extend the atmodem driver or to create a new
> one.

What methods do you need exactly?

Regards,
-Denis

--===============4986307340340400458==--


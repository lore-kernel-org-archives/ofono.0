Content-Type: multipart/mixed; boundary="===============6563742623436642785=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH 04/18] gisi: fix subscription for wgmodem2.5
Date: Wed, 16 Feb 2011 12:33:44 +0100
Message-ID: <4D5BB618.1060504@stericsson.com>
In-Reply-To: <AANLkTi=aS+22cSBibi=i=2K4bcYzLbKtiJ9gtpACL-KS@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6563742623436642785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 2011-02-16 12:16, Aki Niemi wrote:
> Curly brackets are either in both if and else, or in neither. I
> actually prefer not to have them here, since the first line is just a
> comment in the else statement. ;)

Yes you're right :)

> This is not necessary, as a modem plugin is supposed to call
> g_isi_modem_set_device() to set the modem->device to whatever it needs
> to right after creating the GIsiModem instance.
>
> In other words, the assumption is that when the GIsiModem instace is
> actually used, all necessary internal data, such as flags and the
> remote device have already been set.

Tested and works fine, will submit a new patch for the u8500 plugin. =

This is not done in the n900 plugin though, perhaps not necessary ?

Regards
Andreas


--===============6563742623436642785==--


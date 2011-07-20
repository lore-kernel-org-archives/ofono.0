Content-Type: multipart/mixed; boundary="===============8829168996625135495=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 15:17:50 +0200
Message-ID: <1311167871.21109.247.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F060A7@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8829168996625135495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> >Have you tried empty strings like "". Have you tried random values? Do
> >they have to be really specific ones.
> >
> >Is the password checked? Or just the username? Maybe they treat the
> >username as pseudo APN of some sort, but the password means nothing.
> >
> >OFONO_PPP_DEBUG for starters. And then using cdmadial to create a full
> >pppdump compatible log would be good idea. Something that we can open in
> >Wireshark.
> =

> Here are cdmadial result with multiple possibility. The one with 2 tty is=
 funy ;)
> =

> So from the result, I can tell that both login and password are checked.

fair enough. That is enough for me to confirm that it is used in real
networks. We do not like to add APIs for something that is not used
anymore only because some specification or RFC says so ;)

Patch has been applied now. However I changed the commit prefix back to
doc: to make it look cleaner.

For you two TTY cases. That is normal. Huawei treats the first TTY as
modem to issue PPP on it. And the second one (PCUI) is used for
notifications. So yes, oFono needs to open both. You will need the
second one for network registration updates.

Regards

Marcel



--===============8829168996625135495==--


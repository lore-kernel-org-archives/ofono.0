Content-Type: multipart/mixed; boundary="===============9042220330327685464=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv7] plugin: Add ste modem initd integration
Date: Tue, 11 Jan 2011 14:58:24 -0800
Message-ID: <1294786704.3873.42.camel@aeonflux>
In-Reply-To: <1294786590-10241-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9042220330327685464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> This patch introduces auto discovery of ST-Ericsson modems.
> ST-Ericsson modems (M57XX, M7XX, M74XX) are managed by a
> Modem Init Daemon responsible for start, power cycles,
> flashing etc. This STE plugin monitors the modem state exposed
> from the Modem Init Damon's Dbus API. When the modem is in state
> "on" the STE modem is created and registered. Muliple modem
> instances, and reset handling is supported.

<snip>

> Am I still out of luck?
> =

> $ git pull
> Already up-to-date.
> $ git am 0001-plugin-Add-ste-modem-initd-integration.patch
> Applying: plugin: Add ste modem initd integration

patch has been applied. Thanks.

Regards

Marcel



--===============9042220330327685464==--


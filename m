Content-Type: multipart/mixed; boundary="===============6004696012035063031=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 0/7] STE-plugin: Second RFC on STE patch-set
Date: Tue, 19 Jan 2010 10:56:50 -0800
Message-ID: <1263927410.5591.173.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6004696012035063031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> This is the second RFC on the STE driver.Most review
> comments should be included, except for using glib for
> XML parsing and changes to voice-call termination.
> We'll have to get back to this later.

we are getting to closer to something that can be merged as a first
draft and then later extended.

> Sjur Brandeland (7):
>   STE-plugin: Add --disable-stemodem to makefiles.
>   STE-plugin: Add vendor STE and quirks in atmodem.
>   STE-plugin: STE modem driver definition
>   STE-plugin: Add STE plugin
>   STE-plugin: Voicecall driver.
>   STE-plugin: Add CAIF header files in gcaif.
>   STE-plugin: GPRS driver.

So the order of these patches is kinda messed up. Think about it like
this; only adding patch 1 makes the compilation and hence git bisect
break. That should be the last patch.

Also you are adding CAIF headers after you already rely on them in a
previous patch.

Regards

Marcel



--===============6004696012035063031==--


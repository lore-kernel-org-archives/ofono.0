Content-Type: multipart/mixed; boundary="===============7612335723566812648=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [ANNOUNCE] oFono 0.32
Date: Wed, 20 Oct 2010 22:21:47 -0500
Message-ID: <4CBFB1CB.9070408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7612335723566812648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

We've been promising for a long time to start doing release e-mails, so
now is as good a time as any.

oFono 0.32 is out.  This release is a mixed development and bug fix
release with focus on stabilizing the Infineon modem support.  We also
fix some long standing issues with USSD handling.

ChangeLog:
- Fix issue with AT+VTS not using quotes.
- Fix issue with entering PUK and Infineon modems.
- Fix issue with SIM hotswap and Infineon modems.
- Fix issue with hangup active and ISI modems.
- Fix issue with logic to validate USSD strings.
- Add support for call in progress logic to USSD handling.
- Add support for detecting FDN enabled SIM cards.
- Add support for accessing SIM icon storage.

The signed tarballs for oFono 0.32 can be found on kernel.org [1] [2].

[1] http://www.kernel.org/pub/linux/network/ofono/ofono-0.32.tar.bz2
[2] http://www.kernel.org/pub/linux/network/ofono/ofono-0.32.tar.bz2.sign

Regards,
-Denis

--===============7612335723566812648==--


Content-Type: multipart/mixed; boundary="===============4384335777330343399=="
MIME-Version: 1.0
From: Jarkko Lehtoranta <devel@jlranta.com>
Subject: Huawei voice output port issue + patch
Date: Sat, 10 Mar 2012 01:49:55 +0200
Message-ID: <4F5A9723.5000809@jlranta.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4384335777330343399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Voice output serial port is enabled on some Huawei models (e.g. E169) =

without problems, but for example on E173u-2 it is never enabled during =

an incoming call. There might also be other Huawei models having the =

same issue.

I traced the issue down to "^DDSETEX" AT command, which is used to =

notify the device to start streaming audio. It seems that Ofono sends =

this command too early on incoming calls. The command should always be =

sent *after* the dial "D" or answer "A" command. The patch fixes this =

behavior and afterwards voice will also work on E173u-2.

Bug: https://bugs.meego.com/show_bug.cgi?id=3D25004
Patch: https://bugs.meego.com/attachment.cgi?id=3D9702

-Jarkko

--===============4384335777330343399==--


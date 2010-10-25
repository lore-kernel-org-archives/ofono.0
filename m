Content-Type: multipart/mixed; boundary="===============4083863101034850530=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [ANNOUNCE] oFono 0.33
Date: Mon, 25 Oct 2010 11:29:46 -0500
Message-ID: <4CC5B07A.2070404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4083863101034850530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

oFono 0.33 is out.  This release is mostly a mixed development and bug
fix release.  The main new features are Fixed Dialing support and Send
DTMF support.  Another major feature is GPRS support on Infineon modems.

ChangeLog:
- Fix wrong string to enum mapping of radio settings.
- Fix issue with MMI code to bearer class mappings.
- Fix issue with setting correct phase from EFphase.
- Fix issue with phonebook handling and Infineon modems.
- Fix issue with STK session end handling and Infineon modems.
- Fix issue with SMS handling and ISI modems.
- Fix issue with setting SCA type and ISI modems.
- Add support for FastDormancy property.
- Add support for FixedDialing property to indicate FDN.
- Add support for Infineon specific M-RAW_IP GPRS context.
- Add support for handling Send DTMF proactive command.
- Add support for handling SIM Toolkit text attributes.

The signed tarballs for oFono 0.33 can be found on kernel.org [1] [2].

[1] http://www.kernel.org/pub/linux/network/ofono/ofono-0.33.tar.bz2
[2] http://www.kernel.org/pub/linux/network/ofono/ofono-0.33.tar.bz2.sign

--===============4083863101034850530==--


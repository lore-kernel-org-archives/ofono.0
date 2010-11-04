Content-Type: multipart/mixed; boundary="===============5068509123118723341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [ANNOUNCE] oFono 0.34
Date: Thu, 04 Nov 2010 08:53:27 -0500
Message-ID: <4CD2BAD7.8080207@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5068509123118723341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

oFono 0.34 is out. This release is a mixed stabilization and development
release.

The major change in this release is the removal of modemconf plugin.
This plugin has been deprecated for some time and we decided it was time
to finally remove it.  If you were using modemconf along with phonesim,
the phonesim plugin now takes over this responsibility.  The
configuration file format for this case remains almost unchanged, but
has been moved to phonesim.conf.  For other users of modemconf, please
switch to udev or write a dedicated plugin.

Another major change is support for multiple active GPRS contexts.  This
feature has been lightly tested on MBM and IFX modems, please report
back any issues.

Finally several crashing bugs were fixed and IFX support for GPRS
connections was further stabilized.

ChangeLog:
- Fix issue with sim_fs_op_error handling.
- Fix issue with not handling GPRS context driver failures.
- Add support for multiple GPRS context activations.
- Add support for deactivating all GPRS contexts.
- Add support for configuring MMS context settings.
- Add support for barred dialing indication property.
- Add support for fast dormancy settings property.
- Add support for handling Play Tone proactive command.
- Add support for indicating handled STK proactive commands.
- Add support for two active GPRS contexts with MBM modems.
- Add support for time zone reporting with Ericsson MBM modems.
- Add support for detecting IFX modems stuck in multiplexer mode.
- Add support for IFX using up to three active GPRS contexts.
- Add support for IFX device shutdown when DLC disconnects.
- Add support for Phonesim specific configuration files.
- Remove deprecated modem.conf support.

The signed tarballs for oFono 0.34 can be found on kernel.org [1] [2].

[1] http://www.kernel.org/pub/linux/network/ofono/ofono-0.34.tar.bz2
[2] http://www.kernel.org/pub/linux/network/ofono/ofono-0.34.tar.bz2.sign

Regards,
-Denis

--===============5068509123118723341==--


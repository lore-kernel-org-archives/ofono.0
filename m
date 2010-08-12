Content-Type: multipart/mixed; boundary="===============6661218930581912683=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Removal of modemconf plugin
Date: Thu, 12 Aug 2010 11:00:11 -0400
Message-ID: <1281625211.12579.279.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6661218930581912683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

so the modemconf plugin seemed to be a good idea at the time I wrote it,
but lately is causes more issues and confusion than it solves. So we
will be removing this plugin shortly.

For this to happen the following dependencies need to be solved first:

	1) Move phonesim plugin over to use /etc/ofono/phonesim.conf

	2) Create configure option to build without phonesim support

	3) Create udev rule for Calypso device detection

	4) Modify Calypso plugin to work with udev rule

Using special udev rules for special devices (in conjunction with the
oFono auto-detection rule) make the process of setting up oFono for the
system integrator a lot simpler. No manual configuration file patching
anymore. Just installation of an additional udev rule.

The open here is the ISI modem detection, but this should be clearly
done via a Phonet plugin. And also the N900 specific case inside
modemconf is just wrong. This needs to be fixed and just auto-detected
via Phonet or maybe just via RTNL directly.

Regards

Marcel



--===============6661218930581912683==--


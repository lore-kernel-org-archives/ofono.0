Content-Type: multipart/mixed; boundary="===============0416472782807397634=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: First release with GPRS support
Date: Tue, 24 Nov 2009 01:33:40 +0100
Message-ID: <1259022820.2967.20.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0416472782807397634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I just tagged, pushed and uploaded 0.11 release of oFono. Besides the
usual bug fixes in various areas, this comes now with GPRS support. If
you happen to have a Ericsson MBM or Option HSO based modem, then you
under lucky ones who can try GPRS support.

To configure your Primary GPRS Context, you can use the create-context
script from within the test directory:

	create-context <apn>

You just have to give it the APN from your GPRS network settings. And
then list-contexts will show you the configured context. A context needs
to only configured once by SIM card. It will be stored on a per SIM card
basis and restored after restart.

To activate or deactivate the actual connect, activate-context and/or
deactivate-context can be used. On success just call list-contexts again
and you will see your IP settings.

The integration of oFono GPRS support for ConnMan is work in progress
and we hope to finish that pretty soon. So the next ConnMan release
should be able to talk to oFono for data connections.

Regards

Marcel



--===============0416472782807397634==--


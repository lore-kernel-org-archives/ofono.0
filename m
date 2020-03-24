Content-Type: multipart/mixed; boundary="===============6811391747790756945=="
MIME-Version: 1.0
From: Marek Szuba <scriptkiddie@wp.pl>
Subject: Using a Huawei modem in NCM mode
Date: Tue, 24 Mar 2020 15:05:58 +0100
Message-ID: <6c5da4e0-a4df-6d3a-8890-c9673f50d019@wp.pl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6811391747790756945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

A possibly stupid question: is there any way of having my broadband
modem, a Huawei E3372 (12d1:155e), connect in NCM mode rather than
PPP-via-Modem mode? At first I thought this mode was not supported for
Huawei in spite of it exposing a CDC_NCM interface to the system which
the kernel has used to create a WWAN network interface. Then however I
noticed ofonod logs report the modem as capable of both Modem and NDIS
modes, and posts and patches I have found on OpenWRT mailing lists
(comments elsewhere invariably said one had to flash stick-mode firmware
to make it work, which however I am confident is not needed in my case
because I can get the stick out if Hilink and into Modem/NDIS mode
simply by setting the right option in usb_modeswitch configuration)
suggest switching to NDIS mode might be a simple matter of sending an
appropriate AT^NDISDUP command. Unfortunately, I haven't found anything
on how to achieve this in oFono.

Just to make it clear, the ttyUSB0+ppp mode of this modem works
perfectly with oFono.

Again, thank you in advance for your answers.

-- =

MS
--===============6811391747790756945==--


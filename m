Content-Type: multipart/mixed; boundary="===============8385075026591409978=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Huawei EC1260 not working
Date: Fri, 01 Oct 2010 12:57:42 +0200
Message-ID: <1285930662.4231.11.camel@aeonflux>
In-Reply-To: <AANLkTimJHAJNB7HDMdBzjQ3L2voPVQ0j8CxHg9TT-Se7@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8385075026591409978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Debayan,

> I have a Huawei EC1260 modem. It gets detected as a GSM modem without
> installing usb_modeswitch on my MeeGo netbook. I started ofono with
> debug options. I added a line for this device in ofono.rules and on
> plugging in the modem it does print 3 similar lines of text suggesting
> that it has detected a modem. However the list-devices script does not
> list any modem. I went through
> http://ofono.org/wiki/how-enable-modem-ofono . Do I have to wait for
> someone to write a driver plugin for ofono?

start oFono like this "env OFONO_AT_DEBUG=3D1 ./src/ofonod -n -d" and post
the logging messages here.

Also run lsusb to let us now which Huawei modem that is.

Regards

Marcel



--===============8385075026591409978==--


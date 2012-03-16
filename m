Content-Type: multipart/mixed; boundary="===============0574200625096021617=="
MIME-Version: 1.0
From: Reynaldo Baquerizo <reynaldomic@gmail.com>
Subject: Re: Trouble sending sms with cinterion tc65
Date: Fri, 16 Mar 2012 10:50:35 -0500
Message-ID: <20120316105035.2be2f583@bertello>
In-Reply-To: <4F634A75.2060907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0574200625096021617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

> > I'd like to volunteer to fix this (if there is anything to fix
> > here), any hint to further debug this is welcome :-)
> > =

> =

> Please post AT debug logs, see HACKING document for details.  However,
> it sounds like you're not registered to the network.

I think I found it, =


ofonod[12663]: This driver is not setup with Signal Strength reporting via =
CIND indications, please write proper netreg handling for this device
ofonod[12663]: src/network.c:netreg_remove() atom: 0xe216d0
ofonod[12663]: > AT+CGREG=3D2\r
ofonod[12663]: < \r

> > Regarding post_sim and post_online, when one enables the modem the
> > MessageManager is then exposed but one can not send messages, it is
> > only possible after going online. I find this not clear.
> =

> You have to be registered to a network before SMSes will be sent, that
> should be pretty obvious.  The reason MessageManager is available in
> post_sim is to be able to set up various settings (e.g. SMSC) which
> are not tied to whether you are registered to the network or not.

I understand that, but what got me confused is that inside post_online
there is ofono_create_gprs. My thinking was one doesn't a data
connection to send sms. So I guess, ofono_netreg_create and
ofono_create_gprs are unrelated and one can exclude gprs from
post_online (not that I want to, just trying to wrap my head around the
code)

Regards,
--
Reynaldo

--===============0574200625096021617==--


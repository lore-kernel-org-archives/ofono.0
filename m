Content-Type: multipart/mixed; boundary="===============7520047132120431862=="
MIME-Version: 1.0
From: jukka.eklund@nokia.com
Subject: RE: [Meego-handset] ofono-qt - anything to add/improve?
Date: Tue, 05 Jul 2011 06:27:20 +0000
Message-ID: <B3EBB0688840F44EA1B25FB84F7D3F3D06B6EC@008-AM1MPN1-011.mgdnok.nokia.com>
In-Reply-To: <CA04A6A57256304AB6CA9036AD639A1824148FE27A@E2K7MAIL.it.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7520047132120431862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Right, so CE specifically has added those 3 first packages (cellular PIN qu=
ery, and settings). Those are available for upstream also, but probably not=
 accepted for a reason or other.

The last one is the new (Tablet) Settings application that is in MeeGo 1.2.=
 Alex, you could at least get in touch with owner of that component.

________________________________________
From: meego-handset-bounces(a)lists.meego.com [meego-handset-bounces(a)list=
s.meego.com] on behalf of ext H=C3=A4rk=C3=B6nen Timo [Timo.Harkonen(a)digi=
a.com]
Sent: 05 July 2011 08:57
To: Alexander Kanavin; ofono(a)ofono.org; meego-handset(a)lists.meego.com
Subject: Re: [Meego-handset] ofono-qt - anything to add/improve?

Hi

This is from N900 Community Edition:

[root(a)localhost ~]# rpm -q --whatrequires libofono-qt
meegotouchcp-cellular-0.0.1-1.3.DE.armv7hl
meegotouchcp-gprs-0.17.4-12.2.DE.armv7hl
meego-pinquery-0.0.2-1.1.DE.armv7hl
meego-ux-settings-0.4.0-1.33.armv7hl

-Timo

ps. Sorry for top posting. using owa..
________________________________________
L=C3=A4hett=C3=A4j=C3=A4: meego-handset-bounces(a)lists.meego.com [meego-ha=
ndset-bounces(a)lists.meego.com] k&#228;ytt&#228;j&#228;n Alexander Kanavin=
 [alex.kanavin(a)gmail.com] puolesta
L=C3=A4hetetty: 4. hein=C3=A4kuuta 2011 16:01
Vastaanottaja: ofono(a)ofono.org; meego-handset(a)lists.meego.com
Aihe: [Meego-handset] ofono-qt - anything to add/improve?

Hi,

I am the maintainer of ofono-qt library, which provides Qt bindings to
ofono services and licensed under LGPL 2.1:
http://meego.gitorious.org/meego-cellular/ofono-qt

I would like to get in touch with everyone who is using it, or perhaps
would like to use it, and find out if there is anything incomplete,
missing or possible to improve there. Let me know please.

Also, if you know an easy way to find out what is dependent on this
library in Meego, that would be great too.

Regards,
--
Alexander
_______________________________________________
MeeGo-handset mailing list
MeeGo-handset(a)lists.meego.com
http://lists.meego.com/listinfo/meego-handset
_______________________________________________
MeeGo-handset mailing list
MeeGo-handset(a)lists.meego.com
http://lists.meego.com/listinfo/meego-handset

--===============7520047132120431862==--


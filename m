Content-Type: multipart/mixed; boundary="===============5793315329306263855=="
MIME-Version: 1.0
From: Miia.Leinonen@tieto.com
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 14:27:59 +0200
Message-ID: <5B2C0C388E5FAD42A7089E751CDCA9911F488F5EFB@EXMB02.eu.tieto.com>
In-Reply-To: <1296469912.1520.199.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5793315329306263855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Marcel,

> why does the user have different needs here? Where are these needs
> coming from?

You want real life user cases? :)

OK, I give you some. Personally nr 1 is my favourite one as that is such a
common thing to happen.

1) Have you ever been drunk and written stupid messages you really don't
want to reach their destination the next day anymore if they have not
already (maybe you wish they never would have reached the destination
but all the mistakes can't be prevented..)

2) You have a situation that you want to buy something important and
there are two options of which you prefer other one. You can not reach
the guy with preferred option via call so you send a message, but you
want to be sure that you know the situation before the other offer
closes. Of course the preferred option's seller expects you to make the
commitment right away for purchase so text message can not be sent in
vain. =


3) Example from the wonderful world of Internet: =

http://www.developershome.com/sms/sms_tutorial.asp?page=3DbasicConcepts

> How does a normal user actually know what this means for him and the
> network he is using? =

The normal user knows this by reading the manual if he does not
understand it directly when seeing the setting in the device. And if
there is a chance that network does not support all features that device
can offer, a disclaimer about that can be added to manual or help files.

> Is the network actually honoring these values at
> all these days
Whether the network is honoring this case or not is not the issue here.
If such would be the reason for dropping features then many things would
never get completed when people would just discuss who should do what
first. I have not met a situation at least in Finland where network does not
support it, but I have not made comprehensive study about this. If the =

network does not follow the request then that is a network issue and should =

be handled through other channels. The truth is that if oFono does not allo=
w =

this setting through the API, then devices using oFono have no means to =

offer this choice to its users even if the network would support it.

One more thing, Meego also has a requirement about this in Featurezilla:
Feature 4564 - [FEA] Cellular - SMS Validity period

BR,
Miia


______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============5793315329306263855==--


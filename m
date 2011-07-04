Content-Type: multipart/mixed; boundary="===============5019934721000433623=="
MIME-Version: 1.0
From: Christian Gagneraud <chris@techworks.ie>
Subject: Re: ofono-qt - anything to add/improve?
Date: Mon, 04 Jul 2011 15:41:10 +0100
Message-ID: <4E11D106.1060809@techworks.ie>
In-Reply-To: <CANNYZj-ic66A+wibWSDWKt_s3O+5R6v=RzMOxgs_5NxL6bRMnQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5019934721000433623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04/07/11 14:01, Alexander Kanavin wrote:
> Hi,
>
> I am the maintainer of ofono-qt library, which provides Qt bindings to
> ofono services and licensed under LGPL 2.1:
> http://meego.gitorious.org/meego-cellular/ofono-qt

Hi Alexander,

I started to use ofono-qt recently. And first of all, I would like to =

say, that it does offer a very nice DBUS abstraction.

I'm not a user of the voice call interfaces, just the modem, sim, =

network and connman (mobile broadband use case).

I'm actually integrating ofono(-qt) (and other stuff) into PTXdist =

(Reproducable Embedded Linux Systems) [1]

1. Releases.
I've found 2 places for the tarballs:
- git:
   path: =

http://meego.gitorious.org/meego-cellular/ofono-qt/archive-tarball/<version>
   filename: meego-cellular-ofono-qt-<version>.tar.gz
   (which uncompress into a folder named "meego-cellular-ofono-qt"
- meego: http://api.meego.com/public/source/Trunk/libofono-qt/
   name of the archives: ofono-qt-<version>
   which uncompress nicely into a folder named ofono-qt-<version>, =

unfortunately, this is not a repository, as it contains only the version =

used by meego something.

So, to make it clear and simple, is there any official repository for =

ofono-qt?

2. "slotification" of various member functions:

member functions like OfonoModem.setPowered(bool powered) could be =

declared slots, so that it can be connected to signals of same signature =

like QCheckBox.toggled(bool)

3. More convenient function members (I'm getting picky, I know)
example for OfonoModem:
  - existing: setPowered(bool powered), setOnline(bool online)
  - proposed addition: powerOn(), powerOff(), goOnline(), goOffline()

This with the proposed slotification, would make libofono-qt even easier =

to use.

4. Use enumeration instead of strings:
for example in OfonoConnmanContext:
enum ContextType {
	ContextTypeInternet,
	ContextTypeMms,
	ContextTypeWap,
	ContextTypeIms,
};
void setType(ContextType type);
instead of:
void setType(const QString& type)

I know, that it is less flexible (especially if the oFono DBUS API =

change), but it can help to reduce size of binaries and be slightly more =

efficient. [On an ARM9(a)200MHz, every little helps! ;)]

3. bug with path()?
Each time my code call OfonoXyz.path(), I get a message in the console:
QDBusArgument: read from a write-only object

I don't know where does it come from, perhaps it's not even related to =

ofono-qt...

4. partial interface implementation
There some classes that are missing properties/ function members.
On top of my head:
GSM band, UMTS band and fast dormancy in RadioSettings

5. More documentation (doxygen)
   I know that by reading the ofono DBUS API, it's easy to figure out =

how to use ofono-qt. But as ofono-qt offers an abstraction of the ofono =

DBUS API, it might be nice to have a full ofono-qt API documentation.
I guess it would be mainly copy/paste from ofono/doc/*-api.txt.

6. Enhance ofono-qt with a concept of PIN agent?
It's easy to use SimManager.pinRequiredChanged() signals, but perhaps a =

simple PIN agent class might be a nice thing to have.
At the SimManager level, or even better at the Modem level
OfonoModem.registerSimPinAgent(myAgent);

Just throwing some cheap ideas....


Regards,
Chris

[1] http://www.mail-archive.com/ptxdist(a)pengutronix.de/msg04566.html


>
> I would like to get in touch with everyone who is using it, or perhaps
> would like to use it, and find out if there is anything incomplete,
> missing or possible to improve there. Let me know please.
>
> Also, if you know an easy way to find out what is dependent on this
> library in Meego, that would be great too.
>
> Regards,


--===============5019934721000433623==--


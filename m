Content-Type: multipart/mixed; boundary="===============4440514992807016552=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Enhancing mmsd
Date: Sun, 26 Feb 2012 18:14:44 -0800
Message-ID: <1330308884.3392.18.camel@aeonflux>
In-Reply-To: <4F47A9F9.7010407@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4440514992807016552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

> >> as announced in my last mail, I'm here to work with + improve ofono
> >> and related software.
> >>
> >> My next task will be to implement an ofono plugin which handles some
> >> UPL push messages. Because there is only one "listener" at
> >> org.ofono.PushNotificationAgent possible, I see two and a half way
> >> to go on:
> >>
> >> 1) fork ofono-mmsd to handle more message types than mms
> >>     (via plugins?)
> >>     1b) fork ofono-mmsd to handle only SUPL push messages
> >> 2) find a way for more listeners on push messages
> >>
> >> Any suggestions, preferred ways?
> > =

> > I think there is a third way to do what you want : write a SUPL push
> > message consumer as an mmsd plugin and not as an ofono plugin. Actually,
> > mmsd already implements a WAP push message dispatch mechanism for other
> > push message than MMS.
> > To check if this fits your needs, please have a look at the consumer.txt
> > documentation from mmsd/doc/.
> =

> Yeah, you're right. I read it on my first day and had it totally
> forgotten meanwhile. Initially it confuses me, because I assumed
> there can be embedded documents in an mms - and didn't recognize
> that mms is the built-in plugin for mmsd - which should be renamed
> into wspd ;)

we actually discussed this initially to create a separate WAP push
handler daemon, but reality is that it is really pointless and pretty
wasteful as a separate daemon.

The heavy lifting part is parsing WSP and that is the majority of what
mmsd is doing anyway already. So it is cheaper to just have one MMS
daemon that includes WAP Push handling. So essentially you get the MMS
handling for free with it.

Regards

Marcel



--===============4440514992807016552==--


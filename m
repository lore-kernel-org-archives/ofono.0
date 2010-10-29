Content-Type: multipart/mixed; boundary="===============4424839471402534564=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 2/3] voicecall: emergency call handling added
Date: Fri, 29 Oct 2010 14:36:25 +0200
Message-ID: <1288355785.3322.38.camel@aeonflux>
In-Reply-To: <4CCA940A.1050409@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4424839471402534564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> > In general I think that the emergency_watch is unnecessary.  Having a
> > reference counted emergency tracking inside the modem object and a modem
> > online state watch should be sufficient.
> >
> >    =

> The idea with the emergency watch is that any subsystem can get the
> notification  when the emergency mode is entered and react on it.
> To give you a more complex example, it might well be that the gprs
> connection needs to be torn down when making an emergency call in
> 2G mode, there are such networks out there that prevents you from
> making an emergency call if your device is attached to a PDP context.
> In this given situation it comes to the question how to bring down the
> gprs connection. It can be done such that the gprs atom will tear down
> the connection after receiving the EmergencyMode notification, or
> another option is to have gprs connection handling functions made
> available by gprs and to deal with the gprs connection within voicecall
> (or somewhere else). The online/offline mode change handling in fact is
> bringing up the some issue, how the mode change handling should be
> implemented when making the emergency call. My idea was let every
> subsystem deal with the specifics of its own subsystem.

we had this specific discussion before and my understanding is that all
these networks have been updated by now anyway. So this is not an issue
anymore.

However in the end this is not something oFono should be doing in the
first place. The modem should do this. oFono does not know if something
is or becomes an emergency call. Only the modem itself knows if it
starts the procedure to make an emergency call.

Regards

Marcel



--===============4424839471402534564==--


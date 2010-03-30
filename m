Content-Type: multipart/mixed; boundary="===============2330690136708738960=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 07:22:14 -0700
Message-ID: <1269958934.11714.251.camel@localhost.localdomain>
In-Reply-To: <80fd4e751003300439j527f1934ic95dabcfe46f545c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2330690136708738960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> I've been porting the N900 modem control code to oFono. The semantics
> >> of Powered is fine with respect of the atoms, in other words, if the
> >> modem crashes and boots itself, all the atoms are flushed nicely.
> >> When powering up, the Powered can be set to true when the modem is
> >> really up and running.
> >
> > Do you have an overview of the different modes and transitions that the=
 N900 modem control is using today?
> =

> Not really. What do you want to know? There are some design documents
> describing GPIO line usage, something about SSI used for phonet
> messages and how modem bootloader interacts with it, and documents
> about the MTC design and different MTC states.

this really sounds like you guys should implement RFKILL support for the
Phonet subsystem. Solving this in userspace is wrong since the GPIO
lines are deeply attached to specific hardware design.

Regards

Marcel



--===============2330690136708738960==--


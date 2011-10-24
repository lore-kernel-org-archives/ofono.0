Content-Type: multipart/mixed; boundary="===============5447665810065955832=="
MIME-Version: 1.0
From: Jean Parpaillon <jean.parpaillon@free.fr>
Subject: Ofono use
Date: Mon, 24 Oct 2011 11:44:02 +0200
Message-ID: <1319449442.32429.141.camel@talinn.home>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5447665810065955832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
I am currently trying to use ofono and I can not get how to register the
modem in a reliable way.
When I detect a modem, I set org.ofono.Modem.Powered to True.
When SimManager interface is ready, I enter the pin.
Then, I set the modem org.ofono.Modem.Online to True.
By the way, I wait for NetworkRegistration interface to be available.
When it is available, I wait for NetworkRegistration.Name to be non
empty to call NetworkRegistration.Register.

The point is setting Online property usually end with a timeout. It is
the right workflow ? Must I look for other property ? =


In a few words, what is the right workflow to get a UMTS modem
registered to its default network from the moment you plug it in ? =


Any piece of a clue will be appreciated :)


Regards,
Jean


--===============5447665810065955832==--


Content-Type: multipart/mixed; boundary="===============7051343811347867418=="
MIME-Version: 1.0
From: Marek Szuba <scriptkiddie@wp.pl>
Subject: APN for a newly added service provider
Date: Tue, 24 Mar 2020 15:06:42 +0100
Message-ID: <cc4d13b7-9ab5-e5b2-1d57-2380e141c83d@wp.pl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7051343811347867418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have noticed something interesting lately in how oFono (or to be
precise oFono+Connman, as that is what I have on my system) has handled
a newly added service provider and I wonder if this is intentional or I
have done something wrong.

Context: I have attempted to connect to the Internet using a broadband
modem using a SIM card from a provider not listed in my
serviceproviders.xml file. The provider in question is an MVNO on the
German T-Mobile network, with all the settings (other than the SPN, of
course) identical to those of another pre-paid MVNO that already has an
entry in the aforementioned file (Congstar), which has only got a single
APN defined.

My steps: I have cloned the Congstar <provider> section in
serviceproviders.xml with an appropriate SPN, then disconnected the
modem and restarted ofonod just in case.

Expected: Connman establishes a cellular connection right away

Actually happened: although ofonod debug messages showed that it had
correctly read the new SPN entry and set up an Internet context, said
context did not have an APN set and connman failed to use it to
establish a connection - until I used the "create-internet-context" test
script to set the APN. Now regardless of how often I disconnect the
modem, restart ofonod and so on, the context's APN does get set
automatically and the mobile-broadband connection works fine.

I am curious regarding what might have happened here so that I
understand why it has happened and possibly prevent from having to mess
around with test scripts in the future. Thank you in advance for your
comments!

-- =

MS
--===============7051343811347867418==--


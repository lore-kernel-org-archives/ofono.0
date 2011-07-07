Content-Type: multipart/mixed; boundary="===============5309720239320914869=="
MIME-Version: 1.0
From: Alex Kanavin <ak@sensi.org>
Subject: Re: [Meego-handset] ofono-qt - anything to add/improve?
Date: Thu, 07 Jul 2011 15:43:39 +0300
Message-ID: <CANNYZj933A9wkYK1bj5XXS-zTWvjT=OPEZrOrRjHVbQcAOb0=Q@mail.gmail.com>
In-Reply-To: <CANNYZj9ZsDKjKjxt61zz_EOEhoqjhyg_evg8MmPQM7=sMLqicg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5309720239320914869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/7/6 Alex Kanavin <ak@sensi.org>:
> I will write up a wishlist and post it here.

Right, so this is the list of things in no particular order. If you
want any of them to happen faster, you are very much welcome to help.

Check the API and get it up to date:
 - message manager should not use dbusobjectpath class
 - connman contextAdd should return object path
 - radio settings has missing stuff
 - there might be plenty of other things

More formal "certification" of ofono-qt to specific ofono versions
 - change the versioning to match ofono's
 - when new version of ofono is out, diff of ofono/doc/* could serve
   as a list of things to fix

Convert "void setPowered(bool powered)" type functions to public slots.

SIM toolkit bindings. This requires implementing a d-bus agent and some
kind of reasonable test.
 - same for CallHistory.

When automatic modem selection is used, and ofono-qt class moves to using a
new modem, in addition to property change signal also other d-bus signal
subscriptions should be moved to the new modem path.

When interface availability changes, in addition to properties also lists of
object paths (such as voice calls, messages, GPRS contexts etc) should be
refreshed.

-- =

Alexander

--===============5309720239320914869==--


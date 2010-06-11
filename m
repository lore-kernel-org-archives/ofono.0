Content-Type: multipart/mixed; boundary="===============0088253378237121791=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [RFC PATCH 1/2] smsutil: Status Report assembly
Date: Fri, 11 Jun 2010 15:23:13 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A5C@jklmail01.ixonos.local>
In-Reply-To: <201006101152.46861.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0088253378237121791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> I see one problem with this function, namely that under some bizarre
> circumstances, the status report might come back before additional fragme=
nts
> have been added.  So this function should also take a num_fragments argum=
ent
> and keep track of how many fragment status reports were actually received.
> =

> This gets a bit tricky when a failure is reported before the entire set of
> fragments has been submitted...

Yes, with the current implementation the last part would be little bit tric=
ky.
I think that maybe we shoudn't delete the whole msg_id after the first
"undelivered" mr-number. This is just quick brainstorming, but maybe we
could mark the msg_id "dead" when the first undelivered mr arrives and
then just wait for the remaining mrs like we do with the delivered ones?
When all of the mrs has arrived, we check if the msg_id is marked "dead"
and continue from there..

Br,
-Pasi

PS. Have a nice weekend all :)


--===============0088253378237121791==--


Content-Type: multipart/mixed; boundary="===============5145889442616415062=="
MIME-Version: 1.0
From: Reynaldo Baquerizo <reynaldomic@gmail.com>
Subject: Trouble sending sms with cinterion tc65
Date: Fri, 16 Mar 2012 03:29:30 -0500
Message-ID: <20120316032930.5a1c786f@bertello>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5145889442616415062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi everyone,

I would like to know what is Cinterion tc65's status. I am looking for
its sms functionality and it is not working.
I've tried to figure this out for my own, but since I am to new ofono
and not much of a C coder I guess I haven't gone so far.

I've tried running it with the debugger, and as far as I can tell it
doesn't seem to add the atom watch for OFONO_ATOM_TYPE_NETREG because
neither of these conditions are met (in __ofono_modem_add_atom_watch)

> 	for (l =3D modem->atoms; l; l =3D l->next) {
> 		atom =3D l->data;
> =

> 		if (atom->type !=3D type || atom->unregister =3D=3D NULL)
> 			continue;
> 		=

> 		notify(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, data); }

Then I think I've added ofono_cbs_create in tc65_post_online and after
that "atom->type !=3D type" is met but atom->unregister is null still.

I'd like to volunteer to fix this (if there is anything to fix here),
any hint to further debug this is welcome :-)

Regarding post_sim and post_online, when one enables the modem the
MessageManager is then exposed but one can not send messages, it is only
possible after going online. I find this not clear.

Thanks,
--
Reynaldo

--===============5145889442616415062==--


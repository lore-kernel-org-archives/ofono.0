Content-Type: multipart/mixed; boundary="===============2901243990663831388=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3] Add basic Telit UC864-G support:
Date: Thu, 09 Jun 2011 12:26:30 +0200
Message-ID: <1307615190.2589.37.camel@aeonflux>
In-Reply-To: <alpine.DEB.2.00.1106081733590.30119@entw48>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2901243990663831388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

> >> +	switch (status) {
> >> +	case 0:
> >> +		DBG("SIM not inserted");
> >> +		ofono_sim_inserted_notify(data->sim, FALSE);
> >> +		break;
> >> +	case 1:
> >> +		DBG("SIM inserted");
> >> +		/* We need to sleep a bit */
> >> +		g_timeout_add_seconds(1, sim_inserted_notify_with_timeout,
> >> +								modem);
> >> +		break;
> >> +	case 2:
> >> +		DBG("SIM inserted and PIN unlocked");
> >> +		break;
> >> +	case 3:
> >> +		DBG("SIM inserted and ready");
> >> +		break;
> >
> > Why are you not handling any of case 2 or 3. Are they not also mean that
> > SIM is inserted. Or do they always are followed by case 1.

fair enough. I would use ofono_warn(). Just send an extra patch for that
once Denis applied the other one. Put a nice commit message explaining
this and it would be good. Always nice to have a record of things in the
commit logs or as comments.

> The states 2 and 3 never occurred it always reports only one event, which =

> is 1. I added the other states because the manual describes them as =

> something which should happen. Should I print an error or remove it?
> =

> >> +
> >> +	DBG("%p", modem);
> >> +
> >> +	if (!ok) {
> >> +		g_at_chat_unref(data->chat);
> >> +		data->chat =3D NULL;
> >> +		return;
> >
> > If I am not mistaken, then the set_powered(FALSE) call is missing here.
> > Did you test this code path?
> =

> You are right I did not test this code path. I just tested it with if (ok=
) =

> and the path is wrong.
> =

> I added it to the new patch.

Sounds good :)

Regards

Marcel



--===============2901243990663831388==--


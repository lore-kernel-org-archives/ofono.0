Content-Type: multipart/mixed; boundary="===============3359160277160247976=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v3] gprs: Quectel EC21 does not understand AT+CPSB
Date: Mon, 17 Aug 2020 09:56:33 +0200
Message-ID: <20200817075633.dfggbu7wvjzuyild@lem-wkst-02.lemonage>
In-Reply-To: <8c4abe99-6ce3-a526-54a9-64b855f4eab6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3359160277160247976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2020 at 10:03:12AM -0500, Denis Kenzior wrote:
> > @@ -624,6 +667,12 @@ static void gprs_initialized(gboolean ok, GAtResul=
t *result, gpointer user_data)
> >   		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
> >   						NULL, NULL, NULL);
> >   		break;
> > +	case OFONO_VENDOR_QUECTEL_EC2X:
> > +		g_at_chat_register(gd->chat, "+QIND",
> > +				quectel_qind_notify, FALSE, gprs, NULL);
> > +		/* The "QIND: \"act\", ..." URC is activated in
> > +		 * network-registration.c */
> =

> You're using the QIND in network-registration.c to notify CREG technology.
> And now you're trying to use this here in place of CPSB.  This seems fishy
> to me. Looking at the Quectel AT commands manual, I'd just guess they do =
not
> support this bearer concept at all...

Until here, you could tell me way more than the official quectel
support. Thank you for this!
I will post a new version of the patch that will just skip the AT+CPSB
command.

Thanks a lot!

Lars
--===============3359160277160247976==--


Content-Type: multipart/mixed; boundary="===============1595109198148333656=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: [PATCH 1/2] atmodem: move USSD quirk to probe and use it also for
 STE modems
Date: Mon, 17 Jan 2011 10:42:03 +0200
Message-ID: <1295253723.10484.23.camel@lkunnasl-desktop>
In-Reply-To: <1295014835.3873.147.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1595109198148333656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, 2011-01-14 at 16:20 +0200, Marcel Holtmann wrote:
> Hi Lasse,

> > @@ -314,6 +305,18 @@ static int at_ussd_probe(struct ofono_ussd *ussd, =
unsigned int vendor,
> >  =

> >  	ofono_ussd_set_data(ussd, data);
> >  =

> > +	switch (data->vendor) {
> > +	case OFONO_VENDOR_QUALCOMM_MSM:
> > +	case OFONO_VENDOR_STE:
> > +		/*
> > +		* Ensure that the modem is using GSM character set. It
> > +		* seems it defaults to IRA and then umlauts are not
> > +		* properly encoded. The modem returns some weird from
> > +		* of Latin-1, but it is not really Latin-1 either.
> > +		*/
> > +		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
> > +							NULL, NULL, NULL);
> > +		break;
> > +	}
> > +
> >  	g_at_chat_send(chat, "AT+CSCS?", cscs_prefix, read_charset_cb, data,
> >  			NULL);
> >  =

> =

> so we don't really wanna do it this way since other atoms like the
> phonebook can switch the character sets as well.
> =

Yes, seems so. If phonebook switches the character set USSD won't get
notified and vice versa. So in general this should be somehow
centralized in ofono.
What about supporting the IRA character set in ofono? It would get us a
bit forward compared to current situation. Currently USSD functionality
is quite broken with AT modems having IRA character set, all strings
sent from NW are ignored in cusd_parse().

> The best is if the STE modem would provide access to the USSD in PDU
> mode and we can then decode it properly. Using text mode for USSD is not
> the best idea actually. Same as text mode for SMS is utterly broken ;)
Don't know if this is possible.

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



--===============1595109198148333656==--


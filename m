Content-Type: multipart/mixed; boundary="===============7632940448760784176=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH] handsfree-audio: Add .Connect using the card driver
Date: Wed, 27 Mar 2013 11:45:17 -0300
Message-ID: <20130327144517.GC2715@samus>
In-Reply-To: <515302E7.7080100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7632940448760784176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 09:32 Wed 27 Mar, Denis Kenzior wrote:

> >
> >Yes. This behaviour is even covered in one of the PTS tests: TP/ACC/BV-0=
3-I
> >(from the description of the test, "To verify the capability of the HF
> >initiating a legacy audio connection with an AG that does not support the
> >Codec Connection setup procedure. The HF should be able to correctly neg=
otiate
> >a working legacy audio connection to the AG.")
> >
> =

> Okay, that makes things a little harder since we cannot determine
> the driver to use until the SLC is established.


Yeah.

> =

> <snip>
> =

> >>>+	if (!driver || !driver->connect)
> >>>+		goto fallback;
> >>>+
> >>>+	err =3D driver->connect(card, card_connect_reply_cb, card);
> >>>+	if (err =3D=3D -EINPROGRESS) {
> >>>+		card->msg =3D dbus_message_ref(msg);
> >>>+		return NULL;
> >>
> >>As mentioned earlier, the driver should not return an int, however,
> >>lets revisit this part.  I want to better understand the AT+BCC and
> >>codec negotiation interactions.
> >
> >
> >Of course.
> >
> >Another thing that may make sense to bring up now is the AG case: if we =
want
> >to have a HFP 1.6 capable AG, we may want to select the codec (send a +B=
CS)
> >before establishing the SCO connection. I was thinking of setting a spec=
ific
> >error code in the callback to signify that the core handsfree-audio may
> >connect the SCO at that point.
> >
> =

> I thought of setting error codes in callbacks, but I'm not happy
> with that solution.  Perhaps we should make SCO establishment a part
> of the card utility API.  e.g. ofono_handsfree_card_connect_sco().
> That way the AG can run the required +BCS transactions and call the
> above function when it comes to making the SCO connection.

Sounds good. This aproach may even make the case that "we" are the AG and we
receive a AT+BCC easier to handle.

> =

> For HFP 1.6/1.5, we can either use +BCC or call
> ofono_handsfree_card_connect_sco directly.
> =

> Thoughts, other ideas?

Right now, I don't have any. I will give it a try and see how it ends up
looking.

> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============7632940448760784176==--


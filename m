Content-Type: multipart/mixed; boundary="===============4922837045091895307=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH] handsfree-audio: Add .Connect using the card driver
Date: Wed, 27 Mar 2013 11:22:30 -0300
Message-ID: <20130327142230.GB2715@samus>
In-Reply-To: <51527CAF.40802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4922837045091895307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 23:59 Tue 26 Mar, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 03/26/2013 04:28 PM, Vinicius Costa Gomes wrote:
> >Now each handsfree implementation may be notified that a card wants
> >its audio to be connected.
> >
> >In case, that the cards wishes to fallback to the default SCO connection
> >procedure, it just needs to return -ENOSYS.
> =

> Are you interpreting section 4.11.2:
> "For all HF initiated audio connection establishments for which both
> sides support the Codec Negotiation feature, the HF shall trigger
> the AG to establish a Codec Connection. This is necessary because
> only the AG knows about the codec selection and settings of the
> network."
> =

> ... to mean that AT+BCC is only sent when both sides support codec
> negotiation?  e.g. if one or the other side does not support codec
> negotiation, then we are supposed to fall back to old SCO
> establishment rules procedures?

Yes. This behaviour is even covered in one of the PTS tests: TP/ACC/BV-03-I
(from the description of the test, "To verify the capability of the HF
initiating a legacy audio connection with an AG that does not support the
Codec Connection setup procedure. The HF should be able to correctly negoti=
ate
a working legacy audio connection to the AG.")

> =

> >---
> >  src/handsfree-audio.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> >diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> >index f8df6d6..ace3a4f 100644
> >--- a/src/handsfree-audio.c
> >+++ b/src/handsfree-audio.c
> >@@ -307,13 +307,30 @@ done:
> >  	return FALSE;
> >  }
> >
> >+static void card_connect_reply_cb(const struct ofono_error *error, void=
 *data)
> >+{
> >+	struct ofono_handsfree_card *card =3D data;
> >+	DBusMessage *reply;
> >+
> >+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
> >+		reply =3D dbus_message_new_method_return(card->msg);
> >+	else
> >+		reply =3D __ofono_error_failed(card->msg);
> >+
> >+	g_dbus_send_message(ofono_dbus_get_connection(), reply);
> >+
> >+	dbus_message_unref(card->msg);
> >+	card->msg =3D NULL;
> =

> Please replace the above three lines with __ofono_dbus_pending_reply.

Sure. Will fix.

> =

> >+}
> >+
> >  static DBusMessage *card_connect(DBusConnection *conn,
> >  						DBusMessage *msg, void *data)
> >  {
> >  	struct ofono_handsfree_card *card =3D data;
> >+	const struct ofono_handsfree_card_driver *driver =3D card->driver;
> >  	GIOChannel *io;
> >  	const char *sender;
> >-	int sk;
> >+	int sk, err;
> >
> >  	if (agent =3D=3D NULL)
> >  		return __ofono_error_not_available(msg);
> >@@ -326,6 +343,21 @@ static DBusMessage *card_connect(DBusConnection *co=
nn,
> >  	if (card->msg)
> >  		return __ofono_error_busy(msg);
> >
> >+	if (!driver || !driver->connect)
> >+		goto fallback;
> >+
> >+	err =3D driver->connect(card, card_connect_reply_cb, card);
> >+	if (err =3D=3D -EINPROGRESS) {
> >+		card->msg =3D dbus_message_ref(msg);
> >+		return NULL;
> =

> As mentioned earlier, the driver should not return an int, however,
> lets revisit this part.  I want to better understand the AT+BCC and
> codec negotiation interactions.


Of course. =


Another thing that may make sense to bring up now is the AG case: if we want
to have a HFP 1.6 capable AG, we may want to select the codec (send a +BCS)
before establishing the SCO connection. I was thinking of setting a specific
error code in the callback to signify that the core handsfree-audio may
connect the SCO at that point.


> =

> >+	}
> >+
> >+	/* ENOSYS means the driver doesn't want to connect itself */
> >+	if (err<  0&&  err !=3D -ENOSYS)
> >+		return __ofono_error_failed(msg);
> >+
> >+fallback:
> >+	/* There's no driver, fallback to direct SCO connection */
> >  	sk =3D card_connect_sco(card);
> >  	if (sk<  0)
> >  		return __ofono_error_failed(msg);
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============4922837045091895307==--


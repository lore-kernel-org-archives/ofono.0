Content-Type: multipart/mixed; boundary="===============8152210107289078341=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 4/7] quectel: EC21 needs aux channel to be the first mux
 channel
Date: Wed, 27 May 2020 17:08:52 +0200
Message-ID: <20200527150852.x7kqb3bwxfodgtaa@lem-wkst-02.lemonage>
In-Reply-To: <344edfdc-5119-698a-9544-6a49a939ec44@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8152210107289078341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 08:32:07AM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> On 5/26/20 5:16 AM, poeschel(a)lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > =

> > The Quectel EC21 does only work correctly, if the mux channel used for
> > aux is the first mux channel. It does only put it's URC messages in the
> > first mux channel, so this has to be the aux channel in our case.
> > ---
> >   plugins/quectel.c | 51 +++++++++++++++++++++++++++++++++++------------
> >   1 file changed, 38 insertions(+), 13 deletions(-)
> > =

> > diff --git a/plugins/quectel.c b/plugins/quectel.c
> > index 1d312c45..9ff75516 100644
> > --- a/plugins/quectel.c
> > +++ b/plugins/quectel.c
> > @@ -847,18 +847,38 @@ static void cmux_gatmux(struct ofono_modem *modem)
> >   	g_at_mux_start(data->mux);
> > -	data->modem =3D create_chat(modem, "Modem: ");
> > -	if (!data->modem) {
> > -		ofono_error("failed to create modem channel");
> > -		close_serial(modem);
> > -		return;
> > -	}
> > +	if (data->model =3D=3D QUECTEL_EC21) {
> > +		data->aux =3D create_chat(modem, "Aux: ");
> > -	data->aux =3D create_chat(modem, "Aux: ");
> > -	if (!data->aux) {
> > -		ofono_error("failed to create aux channel");
> > -		close_serial(modem);
> > -		return;
> > +		if (!data->aux) {
> > +			ofono_error("failed to create aux channel");
> > +			close_serial(modem);
> > +			return;
> > +		}
> > +
> > +		data->modem =3D create_chat(modem, "Modem: ");
> > +
> > +		if (!data->modem) {
> > +			ofono_error("failed to create modem channel");
> > +			close_serial(modem);
> > +			return;
> > +		}
> > +	} else {
> > +		data->modem =3D create_chat(modem, "Modem: ");
> > +
> > +		if (!data->modem) {
> > +			ofono_error("failed to create modem channel");
> > +			close_serial(modem);
> > +			return;
> > +		}
> > +
> > +		data->aux =3D create_chat(modem, "Aux: ");
> > +
> > +		if (!data->aux) {
> > +			ofono_error("failed to create aux channel");
> > +			close_serial(modem);
> > +			return;
> > +		}
> >   	}
> =

> Can we be smarter about this and just store the per-model creation sequen=
ce
> as an array or something?  Then have a loop that calls create_chat from t=
he
> array info?  The proposed copy-pasting approach is not maintainable long
> term.

I will post a follow-up with a proposed solution tomorrow.

> >   	setup_aux(modem);
> > @@ -951,8 +971,13 @@ static void cmux_ngsm(struct ofono_modem *modem)
> >   	 * the kernel does not yet support mapping the underlying serial dev=
ice
> >   	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
> >   	 */
> > -	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
> > -	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
> > +	if (data->model =3D=3D QUECTEL_EC21) {
> > +		ofono_modem_set_string(modem, "Modem", "/dev/gsmtty2");
> > +		ofono_modem_set_string(modem, "Aux", "/dev/gsmtty1");
> > +	} else {
> > +		ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
> > +		ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
> > +	}
> =

> Doesn't this break the logic in mux_ready_cb, particularly the 'check if =
the
> last virtual gsm tty's are created'

Well, I guess, yes. I missed indeed missed that. The follow-up will
contain a fix for this as well.

> >   	/* wait for gsmtty devices to appear */
> >   	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
> > =

> =

> Regards,
> -Denis

Thank you for reviewing and applying the other patches! :-)

Lars
--===============8152210107289078341==--


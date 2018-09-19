Content-Type: multipart/mixed; boundary="===============5877882888862421161=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 1/3] sim800: adding support for Simcom SIM800 modem
Date: Wed, 19 Sep 2018 21:45:31 +0200
Message-ID: <20180919194531.GB3536@turing>
In-Reply-To: <8f8dea50-577d-fa93-509a-3a8103a7fff5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5877882888862421161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 11:51:26AM -0500, Denis Kenzior wrote:

Hi,

> Hi,
> =

> On 09/18/2018 03:36 PM, Cl=C3=A9mentViel wrote:
> >From: clem <vielclement@gmail.com>
> >
> =

> You might want to describe how this is different from sim900 that it
> warrants a fully separate driver?
> =

> If there are only minor differences, then this can be handled via UDEV
> attributes or querying +CGMM, etc.
> =

> >---
> >  Makefile.am      |   4 +
> >  plugins/sim800.c | 424 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 428 insertions(+)
> >  create mode 100644 plugins/sim800.c
> >

I guess I went straightforward and because sim800 wasn't supported I wanted=
 to add it as a plugin.
Sim800 is really close from sim900, in fact theey are compatible. But becau=
se sim800 series are newer.
sim800 have more AT commands than sim900  so maybe the compatibility won't =
be complete if the two drivers are merged...


> =

> <snip>
> =

> >+
> >+static void sim800_post_sim(struct ofono_modem *modem)
> >+{
> >+	struct sim800_data *data =3D ofono_modem_get_data(modem);
> >+	struct ofono_gprs *gprs;
> >+	struct ofono_gprs_context *gc;
> >+
> >+	DBG("%p", modem);
> >+
> >+	/* Dirty Hack : give some time to sim800 for multiplexing
> >+	 *				to be effective and avoid VOICE_DLC to be
> >+	 *				flooded thus leading to a "famine" situation
> >+	 */
> >+
> >+	sleep(2);
> =

> No sleeps inside plugins.  That blocks the entire daemon and we can't have
> that.  How does this help you anyway?  GAtChat is a queue, so only 1 comm=
and
> is outstanding at a time.

Yep that's why the "Dirty Hack" comment, I'll try another trick, there is a=
n URC that we can trigger on.

> =

> >+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> >+						data->dlcs[SMS_DLC]);
> >+
> >+
> >+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> >+	if (gprs =3D=3D NULL)
> >+		return;
> >+
> >+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> >+					"atmodem", data->dlcs[GPRS_DLC]);
> >+	if (gc)
> >+		ofono_gprs_add_context(gprs, gc);
> >+}
> >+
> =

> Regards,
> -Denis

Regards =

Clement

--===============5877882888862421161==--


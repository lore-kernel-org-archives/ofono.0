Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354818A959
	for <ofono@lists.linux.dev>; Mon,  2 Jun 2025 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848817; cv=none; b=dioYUZY7daLsvlP6FLGVgr7nvGPmBZq7QHzzw5JjsYeeGoMSalcReCSHvpka1CWrwj+NqoPy2S1e6pDpTdeFPbszbPhCnOMpzAtSvJWICIZA/Y9PvbxZn4CaljpGGVNDUQt7ulwWFx5JB2CSb582b0qAYq8M+HQzL0foSOaW79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848817; c=relaxed/simple;
	bh=ZE8JrJkM6ybFISyFvl2Ewl2UERpAW+f1yD2Is7PN8Ss=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnd9lf+rgTGZSvGFseSVuIBQW46Ygl/x8xA4typiP2yrGOqO4JTKn0pWz3HmLQX60VcwalfVEfEm4g3sCQrJ7O+Xo+J4HpQ25aPwacczquYdddzUbcxWCp/thu10KfUWLhtrf+mqr+eCYPg642s/Apse/kIMy3TEh+UVczPXF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fqFX7LGz; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fqFX7LGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1748848804; x=1749108004;
	bh=5DC0mH5REgAzbVPnMeRoJ1bhEIqPQwwkmBF+a1WLUOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fqFX7LGzTAmgiYMbVWspBli1RWMX4ZjjDr0zcJahw7Y6y9jcb5kldvr2DPxAlmoFj
	 b+aFB9zsHxw7XkXoOA5YpMCuAh1jXUsXvi6neqY+6XlM2Z26bDeEKx8ASG5g6QN8ER
	 qsbZgdhncAzkumpSUqtOTVq5m5HXSN00S4YMmwJHLXOw4k5xqVvH7aoGas91TM52J7
	 RzyamblhuolUCwwfh5W7wbGyxYLuEmFSDK94srDWWTTD5YWl5cBJwq+iVBKnB5h7Se
	 zQSU8iPKz/BUeC7tIRIuSEwMZW7Fg9ZkB6Qf/EBTf9vYdwUVN1QaJ2nNoQ8KV8xIiH
	 RJNMwX4M4f/yQ==
Date: Mon, 02 Jun 2025 07:19:59 +0000
To: Denis Kenzior <denkenz@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev
Subject: Re: [PATCH] sim7100: query until AT channel is ready
Message-ID: <dykrm5lfwelcsjv6auimpxj27ioeruwexpciavwdl2c3b3bnp2@2mzvsc6b23rq>
In-Reply-To: <31df1157-aeca-4e03-a0d0-f4313becf90c@gmail.com>
References: <20250523131708.2225801-1-sean@geanix.com> <31df1157-aeca-4e03-a0d0-f4313becf90c@gmail.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: fc6594fed859fc9e8a49f2ecaf15f076ef137ecf
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, May 28, 2025 at 01:17:19PM +0100, Denis Kenzior wrote:
> Hi Sean,
>=20
> On 5/23/25 8:17 AM, Sean Nyekjaer wrote:
> > It's seen that the AT channel contains unknown data upon power on.
> > Query the modem until it answers with OK. Create a timer to re-issue
> > the AT command at regular intervals until the modem answers OK.
> >
> > plugins/sim7100.c:sim7100_enable()
> > plugins/sim7100.c:open_device() devkey=3DAT
> > src/modem.c:get_modem_property() modem 0x261f20 property AT
> > plugins/sim7100.c:open_device() devkey=3DPPP
> > src/modem.c:get_modem_property() modem 0x261f20 property PPP
> > AT: > AT\r
> > AT: < \r\r*A
> > PPP: < \r\r*A
> > AT: < AT\r
> > plugins/sim7100.c:init_timeout_cb() 0x261f20
> > AT: > AT\r
> > AT: < AT\r
> > AT: < \r\nOK\r\n
> > AT: > ATE0Q0V1\r
> > AT: < ATE0Q0V1\r\r\nOK\r\n
> > AT: > AT+CGMM\r
> > AT: < \r\nA7672E-FASE\r\n\r\nOK\r\n
> > plugins/sim7100.c:cgmm_cb() modem model: A7672E-FASE
> > plugins/sim7100.c:cgmm_cb() before CFUN
> > AT: > AT+CFUN=3D4\r
> > AT: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> > PPP: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> > AT: < \r\nOK\r\n
> > plugins/sim7100.c:cfun_set_on_cb()
> > src/modem.c:modem_change_state() old state: 0, new state: 1
> > ---
> >
> > Is this the way to do it? It's quite weird that the serial channel
> > doesn't respond in a sane maner after power up.
>=20
> I've never seen this before.  oFono does perform a tcflush() when opening=
 the
> port, so this garbage must be coming in after the port has been opened.  =
I'm not
> sure what else could be done besides what you're doing here.
>=20
> >
> > Before this patch ofono would get stuck in enable and transmit CFUN=3D4=
,
> > our software would then restart ofono and everything would be fine
> > again.
> > I have done nearly 50 power cycles with this patch all being successful=
.
> >
> >   plugins/sim7100.c | 75 +++++++++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 62 insertions(+), 13 deletions(-)
> >
> > diff --git a/plugins/sim7100.c b/plugins/sim7100.c
> > index b6389b09..d52e5b92 100644
> > --- a/plugins/sim7100.c
> > +++ b/plugins/sim7100.c
> > @@ -22,6 +22,7 @@
> >   #include <glib.h>
> >   #include <gatchat.h>
> >   #include <gattty.h>
> > +#include <ell/ell.h>
> >
> >   #define OFONO_API_SUBJECT_TO_CHANGE
> >   #include <ofono/plugin.h>
> > @@ -57,6 +58,9 @@ struct sim7100_data {
> >   =09GAtChat *at;
> >   =09GAtChat *ppp;
> >   =09enum sim7x00_model model;
> > +=09struct l_timeout *init_timeout;
> > +=09size_t init_count;
> > +=09guint init_cmd;
> >   };
> >
> >   static void sim7100_debug(const char *str, void *user_data)
> > @@ -154,6 +158,47 @@ static void cgmm_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
> >   =09=09=09=09=09=09=09=09=09NULL);
> >   }
> >
> > +
>=20
> nit: No double empty lines please.

Will remove!

>=20
> > +static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_dat=
a)
> > +{
> > +=09struct ofono_modem *modem =3D user_data;
> > +=09struct sim7100_data *data =3D ofono_modem_get_data(modem);
> > +
> > +=09/* ensure modem is in a known state; verbose on, echo/quiet off */
> > +=09g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
> > +
> > +=09g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
> > +
> > +=09l_timeout_remove(data->init_timeout);
> > +=09data->init_timeout =3D NULL;
> > +}
> > +
> > +static void close_serial(struct ofono_modem *modem)
> > +{
> > +=09struct sim7100_data *data =3D ofono_modem_get_data(modem);
> > +
> > +=09g_at_chat_unref(data->ppp);
> > +=09g_at_chat_unref(data->at);
> > +=09data->at =3D data->ppp =3D NULL;
> > +}
> > +
> > +static void init_timeout_cb(struct l_timeout *timeout, void *user_data=
)
> > +{
> > +=09struct ofono_modem *modem =3D user_data;
> > +=09struct sim7100_data *data =3D ofono_modem_get_data(modem);
> > +
> > +=09DBG("%p", modem);
> > +
> > +=09if (data->init_count++ >=3D 30) {
> > +=09=09ofono_error("failed to init modem after 30 attempts");
> > +=09=09close_serial(modem);
>=20
> Do you also need ofono_modem_set_powered(modem, FALSE) here as well?
Sure? We first set ofono_modem_set_powered(modem, TRUE) after
AT+CFUN=3D4.

> You're
> also leaking timeout here.  If this is a hot-pluggable modem, then the ti=
meout
> also needs to be canceled / freed in .remove()

Will do.

>=20
> > +=09=09return;
> > +=09}
> > +
> > +=09g_at_chat_retry(data->at, data->init_cmd);
> > +=09l_timeout_modify_ms(timeout, 500);
> > +}
> > +
> >   static int open_device(struct ofono_modem *modem, char *devkey, GAtCh=
at **chat)
> >   {
> >   =09DBG("devkey=3D%s", devkey);
> > @@ -172,16 +217,22 @@ static int sim7100_enable(struct ofono_modem *mod=
em)
> >
> >   =09DBG("");
> >
> > -=09err =3D open_device(modem, "AT", &data->at);
> > -=09if (err < 0)
> > -=09=09return err;
> > -
> > -=09err =3D open_device(modem, "PPP", &data->ppp);
> > -=09if (err < 0)
> > -=09=09return err;
> > -
> > -=09/* ensure modem is in a known state; verbose on, echo/quiet off */
> > -=09g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
> > +=09if (g_at_chat_get_channel(data->at) =3D=3D NULL) {
>=20
> What does this do?

Will remove, it was cp from the quectel plugin :)

>=20
> > +=09=09err =3D open_device(modem, "AT", &data->at);
> > +=09=09if (err < 0)
> > +=09=09=09return err;
> > +
> > +=09=09err =3D open_device(modem, "PPP", &data->ppp);
> > +=09=09if (err < 0)
> > +=09=09=09return err;
> > +
> > +=09=09data->init_count =3D 0;
> > +=09=09data->init_cmd =3D g_at_chat_send(data->at, "AT", NULL,
> > +=09=09=09=09init_cmd_cb, modem, NULL);
> > +=09=09data->init_timeout =3D l_timeout_create_ms(500, init_timeout_cb,=
 modem,
> > +=09=09=09=09NULL);
> > +=09=09return -EINPROGRESS;
> > +=09}
> >
> >   =09/* query modem model string */
> >   =09g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
> > @@ -196,9 +247,7 @@ static void cfun_set_off_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
> >
> >   =09DBG("");
> >
> > -=09g_at_chat_unref(data->ppp);
> > -=09g_at_chat_unref(data->at);
> > -=09data->at =3D data->ppp =3D NULL;
> > +=09close_serial(modem);
>=20
> Just FYI, this change now makes CI complain:
>=20
>      plugins/sim7100.c: In function 'cfun_set_off_cb':
>      plugins/sim7100.c:246:30: error: unused variable 'data'
> [-Werror=3Dunused-variable]
>        246 |         struct sim7100_data *data =3D ofono_modem_get_data(m=
odem);
>            |                              ^~~~
>      cc1: all warnings being treated as errors
>=20
> >
> >   =09if (ok)
> >   =09=09ofono_modem_set_powered(modem, FALSE);
>=20
> Regards,
> -Denis

/Sean


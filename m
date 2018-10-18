Content-Type: multipart/mixed; boundary="===============7597030578740616448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Stuck in modem driver enable
Date: Thu, 18 Oct 2018 17:48:01 -0500
Message-ID: <d23da274-c820-db96-763b-6cf94110f21a@gmail.com>
In-Reply-To: <AM4PR1001MB0786A11CCCAC698C6DE3A93196F80@AM4PR1001MB0786.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7597030578740616448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 10/18/2018 05:52 AM, Mattias M=C3=A5nsson wrote:
> We have implemented a driver for the Gemalto modem we are using and =

> today I noticed that it got stuck in initialization (during enable). The =

> problem is that the AT+CFUN=3D4 (which is the last step of our init) now =

> returned a CME error. The error handling for this is inspired from all =

> the other drivers:
> =

> =

> static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> {
> struct ofono_modem *modem =3D user_data;
> struct verimalto_data *data =3D ofono_modem_get_data(modem);
> =

> if (!ok) {
> g_at_chat_unref(data->app);
> data->app =3D NULL;
> =

> g_at_chat_unref(data->mdm);
> data->mdm =3D NULL;
> =

> ofono_modem_set_powered(modem, FALSE);
> return;
> }
> =

> // Get initial SIM state
> data->sim_state_query =3D at_util_sim_state_query_new(data->app,
> 2, 20, sim_state_cb, modem,
> NULL);
> }
> =

> This will put the modem in not=C2=A0powered state. The problem is that as=
 it =

> has not completed the initialization, there is now no interfaces at all =


What interfaces?  DBus interfaces?  You still have the Modem interface =

present...

> set up. So we can not try to power it again or anything else. Are=C2=A0al=
l =


The above code does not actually trigger the removal of the Modem =

itself.  So that object is still present and you can still try to set =

Powered to True.  It might still fail the second time of course...

> these drivers having an issue with error handling=C2=A0or have I missed =

> something else? And how could I handle it better?
Not that I'm aware of.  Is there perhaps something deeper happening here =

than what you describe?

Regards,
-Denis

--===============7597030578740616448==--

